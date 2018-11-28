Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8C0C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7D72082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ukQhE4B+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7D72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeK1Sq2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:46:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeK1Sq1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 13:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EPIzflvAJUlGi6iavBRobzBf1shUiab75r8qH4BYRX8=; b=ukQhE4B+N5Ks7zVLHUscRckOr
        /AhGXkPOAwO+/aCQzRfD9WvYfJIWKOuoyCCJ6kLCj6OEk647uMZEG1Ig1IPn8zx5ckdMYG4kyekbG
        nhaLQYmwUadip1jYB2nA16VlXHurQ5niw0biRftJ8kCrHA8mig2CHhD7qQEcoKtD5+AwHUBOQc5JD
        /xm47XvnkgjCOHYFPszuwAknT7rt5WmRY5WrlMc/yDrMFNnfOho+za2mB90qcs3z9NaRZY6Slvr7S
        TaBFXHs++KVo1sPrSYksfh0w9XGt7mQcD85V7lhfYYFk0QVsa/Tx3Ub2UThehbPDacJ48JrQQcf8T
        VBKbWxn4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRuXY-00071p-RX; Wed, 28 Nov 2018 07:45:44 +0000
Date:   Tue, 27 Nov 2018 23:45:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [RFC PATCH v1 0/7] Block/XFS: Support alternative mirror device
 retry
Message-ID: <20181128074544.GA20702@infradead.org>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <20181128053303.GL6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128053303.GL6311@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 04:33:03PM +1100, Dave Chinner wrote:
> 	- how does propagation through stacked layers work?

The only way it works is by each layering driving it.  Thus my
recommendation above bilding on your earlier one to use an index
that is filled by the driver at I/O completion time.

E.g.

	bio_init:		bi_leg = -1

	raid1:			submit bio to lower driver
	raid 1 completion:	set bi_leg to 0 or 1

Now if we want to allow stacking we need to save/restore bi_leg
before submitting to the underlying device.  Which is possible,
but quite a bit of work in the drivers.

> 	- is it generic/abstract enough to be able to work with
> 	  RAID5/6 to trigger verification/recovery from the parity
> 	  information in the stripe?

If we get the non -1 bi_leg for paritity raid this is an inidicator
that parity rebuild needs to happen.  For multi-parity setups we could
also use different levels there.
