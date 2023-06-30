Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A27EB64DD
	for <linux-block@archiver.kernel.org>; Fri, 30 Jun 2023 21:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjF3VRS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 17:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjF3VRR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 17:17:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF042680;
        Fri, 30 Jun 2023 14:17:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666ecb21f86so1889010b3a.3;
        Fri, 30 Jun 2023 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688159835; x=1690751835;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rA+sOUZnV8D4R5T5Y4gyZYhUy+T1XxbqQ2gMPYmRimw=;
        b=c4DnOjVZ3K/66Y9+rxNgSIEEyIHHGO3eN+5i6zVoUZhMKQAQVDueWSPXKyvY1xLGsU
         mvGsXm7VYgWiRTHhOz1KMlnkC+sZv82tQ0J/UTEPEn83sZYwcWuOdM+0g9Zw/EEFp+Xr
         kZDKmP+ZrkCMiOxcMuNkLG0RD3oZ569fQDodgtqfceMSKiWjvwKro/UCnKve6J3LbY6W
         Y/ver6h7QEW77dEmqEu3pcBt751P398C/htn2CyS0D+pgyPZnVsNMCuBs/n7XoeHSTIY
         FvBeX4qsiFMpH8WEqrMLKUzirUxHJYzvuITbOWl+Vrd5O2T7nckbQWVgVIxD9dSQf2G2
         4LZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688159835; x=1690751835;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rA+sOUZnV8D4R5T5Y4gyZYhUy+T1XxbqQ2gMPYmRimw=;
        b=DXIjXCNYWqORjlGSlu6cQu8BriQIN2IcLi0+/u+c/5nltP1FabQrrvABxfEMdmnRrA
         liwVWNFzhI6pcdR9AbzfNWCPWMx8YbZEbZZbZEswtubeSrp/Ruvze7UO5baoVDoz0811
         H7yRgIsGDqQe0jXsBBZGwQsLd+3oG81fOkoviLYKiVf54gDBNC3nvNwVmv+p16gZNP5e
         0bTc9DV1TXL/aui3+TuVZbJhGMJGsQKdMJ2fnqL2Z4O6i8X2kJTe6Zq4MPmCshWm08wN
         nN2FwhuAJ/y8aECQdmBBnBy1AcxNA/UZ81lAF5/UEjxWyFgHXGTdIcwMZBhaNhtHqUdU
         nppw==
X-Gm-Message-State: ABy/qLb7EB07wjltQa99v5h1AY4MWqiYyM9FwPJQsLL9YCwFi6GDoIaD
        j/lvZRmbKZxYszeZTHd5rD8=
X-Google-Smtp-Source: APBJJlF1ySOyREuGhtCXG4XPbsqxLCbA0Pr2C2/5cbQ2AJcTKozJS6KHG8nRW0vSRk12dMxc8jP2FQ==
X-Received: by 2002:a05:6a00:2d1d:b0:680:98c:c595 with SMTP id fa29-20020a056a002d1d00b00680098cc595mr5311689pfb.13.1688159835323;
        Fri, 30 Jun 2023 14:17:15 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id w1-20020a627b01000000b0067903510abbsm1531019pfc.163.2023.06.30.14.17.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jun 2023 14:17:14 -0700 (PDT)
Subject: Re: [FSL P50x0] [PASEMI] The Access to partitions on disks with an
 Amiga partition table doesn't work anymore after the block updates 2023-06-23
To:     Martin Steigerwald <martin@lichtvoll.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>
References: <024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de>
 <a113cb83-9f82-fd39-f132-41ba4c259265@gmail.com>
 <5866778.MhkbZ0Pkbq@lichtvoll.de>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Darren Stevens <darren@stevens-zone.net>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <0a8cabbf-89c6-a247-dee8-c27e081b9561@gmail.com>
Date:   Sat, 1 Jul 2023 09:17:06 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <5866778.MhkbZ0Pkbq@lichtvoll.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,

