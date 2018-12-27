Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8675CC43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5583820882
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lf2uYanC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeL0N47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 08:56:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeL0N47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 08:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5tp1+KlUg7uxaS44iJZMpieOJ4kaFnu8v9LTu88Oqng=; b=Lf2uYanCgtt87fuV0KKxx2Nx6
        QSkpUGxXEAgEUj/j7V7AVogLekMOwyD3l2a5eCR2QMtcHSalu7ipM0RjW90rqu3Qb8L1+ESuZpylN
        s7UOH0ZCJYKnzZfP+n9xYo5cuvYg3Tqzb5fMf+eXUU5qVVcwXVjCFELc9sRoIfxi5iBhzHgCksgea
        IQz0+2eYRqvARUxUrY0py1ggOKcgV64Gr+t25CHNOhKfF6fuq7yACbbF29bieFcl73D1X7v/vxcc2
        u+7lI4OwvXfC0wAQ7W/UrFTrjX6Ut28XLTQLkauQx8Dlth39nDIKBVqhApwttZ6NC22HOTWfc+Uf1
        NIT7LwSjA==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcW9i-0006Ie-V1; Thu, 27 Dec 2018 13:56:59 +0000
Date:   Thu, 27 Dec 2018 14:56:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 09/22] aio: add submission side request cache
Message-ID: <20181227135656.GC25525@infradead.org>
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-10-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221192236.12866-10-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +/*
> + * After the iocb has been issued, it's safe to be found on the poll list.
> + * Adding the kiocb to the list AFTER submission ensures that we don't
> + * find it from a io_getevents() thread before the issuer is done accessing
> + * the kiocb cookie.
> + */
> +static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
> +				   struct aio_kiocb *kiocb)
> +{
> +	if (!state || !IS_ENABLED(CONFIG_BLOCK))
> +		aio_iopoll_iocb_add_list(kiocb);

This still looks odd to me.  Why would be make a batch or not batch
decision based on CONFIG_BLOCK availability?  Either batching is safe
for all ops, in which case we should always enabled it, or it only makes
sense for block devices / block backed filesystem in which case we need
a per-operation check.
