Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13486C04AB1
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B849320818
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 08:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SuHsgfsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfEMIIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 04:08:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMIIj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 04:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=coQz4jh+Dvam/9mVqgXE/XEjCBvgrL1xS3C5k6uz9J4=; b=SuHsgfsLG2KmhMlu8w9OFGA1U
        HINNd0os+Ydf9Qp3Jv1iRfTu1zWKwf9tPRBWsl7VPXlgYNGBKDitilQtvOgIOQsgAyAp1LARCjPuG
        po4Db9fSPirPyM2yNH6F0EKuF/ctjCqHTKPzy2JCk6UPeKA2/3RnU+Y7AFHi/UiVL3yoN8B0qfwtB
        2FQng9CTEjWbzyV5UpEUNDA3j8x3vpC5vyOUkk7L/yqTIWVppcuRR1bdGgMuYdZBvAboth1jVPV0v
        ZxzAIqjPnI4hWo3HDMYT/9Ln1rI2mbQ+80MPQ4mftTwJgYPxZRjjfR58Wr8sIt+LCDT5uoyf41nVm
        6SgRqiEbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ60k-0001dL-GB; Mon, 13 May 2019 08:08:38 +0000
Date:   Mon, 13 May 2019 01:08:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alex Lyakas <alex@zadara.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: preserve BIO_REFFED flag in bio_reset()
Message-ID: <20190513080838.GA5962@infradead.org>
References: <1554555800-14392-1-git-send-email-alex@zadara.com>
 <ae3ac0dc-92ef-36f9-ff0d-ef41e6deacb1@kernel.dk>
 <20190407075651.GA23397@infradead.org>
 <CAOcd+r3djpt1=ewD+QA0KsJ5woFb2G6T_9TAUCha=MtR8TyDww@mail.gmail.com>
 <20190408063052.GA9257@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408063052.GA9257@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 07, 2019 at 11:30:52PM -0700, Christoph Hellwig wrote:
> On Sun, Apr 07, 2019 at 05:35:45PM +0300, Alex Lyakas wrote:
> > Hi Christoph,
> > 
> > I understand and agree with your concern.
> > 
> > Looking at the code, bi_flags is 16-bits wide, and only top 3 bits are
> > preserved by bio_reset(). These bits are used to indicate a bvec pool.
> > So we don't have any free bits to move the BIO_REFFED to. Unless we
> > make bi_flags wider.
> 
> I think we just need to move BIO_REFFED around.  Something like the
> untested patch below should do the job, although blk_types.h could
> use some additional cleanup in this area..

Any comments?
