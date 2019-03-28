Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04237C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E8E20811
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YsfcPxQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfC1PCa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:02:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1PC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 11:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d6elNrrB7v98pMpVnK4nYLwCd3IlFmT/+R0O1pCp4MY=; b=YsfcPxQqg1hsRnqW4+eHsZ1Dd
        ReA10s4d0rJEev0L5DH+6a01wotWH8ppbqNik8wgvDvKVlCHfWaNyPmi1FEoh2Gp7visFszA8StxJ
        blr87gfyb1wGkILav0XXOiPRNLuT7j2g0GYpVnvcd/fW8X/1vtKaYRUV1jnLYaGQnsEX/+U8HpvYv
        2AcXSvKvSsH3IuZOM178FvQaaDdGCOigXYejVE85NJr3GKpwMkHrzVF87E4YB5X4nmCKZnIp9YtNT
        iKLKIXhTOevLLPFB8AlAVyBaRUWR61xxxMJZVA4nrW7/RtIOuBTJUujCO9RVvMSJUQ/nOuWAJXfWp
        xGWV0zJ3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9WXw-00032f-PX; Thu, 28 Mar 2019 15:02:24 +0000
Date:   Thu, 28 Mar 2019 08:02:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block: loop: mark bvec as ITER_BVEC_FLAG_NO_REF
Message-ID: <20190328150224.GA9265@infradead.org>
References: <20190328030531.28279-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328030531.28279-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	iov_iter_bvec(i, direction, bvec, nr_segs, count);
> +	i->type |= ITER_BVEC_FLAG_NO_REF;
> +}

What about simply providing a iov_iter_bvec_noref in core code and
also using that in io_uring?

Otherwise this looks fine to me.
