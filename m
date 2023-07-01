Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84530C001B0
	for <linux-block@archiver.kernel.org>; Sat,  1 Jul 2023 08:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGAILl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Jul 2023 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAILk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Jul 2023 04:11:40 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6916892;
        Sat,  1 Jul 2023 01:11:38 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a38953c928so957391b6e.1;
        Sat, 01 Jul 2023 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688199097; x=1690791097;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lczVavI3GPoH73StmvSW4PVDkyubCsjg2Euu15STfgY=;
        b=E8mtF+1ZV5N2PBpGe29lir/8C0MDKz4ByD9eunVXYgbwkoBP5RMn5HRrS5vxMrtA2r
         sK/TryNiidLMwXxciWuoD8zENfxGVlon0/UKiwxPHtId3z+JFdFdNF4d+5XD8lhX/QFB
         9skXU9qGjzC2+0tkvDpFSxgLhEuBy3usPDS9sC3j2xoXelXLulWyWza+jXeg21HEjbqv
         HWyEQh4GraLUKV4Kr7c5yybylY+oaTWRoHIcT4Z9Q+5gQbMR7VzKtbiZqrmE56o3nVaa
         t3MOp/K3/XWaBGM/Tu5oewjGZ1qOXu9crPofCJqZSrjI3wH68lB3wc3KDvg3FJu3z0A/
         p4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688199097; x=1690791097;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lczVavI3GPoH73StmvSW4PVDkyubCsjg2Euu15STfgY=;
        b=aVWAONA3ERdTPLICGMebHyyCCD+/Wz74CnxOt9JvO2K43K11Ig7vFFdO31Q6Ol0Mjb
         8tJ3ScIrN6R6OzGltLchPTwxR8NN8KVvDpCFqTYtkTSLaG2WcEojCmORsYhHQd5QYclO
         0VdOkxPVD0kY7sPruazuVvPRLM4XoCObV43YcV0K9LmRt/az0JAoNDy1EcSrnSG4yNnC
         9AbO6Dkh67W2RvgG9A3tyj35f0PH/iQtc3XsXvdN+TKzYD8zwoPSHKwkFX0VjeB75OKE
         f9zb0U3PWlEEKPPq6IGHF4FmwE3l2h63cPWM/d23yL8AH20z3K/t6kQzObjFU4VRpeBc
         Kvyg==
X-Gm-Message-State: AC+VfDx/XcVCL3rHenJziPtDS5oWervYhSX8sbKFUsFBRo+0uEV65v5t
        ZK8olvhDtKzK25v4qfjJ8V8+gJ0Nv0X48g==
X-Google-Smtp-Source: ACHHUZ5WnMyW1GR+UDCwHU8M0SPLhPkv/wpxnXsjl16B5kcnDJgp+oAuwYdRrtS4OSHytlm7jkj+XA==
X-Received: by 2002:a05:6808:1781:b0:39e:b4d3:283f with SMTP id bg1-20020a056808178100b0039eb4d3283fmr6029726oib.7.1688199097669;
        Sat, 01 Jul 2023 01:11:37 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id k6-20020aa790c6000000b00681be8ebc00sm4716114pfk.95.2023.07.01.01.11.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2023 01:11:37 -0700 (PDT)
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        linux-block@vger.kernel.org
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <3e3ce346-f627-4adf-179d-b8817361e6e3@xenosoft.de>
Cc:     axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        hch@lst.de, martin@lichtvoll.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <94d46446-97fc-9e92-2585-71c18e65b64a@gmail.com>
Date:   Sat, 1 Jul 2023 20:11:29 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <3e3ce346-f627-4adf-179d-b8817361e6e3@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christian,

Am 01.07.2023 um 18:40 schrieb Christian Zigotzky:
> On 01 July 2023 at 04:35 am, Michael Schmitz wrote:
>> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
>> fails the 'blk>0' test in the partition block loop if a
>> value of (signed int) -1 is used to mark the end of the
>> partition block list.
>>
>> This bug was introduced in patch 3 of my prior Amiga partition
>> support fixes series, and spotted by Christian Zigotzky when
>> testing the latest block updates.
>>
>> Explicitly cast 'blk' to signed int to allow use of -1 to
>> terminate the partition block linked list.
>>
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Fixes: b6f3f28f60 ("Linux 6.4")
>> Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
>> Cc: <stable@vger.kernel.org> # 6.4
>> Link:
>> https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
>>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> ---
>>   block/partitions/amiga.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
>> index ed222b9c901b..506921095412 100644
>> --- a/block/partitions/amiga.c
>> +++ b/block/partitions/amiga.c
>> @@ -90,7 +90,7 @@ int amiga_partition(struct parsed_partitions *state)
>>       }
>>       blk = be32_to_cpu(rdb->rdb_PartitionList);
>>       put_dev_sector(sect);
>> -    for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
>> +    for (part = 1; (s32) blk>0 && part<=16; part++,
>> put_dev_sector(sect)) {
>>           /* Read in terms partition table understands */
>>           if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
>>               pr_err("Dev %s: overflow calculating partition block
>> %llu! Skipping partitions %u and beyond\n",
> Hello Michael,
>
> Thanks for your patch.
>
> I patched the latest git kernel source code with your patch today but
> unfortunately the kernel has reported a bad geometry. (EXT4-fs (sda4):
> bad geometry: block count ...)
>
> dmesg | grep -i sda
>
> [    4.025449] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks:
> (2.00 TB/1.82 TiB)
> [    4.071978] sd 0:0:0:0: [sda] 4096-byte physical blocks
> [    4.119333] sd 0:0:0:0: [sda] Write Protect is off
> [    4.165958] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    4.212921] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    4.259469] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
> [    4.502519]  sda: RDSK (512) sda1 (DOS^G)(res 2 spb 2) sda2
> (SFS^B)(res 2 spb 1) sda3 (SFS^B)(res 2 spb 2) sda4 ((res 2 spb 1)

Good - all partitions are recognized again as they ought to be.

> [    4.551981] sd 0:0:0:0: [sda] Attached SCSI disk
> [   82.421727] EXT4-fs (sda4): bad geometry: block count 319655862
> exceeds size of device (317690430 blocks)

Now that may be a new bug... or just a filesystem created with incorrect 
assumptions about partition size.

That is the partition that had reported:

> sda: p4 size 18446744071956107760 extends beyond EOD, truncated

with my patches backed out? I wonder what size mkfs used when creating 
the filesystem?

The calculated size was clearly incorrect, but the truncated size may 
also be incorrect. The truncated size is likely that of a partition 
extending to the end of the disk, but your actual p4 size may have been 
smaller (your parted -l output had 1992GB which is 8 GB shorter than to 
EOD).

On the face of it, this does not look like a new bug in the RDB 
partition code, but I'd rather verify that by inspecting the RDB 
contents and carrying out the calculations by hand.

Can you please send a copy of the RDB (first few kB of the disk, 
something like dd if=/dev/sda of=rdb-sda.img bs=512 count=16 should do), 
and the output of cat /proc/partitions when running a kernel from before 
my RDB patches?

> I can't mount the ext4 partition on the RDB disk and booting isn't
> possible as well.

I suppose the ext4 filesystem must be resized to match the actual 
partition size. I don't think that can be done on a live, mounted 
filesystem. You may have to hook up the disk to another Linux host for 
that, and use resize2fs there (or boot a ramdisk containing that tool).

Cheers,

	Michael

>
> Thanks,
> Christian
