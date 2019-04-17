Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E19CC10F12
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 05:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE60F20872
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 05:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfDQF1i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:27:38 -0400
Received: from verein.lst.de ([213.95.11.211]:40209 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730108AbfDQF1i (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 01:27:38 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3A0C468AFE; Wed, 17 Apr 2019 07:27:24 +0200 (CEST)
Date:   Wed, 17 Apr 2019 07:27:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
Message-ID: <20190417052723.GA23019@lst.de>
References: <20190408104641.4905-1-hch@lst.de> <20190408104641.4905-2-hch@lst.de> <20190415194435.GA23676@roeck-us.net> <20190415205242.GA6380@lst.de> <20190415210731.GA32723@roeck-us.net> <20190416063356.GA25763@lst.de> <20190416170847.GA5531@roeck-us.net> <20190416171011.GA4611@lst.de> <20190416175108.GA9550@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416175108.GA9550@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that I've fixed the sparc32 iommu code in another thread:  can
you send me your rootfs and qemu arm command line for the failing
one?  I have a hard time parsing your buildbot output.
