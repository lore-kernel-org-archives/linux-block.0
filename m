Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25369C33CB2
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 06:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB35D20678
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 06:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PKBfhEHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgAaGf3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 01:35:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgAaGf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 01:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BW2En7pNvZHFAlYVYPJhv8/Lsw4xkSZ3vMI5gF+lSjk=; b=PKBfhEHpbX4Au31TW/i23h6On
        d1QKv08tCb/QNV7z3y2HMuppnzJsQFhzzFbwPCcauiX+txiFbnz00NfqbM0Rc9roWmI1FycutUX2g
        bnHooMO2UvS1UyOQjq+e7q0HQbwdCMB5R6huwhOSBHQTpBC/YS3dWdlcKhr8MlhpAuGhsIlITTBM6
        K8NZHsOXFJMonEJFJ1fqaOGzOtipTo7xw2sGIP/zqfifNBz3l/c3DfY3HT18RpCZmG26RdCFSe+I0
        dFn8crWyLbl6QhXOn2OePRE8tPGoyHRjRzxBD3K8Dz2VknHIS15efKgaCZITTvsT0IBGmiW+FZ6Ok
        GLsdkVoug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixPtn-00076I-Ry; Fri, 31 Jan 2020 06:35:27 +0000
Date:   Thu, 30 Jan 2020 22:35:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: Re: [PATCH 1/2] block: introduce polling on bio level
Message-ID: <20200131063527.GC6267@infradead.org>
References: <20200126044138.5066-1-andrzej.jakowski@linux.intel.com>
 <20200126044138.5066-2-andrzej.jakowski@linux.intel.com>
 <de27b35e-a713-dc9d-5164-0397c0dff285@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de27b35e-a713-dc9d-5164-0397c0dff285@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 29, 2020 at 09:01:49PM -0700, Jens Axboe wrote:
> blk_poll() used to be a pointer in the queue, but since we just had
> one implementation, we got rid of it. Might make sense to
> reintroduce that, and just make it an optimized indirect call. I
> think that would be prettier than add the bio hack in the middle of
> it, and you're having to add a queue pointer anyway.

Well, the other reason is to avoid an indirect call for the blk-mq
case, which are fairly expensive.  In fact I'm pretty sure we avoid
indirect calls from the bio layer into blk-mq entirely for the fast
path at the moment, and it would be great to keep it that way.
