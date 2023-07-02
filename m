Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FF9EB64D9
	for <linux-block@archiver.kernel.org>; Sun,  2 Jul 2023 07:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGBH4B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jul 2023 03:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBH4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jul 2023 03:56:00 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D0410E5;
        Sun,  2 Jul 2023 00:55:59 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 669AD72A8CE;
        Sun,  2 Jul 2023 09:55:55 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        hch@lst.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Date:   Sun, 02 Jul 2023 09:55:54 +0200
Message-ID: <1885875.tdWV9SEqCh@lichtvoll.de>
In-Reply-To: <afc575b6-5f2d-f5cb-31d1-0830d0e369cf@xenosoft.de>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <afe14b08-7bab-d81b-fce6-e6408741760a@gmail.com>
 <afc575b6-5f2d-f5cb-31d1-0830d0e369cf@xenosoft.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christian Zigotzky - 02.07.23, 06:37:50 CEST:
> On 02 July 2023 at 04:17 am, Michael Schmitz wrote:
> >  I'm sorry to say I cannot see a new RDB partition bug her, just the
> > result of undefined behaviour due to overflowing a 32 bit nr_sect
> > size calculation in the old RDB code.
[…]
> Thanks a lot for your explanation!
> 
> Actually, we need your patch because there is a very old bug but there
> are some endusers with RDB disks with Linux partitions. If I apply
> your patch to our kernels, then I need an enduser friendly solution
> for fixing the issue with their file systems.

I have read through the last mails without commenting. I admit: I do not 
yet get what is wrong here? A checksum was miscalculated? Is this a 
regular thing to happen when using RDB disks with Linux partitions?

I do not yet get how this issue happens. What are the steps to reproduce 
it? And how likely is it to run into it?

> Do you have a solution for the enduser (consumer)? How can they fix
> their file systems? The next issue is, if an enduser uses an old
> unpatched kernel with a partition, created with a new patched kernel.
> I don't know how can I handle this issue in the consumer support.
> 
> I can't help all endusers and some are not active in forums etc.

How many end users are you speaking of?

Back then I thought I was the only one using a hard disk with mixed 
Amiga/Linux RDB setup.

Best,
-- 
Martin


