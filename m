Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF25C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512452081C
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cpbyKj6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512452081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeK1SgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:36:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeK1SgC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 13:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZxdhMXe+Z2tenMy0MqStIk9AmzT88JbT65af1MATTDg=; b=cpbyKj6KF0BSuwxgAbvrbAyAl
        L5rHuoN5e0KP4oLLj0GPHYalUUMzRkbBlMNhvdu6meYrCl1cLiiabeO7MhvN+7WtyWQx5TZfii7HJ
        CuYbuTJwfCe1yDkyajp3WClAd3dBOyeroubUlvu/cwEJjzYhZEboI2hcseknc3OWHG2CBW26nx745
        3m54b+oKkKv+Md5hflja1y1GNnsDDX5DzNNA9/gHs3VlTfqgbJAUz7Hq6pYseHism4KNIgNzADXWk
        DEMx3W8EsEV1LZ0dzvi28UsDz0jSKSh3yxajmdPjv3RfRN0DwnSOvukvQTTnV15UErvasXEVU36GP
        zhD+e3U+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRuNU-0003Jn-MN; Wed, 28 Nov 2018 07:35:20 +0000
Date:   Tue, 27 Nov 2018 23:35:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [PATCH v1 5/7] xfs: Add device retry
Message-ID: <20181128073520.GA7084@infradead.org>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <1543376991-5764-6-git-send-email-allison.henderson@oracle.com>
 <20181128050850.GJ6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128050850.GJ6311@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 04:08:50PM +1100, Dave Chinner wrote:
> So the first time through this loop the block layer devices what
> device to read from, then we iterate devices 1..n on error.
> 
> Whihc means if device 0 is the only one with good information in it,
> we may not ever actually read from it.
> 
> I'd suggest that a hint of "-1" (or equivalent max value) should be
> used for "device selects mirror leg" rather than 0, so we can
> actually read from the first device on command.

Yes.  For one thing I think we really need to split this retry counter
of sorts from the write hints.  I.e. make both u8 types and keep them
separate.  Then start out with (u8)-1 as initialized by the block layer
for the first attempt.  The device then fills out which leg it used
(in the completion path, so that another underlying driver doesn't
override it!), and then the file system just preserves this value on
a resumit, leaving the driver to chose a new value when it gets a
non -1 value.
