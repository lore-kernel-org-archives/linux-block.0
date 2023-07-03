Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC54EB64DD
	for <linux-block@archiver.kernel.org>; Mon,  3 Jul 2023 14:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGCO7l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jul 2023 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGCO7k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jul 2023 10:59:40 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80D0E43;
        Mon,  3 Jul 2023 07:59:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688396344; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=K/UD3/gCNqzSGb/Dnqe7PCEOtbLIffkqyEwlNhSt6H6Ig9K57pmh/sZYs9l3OcCK8G
    TVx7jXasBDHswnN5EXMZi+tV567o1Hy0cTK6uaVDEm720AmBkTmVKRdo7HkfUVPS6e+b
    K8/YHl8VDx1/DwMrSTaTAnGo4SU0iFLuqb0Yf9zKjNAeOysSkfkrt02gj43BNP8LxN+i
    v2rfaQ17XB0vNS8byOB+KDIRL5lvsQU5bW0qSoKs9+FIhXp5ux+1aQu1gkmJTd3NKU8R
    klLa/ClwDV8dAV+cNfj5rfVKkwNwyJDIi4EsdzSc0E2v55C9h/j1qV+HoOZmkmnGbF0c
    GaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688396344;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7jGdreVnyYW1hPkWJoqzItLU51giwP5jp5MAC7wbzHY=;
    b=LFobwfZLzKk2eGmVQIv08Kg+7+Y8MaOz3/eCknbreaE1A/fiWC5fd6M+Cl/dy+Ih+i
    n296WGxFk/pgz38Yt/2K2nlAc9GuiWExRMoijlP7HDlhm2WeEjZcKZ02pss4hT5iH/Wn
    lSLD6LwCwdsyZHLWJ4kwcSKvvpmhNoynPsF3YI4mygoA7PjQJYHn4JakjissXbThFo0Q
    Du7LFU4hx+SZpb94qjslwpweobebaZXVsZfgMND3L5duohNA5iyGJ79yi4vhi9dK8aVN
    SPd7uMJjSLiydaYx/49ormYK4YV59q/6gYTs4qt9FG0cq64twxhARykPzjU7vPlrRs5d
    4UOg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688396344;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7jGdreVnyYW1hPkWJoqzItLU51giwP5jp5MAC7wbzHY=;
    b=Li/jYcjqja6f+8xy+1DIY/tE+NAZILHiUhQdkpG4fM4RZEEjy4e+5I+qzUxQQJSyQH
    cjXv3K/VMjzf3pjP2nOA+hXI8JS8k+tdD7cUV/MX8Wn/ml4lH/CZ5JK8xtZqOSPyoQsO
    aAGugMjlnUa+UgeBrrnCEGUO15vPeKF0PnMAR952xxQw1e8ZldDIFxGn0Q8w7ET7LqW3
    MiKSZ3Gk36Rsmu6AXqxnDGsyTcJsL9Bk2ZVmK1OKuMb4x5B+3cvAeejrH7PhTuGxfGvU
    y1FYHN6x8Eeorm3BwpOskaU7EA5kw/UV1jabvjBMbaxXbTlEXkslekZkbh9EM0mDSta6
    GpUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688396344;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7jGdreVnyYW1hPkWJoqzItLU51giwP5jp5MAC7wbzHY=;
    b=GOa4mmTHQEnc0pm7xW/ylqCvKtM0VkYJsayzIivMZgXDDpd0K+HX5jqRBjYRqcsa5K
    KFsHB8Fs3Bc1OMAynSCw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHvJzedR4hZ0hbXsch5+//XdlPUGFli4Uk5Nm+QSwfKBN9bg="
Received: from [IPV6:2a01:599:a10:1e99:7578:5f56:e200:ca72]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id N28a51z63Ex3y0d
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 3 Jul 2023 16:59:03 +0200 (CEST)
Message-ID: <80266037-f808-c448-c3c7-9d5d5f4253a7@xenosoft.de>
Date:   Mon, 3 Jul 2023 16:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Content-Language: en-US
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>
Cc:     axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        hch@lst.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <1885875.tdWV9SEqCh@lichtvoll.de>
 <234f57e7-a35f-4406-35ad-a5b9b49e9a5e@gmail.com>
 <4858801.31r3eYUQgx@lichtvoll.de>
 <947340d9-b640-0910-317b-5c8022220a55@xenosoft.de>
In-Reply-To: <947340d9-b640-0910-317b-5c8022220a55@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03.07.23 16:19, Christian Zigotzky wrote:
> On 03.07.23 09:05, Martin Steigerwald wrote:
>> So, Christian, unless you can actually enlighten us on a reproducible
>> way how users with those setups end up with incorrect partition tables
>> like this, I consider this case closed. So far you didn't.
>>
>> Ciao,
> This is a very simple explanation. The first partitions on the RDB 
> disk were created with Media Toolbox on OS4.1. After that some 
> additional partitions were created with Linux and formatted with ext4.
> With the new patched kernel, these can no longer be mounted.
>
> I will try out, if I can correct them with GParted. If it works, then 
> I will write some instructions for correcting the partitions via 
> GParted for the end users.
>
> GParted is a good tool and suitable for our customers.
>
> I know, this is a very old bug and no one has noticed this one. I have 
> not received any error messages because of Linux partitions on RDB 
> disks in the last 10 years. I am very happy that this bug is fixed now 
> but we have to explain it to our customers why they can't mount their 
> Linux partitions on the RDB disk anymore. Booting is of course also 
> affected. (Mounting the root partition)
>
> But maybe simple GParted instructions are a good solution.
You can apply the patch. I will revert this patch until I find a simple 
solution for our community.

Thank you for fixing this issue!
