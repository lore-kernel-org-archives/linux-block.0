Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BCAC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A852082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AbXKrCT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A852082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeK1Sv4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:51:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeK1Sv4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 13:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EWo+p2SfKgYx4J3NyR2bG5AfZ/V47E8YX3N4K63yArA=; b=AbXKrCT3xlsWVAFQDnGCUFSBm
        zJ18RBCJ7AZRHlFn/c9DlwLdT9jEL88AM0iKuIPiCU8HsSRalBd2Ydhl2GT1QwXub+ybnLSimIHSR
        0qkS2YCdPHPx0zzrQr+9prbvYAHBi0X8+cmzDAfv7BmYTfkV87allBG0wWdK1HHv+vevjGblyBFJG
        HsFkDd4+b4Te4EOvlkebQHLKDc/wLOLWcFZA2yyazTXlZJpu7efjFiqfSo90uY3G0Mo2dorhgGyXE
        OnaEumr3TshpKHb/9CZGklf8NhdrQabr5vgbo5pa6m0gTrwXsA7d8Gk8+szwzb6oJevH4mh6q1KA+
        ZYnzLfbwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRucp-0001BK-6B; Wed, 28 Nov 2018 07:51:11 +0000
Date:   Tue, 27 Nov 2018 23:51:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [RFC PATCH v1 0/7] Block/XFS: Support alternative mirror device
 retry
Message-ID: <20181128075111.GA29388@infradead.org>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <20181128053303.GL6311@dastard>
 <20181128073722.GB7084@infradead.org>
 <20181128074613.GP6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128074613.GP6311@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 06:46:13PM +1100, Dave Chinner wrote:
> Maybe we should be chaining bios for discontig buffers rather than
> submitting them individually - that keeps the whole chain around
> until all bios in the chain have completed, right?

No, it doesn't.  It just keeps the head of the chain around.

But we generally submit one buffer per map, only if each map was
bigger than BIO_MAX_PAGE * PAGE_SIZE we'd submit multiple bios.
That should always be bigger than our buffer sizes.

We also have the additional problem that a single bio submitted
by the file system can be split into multiple by the block layer,
which happens for raid 5 at least, but at least that splitting
is driven by the drivers make_request function, so it can do
smarts there.


