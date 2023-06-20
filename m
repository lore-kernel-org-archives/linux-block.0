Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482DBEB64DB
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 21:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjFTVSJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 17:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjFTVSI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 17:18:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF32183;
        Tue, 20 Jun 2023 14:18:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-260a60b4421so1391794a91.1;
        Tue, 20 Jun 2023 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687295886; x=1689887886;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AF9svIo5wed4VaRXMCtXnfa3DTKttSBb3Y4CUJZ4oww=;
        b=krMQNhH2tkIif4Ti0duTDgHloeONJbo3rY9WPWpACQVCjGtjDNnEZ3DthQvP5XdVcU
         YfYlW+VcIgkzlaGbeUQDovNrUkap3XHWCQwJnYIZPf8qEPqGV/9sgsUHO9JAyVHISVv+
         5bb1c8MMtzNbyqbQviH7DrEAHQ9FZFEWiw+t1pJoeOpodq4S05KP8cJlxyV9+fUM3NOi
         4ezPBxy58aFnbPLHP89jxR/zunF9++Q5nVFq2lRwtgtqtiKsDkG9EzgSG/GQVmwjPNps
         1oRVgbN6jYSkcwGlBMZfEkehXxW9R2eCVC+qGwCW/kRpZ1Xn1auKSfMSCHuH2Vp3WMqM
         JTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687295886; x=1689887886;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AF9svIo5wed4VaRXMCtXnfa3DTKttSBb3Y4CUJZ4oww=;
        b=Gj+46PcIEhqn8cJkJ4NXjgo/TVGItKrgSDJloqUtM3HjJ48hqXoi2s/qnlPE5ohW9z
         PqyAwunq2YwmYA64VmjW45Lecx/04DqMgu736/WFkrHBUKRbzCV0OiMZwFNeRiUFag4b
         IWQwCZT+qVjJRkaWXYPf2gNylFC1/XZZzE+Lyx2deVYnvnTWEgCqu8pUFrww+0edgrd5
         RxA8nACa1Ot90w8XjnsqSd1nez0/715St5G9ItpG9qMThn/xV9pHzrNNhD9nPe/0pyQR
         leTlqC/O6Xr6tp1lCBFLxcuJ1MtyamlfMexuuD1W5SXal9HhdsgCoPCutfCbT+5o+s6B
         vS2A==
X-Gm-Message-State: AC+VfDysaM2WjW61Ss7DjeKf4kVlveUfPWq/eMiaaiuDv+AFJ5HzYotS
        BDXDmazQ9ESTrL6JRYUQ7gc=
X-Google-Smtp-Source: ACHHUZ4slyFlMX+XoZa98EhGUO64Nsr0tErmy0b9aP0YV2dMHJkv2xExzQR3ScRLOYOiEMIBPrce0g==
X-Received: by 2002:a17:90a:516:b0:25e:a87b:28cb with SMTP id h22-20020a17090a051600b0025ea87b28cbmr8317556pjh.25.1687295886244;
        Tue, 20 Jun 2023 14:18:06 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:a55d:8ddb:1e3b:925b? ([2001:df0:0:200c:a55d:8ddb:1e3b:925b])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a74c900b0025de9b9542dsm7613958pjl.39.2023.06.20.14.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 14:18:05 -0700 (PDT)
Message-ID: <10e23e7d-d2b0-f540-f0aa-ca83727fa10e@gmail.com>
Date:   Wed, 21 Jun 2023 09:17:58 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 0/3] Amiga RDB partition support fixes
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        jdow <jdow@earthlink.net>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <168729291463.3788860.17194611750755016861.b4-ty@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <168729291463.3788860.17194611750755016861.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Jens!

And a big 'Thank You' to all who helped with suggestions and comments.

Cheers,

     Michael


On 21/06/23 08:28, Jens Axboe wrote:
> On Wed, 21 Jun 2023 08:17:22 +1200, Michael Schmitz wrote:
>> another last version of this patch series, only change
>> in this version is in the patch 2 subject (to better
>> reflect what it's about), and adding Geert's review
>> tag to said patch.
>>
>> I hope I've crossed all i's and dotted all t's now...
>>
>> [...]
> Applied, thanks!
>
> [1/3] block: fix signed int overflow in Amiga partition support
>        commit: fc3d092c6bb48d5865fec15ed5b333c12f36288c
> [2/3] block: change all __u32 annotations to __be32 in affs_hardblocks.h
>        commit: 95a55437dc49fb3342c82e61f5472a71c63d9ed0
> [3/3] block: add overflow checks for Amiga partition support
>        commit: b6f3f28f604ba3de4724ad82bea6adb1300c0b5f
>
> Best regards,
