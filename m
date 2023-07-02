Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDCBEB64DD
	for <linux-block@archiver.kernel.org>; Sun,  2 Jul 2023 11:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjGBL3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jul 2023 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGBL3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jul 2023 07:29:33 -0400
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7187E72;
        Sun,  2 Jul 2023 04:29:30 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 800BD72B00B;
        Sun,  2 Jul 2023 13:29:28 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>, axboe@kernel.dk,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-m68k@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Darren Stevens <darren@stevens-zone.net>
Subject: Re: [FSL P50x0] [PASEMI] The Access to partitions on disks with an Amiga
 partition table doesn't work anymore after the block updates 2023-06-23
Date:   Sun, 02 Jul 2023 13:29:28 +0200
Message-ID: <3200191.5fSG56mABF@lichtvoll.de>
In-Reply-To: <48ded6f5-242c-a1b7-39b3-0585be4b848a@gmail.com>
References: <024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de>
 <0a8cabbf-89c6-a247-dee8-c27e081b9561@gmail.com>
 <48ded6f5-242c-a1b7-39b3-0585be4b848a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael.

Michael Schmitz - 01.07.23, 04:05:30 CEST:
> The RDB format description URL that appears in one of your messages
> from the 2012 thread has gone dead. I'll try to find it on Wayback
> later. In the meantime, I will submit a patch to fix the new bug ...
> We can has out details in the inevitable review process.

Hmm, I think they just went for prettier URLs:

https://wiki.amigaos.net/wiki/RDB

But there is not much on it.


Not sure whether there is a more detailed explanation anywhere on the 
net. I am pretty sure there is more in the NDK/SDK tough. And indeed 
there is:

AmigaOS 3.x NDK

https://www.hyperion-entertainment.com/index.php/downloads?
view=files&parent=40

I found it in: Include_H/devices/hardblocks.h

This is at least an include with the exact structure of the RDB and of 
the partition blocks. There are some explanations in the comments. Maybe 
there is something more elsewhere in this NDK.

You can unpack this using lhasa, easily available in Debian based 
distributions.

AmigaOS 4.x Software Development Kit

https://www.hyperion-entertainment.com/index.php/downloads?
view=files&parent=30

This is a bit more time consuming to dig through. I skip it for now.

Best,
-- 
Martin


