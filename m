Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E480C4332F
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 14:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbiKQOBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 09:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbiKQOAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 09:00:48 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D8B74CF2;
        Thu, 17 Nov 2022 06:00:45 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ovfRO-0004gw-BJ; Thu, 17 Nov 2022 15:00:30 +0100
Date:   Thu, 17 Nov 2022 13:59:04 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 3/4] partitions/efi: add support for uImage.FIT
 sub-partitions
Message-ID: <Y3Y+KIaINZOpWlx1@makrotopia.org>
References: <cover.1668548123.git.daniel@makrotopia.org>
 <7526fc5a461a0d68eb1dab575f9c1950638fc21a.1668548123.git.daniel@makrotopia.org>
 <Y3R8oQXRQ8uq8p4P@infradead.org>
 <Y3V9/pmHs7ypE7lb@makrotopia.org>
 <Y3XN+fDTjHz09qEE@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3XN+fDTjHz09qEE@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 16, 2022 at 10:00:25PM -0800, Christoph Hellwig wrote:
> On Thu, Nov 17, 2022 at 12:19:10AM +0000, Daniel Golle wrote:
> > While weirdness is certainly subjective, uImage.FIT is not just a
> > random image format but used by a great majority of headless embedded
> > Linux devices out there. It's the default image format of many of the
> > SDKs distributed by chip vendors such as Allwinner, Marvell, MediaTek,
> > NXP, Qualcomm/Atheros, ...
> 
> "Look see, my weird format is used by all these companies building
> crappy SOCs, it is not weird.."

I didn't invent this, and it's just as broken and yet perdominant as,
let's say, MS LDM on x86.

> 
> > Please let me know if this sounds acceptable, so I won't put effort
> > into implementing something which will then be rejected again after 5
> > iterations on the mailing list for reasons which could have been
> > expressed from the beginning. An RFC for this series was posted on
> > 2022-04-25 [1], I wouldn't have worked months to fix all requests of
> > other maintainers and tested it on a variety of different hardware
> > knowing that the whole approach will be NACK'ed...
> 
> If people ignore something that is obviously broken they might just hope
> for it to go away, becaue often it does.

While I'm sure that strategy works seen from your perspective, it does
waste resources on the other end. In this case it might not have been
obvious to everybody, I did receive feedback from other maintainers,
as I said. It's not that everybody ignored this contribution. Hence,
looking at it from my end, the picture is a bit different. Anyway.
I would have appreciated an earlier explicite NACK, that's all I
wanted to say.

