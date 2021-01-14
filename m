Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696ADC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 01:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0DB206C0
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 01:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbhANBub (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 20:50:31 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:53854 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbhANA0b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 19:26:31 -0500
Received: by mail-wm1-f47.google.com with SMTP id k10so3101527wmi.3
        for <linux-block@vger.kernel.org>; Wed, 13 Jan 2021 16:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CjOYVZEsf2FiLNXwyV5fZxp1Cug1pJCM1gzhjiP5Ln4=;
        b=P3Fm3C5jug/csGWMqkAk6Adi0/D57ykEixujCdfhGnTjT1n5pjqgA9zEV30l3NAlyM
         nZZODEBj+EIHU9NuzoWinA5oaBSztkl0r5/COaboKXNamAVqoZ7wENzwwMXooh1quVCb
         zyV8aTqOyuT7RWfMpxjIAlmyGV640zgmjbh8K5tr6zXppvlc3S4rBsnjdO2D/YMjjaOt
         0NG7B0S3o+EoNICb4pXXhSo3N48GHwqqX3OrvTMZSeFDVwS/fxEnPV2hlmEIjly9cho1
         gbzGKjhZSoh31pdPXwfv3Euo/lEzXmLNnlc0K4DLdN3GkR50qgLUdEc2LZzcxPF/1Ee0
         X7wQ==
X-Gm-Message-State: AOAM533Ai1n5EPR8uduYEg6hkE5knd9Vc3bUxHFu2IJp08wPmIgBsIf2
        CZqCUUPknu3LBLBWVtzsKJH95qBRUf8=
X-Google-Smtp-Source: ABdhPJxnDgb+WIYycc3ID2vAo2/XWBQDZ6Nm9gUBvvvpApZYDr5WBKf2Vu5qmI2AgxtIO2IiTyQeQg==
X-Received: by 2002:a05:600c:2905:: with SMTP id i5mr1407139wmd.28.1610583355938;
        Wed, 13 Jan 2021 16:15:55 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988? ([2601:647:4802:9070:e70c:620a:4d8a:b988])
        by smtp.gmail.com with ESMTPSA id c2sm705931wrt.87.2021.01.13.16.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 16:15:55 -0800 (PST)
Subject: Re: [PATCH v2 0/6] avoid repeated request completion and IO error
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk
References: <20210107033149.15701-1-lengchao@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <879d04a5-c52e-4d21-5003-d369ab5cdaee@grimberg.me>
Date:   Wed, 13 Jan 2021 16:15:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107033149.15701-1-lengchao@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> First avoid repeated request completion for nvmf_fail_nonready_command.
> Second avoid IO error and repeated request completion for queue_rq.

Maybe this is me chiming in v2, but what is this fixing? what
is the bug you are seeing?
