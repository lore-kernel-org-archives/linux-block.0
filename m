Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2AAC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3582420818
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KMzBCvjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3582420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeKOBnd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:43:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbeKOBnd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rl/oP1vYMS/MjbCV2jHH7fFgWsHVFycmefaLFvrCmwY=; b=KMzBCvjqhTwq9AdsHIT8EcsrM
        e7JzHUt9ujbz3KBSvkfA+L5dtjQPduwr9fViQQCNTpgpQQpq6159m6sZ82nIKt3/FVmSy2vzFbSbo
        R12vgs2pzT5V/7iHoAMGlMqNP4z1YC1kcpWrT6DaZjbzG0mw4vp51TxrTtNIjhfrM5mV0E5UqHKen
        EKZr5FiTR5xeJpQddwzZVX0wdesNrAtxh/yqbG1UMh5zRQNKnNGI3b++yWljYAeKPdhdZP0VpNpxe
        LdXuJfVHiXUEfkmbHSI6oFa5pe0NL6XVeENDW2Qqg6kxwulsY5xC5/QA8eMWteojvBCVjf2upUY8H
        SvH+0qUMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxGf-0005yF-3z; Wed, 14 Nov 2018 15:39:49 +0000
Date:   Wed, 14 Nov 2018 07:39:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/6] blk-mq: embed blk_mq_ops directly in the request
 queue
Message-ID: <20181114153948.GA22811@infradead.org>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-4-axboe@kernel.dk>
 <20181114152053.GA22186@infradead.org>
 <130070cd-e0d1-e75e-4341-7c1b26d1531e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <130070cd-e0d1-e75e-4341-7c1b26d1531e@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 08:33:06AM -0700, Jens Axboe wrote:
> It's measurable. It doesn't defeat the const at all, the mq_ops
> is still const and is never modified outside of when the queue
> is allocated. The only difference is of course that it is no
> longer residing in a read only mapped section, which is a shame.

And the separate section is very much the point of the const.

Without it attackers can easily overwrite the function pointer and
use it for exploits, as the C const attribute by itself doesn't
protect from that in any way.  But once it is in a read-only section
it can't easily be modified.
