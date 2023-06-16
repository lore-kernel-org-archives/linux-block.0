Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41474EB64DC
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 07:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbjFPHva (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241738AbjFPHv2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 03:51:28 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22D42947;
        Fri, 16 Jun 2023 00:51:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-62fe6773c4fso4374436d6.2;
        Fri, 16 Jun 2023 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686901885; x=1689493885;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S39clMqWvsAjffMAgh5mzXycA6WYRm5OAbh2nZGDiY=;
        b=YEffHRf/ZsQzJ2JcOR8g8WLkwFnEkG86gOQoYTkK7xfE+z8c9+xW6BTZ8ktkP+BqCC
         47RgdGJdNalZ+z/SbYbtcvfYOI3pMAs9/ySMnUw9kNwvSlBp4U1v+Bvi8DN3KZS7RP6x
         r6Un+VTd24B83FbrNA+aESOY30F66u9kV/mLVHzNO4iE1LD/0zdwp0kY6IMqW71tM5eu
         R6MFPxQYBDNLd6xUDo01bLHGEH3DlGbztDDoxCTofsDD7vST1q+yoKwx6qYR+3p/do0S
         ieYZcmNhSpNXsqwHSi8Wgrpy0UuD5G+GcdPx8sXRDiRj9gRFJ0M0ETZYK1PlfmBdm26M
         8GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901885; x=1689493885;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7S39clMqWvsAjffMAgh5mzXycA6WYRm5OAbh2nZGDiY=;
        b=Bw1l6X5djLlkPZNx2+VMRLM0nJmZZ712sy72fWHD8qp4mnKorR/rUIkqtIVSW9b3x0
         W6z0uwJ+q4pFNiBdNHOpKhG7cVFbu8WZWXj/Olb5sh89RFitBeQWxRJxGvHR20ofwRl5
         WXuWZ46jwbg1qHi+9PpWHQT0dcrMnl7wD4pVUi4Ob9UVjmdN+42NowRV4PfhcoULAPbf
         YC8Tnv/qfJj74jw+jOAPMxmmeO8CJsuH7YiJGBZQjyaUzJF4IriAXik74L0fuBBSJAdJ
         wQPhSGKuGoCTZvW6PuQf7xDstfMmUvjIvvFXa6V24/xHUS7b5peK0Btnx7tEIBdVw5lA
         a0hQ==
X-Gm-Message-State: AC+VfDwbrgUPD1XaNp+T9DlCIhF7GxQx5+zrp/r02PVo0maZLYg6Phtv
        PKFWyl2yK914kCA02u/nlisCwInHDoA=
X-Google-Smtp-Source: ACHHUZ7x9PHRva6tOp7zrxzmsl5KW1QP+U40WeH4z6dL8QvvX0lO+xaAbvI30OYLLiBwlsr43KFblQ==
X-Received: by 2002:a05:6214:e49:b0:623:9ac1:a4be with SMTP id o9-20020a0562140e4900b006239ac1a4bemr1669782qvc.12.1686901884755;
        Fri, 16 Jun 2023 00:51:24 -0700 (PDT)
Received: from [10.1.1.24] (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id h126-20020a636c84000000b0050be8e0b94csm13642763pgc.90.2023.06.16.00.51.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:51:24 -0700 (PDT)
Subject: Re: [PATCH v10 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
To:     Christoph Hellwig <hch@lst.de>
References: <20230615030837.8518-1-schmitzmic@gmail.com>
 <20230615030837.8518-3-schmitzmic@gmail.com> <20230615041742.GA4426@lst.de>
 <056834c7-89ca-c8cd-69be-62100f1e5591@gmail.com>
 <20230615055349.GA5544@lst.de>
 <CAMuHMdWyQnKUaNtxYjqpxXovFKNPmhQDeCXX=exrqtgOfSFUjw@mail.gmail.com>
 <69ecfff9-0f18-abe7-aa97-3ec60cf53f13@gmail.com>
 <20230616054847.GB28499@lst.de>
 <80ffb46c-b560-7c4e-0200-f9a91350c000@gmail.com>
 <20230616072554.GA30156@lst.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, martin@lichtvoll.de,
        fthain@linux-m68k.org, stable@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <3396f375-e61b-a9ef-9c91-5f3a9b6d6b0d@gmail.com>
Date:   Fri, 16 Jun 2023 19:51:17 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230616072554.GA30156@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

Am 16.06.2023 um 19:25 schrieb Christoph Hellwig:
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
> Well, the return value of be32_to_cpu is going to be a assigned to a,
> presumably signed, variable.  With that you get an implicit cast.

I see - as Geert explained, signed or unsigned doesn't matter for the 
type of checksum algorithm used in this case, so there is no potential 
for confusion once you think about it (which I didn't, obviously).

Cheers,

	Michael


