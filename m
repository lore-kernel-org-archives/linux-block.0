Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DF1C001B0
	for <linux-block@archiver.kernel.org>; Sun,  2 Jul 2023 02:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjGBCRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Jul 2023 22:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGBCRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Jul 2023 22:17:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7421703;
        Sat,  1 Jul 2023 19:17:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b7f2239bfdso26142205ad.1;
        Sat, 01 Jul 2023 19:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688264258; x=1690856258;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJTGw+c9DJrbYqiA04K/2tANXpXGkgOAgtlz124a1Co=;
        b=YgaK746I+skXxol7AodgRplLh/h4Un1YNEUG7ChHu1aIEwGJM26CThspI00TET9jYU
         HsOAMzX3opDf+nm8c2SXTrbbjKxmpqCKVpOpKnKbkQeg+0NSo3SsA4M5J6R3f5ACJMwt
         rdeaSIinHZ9oNhxYSX42yap+UNw04KMfCKliMFuf6CYGoUiG2X3rrsd3X5wlOi9bNzsX
         2eE6y7nsaCalVlw3RkXeFbDkDzQoQE6MqLWxLFgrTAhyVmjk45LRmEEnNFt4yCqzpffe
         /qcMz71olL8Rl3sjm/gB9v60k20OnlCfPLiW8sVXzw7Kk/AcxXrBr3kpJ9nI6Ml18cuQ
         bvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688264258; x=1690856258;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yJTGw+c9DJrbYqiA04K/2tANXpXGkgOAgtlz124a1Co=;
        b=fer6czbEEqdWH8wWcQai61hV4jnrJLbhw9/RjJ1epWYm2d5y3A09TkCwgcKAqMuAZk
         wKKlXdvx/s8HSkLv7+q2fbKI3wG2m9Q3bTm0W2/YKGVlnxD+zcYMBVXCnATfptB0X0Je
         RVb54sPvZ1VufW37zYYtpk5XaIWzfzSxpDXuGVj6U/1+xBuRoR+QPop63YhAX2cBZY14
         BI2fDopdVuXVdIQV4P1GHaydnU7QwKWrmi7ahGv6W80Nw1H7f6+/gXIfVU5KCe/idQMx
         hJD14GXa7umwyteD6zIlTYjsjIv68ynh5T1Hge30EPe/WVyIxfzeEYAiWJCZqBN3IwCt
         sLdQ==
X-Gm-Message-State: ABy/qLbQZFGplW5M09TkVTxEjlA9VoAK1r9xIB2QeSG8y7Gp7jbibdHW
        3FphxLOqlBYWo7TnkA3I7OQ=
X-Google-Smtp-Source: APBJJlEHuyOIr+bpMXj6M8qVN84MWrOUnsf0HN46zV15E4B5oVJcSfNCuw0JTj4GKAK40hSTwnrpFw==
X-Received: by 2002:a17:903:1246:b0:1b4:5697:d991 with SMTP id u6-20020a170903124600b001b45697d991mr8479034plh.15.1688264257789;
        Sat, 01 Jul 2023 19:17:37 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id j23-20020a170902759700b001b53953f306sm12875459pll.178.2023.07.01.19.17.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2023 19:17:37 -0700 (PDT)
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        linux-block@vger.kernel.org
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <3e3ce346-f627-4adf-179d-b8817361e6e3@xenosoft.de>
 <94d46446-97fc-9e92-2585-71c18e65b64a@gmail.com>
 <b9600d91-6a25-746e-0769-4d0e31038da5@xenosoft.de>
Cc:     axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        hch@lst.de, martin@lichtvoll.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <afe14b08-7bab-d81b-fce6-e6408741760a@gmail.com>
Date:   Sun, 2 Jul 2023 14:17:23 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <b9600d91-6a25-746e-0769-4d0e31038da5@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christian,

Am 01.07.2023 um 21:48 schrieb Christian Zigotzky:
>> Can you please send a copy of the RDB (first few kB of the disk,
>> something like dd if=/dev/sda of=rdb-sda.img bs=512 count=16 should
>> do), and the output of cat /proc/partitions when running a kernel from
>> before my RDB patches?
>>
>>
> Copy of the RDB: https://www.xenosoft.de/rdb-sda.img

Thanks, casual inspection of this RDB does show that indeed a value of 
-1 is used as pb_next in partition slot 4 (and 5).

The disk geometry is defined as 3 heads, 16 sectors per track (48 
sectors per cylinder) and 81396441 cylinders which matches your 2 TB 
disk size.

The first partition begins at cylinder 43 and ends at cylinder 5004, 
matching the 119088 k (k == 1024 bytes) below.

Partition 2 begins at cylinder 5005, ends at 92508, size 2100096 again 
as below.

Partition 3 begins at cylinder 92509, ends at 28120463, size 672670920 
as below.

Partition 4 begins at cylinder 28120464, ends at 81068868, size 
1270041720, different from the size shown in your /proc/partitions log.

The disk ends at cylinder 81396440, so a partition 4 extending to the 
end of the disk would have size 1278623448, which is what your log shows.

>
> cat /proc/partitions:
>
> major minor  #blocks  name
>
>    8        0 1953514584 sda
>    8        1     119088 sda1
>    8        2    2100096 sda2
>    8        3  672670920 sda3
>    8        4 1278623448 sda4

I have (disk image on sdb, patches applied):
      8       20 1270761720 sdb4

which matches what I calculated by hand above.

With an old kernel that does not have the RDB fixes, I get the same 
partition size as you report. That size is the result of truncation to 
EOD (the miscalculated size of 18446744071956107760 exceeds the device 
size).

Creating the filesystem on an unpatched kernel will use that incorrect 
partition size. I'm sorry to say I cannot see a new RDB partition bug 
her, just the result of undefined behaviour due to overflowing a 32 bit 
nr_sect size calculation in the old RDB code.


If you cannot shrink the filesystem, you will have to edit the partition 
table to extend p4 to the end of the disk. Just replace the partition 4 
pb->pb_Environment[10] (at offset 0x8a8, current value 0x04d50344) by 
0x04da02d8. As far as I can see, there is no adjustment to the partition 
block checksum required, as the checksummed block of 160 bytes ends just 
before the location of the partition's low and high cylinder addresses....

I'd best verify that a patched RDB actually works...

Cheers,

	Michael



>   11        0    1048575 sr0
>    8       32     250880 sdc
>    8       33     249856 sdc1
>    8       16  234431064 sdb
>    8       17  144364512 sdb1
>    8       18          1 sdb2
>    8       19   18500608 sdb3
>    8       20   40717312 sdb4
>    8       21   14684160 sdb5
>    8       22   16161792 sdb6
>    8       48       1440 sdd
>    8       49       1439 sdd1

