Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1182C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFC820832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="shoJvRA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFC820832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeK1SXP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:23:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbeK1SXP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 13:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6N3GQCkQeyr9uX7QuE1WMznhEB3RG1ODRu7wvIPOEb4=; b=shoJvRA3Ldh4Y1+dk6byIiyD+
        qZkhHu+cGe92bUPFEUsM29FeRkDLGjd73e8LSbn63m9ysUwgJn5Cwmfdm32yIhH7DfJ9iAspJ/ZB5
        UApWDjS7pX/TxwcXdQyAFfEqtMC3ApD1letGY0BHg4acfc2jyfrBJlH3KgoML8CQnk6EXp6LxkKxh
        Rnp15CRQy6UgfVMncrcPv5p0IqJ3WFfoPm7EeT5L8w3noF9aSDV7ld/ELA9ScDW4cQXQgKmwxMn+7
        JiBj/modnewKYM7NDdCFdAsqyed19mK9oJyz1KTuAUL0LXcNuPV9XrsWP3BRIbhrgvaEXZigQxSIm
        L5RBMgzHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRuBA-0006nJ-Ei; Wed, 28 Nov 2018 07:22:36 +0000
Date:   Tue, 27 Nov 2018 23:22:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/8] ataflop: implement mq_ops->commit_rqs() hook
Message-ID: <20181128072236.GD11774@infradead.org>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126163556.5181-7-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:35:54AM -0700, Jens Axboe wrote:
> We need this for blk-mq to kick things into gear, if we told it that
> we had more IO coming, but then failed to deliver on that promise.

queue_rq also calls finish_fdc under atari_disable_irq( IRQ_MFP_FDC ),
do we need that here as well?
