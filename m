Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B879C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47182082E
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XgjIelT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfBDPBg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:01:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfBDPBg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 10:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1HXphwQUazxFIy+RRpwBBt6gSAedNaaIEBbwGi7VONU=; b=XgjIelT9kUDIrIfa+lFmTXEp+
        fX4xAVT3x+7b7JJZbrY5BtlfZHRve6TW4uEznIKveUn2lYEoQVPveC98NOE4bcdc1froovABO15nG
        hS+ULYt8U5obooOS5CqV8738kCHEhV4QPUBAkqIKcllPrSwRCameHjGLcs0lsQCNGXaXCWGBHR4a3
        J1Bgy6m961Z5XtVr9qK3nWxUvzUwzJ/TT9g7YxUHKbQqT7uvyMV/ZvTz5QzOL0TLaPg54np2t/yeJ
        y0XWyk0RZTe1M6YAiigtYZntn82lFBfQ01AE5KAFrK8zvvK74nX1u2oAcOPY0PqYiWCSJ6GJR7X4T
        MC5yl0Wuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfka-0006bq-Ar; Mon, 04 Feb 2019 15:01:32 +0000
Date:   Mon, 4 Feb 2019 07:01:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 15/16] block: sed-opal: don't repeat opal_discovery0
 in each steps array
Message-ID: <20190204150132.GM31132@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-16-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549054223-12220-16-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	/* first do a discovery0 */
> +	error = opal_discovery0_step(dev);
>  
> +	for (state = 0; !error && state < n_steps; state++)
> +		error = execute_step(dev, &steps[state], state);
> +
> +	/*
> +	 * For each OPAL command the first step in steps starts some sort of
> +	 * session. If an error occurred in the initial discovery0 or if an
> +	 * error occurred in the first step (and thus stopping the loop with
> +	 * state == 1) then there was an error before or during the attempt to
> +	 * start a session. Therefore we shouldn't attempt to terminate a
> +	 * session, as one has not yet been created.
> +	 */
> +	if (error && state > 1)
> +		end_opal_session_error(dev);
>  
>  	return error;

The flow here is a little too condensed for my taste.  Why not the
plain obvoious, if a little longer:

	error = error = opal_discovery0_step(dev);
	if (error)
		return error;

	for (state = 0; state < n_steps; state++) {
		error = execute_step(dev, &steps[state], state);
		if (error)
			goto out_error;
	}

	return 0;

out_error:
	if (state > 1)
		end_opal_session_error(dev);
 	return error;

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
