Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43481EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 04:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241513AbjFOEu4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 00:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbjFOEuy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 00:50:54 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937DDA7;
        Wed, 14 Jun 2023 21:50:53 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b162127472so4955016a34.0;
        Wed, 14 Jun 2023 21:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686804652; x=1689396652;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0rcPg8ZW2YZLxnnxD+jjfZgANWFm8aOmD5pKRuyphA=;
        b=bmP4kmp8luXG6P3mkw6RZ2InFAITOxNxJsnDb0kKTX+n3pAc4K13DIXlRV7FBs13YS
         BsgKRIyLCnjrsnx6gIg+Qg5FmkUpjLV0GuMzut3mWM/w3IAGks07acoDGFRcD2wIgMSV
         VYF3onMqmNhlMwzZC6hAvyqlgmiy/HXDWlveeAj/bbYAORHcTA16Koyh6p9bFLdeIzpv
         2FH4sB5tBbHRk/N8t0JzR8xtC8SQD1yipQOO05nu2djLlP//M6XpRFIGrdXjd7orJOgG
         kMZAeCQMosOn4pi+AbAbAG7fGu/Ngnsexyyn6e5FhiHlsZTQDHuYYuHbJCMKN1fXDGTH
         EMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686804652; x=1689396652;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h0rcPg8ZW2YZLxnnxD+jjfZgANWFm8aOmD5pKRuyphA=;
        b=HjOZ3oT7qoZUNItIILimHgopF2I0dQFpMopmlmXWKs961AALoGAWcjTJ+E8pnDeuZX
         dMH58+UjmzE3n0BpH1rhQYqcgKITZahbmFZCSlPwEj+Ho3KLWOK/USdKsDUxHi8smh69
         JonTPNnXKV05SLmDgBw5QcIugbd6kVKO4ssE9SohH+CEV/5dHfDVbr9EPyJqGHXfkKMi
         hAIHYXY110wfx0mSc7suyq2GQwarHdNx5Z1/5y7ojxK3iDBc7UzhmaHThZqPIzKjZnN/
         ZLTnTPWaINwTkK/Bb0ucPjHUHYP1iDsABs8H+b61z0iTV9iYyWQOGelC2zSxDBqEo7dM
         AcAg==
X-Gm-Message-State: AC+VfDxop3KcprT1Hv9VO7O/JJ5im2xnd67+vSXgKU2XufpefdZSJVly
        9dZmVIJF6nE66g57nKM15ZrydEU3/7g=
X-Google-Smtp-Source: ACHHUZ73QlXQkAyEtzEOaI4uOM93r5cW86eZ14Nx94gQyTzuI71TGvKHas8lgTSHli6x+nmeuFCCiQ==
X-Received: by 2002:a9d:7b44:0:b0:6b2:ae03:ff00 with SMTP id f4-20020a9d7b44000000b006b2ae03ff00mr15204952oto.13.1686804652434;
        Wed, 14 Jun 2023 21:50:52 -0700 (PDT)
Received: from [10.1.1.24] (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id r64-20020a632b43000000b0054fe6bae952sm926566pgr.4.2023.06.14.21.50.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jun 2023 21:50:51 -0700 (PDT)
Subject: Re: [PATCH v10 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
To:     Christoph Hellwig <hch@lst.de>
References: <20230615030837.8518-1-schmitzmic@gmail.com>
 <20230615030837.8518-3-schmitzmic@gmail.com> <20230615041742.GA4426@lst.de>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        martin@lichtvoll.de, fthain@linux-m68k.org, stable@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <056834c7-89ca-c8cd-69be-62100f1e5591@gmail.com>
Date:   Thu, 15 Jun 2023 16:50:45 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230615041742.GA4426@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

thanks for your comments!

Am 15.06.2023 um 16:17 schrieb Christoph Hellwig:
> On Thu, Jun 15, 2023 at 03:08:36PM +1200, Michael Schmitz wrote:
>> +/* MSch 20230615: any field used by the Linux kernel must be
>> + * annotated __be32! If any fields require increase to 64
>> + * bit size, rdb_ID _must_ be changed!
>> + */
>
> This is a really weird comment.  If you change on-disk format it
> is a different format and needs to be marked as such, sure.

I concede this isn't relevant to the matter at hand, and it's something 
that _should_ be obvious. This came up in my off-list discussion with 
Joanne Dow as a caveat for future huge disk sizes, so I thought I'd add 
it to the comment.

> And as far as I can tell everything that is a __u32 here should
> be an __be32 because it is a big endian on-disk format.  Why
> would you change only a single field?

Because that's all I needed, and wanted to avoid excess patch churn. 
Plus (appeal to authority here :-)) it's in keeping with what Al Viro 
did when the __be32 annotations were first added.

I can change all __u32 to __be32 and drop the comment if that's preferred.

Cheers,

	Michael


