Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67973C001B0
	for <linux-block@archiver.kernel.org>; Mon,  3 Jul 2023 07:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjGCHF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jul 2023 03:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGCHFz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jul 2023 03:05:55 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B512E44;
        Mon,  3 Jul 2023 00:05:54 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id AEB9772BDDB;
        Mon,  3 Jul 2023 09:05:50 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-block@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        hch@lst.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Date:   Mon, 03 Jul 2023 09:05:50 +0200
Message-ID: <4858801.31r3eYUQgx@lichtvoll.de>
In-Reply-To: <234f57e7-a35f-4406-35ad-a5b9b49e9a5e@gmail.com>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <1885875.tdWV9SEqCh@lichtvoll.de>
 <234f57e7-a35f-4406-35ad-a5b9b49e9a5e@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Michael Schmitz - 02.07.23, 22:22:27 CEST:
> > I have read through the last mails without commenting. I admit: I do
> > not yet get what is wrong here? A checksum was miscalculated? Is
> > this a regular thing to happen when using RDB disks with Linux
> > partitions?
> I sent instructions to Christian on how to fix his partition table so
> the size mismatch between partition and filesystem (caused by the old
> RDB code) can be avoided, and misreading the checksum calculation code
> I forgot to update the checksum. That's all.

Ah okay. Sure, the checksum needs to be updated then.

From what I thought I gathered from Christian, I thought that his issue 
would be something that would automatically be triggered by just using 
disks Amiga + Linux RDB partitioning setup. And I did not get, how any 
tool on AmigaOS would create partition tables with errors like too large 
partitions in them. I am not completely sure about the amiga-fdisk tool 
for Linux, but even there I would be surprised if it would allow to 
create such a partition table. Especially given that as I remember back 
then when I faced the overflow issue amiga-fdisk showed the correct 
values. I always suggest to use a tool on AmigaOS however.

So that was it: I did not get how Christian comes to claim that so many 
users were affected with incorrect partition tables, cause frankly Amiga 
RDB partitioning tools are not actually famous for creating incorrect 
partition tables like this. There has been some compatibility issue 
between some Phase 5 tool with a name I do not remember and the other 
tools back then I believe, but it was not about partition sizes. 
Especially if you use a HDToolBox from any AmigaOS version up to 3.x or 
Media Toolbox from AmigaOS 4.x with automatic geometry calculation, I 
never heard of such a partition to large error in the partition table. 
Those tools simply do not allow creating that.

So, Christian, unless you can actually enlighten us on a reproducible 
way how users with those setups end up with incorrect partition tables 
like this, I consider this case closed. So far you didn't.

Ciao,
-- 
Martin


