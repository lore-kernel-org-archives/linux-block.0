Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B26C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 17:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjE3RDK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 13:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjE3RDE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 13:03:04 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5C0E8
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 10:02:50 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3357fc32a31so829155ab.1
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685466169; x=1688058169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRoDmakO8mrN7BvELyyzaW32Q2l2bnomKWiwa5cHUpA=;
        b=be4Ruwzg4H/6dypcz6TQR2g21cAynOFpZugTdkH/nePfKZg/I7DE/R6DZjIOANPgfm
         EAZ1UP9ba9X+Vx317rQuKLUuIFNw/meR3q9d9Zko6p7didG6zgOhXETAXIHhJvjbSezT
         vlHtWsO1NVQlXphb44pIScjiowuV/Kf/RkoWMGRQIN7O9eIBdfZleNxY4y19kGQMdVW6
         wNoZoQwSNWUuLzx+TbleFYQtMY1GGeQYuAnCBXZqZQfX16/md2jVEC4sRBgeRZaO+0Hc
         YnYPWRkVvi+ozXjs9yfcPtAnYV198p8a8ZOLtE7QGIMdLHBzRT7knB5kruCdwYNmDmsl
         yySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466169; x=1688058169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRoDmakO8mrN7BvELyyzaW32Q2l2bnomKWiwa5cHUpA=;
        b=ihf5+vs5wcNT2fJgxMaJI5KKiUyE1GDHp5JZTFzJTrDxXvG1zjJ5E6WljgZd40kyLo
         2FPB/XvFr8rR3ZwpS+e5hkGaGmSyrlFKfN9KXLCo0W9YZDERCTl687FUUsY4gHapPE0U
         bT2wPqhMYP9J2MS9usPyT1aVVU1N6KrLwmGdyHgKFDFbHfxLx3rfsWTQsLA5QcCC2ev3
         WqfAkYcToZWpgMKuPq+2VIQ3izVzt5A6KawSjrTb+OahOfwR+3zd1og+BTRy55/8bExt
         Wy7O4utFOLnXRwyuEhHVzusyr+3RelmTacarVuJg/oHaqFfs16Z77mYdf9wG/eiY3H2K
         gcqQ==
X-Gm-Message-State: AC+VfDxQNm4++/12zuIX/4x1+aLmigRnJHUkR0U85rRIATyz0atlnGhQ
        bTqksjKAKUrlnTrJA/8+11i1ag==
X-Google-Smtp-Source: ACHHUZ6xqxRUQnK9LwqsJczYvkyFp5/L3wIJn+R0nqdGP4nB/d5h2eGBwNj8PrSrGnWnQ+dnnCA5SA==
X-Received: by 2002:a05:6e02:1248:b0:33b:3a14:c14c with SMTP id j8-20020a056e02124800b0033b3a14c14cmr14294ilq.3.1685466169616;
        Tue, 30 May 2023 10:02:49 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s185-20020a0251c2000000b004187f6d4e78sm877638jaa.105.2023.05.30.10.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 10:02:47 -0700 (PDT)
Message-ID: <00c4aa95-a096-0487-c162-e8817dfc0b96@kernel.dk>
Date:   Tue, 30 May 2023 11:02:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/4] block: constify some structures of
 partitions/core.c
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
 <5aeb26f6-aeca-4f77-8328-a753f9a5141b@t-8ch.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5aeb26f6-aeca-4f77-8328-a753f9a5141b@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/30/23 10:52 AM, Thomas Weißschuh wrote:
> Hi Jens,
> 
> could you take a look at this?

Looks fine to me, more const always a good thing. Can you respin
it against for-6.5/block?

-- 
Jens Axboe


