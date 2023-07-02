Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E10EB64DA
	for <linux-block@archiver.kernel.org>; Sun,  2 Jul 2023 03:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGBDqC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Jul 2023 23:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGBDqB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Jul 2023 23:46:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4951703;
        Sat,  1 Jul 2023 20:46:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e64e97e2so1751804b3a.1;
        Sat, 01 Jul 2023 20:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688269560; x=1690861560;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XhbtwciKq0owjEFsHsEd3iI7nd0TViQwAdoBtAWgxg=;
        b=oDQw2pfzYWvdX9FxMqZ/0G6jKDTWh9SUA3M3soWlL1Hd21Lj+BhoyAyWnOnmoo4F/l
         rZGj9xoT2A+7vmR3XIzpk02xgm+MqMxgDhONvn58YHDGIIja2sw8Jw5J9vzSAPICKckW
         Uc/RDJIMY5DiLQWtYTnueQLuWmRYV66elxLdWrzv6P25zN1a2Za5f3mLL8axxGF/9bjo
         czqYbNH1mQax6L3i0t2fwC8Wi3pyJ6S30NU9FSdnnVU0gmDpSw7At9wgpEd+pPPu9M/s
         n5/R/DTwY6vewUdSeCr9Ii9zRKUZHVNxmvoNnDgnWbwkByekZ9ub51ieFMvlUC+FLv8I
         u6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688269560; x=1690861560;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+XhbtwciKq0owjEFsHsEd3iI7nd0TViQwAdoBtAWgxg=;
        b=NSrvlPpHZvwFV6MdFkACVRHZ/RrLNJHiB5r9OUxXpAYOHq3xTZNXxYF/ljuZSj3QTg
         dp62+tz7Mpc4u2OUGHO2smyR603gpfMDc7SGc9xzTpwXlMmVbVFI4xoQAnbpKcSYezVI
         ZZdlZrW6lNiUPno5X/BqD9zQ8mFGdt7TBTqKOaX6ry26pGurxHXvFUHBoCE1H5NDDo64
         7lkIZjXsb/u6XcD+quMVMWJ2rl5mSRkp4XHfXTiIlWLfsjEUoXHhkxG/5ZFCkQ/Ppmil
         m9pd5JqooMz1cIs+Bbpuxcw0W6f/M4P2eYEQDX5zxuKZrpW59SjG2UW4nC4A7/kR24qS
         kQSw==
X-Gm-Message-State: ABy/qLYnHr+G5/iwGFE0oq2nuQdlJERVLoKp1ugakcKBebaPbrw5/BTX
        yC5461STMeQfaGmQvJatW4wQ/ZnH2eMC6A==
X-Google-Smtp-Source: APBJJlEWYntMHWEaw33Qv7el1w7q0nedc1PitCk1Rgkuicag7HrbyTMwC1YWGRqWU0+CBODVzO8Pkg==
X-Received: by 2002:a05:6a00:13a1:b0:677:bdc:cd6b with SMTP id t33-20020a056a0013a100b006770bdccd6bmr7638706pfg.19.1688269559772;
        Sat, 01 Jul 2023 20:45:59 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id n12-20020aa78a4c000000b0065dd1e7c3c2sm7682020pfa.184.2023.07.01.20.45.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2023 20:45:59 -0700 (PDT)
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        linux-block@vger.kernel.org
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <3e3ce346-f627-4adf-179d-b8817361e6e3@xenosoft.de>
 <94d46446-97fc-9e92-2585-71c18e65b64a@gmail.com>
 <b9600d91-6a25-746e-0769-4d0e31038da5@xenosoft.de>
 <afe14b08-7bab-d81b-fce6-e6408741760a@gmail.com>
Cc:     axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        hch@lst.de, martin@lichtvoll.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <a399af9e-9515-7079-ebf6-31bba47aca7e@gmail.com>
Date:   Sun, 2 Jul 2023 15:45:47 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <afe14b08-7bab-d81b-fce6-e6408741760a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christian,

Am 02.07.2023 um 14:17 schrieb Michael Schmitz:
> If you cannot shrink the filesystem, you will have to edit the partition
> table to extend p4 to the end of the disk. Just replace the partition 4
> pb->pb_Environment[10] (at offset 0x8a8, current value 0x04d50344) by
> 0x04da02d8. As far as I can see, there is no adjustment to the partition
> block checksum required, as the checksummed block of 160 bytes ends just
> before the location of the partition's low and high cylinder addresses....
>
> I'd best verify that a patched RDB actually works...

Argh - the checksum is over 160 longwords, not bytes.

Replace the checksum (at offset 0x808, currently 0x25d82b54) by 0x25d32bc0.

With these changes, I get the same size for partition 4 as you got by 
truncation with the original RDB partition code. That might be the 
fastest way to get your Linux partition mountable again.

Cheers,

	Michael


>
> Cheers,
>
>     Michael
>
>
>
>>   11        0    1048575 sr0
>>    8       32     250880 sdc
>>    8       33     249856 sdc1
>>    8       16  234431064 sdb
>>    8       17  144364512 sdb1
>>    8       18          1 sdb2
>>    8       19   18500608 sdb3
>>    8       20   40717312 sdb4
>>    8       21   14684160 sdb5
>>    8       22   16161792 sdb6
>>    8       48       1440 sdd
>>    8       49       1439 sdd1
>
