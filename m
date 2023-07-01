Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B5C0015E
	for <linux-block@archiver.kernel.org>; Sat,  1 Jul 2023 09:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjGAJsl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Jul 2023 05:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGAJsk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Jul 2023 05:48:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BE3C29;
        Sat,  1 Jul 2023 02:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688204882; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KdbtNqylftOo1+PbBsC55VutPhxTjNTKGLp2HbuzERO0BqPmB0X0tXpLNeBCxI7V06
    IU4g7lGfTg7H1tidslsHtnaASa9dojI5SKQ1qDtdZjV4qpgLOkdopIUAbUdwlIY3yuvp
    4/siEAJ99VMoRaN+59J9Samgca1PtIFwlPTCzsLtCrKJvJqXJv46n7SDgdQYwhcEuQfe
    r66a7iFFW1g+09K6npXW6BlnHnuNpIERG8W009XetNyBp+UA3y1vnGiSBK54rS9ikF2Y
    1gUPgDnuUM7LHbpiEHVWTKLb8yx4QOTL3MLTSxyPNahmBN5VFKlUNeJkuUtya1Fc7FuB
    P2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688204882;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qvqpM5AoRX2cCiwKz3Sb461vdD3xeoeZK2q+kBPv04g=;
    b=UQGrMKcjMZv7rhcwx3VmV2SHGm3UfiXbZ8vZTqnym9j2ANoeqmTRVtpOkh2X+Prz4u
    +ldDStW8ykPcRVzoHTS8o1ezq8KV6jNKUkNBLvWZkwX98ikJYy3JkvSOiQQvB5nVB1UP
    aei0CgcXG0fFREjUvUFg1vVeOO5/kpOpP2lK8K1m1VTVg2ZUXX6fm4qWA4jjoitHRB3P
    bLfMLDHKdt6PWebCPLdRu+WPqqCm2OJPmcTQ6bUegLKKRb4QEVXAM8ScT34APMMqMsFN
    nGUf+9Z0XTYf+i0IiQP00tQbjko/ajlS1XFG+WpAyyc5ltXRoXoRuDPFq+KVEKVMBhlC
    TuHg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688204882;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qvqpM5AoRX2cCiwKz3Sb461vdD3xeoeZK2q+kBPv04g=;
    b=eYqf046Al535sFwuIPIweoln2AY2veN+CgyJP1JADGDRSGyxuiApVwJcyR9GEesvwU
    aM+0HqHv+Or3ixRd3lMKNCXD1ULa4Sqpl7iiG/PYnUVXEkUV8ytCLnUFuqGsQ+tA6b9p
    is8LuNE7M7PsYwyxF3HEhW5bPCG8d015L5B/apWqxn/Hx4QcUXQGi+b0ZdqFuNtAQ62e
    t/VC8JoJgrKVDURWLWrdk46lbg05sPA8EcRO/JD2bLb1GoAxRenlT8tcLL9N0GtWF4Z2
    VwyS+tlP91BHaP5f1wvx+JQYcUj2MNiPRxYhIa7dJAAeqFyLv1NUW3dtZ1uLhp1wVzYh
    oHVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688204882;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qvqpM5AoRX2cCiwKz3Sb461vdD3xeoeZK2q+kBPv04g=;
    b=166uqhK1qpchihhOp46ND9BsxEC6UaR1JJIRQ47pTlRBlR6QId5kAF9Q1jjxtWuLq6
    yAksTR2D2isbYQxbQADA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBfio0GngadwjR6CBYqLfA6c5k/Fdf2SzuGLMLzg=="
Received: from [IPV6:2a02:8109:8980:4474:4196:3fea:dfa5:89da]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id N28a51z619m1sPS
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 1 Jul 2023 11:48:01 +0200 (CEST)
Message-ID: <b9600d91-6a25-746e-0769-4d0e31038da5@xenosoft.de>
Date:   Sat, 1 Jul 2023 11:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        hch@lst.de, martin@lichtvoll.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <3e3ce346-f627-4adf-179d-b8817361e6e3@xenosoft.de>
 <94d46446-97fc-9e92-2585-71c18e65b64a@gmail.com>
