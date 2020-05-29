Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD2FC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 21:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A3E20707
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 21:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="WZeC7eO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgE2Vzi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2Vzh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 17:55:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B0BC08C5C9
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 14:55:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f185so5626530wmf.3
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=y+7fPyOVJN5kEZ9dPieR6MlsnghgeDslNqLeQyzk6T0=;
        b=WZeC7eO7/F1ZaHD2HPukUdjFIz2gU316B+8AUCkZ3RKsm7iLEROxDs+nbuAmSb/M1D
         oto7q3ImBObrsf7Z8ZjIa2xJvNFfpmhYKUXEMNdbGPul2Odv8xHsR0jxFRbs75pFsx8s
         tEBmiGdLzbVZNYQ5xTX0vEWNkGPpXNroUaoy77ja1l5tGYab04onKEOIRN3Mi46GrMtQ
         SetD/TtpId/Ilf7VGL1u8VPwxrB29EEl3tywWnAl0i+PVtPjDP3lxNZ07IpbuOUE4a55
         fiblyxy3HtslcCuCq66nOo+R7FDVhxyx46HZvQ+KZjC/3rkGtvP+LfVqOmpJFfg5Znu7
         Qzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=y+7fPyOVJN5kEZ9dPieR6MlsnghgeDslNqLeQyzk6T0=;
        b=tBa6qGjI3Qj9aMxzYZG9GVXZfyiLfzXlaikRDxwgXN9gMXhnkP2yYKjtSjz9ITWycY
         6NaVdUP+RucK/GPw94/HL5SdMYlHOmcf/7MYVhzn34C2U7AHZRXgzDJ+3kYuBljPn94v
         wjQ/1SBMnVxaJxKD+mvfFA/AyvgAhaOBGOFkD8VT+ggEirOtQiR7l+yCRsmE37/7DSuD
         Sujx/T0cVCXNen4m1k90cNTbkA/Qlnv4BMDnvccxHn1BKxg6zzGgwyDVAVg4G4rnp7xR
         Q5UckJncSDMttKICka5qthVS4Va3AbvDpoFm0xB3IrxJGlcaGEr0jzgaGhvrKCFWwCpl
         x8Cw==
X-Gm-Message-State: AOAM530n29gytn3hXpVBQtwhoDwzwxVKfXsm6lHHwx73iUIO7RB+RE6d
        wNwGTlCZ7VUiELTrwrU24S0x/kQevSefSw==
X-Google-Smtp-Source: ABdhPJwebDU0toeDqVExcoUsOjyNPjev/ummN9l/P8IRsg1/RBgPJu0TE/gEy3JksZSZdsnGz7qe6A==
X-Received: by 2002:a05:600c:3cf:: with SMTP id z15mr10058213wmd.24.1590789335789;
        Fri, 29 May 2020 14:55:35 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4826:7300:a436:5e5d:3e25:d8b3? ([2001:16b8:4826:7300:a436:5e5d:3e25:d8b3])
        by smtp.gmail.com with ESMTPSA id t14sm5080616wri.7.2020.05.29.14.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 14:55:35 -0700 (PDT)
Subject: Re: [PATCH 0/4] cleanup for blk-wbt and blk-throttle
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <f308bc7f-083a-d0f3-aad2-b353c241dbde@cloud.ionos.com>
Date:   Fri, 29 May 2020 23:55:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Gently ping.

On 5/9/20 12:00 AM, Guoqing Jiang wrote:
> Hi,
>
> Find some functions can be removed since there is no caller of them when
> read the code.
>
> Thanks,
> Guoqing
>
> Guoqing Jiang (4):
>    blk-throttle: remove blk_throtl_drain
>    blk-throttle: remove tg_drain_bios
>    blk-wbt: remove wbt_update_limits
>    blk-wbt: rename __wbt_update_limits to wbt_update_limits
>
>   block/blk-throttle.c | 63 --------------------------------------------
>   block/blk-wbt.c      | 16 +++--------
>   block/blk-wbt.h      |  4 ---
>   block/blk.h          |  2 --
>   4 files changed, 4 insertions(+), 81 deletions(-)
>

