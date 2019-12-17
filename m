Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189E8C2D0CD
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 17:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D722465E
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 17:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c2/nDvfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfLQRuc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:50:32 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45849 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLQRuc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 12:50:32 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so8862441ioi.12
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PIHajc5T69riCgfx1WTM9wSNYlMqcBP3FW3/e8WLwW8=;
        b=c2/nDvfyq4GTr+gc8nYpZSJO9zSjRaTVbXSwTjz040mkufZ1aIt3/Tv2L+3w7VDOvd
         k5F7o4O3pauikobpVeY6fjBJDdeq/opt78VnHVbkEjqtfFnAuqGWJLCGsEoXCHvVfQcT
         ucT7ICyumVsU4+GKOuBzskQXQMfv6vmgoYGJARKFB9svsd/HcNyHLJIVnqv1TeWEf0v9
         d8xhkBWyuXIM6iIKD/MPqwWeg4w0ffKhdMEpUDW0upWU9iBYt8xVr2lYV7hZ7rlAi8uA
         0ARanpwf7dLBwaLlHycfWPs74/USc92rW3mdOdyvH7OghrxSFh2qDOJF232anXxhD9rF
         ZHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PIHajc5T69riCgfx1WTM9wSNYlMqcBP3FW3/e8WLwW8=;
        b=dBGqAJGGlRW58+0R8WGfsWqqJ94t23FITj2rOGZJ9t6IegpntDVvEdQUEcB1k9WB0K
         qw2ChyNRi7mhbZhV2jv87zyoDyeT0wQrJxgo3pLRJKsbbzI4KqvOpgPB3eVXXNtatQk+
         Lzg8bDajufxzv3rI1a24paNKwrl9fMupEzg/WN+kktNGAmMu7Mi/D9Rb94dZjpJMlAXU
         d+/Ya1EgjAiPKg5tBorwuSlrHY8lpw/d7XgUpPaxGwwTJ3WnrrxLaHOgrfQwOyjGtZAh
         0O6lGyZdmpiF27KdPXspImPk5MxXGDfEO1PD7pSR+DODqxO5QvL2PJVtk+3Yr9Ddro5s
         M3sw==
X-Gm-Message-State: APjAAAV+YbSf++rb1sWoJOiA0A0hogianYLm3R3h59QGGR/AD2+SX3uh
        uKpDiqJ7JmNI4JaSqqylbnZyGQ==
X-Google-Smtp-Source: APXvYqwVrKM1N+oHGRkj51mPZn4JC/P64LM/EyVU/TOjtftWlFuKwEr+DIXhrirm0a1jR8TKm6Ajbg==
X-Received: by 2002:a02:3f26:: with SMTP id d38mr18522848jaa.53.1576605031200;
        Tue, 17 Dec 2019 09:50:31 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r22sm6893741ilb.25.2019.12.17.09.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 09:50:30 -0800 (PST)
Subject: Re: [PATCH] nbd: fix shutdown and recv work deadlock v2
To:     Mike Christie <mchristi@redhat.com>, sunke32@huawei.com,
        nbd@other.debian.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20191208225150.5944-1-mchristi@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <89b62516-087a-d5f7-6f53-749df63129cf@kernel.dk>
Date:   Tue, 17 Dec 2019 10:50:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191208225150.5944-1-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/8/19 3:51 PM, Mike Christie wrote:
> This fixes a regression added with:
> 
> commit e9e006f5fcf2bab59149cb38a48a4817c1b538b4
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Sun Aug 4 14:10:06 2019 -0500
> 
>     nbd: fix max number of supported devs
> 
> where we can deadlock during device shutdown. The problem occurs if
> the recv_work's nbd_config_put occurs after nbd_start_device_ioctl has
> returned and the userspace app has droppped its reference via closing
> the device and running nbd_release. The recv_work nbd_config_put call
> would then drop the refcount to zero and try to destroy the config which
> would try to do destroy_workqueue from the recv work.
> 
> This patch just has nbd_start_device_ioctl do a flush_workqueue when it
> wakes so we know after the ioctl returns running works have exited. This
> also fixes a possible race where we could try to reuse the device while
> old recv_works are still running.

Applied, thanks Mike.

-- 
Jens Axboe

