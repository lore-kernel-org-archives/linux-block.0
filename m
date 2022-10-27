Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B09FA3740
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 13:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiJ0NP4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiJ0NPz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 09:15:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2609E85591
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 06:15:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m2so1485075pjr.3
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBfCM5SMkIGMEbZoL8e3ReYcZIOMaiwrs47mnFIdDdk=;
        b=uK6WYYH1RMGUmm6jYgWDrdeLhvUL5CH1VnIPTfz1BR/vxfvHv/j0SD1F/CeSgx7ZhP
         oyO64Cpp8AkqyePXjFn0jEG6G5I07KGHwdIAQpANtIuZqKRKZahIZ7Gj4bRYDXsnFNxS
         cM4yJVrQVedCrg0oUPRYroCoi9UdBq+xIbe+kUH4UnPHd9mAvQ0yQ+aH+LezUSEGKHGp
         H3Vz8Ra5tAZjw4djtX0N2kI/A2hFaWDaQ+n53hWO0kFkGWNcZqnuCz/4hngQpylTpN/T
         izkk9LQsklOjleQ4JJk4gEC31AnWioZ8OkdG4fW8nFq1hSjNDtTps7198jm2RKoRkAl+
         TvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBfCM5SMkIGMEbZoL8e3ReYcZIOMaiwrs47mnFIdDdk=;
        b=OKB/S9B1i61Y77k+f533B/bzzP7WWajlEQVcRVOK97VTCm6x8lRsgQUe9JfnusbaB0
         oPvxQZV5bxFHhjp1MZOk++fllOawZpbbx/sLWe0Z6+V/C4YlTcCrcY4Y1l2nk7kHi++h
         QL65AMyUu3LHr9XpdqeJVZ13301ujWhKsEe9FcDKc3LsbPrQPL5T6uJa9TIKXy0cIUgb
         v6jJi7UY6AtISMm/Jo6L9kfpnJxW4szRiBpp1cVkSP8n+NG/93kI+a8PeaQDbwGgQzjO
         HS2ZGxT9ADiCgLBtoJnPBUOWFGB1r9TzNZoQYGjrdzyPBXV4UKSlcx7itBAwfTdOzyXQ
         Gdtw==
X-Gm-Message-State: ACrzQf0Ih7YqRn77L8eVK8+p0t7jirllUBgvfGV3I1MfcjTkru11oEAl
        HiAFcuraXFNxoT60sXaWp24rGVa9laoqE1+A
X-Google-Smtp-Source: AMsMyM6fdsnMZ1IafarP5oLU+jn2wyrHokSsVLtd1NjIjMvXU3imwtSkb3N44hUr0gZG6KKEKjRXlg==
X-Received: by 2002:a17:902:c189:b0:186:88bd:42c4 with SMTP id d9-20020a170902c18900b0018688bd42c4mr29140566pld.0.1666876553518;
        Thu, 27 Oct 2022 06:15:53 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m10-20020a63f60a000000b004608b721dfesm1027480pgh.38.2022.10.27.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 06:15:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ceph-devel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-block@vger.kernel.org
Cc:     yehuda@hq.newdream.net, idryomov@gmail.com,
        dongsheng.yang@easystack.cn
In-Reply-To: <20221027091918.2294132-1-yangyingliang@huawei.com>
References: <20221027091918.2294132-1-yangyingliang@huawei.com>
Subject: Re: [PATCH] rbd: fix possible memory leak in rbd_sysfs_init()
Message-Id: <166687655254.10763.17976246542549193136.b4-ty@kernel.dk>
Date:   Thu, 27 Oct 2022 07:15:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 27 Oct 2022 17:19:18 +0800, Yang Yingliang wrote:
> If device_register() returns error in rbd_sysfs_init(), name of kobject
> which is allocated in dev_set_name() called in device_add() is leaked.
> 
> As comment of device_add() says, it should call put_device() to drop
> the reference count that was set in device_initialize() when it fails,
> so the name can be freed in kobject_cleanup().
> 
> [...]

Applied, thanks!

[1/1] rbd: fix possible memory leak in rbd_sysfs_init()
      (no commit info)

Best regards,
-- 
Jens Axboe


