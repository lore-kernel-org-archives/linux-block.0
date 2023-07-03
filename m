Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103D0EB64DD
	for <linux-block@archiver.kernel.org>; Mon,  3 Jul 2023 01:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGCB5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jul 2023 21:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCB5V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jul 2023 21:57:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972AE19A;
        Sun,  2 Jul 2023 18:57:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b84c7a2716so18826345ad.3;
        Sun, 02 Jul 2023 18:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688349440; x=1690941440;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgtuTfk8ghajOELdnsmPNXhVMSoe5USZM9GNI8VUIuA=;
        b=m0KH6j1lxg1izPCZ4LSzPy/lbtzy7sLoCO1xDyf4za2b2L32Xz+w2pO4YD2zPqJufu
         w4kn9Dq8je0rwFZnTRDUccKUahRDTdDretVefCcm5T9BesxS3dC2ggPoe/KSia2MMLyq
         D7OzSwTk/WYy+q7sCh1pXAlF2sXyggQwiHGO+rrQyWZQfrO680/xZW7/cC1nnTh1t0Es
         4KYKLMLd2LwWE7sRETZFutIT4vLKwcpY8e2iEJL8Jxws5I+xYJWrJpLWpdD1q+nftwqP
         5SwrBuvFVQIMP7O665E1iRahc4Z+/bp4hiZTO938vp5CNs1gw8Eaq9tPCP5lrX8XrEPr
         1LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688349440; x=1690941440;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IgtuTfk8ghajOELdnsmPNXhVMSoe5USZM9GNI8VUIuA=;
        b=XDbCmt7OGJQHY9bceHvhczuo+xmENTf3WjPMtP0Q42NBdyky3ylpuU0mO9U6JJuL+C
         iZkjoYrqKQxs8UwyrhctlvxV8QumKp511vBnMxrndJF+6vG6gYUsy0tgZQHiWKSgLJFu
         aHYMBbBquKj24qr949h1dwBK1vxtyYpFszxQNVL+fY3HYWyyLj00V3fKSpQeg9DMawtY
         81fX+xg01v1xmSc6TsuShRrOR2BnXuePOTHI+i6rdCrSGFC8ntBqtGAGdw7yQJkoSnpi
         zmPd9IXQGAqnp0yOl7i9Ko98a6tHanlkVLdCdxWjluC4WMZp4HPVnY2zerBzhyj4dAJS
         EDEA==
X-Gm-Message-State: ABy/qLYlatJh1lDsPVFu7/xtDCaoBjcQJr/3HWGGiF4yMaoaZD2PjaoR
        c+HA5aa73G2OLRNo2aXKhG0=
X-Google-Smtp-Source: APBJJlGAOeTVKETBQ1UaZItJXnhLmCJejXbsjfshpRQgXuDm1Uf1+26l+cFZD+VwbNR9l0DTd1v3FA==
X-Received: by 2002:a17:902:ecd2:b0:1b6:b1f3:add5 with SMTP id a18-20020a170902ecd200b001b6b1f3add5mr9349895plh.27.1688349439976;
        Sun, 02 Jul 2023 18:57:19 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902ba8d00b001b69303db54sm14141289pls.91.2023.07.02.18.57.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jul 2023 18:57:19 -0700 (PDT)
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Martin Steigerwald <martin@lichtvoll.de>
References: <3C36662C-78A3-4160-93AB-3E28A246AFCE@xenosoft.de>
 <9785707F-E415-4E04-A8E5-AD984CE16AA0@xenosoft.de>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c3a7f613-102b-add1-0d55-32f030e936b7@gmail.com>
Date:   Mon, 3 Jul 2023 13:57:10 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <9785707F-E415-4E04-A8E5-AD984CE16AA0@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christian,

please stop placing your replies underneath the previous mail's 
signature separator. There are mail clients that won't copy such text 
when composing a reply.

Am 02.07.2023 um 21:34 schrieb Christian Zigotzky:
>
>
> On 2. Jul 2023, at 10:56, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>
> ﻿On 2. Jul 2023, at 09:55, Martin Steigerwald <martin@lichtvoll.de> wrote:
>
> How many end users are you speaking of?
>
> Back then I thought I was the only one using a hard disk with mixed
> Amiga/Linux RDB setup.
>
> Best,
>
>
> Martin
>
>
>
> A lot.  I am speaking about the new A-EON machines.
>
>
>
> The end users have to fix their  RDBs if they want to use the new patched kernels.

So what you're saying is that you have let your end users use RDB 
partitions on the old kernels that had a bug against them in the RDB 
code for eleven years, and proposed bugfixes for as long, patches to 
resolve the problem submitted to linux-block for the last five years, 
and you never once stopped to investigate what the ramifications of this 
bug were, and what the consequences of the proposed bugfix would be?

The discussion of this bug among Martin, Joanne and Geert didn't leave a 
lot to imagination as regards data corruption potential.

> But a normal user can’t edit the RDB manually. What can we do for the end users?

End users can use whatever tool they happened to use to partition the 
disk in the first instance, and correct the partition table that way.

Leaving 8 GB unused at the end of the disk can't be some feature of 
Amiga partition editors, leastways not one that can't be overridden?


But if you want to support your large userbase by a convenient solution, 
may I suggest you write a small tool that gets the disks's end cylinder 
from the RDB (field rdb_HiCylinder, offset 0x8c), then walk the 
partition list starting from rdb_PartitionList for the first partition 
block, then pb_Next for the next one, find the last valid partition 
(where pb_Next is 0xffffffff), and check whether the partition size 
calculation for that partition (in 32 bit arithmetic) would cause the 
partition end to land beyond EOD. If that is the case, the old kernel 
code would have truncated that partition to exactly EOD, and you have to 
change the partition end cylinder value (offset 0xa8 from the start of 
that partition block) to the value of rdb_HiCylinder. Adjust the 
partition checksum (offset 0x8) by the difference of the old and new 
values (i.e. add (old-new) to the checksum stored there) and you should 
have a valid partition to the end of the disk.

Might be a bit tough in a shell script but not too hard in Perl or Python.

Putting that kind of fix in the kernel would be asking Jens and Linus 
(and quite a few others) to yell at me and call me names, and for very 
good reason (but of course you can always do that in kernels you 
distribute to your end users).

Cheers,

	Michael


