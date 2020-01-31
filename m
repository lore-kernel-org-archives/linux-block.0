Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EECCC33CB2
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 06:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A235214D8
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 06:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f922nfmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgAaGeM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 01:34:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAaGeM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 01:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qf43bj/aO0QbuMlsrS+q3nPkAsZxyDf4EtsomatRUiU=; b=f922nfmTnTE5Q2Ro5/bBHNal4
        I+Na+9gtjAgOv8RKzX2Bbm/tKSGF3OZpPaWNdZdHMxKxTgEtazW+nQ5cIeCk0vs/44ydCictqFk+L
        z9SM9yoZAxiO2baeDXiBQva2PyKkc/bacZJTWaWJC0fuqGoyfCF5OpmCfc/U+RbjaeT0gAO78AHzL
        0rDpT4bz6JrbAuQgb9OsUZUmMnAjxHqXeioIOSOFFAtmt8YGTbteDuttnAiskxOZSAwlzrTfQy6Mj
        Ao3qo4lDKf4nmyQsd3sLbqFe8V/GpoyKkDGmtDBO/krVXYz3xzddZOSTEIsbn+OMRPZ9RlXbQPLSi
        c1DSSVOzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixPsV-0005ox-9c; Fri, 31 Jan 2020 06:34:07 +0000
Date:   Thu, 30 Jan 2020 22:34:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Cc:     axboe@kernel.dk, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: Re: [PATCH 1/2] block: introduce polling on bio level
Message-ID: <20200131063407.GB6267@infradead.org>
References: <20200126044138.5066-1-andrzej.jakowski@linux.intel.com>
 <20200126044138.5066-2-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126044138.5066-2-andrzej.jakowski@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 25, 2020 at 09:41:37PM -0700, Andrzej Jakowski wrote:
>  	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
> -		goto not_supported;
> +		if (!(bio->bi_opf & REQ_HIPRI))
> +			goto not_supported;

Can you explain this check?  This looks weird to me  I think we need
a generalized check if a make_request based driver supports REQ_NOWAIT
instead (and as a separate patch / patchset).

> +	if (q->bio_poll_fn != NULL) {
> +		state = current->state;
> +		do {
> +			int ret;
> +
> +			ret = q->bio_poll_fn(q, cookie);
> +			if (ret > 0) {
> +				__set_current_state(TASK_RUNNING);
> +				return ret;
> +			}
> +
> +			if (signal_pending_state(state, current))
> +				__set_current_state(TASK_RUNNING);
> +
> +			if (current->state == TASK_RUNNING)
> +				return 1;
> +			if (ret < 0 || !spin)
> +				break;
> +			cpu_relax();
> +		} while (!need_resched());
> +
> +		__set_current_state(TASK_RUNNING);
> +
> +		return 0;
> +	}

This needs to be factored out into a helper at least.
