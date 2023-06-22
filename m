Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F36EB64DB
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 03:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFVDv4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 23:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVDvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 23:51:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC2D122;
        Wed, 21 Jun 2023 20:51:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 685FE67373; Thu, 22 Jun 2023 05:51:49 +0200 (CEST)
Date:   Thu, 22 Jun 2023 05:51:49 +0200
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
Message-ID: <20230622035149.GA4667@lst.de>
References: <20230523074535.249802-1-hch@lst.de> <20230523074535.249802-15-hch@lst.de> <8c1992bc-110a-4dad-8643-766c14bf6fd4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1992bc-110a-4dad-8643-766c14bf6fd4@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 21, 2023 at 02:07:13PM -0700, Guenter Roeck wrote:
> On Tue, May 23, 2023 at 09:45:25AM +0200, Christoph Hellwig wrote:
> > Instead of only clearing root_wait in devt_from_partuuid when the UUID
> > format was invalid, do that in parse_root_device for all strings that
> > failed to parse.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> In linux-next, almost all of my boot tests from usb drives as well
> as a few others fail with "Disabling rootwait; root= is invalid."
> in the log. Bisect points to this patch.

Can you send such a log, and the command line you've used?

