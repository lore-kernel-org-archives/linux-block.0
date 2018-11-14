Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D8EC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026DA208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RNn+k9Z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026DA208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeKOCCb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:02:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeKOCCa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9A2QLYSk0TOBFpQjDm7Wf35crbq10uZKh8udoFHNxH0=; b=RNn+k9Z/p0Y9aW/mdJTqkQE++
        llcN25O/jQuCSFeQxXm6nt8aAxik2KwA9ifI+lGU4XaXzRtcBwG2HM43aH/D4IecGMrgG5ggieIRk
        KvdT95XyT0YXprm0I0fpP/7AV7u7YfKdZKqSMk3BNSsZ+Ya9FFiva36fSYUds1uhCUgK6YK8pqTrY
        UqHNOsHcq4mQWc2RT6o55bW6TfrrZuXmFcsuHfZj+M5bSEb2OvhEHlwW5daF/UdgavIEbjFW+3KI6
        H69SpMDfPnmeGUPv/jKUn881Qx7dLuqL2Tj4mNK8k1ee0nbSgrJYEXgnfnG5z7zsRqwsIIKsPSA2T
        CCLqDQRqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxYw-0004Rf-OG; Wed, 14 Nov 2018 15:58:42 +0000
Date:   Wed, 14 Nov 2018 07:58:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/6] blk-mq: embed blk_mq_ops directly in the request
 queue
Message-ID: <20181114155842.GA16940@infradead.org>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-4-axboe@kernel.dk>
 <20181114152053.GA22186@infradead.org>
 <130070cd-e0d1-e75e-4341-7c1b26d1531e@kernel.dk>
 <20181114153948.GA22811@infradead.org>
 <1bec98d9-c0b1-c14a-8717-59af2e746895@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bec98d9-c0b1-c14a-8717-59af2e746895@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 08:47:58AM -0700, Jens Axboe wrote:
> Are we really worried about this as an attack surface? I get it
> for other types of ops, but for mq_ops, I'd be more worried about
> callers changing it inadvertently, and they still can't do that.

It isn't quite as bad as for thing like file ops, but for modern
atacks finding some piece that is easily patchable is what starts
it all.  So the less functions pointers we have that are ever
runtime writable, the better.

> It's not a huge deal to me, I can drop this one for now and
> revisit at a later time.

Yes, I'd be much happier if we dropped this for now.