Content-Language: de-DE
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <94d46446-97fc-9e92-2585-71c18e65b64a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01 July 2023 at 10:11 am, Michael Schmitz wrote:
> Hi Christian,
>
> Am 01.07.2023 um 18:40 schrieb Christian Zigotzky:
>> On 01 July 2023 at 04:35 am, Michael Schmitz wrote:
>>> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
>>> fails the 'blk>0' test in the partition block loop if a
>>> value of (signed int) -1 is used to mark the end of the
>>> partition block list.
>>>
>>> This bug was introduced in patch 3 of my prior Amiga partition
>>> support fixes series, and spotted by Christian Zigotzky when
>>> testing the latest block updates.
>>>
>>> Explicitly cast 'blk' to signed int to allow use of -1 to
>>> terminate the partition block linked list.
>>>
>>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>>> Fixes: b6f3f28f60 ("Linux 6.4")
>>> Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
>>> Cc: <stable@vger.kernel.org> # 6.4
>>> Link:
>>> https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de 
>>>
>>>
>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>> ---
>>>   block/partitions/amiga.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
>>> index ed222b9c901b..506921095412 100644
>>> --- a/block/partitions/amiga.c
>>> +++ b/block/partitions/amiga.c
>>> @@ -90,7 +90,7 @@ int amiga_partition(struct parsed_partitions *state)
>>>       }
>>>       blk = be32_to_cpu(rdb->rdb_PartitionList);
>>>       put_dev_sector(sect);
>>> -    for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
>>> +    for (part = 1; (s32) blk>0 && part<=16; part++,
>>> put_dev_sector(sect)) {
>>>           /* Read in terms partition table understands */
>>>           if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
>>>               pr_err("Dev %s: overflow calculating partition block
>>> %llu! Skipping partitions %u and beyond\n",
>> Hello Michael,
>>
>> Thanks for your patch.
>>
>> I patched the latest git kernel source code with your patch today but
>> unfortunately the kernel has reported a bad geometry. (EXT4-fs (sda4):
>> bad geometry: block count ...)
>>
>> dmesg | grep -i sda
>>
>> [    4.025449] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks:
>> (2.00 TB/1.82 TiB)
>> [    4.071978] sd 0:0:0:0: [sda] 4096-byte physical blocks
>> [    4.119333] sd 0:0:0:0: [sda] Write Protect is off
>> [    4.165958] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> [    4.212921] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
>> enabled, doesn't support DPO or FUA
>> [    4.259469] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
>> [    4.502519]  sda: RDSK (512) sda1 (DOS^G)(res 2 spb 2) sda2
>> (SFS^B)(res 2 spb 1) sda3 (SFS^B)(res 2 spb 2) sda4 ((res 2 spb 1)
>
> Good - all partitions are recognized again as they ought to be.
>
>> [    4.551981] sd 0:0:0:0: [sda] Attached SCSI disk
>> [   82.421727] EXT4-fs (sda4): bad geometry: block count 319655862
>> exceeds size of device (317690430 blocks)
>
> Now that may be a new bug... or just a filesystem created with 
> incorrect assumptions about partition size.
>
> That is the partition that had reported:
>
>> sda: p4 size 18446744071956107760 extends beyond EOD, truncated
>
> with my patches backed out? I wonder what size mkfs used when creating 
> the filesystem?
>
> The calculated size was clearly incorrect, but the truncated size may 
> also be incorrect. The truncated size is likely that of a partition 
> extending to the end of the disk, but your actual p4 size may have 
> been smaller (your parted -l output had 1992GB which is 8 GB shorter 
> than to EOD).
>
> On the face of it, this does not look like a new bug in the RDB 
> partition code, but I'd rather verify that by inspecting the RDB 
> contents and carrying out the calculations by hand.
>
> Can you please send a copy of the RDB (first few kB of the disk, 
> something like dd if=/dev/sda of=rdb-sda.img bs=512 count=16 should 
> do), and the output of cat /proc/partitions when running a kernel from 
> before my RDB patches?
>
>
Copy of the RDB: https://www.xenosoft.de/rdb-sda.img

cat /proc/partitions:

major minor  #blocks  name

    8        0 1953514584 sda
    8        1     119088 sda1
    8        2    2100096 sda2
    8        3  672670920 sda3
    8        4 1278623448 sda4
   11        0    1048575 sr0
    8       32     250880 sdc
    8       33     249856 sdc1
    8       16  234431064 sdb
    8       17  144364512 sdb1
    8       18          1 sdb2
    8       19   18500608 sdb3
    8       20   40717312 sdb4
    8       21   14684160 sdb5
    8       22   16161792 sdb6
    8       48       1440 sdd
    8       49       1439 sdd1

Thanks

