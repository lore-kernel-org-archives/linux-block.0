Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D33C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 19:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbiBOTRr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 14:17:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiBOTRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 14:17:45 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9959C108BD4;
        Tue, 15 Feb 2022 11:17:34 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2F2268AA6; Tue, 15 Feb 2022 20:17:31 +0100 (CET)
Date:   Tue, 15 Feb 2022 20:17:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Markus =?iso-8859-1?Q?Bl=F6chl?= <markus.bloechl@ipetronik.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220215191731.GB25076@lst.de>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 14, 2022 at 10:51:07AM +0100, Markus Blöchl wrote:
> After the surprise removal of a mounted NVMe disk the pciehp task
> reliably hangs forever with a trace similar to this one:

Do you have a specific reproducer? At least with doing a

echo 1 > /sys/.../remove

while running fsx on a file system I can't actually reproduce it.
