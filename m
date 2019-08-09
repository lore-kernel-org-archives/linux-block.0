Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6B2C433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 13:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987752171F
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 13:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHINkY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:40:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53042 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfHINkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Aug 2019 09:40:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so5777058wms.2;
        Fri, 09 Aug 2019 06:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1GjhzdeWS6zwKaticm/ck6X2PyUe8cCKSvA0Ii8gVJ8=;
        b=Aw9SLfUVP5cOP2gpn/aejBKCQ/9qiB8edbrJ6BdDBR4X3EQfABgHy3xVxgnQyxQa7j
         TJv8117M2M5RDn2AJ2kZI7Nbx+8lHVV1jIkz42Kx27WQd0IeMcyM6H2XeNd9cALhett3
         RXZc5J7kU9vzJOV2BkeOwoxdVIck4IAKm3cvUBprJfSeBpjxjso6F1ulfpeP+l1zaDK/
         Rru+O3cgGSHPaRSJoqxF4IpBildM7Mjcvth6fzpgfpueJeiXTVvgw317YuaH9WGUFvWp
         SHOlWJuj9wfyEhRVd0W6KBoCBCRJ+lqUmksIpzmv8p+Qjvt8TEiJae3rjrYVMYLjK+Z6
         jGCA==
X-Gm-Message-State: APjAAAU6KMZCPxrKehdY1ztyG+llPCiOnxjUHBYsTDPuBqjFiIESN7Og
        OmYUEZ6mUlkhtbLoiT3kaQU=
X-Google-Smtp-Source: APXvYqwmVbhA3YyFKBHjQq3419RKW9VXrP89JRalqVn7N1inyQLmj/OLZhI2Chz+DG2tXNTSxHWrOg==
X-Received: by 2002:a1c:5f0a:: with SMTP id t10mr11496714wmb.14.1565358020739;
        Fri, 09 Aug 2019 06:40:20 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id x18sm6021764wmi.12.2019.08.09.06.40.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 06:40:20 -0700 (PDT)
Subject: Re: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     axboe@kernel.dk, jikos@kernel.org,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <b71cf216-0881-5c69-abb8-c689536d1835@linux.com>
Date:   Fri, 9 Aug 2019 16:40:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

Sorry for the late response. But I think I could add some useful info,
because I also analyzed this report from syzkaller.

I don't think that we could fix this UBSAN warning with this patch. If you look
at the lines right before your check you will find another check of cmd_count
with clarifying comment:

        if (ptr->cmd_count > 33)
                        /* the command may now also take up the space
                         * initially intended for the reply & the
                         * reply count. Needed for long 82078 commands
                         * such as RESTORE, which takes ... 17 command
                         * bytes. Murphy's law #137: When you reserve
                         * 16 bytes for a structure, you'll one day
                         * discover that you really need 17...
                         */
                return -EINVAL;

        for (i = 0; i < 16; i++)
                ptr->reply[i] = 0;
        ptr->resultcode = 0;

And a little bit more details about (from include/uapi/linux/fd.h):
struct floppy_raw_cmd {
...
        unsigned char cmd_count;                                                 
        unsigned char cmd[16];                                                   
        unsigned char reply_count;                                               
        unsigned char reply[16];
...
}

So, cmd[16] + reply_count[1] + reply[16] == 33.

Thus, this behavior is intentional, we could not fix it this way and it's already
a part of UAPI.

But thank you for analyzing the report!

Denis

On 23.10.2018 02:20, Kyungtae Kim wrote:
> We report a bug found in v4.19-rc2 (v4.19-rc8 as well):
> UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
> 
> kernel config: https://kt0755.github.io/etc/config_v2-4.19
> repro: https://kt0755.github.io/etc/repro.b4076.c
> 
> Analysis:
> 
> struct floppy_raw_cmd {
>    unsigned char cmd_count;
>    unsigned char cmd[16];
>   ...
> };
> 
> for (i=0; i<raw_cmd->cmd_count; i++)
>     output_byte(raw_cmd->cmd[i])
> 
> In driver/block/floppy.c:1495, the code snippet above is trying to
> write some bytes to the floppy disk controller, depending on "cmd_count".
> As you see "struct floppy_raw_cmd" above, the size of array “cmd” is
> fixed as 16.
> The thing is, there is no boundary check for the index of array "cmd"
> when this is used. Besides, "cmd_count" can be manipulated by raw_cmd_ioctl
> which is derived from ioctl system call.
> We observed that cmd_count is set at line 2540 (or 2111), but that is
> after such a bug arose in our experiment. So by manipulating system call
> ioctl,
> user program can have illegitimate memory access.
> 
> The following is a simple patch to stop this. (This might not be the
> best.)
> 
> diff --git a/linux-4.19-rc2/drivers/block/floppy.c
> b/linux-4.19-rc2/drivers/block/floppy.c
> index f2b6f4d..a3610c9 100644
> --- a/linux-4.19-rc2/drivers/block/floppy.c
> +++ b/linux-4.19-rc2/drivers/block/floppy.c
> @@ -3149,6 +3149,8 @@ static int raw_cmd_copyin(int cmd, void __user *param,
>                          */
>                 return -EINVAL;
> 
> +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd)) {
> +               return -EINVAL;
> +
>         for (i = 0; i < 16; i++)
>                 ptr->reply[i] = 0;
>         ptr->resultcode = 0;
> 
> 
> Crash log
> ==================================================================
> UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
> index 16 is out of range for type 'unsigned char [16]'
> CPU: 0 PID: 2420 Comm: kworker/u4:3 Not tainted 4.19.0-rc2 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Workqueue: floppy fd_timer_workfn
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xd2/0x148 lib/dump_stack.c:113
>  ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
>  __ubsan_handle_out_of_bounds+0x174/0x1b8 lib/ubsan.c:386
>  setup_rw_floppy+0xbd9/0xe60 drivers/block/floppy.c:1495
>  seek_floppy drivers/block/floppy.c:1605 [inline]
>  floppy_ready+0x61a/0x2230 drivers/block/floppy.c:1917
>  fd_timer_workfn+0x1a/0x20 drivers/block/floppy.c:994
>  process_one_work+0xa0c/0x1820 kernel/workqueue.c:2153
>  worker_thread+0x8f/0xd20 kernel/workqueue.c:2296
>  kthread+0x3a3/0x470 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
> ==================================================================
> 
