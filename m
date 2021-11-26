Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FC6C433EF
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 22:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhKZWQu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:16:50 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:36617 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbhKZWOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 17:14:49 -0500
Received: by mail-pl1-f170.google.com with SMTP id u11so7498387plf.3
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 14:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZI+KeJmK9GzMojYEC4L3JC6DbFySKPY5klpgO5UuWhA=;
        b=WEUPL2UBx17fTNgareBuEr+58YXTma0DP9MdWXVCXEhEpAyAO+LxM4QpxSDzsjlQdl
         Pl8YXT16yT6HtHx8kBwTefYuQv5hg0vGFMX237Gi9w2sFy4Qu4x6nvTnMnyNV/mez4G4
         AARyCxoKv0tErO3KqpsCZH/lGpYmn1VCxsUoWIUKIG7E/im1tCljZ5m9VPjXqlpso0mq
         GCyMQ1pbjfzc4qIYlujZdTWeigJ1P2YJxeV2hmGLhkQW6wPLABjY3eGawi6bfupWGJgz
         ORaDUbB0Euj+jCCeoXTt3MiPMYWZ/bka+11CdaX5Ot9ZKDpK01m63PKFPiMu00D8Hy16
         3RAA==
X-Gm-Message-State: AOAM531WVEHhvzvS7Ug9SmRiD95c9hcXycXHNh8XNvPEcgMRmSQpMOQo
        7C9fcRnVEvzTe1kPRWQmTDMwjP8My8w=
X-Google-Smtp-Source: ABdhPJyVtIfkrqyX2T8PgE2r0GKVBkqeIWFWTqspsCRyz5y/Adrz/jcDqVZTLT+F7hM6cfXThYPS3Q==
X-Received: by 2002:a17:90a:fe85:: with SMTP id co5mr18582221pjb.110.1637964696172;
        Fri, 26 Nov 2021 14:11:36 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id j1sm7534147pfe.158.2021.11.26.14.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 14:11:35 -0800 (PST)
Message-ID: <b64942a1-0f7e-9e9c-0fd4-c35647035eaf@acm.org>
Date:   Fri, 26 Nov 2021 14:11:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] block: Fix two memory leaks in blkcg_init_queue
Content-Language: en-US
To:     Sean Anderson <seanga2@gmail.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Yanfei Xu <yanfei.xu@windriver.com>
References: <20211124035858.1657142-1-seanga2@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20211124035858.1657142-1-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 19:58, Sean Anderson wrote:
> The ioprio and iolatency rqos never get free'd on error or queue exit, causing
> the following leaks:
> 
> unreferenced object 0xffff97b143bc0900 (size 64):
>    comm "kworker/u2:3", pid 101, jiffies 4294877468 (age 159.967s)
>    hex dump (first 32 bytes):
>      00 15 f9 86 ff ff ff ff 60 f4 cf 45 b1 97 ff ff  ........`..E....
>      03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<0000000063d10c99>] blk_ioprio_init+0x25/0xe0
>      [<000000005dd8844d>] blkcg_init_queue+0x8d/0x140
>      [<00000000bd7aac9b>] blk_alloc_queue+0x1ef/0x280
>      [<0000000044d961f9>] blk_mq_init_queue+0x1a/0x60
>      [<0000000031908ee1>] scsi_alloc_sdev+0x20f/0x370
>      [<00000000e99f53d3>] scsi_probe_and_add_lun+0x9db/0xe10
>      [<00000000942c5af3>] __scsi_scan_target+0xfc/0x5b0
>      [<000000007194bb8f>] scsi_scan_channel+0x58/0x90
>      [<00000000ebf8a49b>] scsi_scan_host_selected+0xe9/0x120
>      [<00000000f745ec7d>] do_scan_async+0x18/0x160
>      [<000000006f6ff8ca>] async_run_entry_fn+0x30/0x130
>      [<000000003d813304>] process_one_work+0x1e8/0x3c0
>      [<0000000020b6d54d>] worker_thread+0x50/0x3c0
>      [<000000007fc10a0f>] kthread+0x132/0x160
>      [<0000000010197ee2>] ret_from_fork+0x22/0x30
> unreferenced object 0xffff97b143da4360 (size 96):
>    comm "kworker/u2:3", pid 101, jiffies 4294877468 (age 159.987s)
>    hex dump (first 32 bytes):
>      40 1b f9 86 ff ff ff ff 60 f4 cf 45 b1 97 ff ff  @.......`..E....
>      01 00 00 00 00 00 00 00 00 09 bc 43 b1 97 ff ff  ...........C....
>    backtrace:
>      [<000000000ffb4700>] blk_iolatency_init+0x25/0x160
>      [<00000000c4cdb872>] blkcg_init_queue+0xc7/0x140
>      [<00000000bd7aac9b>] blk_alloc_queue+0x1ef/0x280
>      [<0000000044d961f9>] blk_mq_init_queue+0x1a/0x60
>      [<0000000031908ee1>] scsi_alloc_sdev+0x20f/0x370
>      [<00000000e99f53d3>] scsi_probe_and_add_lun+0x9db/0xe10
>      [<00000000942c5af3>] __scsi_scan_target+0xfc/0x5b0
>      [<000000007194bb8f>] scsi_scan_channel+0x58/0x90
>      [<00000000ebf8a49b>] scsi_scan_host_selected+0xe9/0x120
>      [<00000000f745ec7d>] do_scan_async+0x18/0x160
>      [<000000006f6ff8ca>] async_run_entry_fn+0x30/0x130
>      [<000000003d813304>] process_one_work+0x1e8/0x3c0
>      [<0000000020b6d54d>] worker_thread+0x50/0x3c0
>      [<000000007fc10a0f>] kthread+0x132/0x160
>      [<0000000010197ee2>] ret_from_fork+0x22/0x30
> 
> Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
> Fixes: 556910e39249 ("block: Introduce the ioprio rq-qos policy")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
>   block/blk-cgroup.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 663aabfeba18..ced5ee637405 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -32,6 +32,7 @@
>   #include <linux/psi.h>
>   #include "blk.h"
>   #include "blk-ioprio.h"
> +#include "blk-rq-qos.h"
>   #include "blk-throttle.h"
>   
>   /*
> @@ -1200,16 +1201,18 @@ int blkcg_init_queue(struct request_queue *q)
>   
>   	ret = blk_throtl_init(q);
>   	if (ret)
> -		goto err_destroy_all;
> +		goto err_qos_exit;
>   
>   	ret = blk_iolatency_init(q);
>   	if (ret) {
>   		blk_throtl_exit(q);
> -		goto err_destroy_all;
> +		goto err_qos_exit;
>   	}
>   
>   	return 0;
>   
> +err_qos_exit:
> +	rq_qos_exit(q);
>   err_destroy_all:
>   	blkg_destroy_all(q);
>   	return ret;
> @@ -1229,6 +1232,7 @@ int blkcg_init_queue(struct request_queue *q)
>    */
>   void blkcg_exit_queue(struct request_queue *q)
>   {
> +	rq_qos_exit(q);
>   	blkg_destroy_all(q);
>   	blk_throtl_exit(q);
>   }

Thanks for having reported this. However, I'm not sure the above patch 
is the best way to fix this. I'd prefer to restore the rq_qos_exit(q) in 
blk_cleanup_queue() and also to add the following to such a patch: 
Fixes: commit 8e141f9eb803 ("block: drain file system I/O on 
del_gendisk"). As far as I can see calling rq_qos_exit(q) twice for the 
same request queue is fine.

Bart.



