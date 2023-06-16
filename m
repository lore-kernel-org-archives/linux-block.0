Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E420EEB64D8
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 07:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbjFPHVv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 03:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245084AbjFPHV3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 03:21:29 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF96030FB;
        Fri, 16 Jun 2023 00:21:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b525af07a6so2731945ad.1;
        Fri, 16 Jun 2023 00:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686900060; x=1689492060;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrtEi7hlzKkUlwcufPInEFlIubkp8fe9gW38ZbKM+eg=;
        b=JsuFpLF9zakTA9YWgYezQk1TUO8xzurBvXqlL3OFB99lIsEm3qhVOU6GUiZH15Hv6u
         Lgoe8PU3rqNGTMU6ytNbosb6kWU+WUAYSdvrVgZNc7efnqxHHWSyKeklXISi2ZExVkFH
         nwF3tqoBrrJQcRdVR0jBHgStLp8eJeFZ5iccium/PWu3YJ78iNRHkQnO2iNUpwGPCU0j
         c5ko6Unj6Aji3DF2KtwsVTVWEr0qSJ4MxqvQnXrkGMwR9CiLe+jn2b8myHHjwYJdGCuE
         dYY64cvbTn5/haPTVP/62+mvoioK4YxcRWza5Itt8kPgIjiLVpwdkmniRIR4kSBlrxCs
         lsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686900060; x=1689492060;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JrtEi7hlzKkUlwcufPInEFlIubkp8fe9gW38ZbKM+eg=;
        b=ee4lmfiB8u7drarpcH6IbZS+WxMY1qAx5Q1DUvIc40T1i2yuryp+8RbADb1b9fLuQp
         HHJHYhdPTyzbLuv97JiIV3Nq5wIUAsLtCb3J9jDXe3IgKhA4p0otqzU85mc+E0k3XLE2
         1u7NPf3NOeox1y1HebA2/Tv176jMThqtJu4v7Dvf6gkNwVrddpiCJ/Zey/cDReDHDZ+3
         VgPNUqCO9bzB586NpEZJmj1xVGd5rpRwE+y+nqV+oAtP2teGbq7AHu0FGAs3cDojDZqp
         WWos3ya5fIyVu1WY/O6CaeLBz3kS0bxxoGTnIKRBhPzsURBjc2FS58x6RQK4TZqeXjX/
         q3dA==
X-Gm-Message-State: AC+VfDwTeNh4+FhspTAYd5ro6WyhN95yKuen4Ic1iY3W4SUI5Ys1R6kp
        0z99CRhEoQArFUFxt3X2Q6Dzhd4zRNA=
X-Google-Smtp-Source: ACHHUZ4ury2YljOkQx0+2BcslguYPw0P192uFbYQRmnPf2fZ2KB+GXinKnZu1bF1M21e8Y3ssSNhOw==
X-Received: by 2002:a17:902:db0d:b0:1b2:6054:8629 with SMTP id m13-20020a170902db0d00b001b260548629mr947360plx.52.1686900059695;
        Fri, 16 Jun 2023 00:20:59 -0700 (PDT)
Received: from [10.1.1.24] (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902c38100b001a52c38350fsm630171plg.169.2023.06.16.00.20.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:20:59 -0700 (PDT)
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
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, martin@lichtvoll.de,
        fthain@linux-m68k.org, stable@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <80ffb46c-b560-7c4e-0200-f9a91350c000@gmail.com>
Date:   Fri, 16 Jun 2023 19:20:52 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230616054847.GB28499@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

Am 16.06.2023 um 17:48 schrieb Christoph Hellwig:
> On Fri, Jun 16, 2023 at 07:53:11AM +1200, Michael Schmitz wrote:
>> Thanks - now there's two __s32 fields in that header - one checksum each
>> for RDB and PB. No one has so far seen the need for a 'signed big endian 32
>> bit' type, and I'd rather avoid adding one to types.h. I'll leave those as
>> they are (with the tacit understanding that they are equally meant to be
>> big endian).
>
> We have those in a few other pleases and store them as __be32 as well.  The
> (implicit) cast to s32 will make them signed again.

Where's that cast to s32 hidden? I've only seen

#define __be32_to_cpu(x) ((__force __u32)(__be32)(x))

which would make the checksums unsigned if __be32 was used.

Whether the checksum code uses signed or unsigned math would require 
inspection of the Amiga partitioning tool source which I don't have, so 
I've kept __s32 to be safe.

Thanks for reviewing v11!

Cheers,

	Michael
