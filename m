Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAF2C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207D420871
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rl0+xNKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207D420871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeKSSlZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:41:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeKSSlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TcsFCDZDp3brgKi9lhhjpZpbQKOwDcU9h4sEEI44Tmc=; b=rl0+xNKBf5zkX36YDWyT9hzps
        /2xc5pnh3rzzXFc1wloqdjTNHwdEYfn7+29cfIA+FifMzJpYwAm87S0TzUbvvtOB35faFsANsKHP8
        Sv1S58LZ5yB28amyPQl9wB27GJ4M4U9WQOoE2n4JiUUINAoiqLhK7xolyPBtJ3h0vt+CUwoBKLCww
        sspMB0HslaHPL4SrHsAtwvP0r5TgHxAL/FULAEFUDDzHMYikIJhz2IyrxD+or8QsBPjSGNjz2NDSI
        Cqd9f9pMoz8IpZUCdK2zZWxAInnf2oyPrTJbpys9O93W0iJ6BtnksVpVONz42xBC8TnAkw2XxMJ++
        DO4t6ZVoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOelL-00024x-Qx; Mon, 19 Nov 2018 08:18:31 +0000
Date:   Mon, 19 Nov 2018 00:18:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] aio: Fix fallback I/O priority value
Message-ID: <20181119081831.GP9622@infradead.org>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-6-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119035131.11255-6-damien.lemoal@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 12:51:29PM +0900, Damien Le Moal wrote:
> For cases when the application does not specify aio_reqprio for an aio,
> fallback to use get_current_ioprio() to obtain the task I/O priority
> last set using ioprio_set() rather than the hardcoded IOPRIO_CLASS_NONE
> value.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
