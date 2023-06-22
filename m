Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B9EEB64DB
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 06:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFVGAN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 02:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFVGAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 02:00:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39909E2;
        Wed, 21 Jun 2023 23:00:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E6A467373; Thu, 22 Jun 2023 08:00:01 +0200 (CEST)
Date:   Thu, 22 Jun 2023 08:00:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 14/24] init: clear root_wait on all invalid root=
 strings
Message-ID: <20230622060001.GA8351@lst.de>
References: <20230523074535.249802-1-hch@lst.de> <20230523074535.249802-15-hch@lst.de> <8c1992bc-110a-4dad-8643-766c14bf6fd4@roeck-us.net> <20230622035149.GA4667@lst.de> <2205ef1e-9bb6-fb1e-9ca3-367c1afe12ac@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2205ef1e-9bb6-fb1e-9ca3-367c1afe12ac@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guenter,

can you try this patch?

diff --git a/block/early-lookup.c b/block/early-lookup.c
index a5be3c68ed079c..66e4514d671179 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -174,7 +174,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	while (p > s && isdigit(p[-1]))
 		p--;
 	if (p == s || !*p || *p == '0')
-		return -EINVAL;
+		return -ENODEV;
 
 	/* try disk name without <part number> */
 	part = simple_strtoul(p, NULL, 10);
