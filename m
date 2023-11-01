Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFDBC4332F
	for <linux-block@archiver.kernel.org>; Wed,  1 Nov 2023 16:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjKAQzK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQzJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Nov 2023 12:55:09 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889AE10C
        for <linux-block@vger.kernel.org>; Wed,  1 Nov 2023 09:55:02 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so40820b3a.2
        for <linux-block@vger.kernel.org>; Wed, 01 Nov 2023 09:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698857702; x=1699462502;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ygDWIXs7s5G1YSvpksQYqyCDCgc12edGUS5F1zWbZo=;
        b=CQ1A4bfY3+86bWOd70TbyySSG+/GTZrObIkRUJ3B4GonHIhunNDu/4dcW+YMH8WTgC
         ty+EZCLKyIWCsyauOC7OVauT0o4LCB88KHffxdHpbfFHpflZDkYVF3iKwrwcvYuTKVkQ
         buqi0oqsJDtRfaRdoLVVvbQFkf6u0fYVYCf6k7EnVd7jeqi9BWYGNm/8rgJxP259qIMQ
         +a+dA9o2nkP1Txr/uWDfhBZ7/aImBplucLS5CDp9P/JkNdVfz/WNI0pWozPlwxYtOVGy
         p2Ti4vDqVCmspkvLtUTbkmWSSjQSRufbw1TgXolcqHN6hoOBtBcQKKpcWnuTAuls4mTu
         7oow==
X-Gm-Message-State: AOJu0YxI6QQxTRzq5tT+E9HwAD4ZGPncOqWKcDBPzoTBaNSY/dllAEI3
        zlHTjt2lpIoI5tb+fiksYONu4mQZfmDtKA==
X-Google-Smtp-Source: AGHT+IHKeyGozaHcKWegoF+3fuVL+J33GK9Ssd//w58yR6oFNXCTXYCzwNa/KFenpivx4sAknpyEaA==
X-Received: by 2002:a05:6a00:814:b0:6bb:aaf:d7db with SMTP id m20-20020a056a00081400b006bb0aafd7dbmr21758599pfk.29.1698857701899;
        Wed, 01 Nov 2023 09:55:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2312:f48f:8e12:6623? ([2620:15c:211:201:2312:f48f:8e12:6623])
        by smtp.gmail.com with ESMTPSA id a24-20020a637f18000000b00584aff3060dsm118895pgd.59.2023.11.01.09.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 09:55:01 -0700 (PDT)
Message-ID: <234fc027-e91e-4df8-b928-7b6667a2312d@acm.org>
Date:   Wed, 1 Nov 2023 09:54:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel hung on block driver can't I/O complete
Content-Language: en-US
To:     =?UTF-8?B?xJDhu5cgVsSDbiBOZ+G7jWMgKFZGLUtIVFZQTUREVC1UVFRLTEtERFQp?= 
        <v.ngocdv4@vinfast.vn>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <aa9f893b7113fb223d0592b9be669f2395a7eb32.camel@vinfast.vn>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aa9f893b7113fb223d0592b9be669f2395a7eb32.camel@vinfast.vn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/23 19:29, Đỗ Văn Ngọc (VF-KHTVPMDDT-TTTKLKDDT) wrote:
> We are developing project on Android 9 which used kernel 4.14.133
> version.

If you are using a kernel from https://android.googlesource.com/, please
report this issue on https://issuetracker.google.com/. The linux-block
mailing list is for discussion of patches that are intended for the
upstream kernel and also for discussion of bugs in the upstream kernel.
Grabbing attention of upstream developers works best when using a recent
kernel, e.g. kernel v6.6. Please note that I'm not sure that kernel v6.6
supports the hardware in your device nor that it's compatible with the
Android 9 user space software.

Thanks,

Bart.

