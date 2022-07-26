Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A7CC19F29
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 22:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiGZW2P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 18:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGZW2P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 18:28:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720E275F2;
        Tue, 26 Jul 2022 15:28:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso317042pjd.3;
        Tue, 26 Jul 2022 15:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cUakA031uAGu8Qe1zvGTpC9ti0G9n32ARq56hwimi+k=;
        b=Om+qM1FEpuSbNmSbFvVze5NdmtUYdZBdkRttycVxJm+9guJzRMmRUuWjfWcusPv54j
         oTqcEJ6nZ1CR6O3KuKr08FcCm92NOf6k46WnpQncvXwhmQI4IJCkCfaaZSvi0B1ZlSin
         Y1l84BsiWY+uLUKxHRKTY69XHAp739L3+uOmO6DV357sFnEUNYwdgJBEK8Feg/7FVDts
         jFc0pVHY2Soln6MZITpfd1BCIvRCEBS0lQKEHOCxb82jwUJM6HjB47IGqlBbjtkTHUQU
         FjjNX7+eKHgfzkA8eOfgImfkSNchl0ZVmq7B19Ea9KKOAOi57jEJ+BUp6DuA87++xENl
         qqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cUakA031uAGu8Qe1zvGTpC9ti0G9n32ARq56hwimi+k=;
        b=anqfeJDGF9sOOp5zUiWynVw6arwPmj5rJUkc4G7fmmzACkIuKwPnKi5uSKfcYiWydT
         VB0oNz1CtwNZaYUPlZRKWQwtL6IGIM3C0KnesWr13PkJk8p7ac7+hpAciN1ss3gkJPFB
         rRHToMbyFNmLNL2kyEgPp52UveVGg2m+IIAXQvUiZQgoxmuFpnJ+o3k2xisKNt9T1DOk
         WyycfRI3BHBboNB1eVe+lyeJqUYG2M8Fm3v/UV+fH382ulWjRD+yzcAygZFW8Ztv4HN7
         vneX+W/S3uhHUvuV2IZUWwZiXcmbyEaY3yfXOq0rnUGr17MbXdyb3H7yP4amYgKVS4ch
         CKPQ==
X-Gm-Message-State: AJIora/0XGSvdtqwxjt7HFY4Lhb7ud1sdmHFjqpF2Hjp9C6SWYG440Zv
        JX8M70vbifrPBBvdo4lF+LKc7vw23Pg=
X-Google-Smtp-Source: AGRyM1tQpmi7LswiniSLvv3ky+C0mF2WQ6FyvOdentniXQrQPQ6x6AgVAkt7PuFH6C7kZEWyxj96Yw==
X-Received: by 2002:a17:90b:681:b0:1f2:147a:5e55 with SMTP id m1-20020a17090b068100b001f2147a5e55mr1174109pjz.159.1658874493899;
        Tue, 26 Jul 2022 15:28:13 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:a0c2:b058:643a:c5f9? ([2001:df0:0:200c:a0c2:b058:643a:c5f9])
        by smtp.gmail.com with ESMTPSA id 1-20020a630d41000000b00412a708f38asm10479254pgn.35.2022.07.26.15.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 15:28:13 -0700 (PDT)
Message-ID: <c0911dfc-2ece-e7de-640d-2b4c010569ac@gmail.com>
Date:   Wed, 27 Jul 2022 10:28:08 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 2/2] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org
References: <20220726045747.4779-1-schmitzmic@gmail.com>
 <20220726045747.4779-3-schmitzmic@gmail.com> <Yt/TQOJQZEhZE+2p@infradead.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <Yt/TQOJQZEhZE+2p@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On 26/07/22 23:42, Christoph Hellwig wrote:
> On Tue, Jul 26, 2022 at 04:57:47PM +1200, Michael Schmitz wrote:
>> The Amiga partition parser module uses signed int for partition sector
>> address and count, which will overflow for disks larger than 1 TB.
>>
>> Use u64 as type for sector address and size to allow using disks up to
>> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
>> format allows to specify disk sizes up to 2^128 bytes (though native
>> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
>> u64 overflow carefully to protect against overflowing sector_t.
>>
>> Bail out if sector addresses overflow 32 bits on kernels without LBD
>> support.
>>
>> This bug was reported originally in 2012, and the fix was created by
>> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
>> discussed and reviewed on linux-m68k at that time but never officially
>> submitted (now resubmitted as separate patch).
>> This patch adds additional error checking and warning messages.
>>
>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
>> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
>> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>>   block/partitions/amiga.c | 111 +++++++++++++++++++++++++++++++--------
>>   1 file changed, 89 insertions(+), 22 deletions(-)
>>
>> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
>> index f98191545d9a..7356b39cbe10 100644
>> --- a/block/partitions/amiga.c
>> +++ b/block/partitions/amiga.c
>> @@ -11,10 +11,18 @@
>>   #define pr_fmt(fmt) fmt
>>   
>>   #include <linux/types.h>
>> +#include <linux/mm_types.h>
>> +#include <linux/overflow.h>
>>   #include <linux/affs_hardblocks.h>
>>   
>>   #include "check.h"
>>   
>> +/* magic offsets in partition DosEnvVec */
>> +#define NR_HD	3
>> +#define NR_SECT	5
>> +#define LO_CYL	9
>> +#define	HI_CYL	10
> The last line has a tab after the #define while the previous three
> don't.  Pick one style and stick to it for the others.
>
>>   		if (!data) {
>> -			pr_err("Dev %s: unable to read RDB block %d\n",
>> -			       state->disk->disk_name, blk);
>> +			pr_err("Dev %s: unable to read RDB block %llu\n",
>> +			       state->disk->disk_name, (u64) blk);
> No need for the various printk casts, a sector_t is always an
> unsigned long long.

Thanks, wil fix (and address the other issues raised).

Cheers,

     Michael


