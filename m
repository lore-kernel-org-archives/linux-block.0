Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BD4C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 22:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhLGWLS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 17:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241502AbhLGWLS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Dec 2021 17:11:18 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2614C061574
        for <linux-block@vger.kernel.org>; Tue,  7 Dec 2021 14:07:47 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 71so316656pgb.4
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=fwdUbNPdB5zfeQV39gC2p6/3tCnNJ6f6pb6gHCxDjEU=;
        b=t2cNih/Bh92gjUEr5bW8Sb79qXEOnUwERBokuSpYJSc42i2Avo8lfoHdChcqDsfoHo
         tWUwxopd5kjC1zEybFBMyHFVwnUUWAGtrWTmLKrd/sUTbQK7nVJF6ZLeU1kACEjEY6J0
         Dtq9BOc/JhyvdI+Y3yCyG21i1+DQcW9ru9r3XRx2br5rh+CD58Asf7Tujs5DMbx35syV
         arAb3h6N+YDd2doHgVfIYKW7lJyBmiklGo9vRla+VtG4VKC8hk1Bf9uzKUkEq0mR+38O
         thsi5skxGl1wKWDbKdXzSWVMsoB34a5I4pUEvateuWG/omqVg/hOc6OZHPW4gIDFspha
         aeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=fwdUbNPdB5zfeQV39gC2p6/3tCnNJ6f6pb6gHCxDjEU=;
        b=wZB4blGF93fiOKUETBNxt9ktB5kv4Euc/2Gd2YC80PtAYjKTxkdMxXJ1PQq7uIxb65
         iVdsv6RPqTtYvyqW/t2T/VPANHXyZLDUlEfMVWxi5wBbeZRXDjKxBV5V+PvSOhsA0eGB
         1x4HUu/hWaePPqt6MHSbVwA7s2Sdhqagc+AmJPruVn3EEwE+GAG6H3SVWZUvM6ZE0BMR
         2Db/yMxp6ZrVrgSgyhOoZ1QIOjaSyAiD0XAsF3QG962d7NfxMN7ST35OmA+zfED14Blx
         /c1KmntaHpqVrEU9W41IFMc5ZuRNUNaJ7OuvgNdSk7FyUFLGv6n2I6HxEca9zElhwRJV
         5oRg==
X-Gm-Message-State: AOAM530vEizj1NLetKm3L/JhNcYsL9hpvY/157yTRamj4I4kDmhejnbO
        xuHvRtvdmNiRfugny/UhxlJys850QKfmELCO
X-Google-Smtp-Source: ABdhPJwMlUlO2QevmW8cStyCH2jv5hGVCTKU1epI9j4rWvh6YOnlskxW/BziBDJxiMTC4IwVh+HyXw==
X-Received: by 2002:a62:7802:0:b0:49f:d21e:1dc9 with SMTP id t2-20020a627802000000b0049fd21e1dc9mr1995154pfc.18.1638914866913;
        Tue, 07 Dec 2021 14:07:46 -0800 (PST)
Received: from [172.20.10.2] ([2600:380:b45e:42fd:5a55:bd65:7fc7:f698])
        by smtp.gmail.com with ESMTPSA id me7sm4519787pjb.9.2021.12.07.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:07:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     George Kennedy <george.kennedy@oracle.com>
In-Reply-To: <c9eb786f6cef041e159e6287de131bec0719ad5c.1638907997.git.asml.silence@gmail.com>
References: <c9eb786f6cef041e159e6287de131bec0719ad5c.1638907997.git.asml.silence@gmail.com>
Subject: Re: [PATCH 5.16] block: fix single bio async DIO error handling
Message-Id: <163891486467.184204.29998241985904366.b4-ty@kernel.dk>
Date:   Tue, 07 Dec 2021 15:07:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 7 Dec 2021 20:16:36 +0000, Pavel Begunkov wrote:
> BUG: KASAN: use-after-free in io_submit_one+0x496/0x2fe0 fs/aio.c:1882
> CPU: 2 PID: 15100 Comm: syz-executor873 Not tainted 5.16.0-rc1-syzk #1
> Hardware name: Red Hat KVM, BIOS 1.13.0-2.module+el8.3.0+7860+a7792d29
> 04/01/2014
> Call Trace:
>   [...]
>   refcount_dec_and_test include/linux/refcount.h:333 [inline]
>   iocb_put fs/aio.c:1161 [inline]
>   io_submit_one+0x496/0x2fe0 fs/aio.c:1882
>   __do_sys_io_submit fs/aio.c:1938 [inline]
>   __se_sys_io_submit fs/aio.c:1908 [inline]
>   __x64_sys_io_submit+0x1c7/0x4a0 fs/aio.c:1908
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [...]

Applied, thanks!

[1/1] block: fix single bio async DIO error handling
      commit: 75feae73a28020e492fbad2323245455ef69d687

Best regards,
-- 
Jens Axboe


