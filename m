Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B4CC433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB0320684
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbhAZV7x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405295AbhAZUJt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 15:09:49 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27A5C061573
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:09:08 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 30so12171184pgr.6
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RFzsjs73B5QGolUY36etsSHceLP09/8jna6hDkWinoI=;
        b=NHT3FZZp9joO/4A2cIe+S9vs9lbh0VEwMmGIlFcM997cgIKdCTtbDRMw4vIA8MMDdf
         6jcCKXxlNPkYB8uu8Hy+MaYzrcgk3VKsx2mI9hjgdhZe72QkNP4jUkynGfyhyI0ITftK
         227BFngVq9IP8Wgi0ugTfmuPU4FVdvPhokdvsmjWzu+T+fPoJBlhy3Q4n2tsleUiNta0
         6Py2C+w367MVGvQRkucb6NNdksabAslf+2p+oOiyJiF/FNPG7ExQ4vVuqt63u+NqL3H4
         XatCkFDYUoDc2dcuDuNyVZTYgSwbubVLj78PUT9GqcK99Vh7sUSCVekPcyShTy7JHGpC
         F+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RFzsjs73B5QGolUY36etsSHceLP09/8jna6hDkWinoI=;
        b=WioNvAG1Hb2yUpnpVFZowcw7SMnhiTc/yiNHCyrD3LlWvBmPRenl3qHU+RP6/DnQmo
         g2qgYi3IK+8zMi3GRQOMDYL946wA8VQS2iAOFjMEjQtTC0rvJM1SxroUyZ2UzvUqy/lQ
         2DjhpANX40dOw8Wjd0L3z5mWSN/FiOSooDb5QHXAsQXodLIJ5Y8vpryiJBDKBWfdhiQV
         oZFuBmr6RtOKZ09JitypN7uDlAL64Iku3w95xpLH0R/tLoifnTRbM0UZf5tM778AhOU/
         hAgI494jShLUSwn1R2ePsdS0FEq6wOx9nd89xenkxbdqhmTxsRUSLC8j+W7zPdGIdZwD
         AmBA==
X-Gm-Message-State: AOAM530W6YoWxnzVWwya7axH1habgXD1WSHs+ZGhMR9K0cDKn0fyBV2e
        xEYJ0IJsFbojmtJ1iB14tb/GfQ==
X-Google-Smtp-Source: ABdhPJz8CuV4Pt+g2YOn4X6fah7MOajq5qzAEUxnHyOT2+pUQj854HVAxAZIErQWr8QR9q0WtpBfNw==
X-Received: by 2002:a62:380a:0:b029:1a9:5aa1:6d0d with SMTP id f10-20020a62380a0000b02901a95aa16d0dmr6617617pfa.45.1611691748448;
        Tue, 26 Jan 2021 12:09:08 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id u126sm18970542pfu.113.2021.01.26.12.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:09:07 -0800 (PST)
Subject: Re: [PATCH v4 1/1] loop: scale loop device by introducing per device
 lock
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        tyhicks@linux.microsoft.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org, jmorris@namei.org,
        lukas.bulwahn@gmail.com, hch@lst.de, pvorel@suse.cz,
        ming.lei@redhat.com, mzxreary@0pointer.de, mcgrof@kernel.org,
        zhengbin13@huawei.com, maco@android.com, colin.king@canonical.com,
        evgreen@chromium.org
References: <20210126144630.230714-1-pasha.tatashin@soleen.com>
 <20210126144630.230714-2-pasha.tatashin@soleen.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <daf21294-f51e-3f03-8a46-d0181104d9e3@kernel.dk>
Date:   Tue, 26 Jan 2021 13:09:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126144630.230714-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/21 7:46 AM, Pavel Tatashin wrote:
> Currently, loop device has only one global lock: loop_ctl_mutex.
> 
> This becomes hot in scenarios where many loop devices are used.
> 
> Scale it by introducing per-device lock: lo_mutex that protects
> modifications of all fields in struct loop_device.
> 
> Keep loop_ctl_mutex to protect global data: loop_index_idr, loop_lookup,
> loop_add.
> 
> The new lock ordering requirement is that loop_ctl_mutex must be taken
> before lo_mutex.

Applied, thanks.

-- 
Jens Axboe

