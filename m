Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0689C433FF
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02D921479
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EjjD3Ce6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfHHN3U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:29:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33908 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732990AbfHHN3T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 09:29:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so37860299pgc.1
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ca6T0eASzQmOiSyowdSYOXK1MYWFMr9czZcrawwTVio=;
        b=EjjD3Ce6v8QFullurWeuJW0wfMh/7I6a7/IK9ya0V4taor3Y0gtAVc7PwXgIoRAOJW
         KtQQCjCwIQZVmRduz3VEAunShPTG4cSz+91Q2TtGR4UY4hULwdTceHqaHgNlAcSGqAWC
         0Dwrl7UTsabIzmCnMfFOxbmML9WkFwJyUyyGasEkkrDBGxHqM5I0kn/9Z2SOcqL/1kyB
         yruxmmD3xers5FhXyF67+ZSaiZ6DGyoIF9bzJLXmyJfcoDTFeDX+nok7cWnHNO+dfp+f
         4b0/1ZJnS3CRKMoSyVNqjSthN71rFsKaEGC+5FhYX74nqkocqLb3ldh0QSxaWaWG08EB
         R4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ca6T0eASzQmOiSyowdSYOXK1MYWFMr9czZcrawwTVio=;
        b=WBsp9f6Ay0tinQOYn6nxyhbjsejf0ev2GUUlxeu6Fqp5o9vdm2SQSO35RqvrsnEMQZ
         4krL/xuWoOZKkDvxcJdNPBv0UYpSct2shN/YwmZq+uqlhb1Bj5Pg3sNAFmEDx2qfVSU5
         rjhGXgIX5vWX19vguZL2B3iz9qWlS4ok+deX0TT+5yfnLYiMf3qrbmrFCF4ZwhH8y9wR
         1El6oZjn7a3+sCNN299JZgwxPDrFi7I9flwf6VFMMhF4zckihGE6YymZXa8UxN/aML3m
         R16rYGU0OG4u1onWfocWAhZXcRzyY97aLRdABf3fP9j88LzqlGS3PetzT/whT2sK3SQR
         WVRw==
X-Gm-Message-State: APjAAAU/WzXh1gdT7YOJncv2gQaf2aB408tFsTLZmpibpQWbasWIGaaL
        zYaLvmTeGie8YQ6+EDisu5vMWD+VoNsS1Q==
X-Google-Smtp-Source: APXvYqzIeeoxgmWqY2PHZ7+/r4DJz+6DXaU8neOzjuD3iYXAVFgS3BwyCO7BxyDiaz6U3oFxg89qvA==
X-Received: by 2002:a65:60d2:: with SMTP id r18mr12522270pgv.71.1565270958957;
        Thu, 08 Aug 2019 06:29:18 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:186c:3a47:dc97:3ed1? ([2605:e000:100e:83a1:186c:3a47:dc97:3ed1])
        by smtp.gmail.com with ESMTPSA id f14sm16978362pgu.8.2019.08.08.06.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 06:29:18 -0700 (PDT)
Subject: Re: [PATCH] block: aoe: Fix kernel crash due to atomic sleep when
 exiting
To:     zhe.he@windriver.com, justin@coraid.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1565233794-458496-1-git-send-email-zhe.he@windriver.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <afd1ac3b-127b-d436-98ac-e4f2748eacb8@kernel.dk>
Date:   Thu, 8 Aug 2019 06:29:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565233794-458496-1-git-send-email-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/19 8:09 PM, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> Since commit 3582dd291788 ("aoe: convert aoeblk to blk-mq"), aoedev_downdev
> has had the possibility of sleeping and causing the following crash.
> 
> BUG: scheduling while atomic: rmmod/2242/0x00000003
> Modules linked in: aoe
> Preemption disabled at:
> [<ffffffffc01d95e5>] flush+0x95/0x4a0 [aoe]
> CPU: 7 PID: 2242 Comm: rmmod Tainted: G          I       5.2.3 #1
> Hardware name: Intel Corporation S5520HC/S5520HC, BIOS S5500.86B.01.10.0025.030220091519 03/02/2009
> Call Trace:
>   dump_stack+0x4f/0x6a
>   ? flush+0x95/0x4a0 [aoe]
>   __schedule_bug.cold+0x44/0x54
>   __schedule+0x44f/0x680
>   schedule+0x44/0xd0
>   blk_mq_freeze_queue_wait+0x46/0xb0
>   ? wait_woken+0x80/0x80
>   blk_mq_freeze_queue+0x1b/0x20
>   aoedev_downdev+0x111/0x160 [aoe]
>   flush+0xff/0x4a0 [aoe]
>   aoedev_exit+0x23/0x30 [aoe]
>   aoe_exit+0x35/0x948 [aoe]
>   __se_sys_delete_module+0x183/0x210
>   __x64_sys_delete_module+0x16/0x20
>   do_syscall_64+0x4d/0x130
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f24e0043b07
> Code: 73 01 c3 48 8b 0d 89 73 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f
> 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff
> ff 73 01 c3 48 8b 0d 59 73 0b 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffe18f7f1e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f24e0043b07
> RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000555c3ecf87c8
> RBP: 00007ffe18f7f1f0 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007f24e00b4ac0 R11: 0000000000000206 R12: 00007ffe18f7f238
> R13: 00007ffe18f7f410 R14: 00007ffe18f80e73 R15: 0000555c3ecf8760
> 
> This patch, handling in the same way of pass two, unlocks the locks and
> restart pass one after aoedev_downdev is done.

Applied, thanks.

-- 
Jens Axboe

