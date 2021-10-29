Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B44CC433F5
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 19:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C9660F02
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 19:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhJ2TQO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 15:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ2TQO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 15:16:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEEAC061570
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 12:13:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id b4so3702555pgh.10
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=rAJgsGp1kooMIpSzGVFqtiJ4sW4vy9QGhNG4LIEAgwk=;
        b=t6O9/GoIGS2FRPNTrXM4gFE16G5GaVpvclD59QgE6P00kbO9h6e43p9yD6/G/5RDrP
         1RRlnjeemoo7O3GQy1M9yVwlDoZHH+H913RVDAAWkeXUejE0v3zI7re+y3TsSPeruCDH
         0mtXcoc85tMbHv+FcTMtgO+vMGcJ0qHMy8ZnVc0gnfZJeS234XtbSOC8o+5SRzbBAg7M
         rQABTRWJfj1EfJDWGdqWkDq/8auGoBtArF4kNP4tHQwEsuSOY0RIj/Pw+RoDzk6nC/Cx
         FZXWGfnvrpWJvd3otlmKUmVwJkFlyUJBNCiAdAxJXeSlwdC82mcRGlL4AwOWf0Q+zBdy
         pmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=rAJgsGp1kooMIpSzGVFqtiJ4sW4vy9QGhNG4LIEAgwk=;
        b=20d9Nk+lDSKZaDleLjM4+6woa8x+h8yLubPP4LE0fJnfDpyVNGzh2d5my+S11v2qs+
         yLntGcbhZicvoLEg3Hff8wr+u/i93igKOtpYFj7m8cM7N6CmK9tc9x65eKOzNT0GgkbU
         9shd8KgO+2B7mOaSgmDbkq6TxeOPDFSyHh3HuAygoYEoJ2FcRd/xs5CEUbtUqcguy3wp
         /5lw6A+zhrrRvTnSZrhQqMr7cA/gnndeUcPoNjGOQpdFpgIDoEohibBrSMXLPHTP1GkQ
         BqatV04Se4rWVFvjBdHJNu74gD6AXgH3QfM5bgErrx+Ppa4XjWTg35b0W1tgMLsMPMkW
         kSkQ==
X-Gm-Message-State: AOAM533i+rTDaCD6atRo+7ZXY1EPkIBJyxsAg8NpBBhnyEU8jgNibqD5
        q3yH2xkBgv2oo0/utsczRjUvi28zIsVIW3gG
X-Google-Smtp-Source: ABdhPJxCnb2ibRihvOeE3jAXT9+ZDYb9aJwWvh4md55/JcjgZxtPBwMgDvIcW9pQ7bqvw8bO9JCALQ==
X-Received: by 2002:aa7:888d:0:b0:47c:128b:ee57 with SMTP id z13-20020aa7888d000000b0047c128bee57mr12907638pfe.81.1635534824828;
        Fri, 29 Oct 2021 12:13:44 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id y16sm7593767pfl.198.2021.10.29.12.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 12:13:44 -0700 (PDT)
Message-ID: <7468db5d-55b4-07c9-628a-9a60419d9121@linaro.org>
Date:   Fri, 29 Oct 2021 12:13:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: general protection fault in del_gendisk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
I'm looking at a bug found by the syzkaller robot [1], and I just wanted
to confirm that my understanding is correct, and the issue can be closed.
First, the kernel is configured with some fault injections enabled:

CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y

The test adds loop devices, which causes some entries in sysfs to be created.
It does some magic with ioctls, which calls:
__device_add_disk() -> register_disk()
which eventually triggers sysfs_create_files() and it crashes there,
in line 627 [2], because the fault injector logic triggers it.
That can be seen in the trace [3]:
[   34.089707][ T1813] FAULT_INJECTION: forcing a failure.

Sysfs code returns a -ENOMEM error, but because the __device_add_disk()
implementation mostly uses void function, and doesn't return on errors [4]
it goes farther, hits some warnings, like:
disk_add_events() -> sysfs_create_files() -> sysfs_create_file_ns() - > WARN()
and eventually triggers general protection fault in sysfs code, and panics there.

I think for this to recover and return an error to the caller via ioctl()
the __device_add_disk() code would need be reworked to handle errors,
and return errors to the caller.
My question is: is it implemented like this by design? Are there any plans
to make it fail more gracefully?

[1] https://syzkaller.appspot.com/bug?id=c234dd5151b92650adff0683a8c567c269fb39e5
[2] https://elixir.bootlin.com/linux/v5.14.15/source/fs/kernfs/dir.c#L583
[3] https://syzkaller.appspot.com/text?tag=CrashLog&x=113d8bfcb00000
[4] https://elixir.bootlin.com/linux/v5.14.15/source/block/genhd.c#L532

-- 
Thanks,
Tadeusz
