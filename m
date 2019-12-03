Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C440C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 15:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8272070A
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 15:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLCPmy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:42:54 -0500
Received: from verein.lst.de ([213.95.11.211]:44298 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfLCPmy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Dec 2019 10:42:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CFB868BFE; Tue,  3 Dec 2019 16:42:51 +0100 (CET)
Date:   Tue, 3 Dec 2019 16:42:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 8/8] block: set the zone size in
 blk_revalidate_disk_zones atomically
Message-ID: <20191203154251.GA928@lst.de>
References: <20191203151808.GA558@lst.de> <8FC173FA-576A-4425-AAE4-EE2A27C5F6BE@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8FC173FA-576A-4425-AAE4-EE2A27C5F6BE@javigon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 03, 2019 at 04:34:08PM +0100, Javier González wrote:
> Agree on the BUG_ON part.  But since you’re looking into this part now, would it make sense to do the check in the block layer only if the driver imposes a power of two? We can also do it down the road, but seems like double work.

The whole block layer chunk / zone handling has always assumed power
of two zone sizes.  Changing that would introduce expensive divisions
in the fast path.  This patch just moves the check to where it belongs.