Am 30.06.2023 um 20:35 schrieb Martin Steigerwald:
> Hi Michael, hi Christian.
>
> Michael Schmitz - 29.06.23, 22:27:59 CEST:
> […]
>> On 29/06/23 16:59, Christian Zigotzky wrote:
>>> Hello,
>>>
>>> The access  to partitions on disks with an Amiga partition table
>>> (via the Rigid Disk Block RDB) doesn't work anymore on my Cyrus+
>>> board with a FSL P50x0 PowerPC SoC [1] and on my P.A. Semi Nemo
>>> board [2] after the block updates 2023-06-23 [3].
>>>
>>> parted -l
> […]
>>> dmesg | grep -i sda
>>>
>>> [    4.208905] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks:
>>> (2.00 TB/1.82 TiB)
>
> That is roughly the size of the disk that triggered my bug report from
> 2012.
>
> Jun 19 21:19:09 merkaba kernel: [ 7891.821315] ata8.00: 3907029168
> sectors, multi 0: LBA48 NCQ (depth 31/32)
>
> Bug 43511 - Partitions: Amiga RDB partition on 2 TB disk way too big,
> while OK in AmigaOS 4.1
>
> https://bugzilla.kernel.org/show_bug.cgi?id=43511

Yes, that's been the first disk size allowing the overflow to occur. 
This time it's not about partition size but partition block address though.

>> By reverting my patch, you just reintroduce the old bug, which could
>> result in mis-parsing the partition table in a way that is not
>> detected by inane values of partition sizes as above, and as far as I
>> recall this bug was reported because it did cause data corruption. Do
>> I have that correct, Martin? Do you still have a copy of the
>> problematic RDB from the old bug report around?
>
> It is in the first attachment of the bug report I mentioned above. The
> bug the patch fixed.

Thanks, I'll get it from there.

> In the bug report I wrote:
>
> "I had a BTRFS filesystem that had some checksum errors. Maybe thats
> somehow related to this issue and AmigaOS and/or Linux overwrote
> something it shouldn´t have touched."
>
> (Meanwhile I bet it is safe to assume that in case the checksum error
> was from overwriting something it was not AmigaOS 4.)
>
> This is no proof, but as I re-read my bug report: It is clearly an
> overflow issue worsened by Linux back then truncating the too high
> partition sizes larger than the disk to the disk size instead of bailing
> out. So the partition I created for the Linux LVM in front of the Amiga
> partitions overflowed into the Amiga partitions. Had I used that place
> inside the PV for any LV and written to it… I bet it would have been
> goodbye to the Amiga data.

Thanks, that's good enough reason for me to not back out patch 3.

>
>>> Could you please check your commit?
>>
>> The patch series has undergone the usual thirteen versions in review,
>> but the reviewers as well as myself may well have missed this point of
>> detail...
>
> I think the patch series has been very well reviewed, but I would not
> have spotted such an issue as I am not really an RDB expert and even

I agree - not meant as a slight to the reviewers but more a dig at my 
patch record.

> then, with all the big endian conversions and what not inside of there…
> In my understanding the RDB format is not really as Rigid as the name
> implies. It is quite flexible, especially when compared to what had been
> used on PC back then and sometimes even now. So there is a chance for a
> RDB partitioning that triggers an oversight in the patch series.

At least it did show up in testing real fast.

>
>> Could you please check this (whitespace-damaged) patch?
>>
>>      block/partitions - Amiga partition overflow fix bugfix
>>
>>      Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
>>      fails the 'blk>0' test in the partition block loop if a
>>      value of (signed int) -1 is used to mark the end of the
>>      partition block list.
>>
>>      Explicitly cast 'blk' to signed int to catch this.
>>
>>      Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>
>> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
>> index ed222b9c901b..506921095412 100644
>> --- a/block/partitions/amiga.c
>> +++ b/block/partitions/amiga.c
>> @@ -90,7 +90,7 @@ int amiga_partition(struct parsed_partitions *state)
>> }
>>          blk = be32_to_cpu(rdb->rdb_PartitionList);
>>          put_dev_sector(sect);
>> -       for (part = 1; blk>0 && part<=16; part++,
>> put_dev_sector(sect)) {
>> +       for (part = 1; (s32) blk>0 && part<=16; part++,
>> put_dev_sector(sect)) {
>
> Makes sense to me.

Good, now we just need to see whether it does indeed fix the issue.

Cheers,

	Michael
