Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1265EB64DA
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 07:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245389AbjFPHpv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 03:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241144AbjFPHph (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 03:45:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB0B2944;
        Fri, 16 Jun 2023 00:45:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b53910241eso73005ad.2;
        Fri, 16 Jun 2023 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686901535; x=1689493535;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dUQ4h/rPm3CGPVEQXhmcRGAFqssSVeZxrzFM8/+8xM=;
        b=e88zrghBd7AZlhWODvhq9J9ixtKvLrAoTCK+yeHAbA1YPM9Zq1fD9+8kCuDkfO525K
         cs/vL6623M5TMrEf2HKymQiTpPFPg8GCX2pJMItJ47aU1juQjW3SEWqcSSDdV4yBlCZ1
         qJ9Ez+wq4N/BXyGC7jBZ7Z+84QNle+uwrm21CJaCVBNlryQ4fCdVfEbksxbWnqGGlBw0
         qPXyi0j4SfcfrNOfiXKYH0JIe/SO76PFN7j/oOft/8XQVHtB5hfZOmaw2xqdZ2YnTTM5
         YL1jYLvRIP5UrAf8dP7tmW/Q3Zz7sQ1XDMHcpsb+mBeUbLlHEySZLGsYSEKsipzGnOLs
         8NsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901535; x=1689493535;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9dUQ4h/rPm3CGPVEQXhmcRGAFqssSVeZxrzFM8/+8xM=;
        b=SRxJuE6dy/0gqYLn/eqiwC7e4e+Mo+zf11Bq2earXq7Htw/QMD9cjM8G/rNRNLuXnm
         fK2DNrQAKcWn+L/QLyD7L9H7tFp7waLHJVnIhbXufgQ+ErrX6+HROVfD7bfWi/G258au
         TKV2musQc5gMgCGoD6hacn9kaPcXKoQC/pVCud3SU3Gq516g9uZUBhkGuZdo0U5T5x07
         TKeN1VmxWzxOaW9Tv3gTed/JpmVw6awGnRCzZM12/sgw798EvGXon9wuLuv36m/zaRpq
         Z7+ZxNEJP4YZVQTmjiEgwE41YXcaXxXJYDn395nJbe/5Qr4V7BSfUkkbPDqUendGIwEW
         7zGw==
X-Gm-Message-State: AC+VfDwBu1X8OMb2m2pe1CoOI94wY87Q1DoG4kUXXYktjRlNrhaZSgvl
        3usTD7TqyjwSqGnC6xJUcJ1d0rUi1lA=
X-Google-Smtp-Source: ACHHUZ52OjAWRqdKw7PxKZknc3/LmUCbu/qNlfbqlc0LbFapeKqomDaR6cvc5XX6HuWkmL4mu+wq7g==
X-Received: by 2002:a17:903:264e:b0:1a8:ce:afd1 with SMTP id je14-20020a170903264e00b001a800ceafd1mr1187367plb.20.1686901534814;
        Fri, 16 Jun 2023 00:45:34 -0700 (PDT)
Received: from [10.1.1.24] (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id x21-20020a17090300d500b001acad024c8asm11536975plc.40.2023.06.16.00.45.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:45:34 -0700 (PDT)
Subject: Re: [PATCH v10 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230615030837.8518-1-schmitzmic@gmail.com>
 <20230615030837.8518-3-schmitzmic@gmail.com> <20230615041742.GA4426@lst.de>
 <056834c7-89ca-c8cd-69be-62100f1e5591@gmail.com>
 <20230615055349.GA5544@lst.de>
 <CAMuHMdWyQnKUaNtxYjqpxXovFKNPmhQDeCXX=exrqtgOfSFUjw@mail.gmail.com>
 <69ecfff9-0f18-abe7-aa97-3ec60cf53f13@gmail.com>
 <20230616054847.GB28499@lst.de>
 <80ffb46c-b560-7c4e-0200-f9a91350c000@gmail.com>
 <CAMuHMdXpxK2HXJ0s_Fa--sMOAjR8Qt4EVQL2UC7UynMCA6q+1g@mail.gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-m68k@vger.kernel.org, martin@lichtvoll.de,
        fthain@linux-m68k.org, stable@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <fec3fd71-47ae-9d15-a64a-a3a899bee503@gmail.com>
Date:   Fri, 16 Jun 2023 19:45:27 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXpxK2HXJ0s_Fa--sMOAjR8Qt4EVQL2UC7UynMCA6q+1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

Am 16.06.2023 um 19:28 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Fri, Jun 16, 2023 at 9:21 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 16.06.2023 um 17:48 schrieb Christoph Hellwig:
>>> On Fri, Jun 16, 2023 at 07:53:11AM +1200, Michael Schmitz wrote:
>>>> Thanks - now there's two __s32 fields in that header - one checksum each
>>>> for RDB and PB. No one has so far seen the need for a 'signed big endian 32
>>>> bit' type, and I'd rather avoid adding one to types.h. I'll leave those as
>>>> they are (with the tacit understanding that they are equally meant to be
>>>> big endian).
>>>
>>> We have those in a few other pleases and store them as __be32 as well.  The
>>> (implicit) cast to s32 will make them signed again.
>>
>> Where's that cast to s32 hidden? I've only seen
>>
>> #define __be32_to_cpu(x) ((__force __u32)(__be32)(x))
>>
>> which would make the checksums unsigned if __be32 was used.
>>
>> Whether the checksum code uses signed or unsigned math would require
>> inspection of the Amiga partitioning tool source which I don't have, so
>> I've kept __s32 to be safe.
>
> Unsurprisingly, block/partitions/amiga.c:checksum_block() calculates
> a checksum over __be32 words.  The actual signedness of the checksum
> field doesn't matter much[*], as using two-complement numbers, you can
> just assign a signed value to an unsigned field.
> It should definitely be __be32.
>
> [*] I guess it was made signed because the procedure to update the
> check goes like this:
>   1. set checksum field to zero,
>   2. calculate sum,
>   3. store negated sum in checksum field.

Thanks, that explains why the result of checksum_block() is tested 
against zero. Makes sense now.

Will fix in v12 ...

Cheers,

	Michael



>
> Gr{oetje,eeting}s,
>
>                         Geert
>
