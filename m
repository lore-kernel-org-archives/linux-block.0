Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F5C04E87
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE9C2173E
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Tuu89weJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEUMtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 08:49:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42428 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUMtN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 08:49:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id 145so8546869pgg.9
        for <linux-block@vger.kernel.org>; Tue, 21 May 2019 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y8l+jqw9ehxJQIKyKC2wOfquZL5ckA8lT80GF2Im1p0=;
        b=Tuu89weJ+xes8MFynIwqb/wwNZPQnusHc8s/LGp5hAVmvChO5TGngyayuee5XLJa7F
         rfJ/Zsx7anV2nFsLQ+HDam6FQaaWebmaXrX3swdKCUXoSeFCivUco5loBWZHQ7b53HAy
         IPuf6JgHrAwWrZ75bVQpUO1UxKx8anjnKxeQeconjEqijUQ3u4zkXSrncDbhlGVViwW+
         fsSlKYFDdEgd1/F9Li+afVZ3Il1RtpmLP9fegQ8u7adbc5yh75/g1X17ON5ZJ8D2J/5F
         1mt1h6M1jdhbTEhxLQmV4gtjGwwfDzRjFD5qvmwKoB6t4h0ARuprZvqZhfLtpuHQOhhp
         lGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y8l+jqw9ehxJQIKyKC2wOfquZL5ckA8lT80GF2Im1p0=;
        b=AGcgh/iIBUK4idpvs/vfxLZIfHhosn6lp64KrFKlt/Yr+VRct9Ch5y999cYx1uhCjb
         9tIoQU+4e9nU4ReedZw2UR+DYJZSq1Uh4l9zlB9ZQLdYMLW8MsUoXrh/3dDM1DJQueLv
         sQiVfJwFicTVSvgPySnW8SWKDElAxVm/4frRy5Wy6AedceS+w1EFRu7+ytimpW0qYbb4
         VY8232XzV1RmDLeMmvz0Rs+fcEjcA9tmlF6SkTqtrMAUKHTGZ0bpZlabwOp+YekyEYO7
         Quhd9cYoVXYl2pr1HIYJOSI/9dUKC2xpWgaKitlplfnb/2DxCXqL67mKyTMJg8qCgrDz
         hkcA==
X-Gm-Message-State: APjAAAUS3MLJEAfJjSO2XPmyX8rlps5JFPISN0qhvO41hiDvC64da6IG
        MddTdXooFOub8/u4rDgB+U9zxg==
X-Google-Smtp-Source: APXvYqwFmDQrYAqUVg1mt3lKzI6EWS+ILv5swv3G1ekRrL1MtlRl8elZ0sOj9D8GsITJLG7PSjENjQ==
X-Received: by 2002:a62:e00e:: with SMTP id f14mr86630578pfh.257.1558442952728;
        Tue, 21 May 2019 05:49:12 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id i16sm8235549pfd.100.2019.05.21.05.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 05:49:11 -0700 (PDT)
Subject: Re: [RESEND PATCH v4] blk-mq: fix hang caused by freeze/unfreeze
 sequence
To:     Bob Liu <bob.liu@oracle.com>
Cc:     linux-block@vger.kernel.org, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        jinpuwang@gmail.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
References: <20190521032555.31993-1-bob.liu@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc6ad7f7-0971-3635-9ebf-2c47d0abd712@kernel.dk>
Date:   Tue, 21 May 2019 06:49:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521032555.31993-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/19 9:25 PM, Bob Liu wrote:
> The following is a description of a hang in blk_mq_freeze_queue_wait().
> The hang happens on attempt to freeze a queue while another task does
> queue unfreeze.
> 
> The root cause is an incorrect sequence of percpu_ref_resurrect() and
> percpu_ref_kill() and as a result those two can be swapped:
> 
>  CPU#0                         CPU#1
>  ----------------              -----------------
>  q1 = blk_mq_init_queue(shared_tags)
> 
>                                 q2 = blk_mq_init_queue(shared_tags):
>                                   blk_mq_add_queue_tag_set(shared_tags):
>                                     blk_mq_update_tag_set_depth(shared_tags):
> 				     list_for_each_entry()
>                                       blk_mq_freeze_queue(q1)
>                                        > percpu_ref_kill()
>                                        > blk_mq_freeze_queue_wait()
> 
>  blk_cleanup_queue(q1)
>   blk_mq_freeze_queue(q1)
>    > percpu_ref_kill()
>                  ^^^^^^ freeze_depth can't guarantee the order
> 
>                                       blk_mq_unfreeze_queue()
>                                         > percpu_ref_resurrect()
> 
>    > blk_mq_freeze_queue_wait()
>                  ^^^^^^ Hang here!!!!
> 
> This wrong sequence raises kernel warning:
> percpu_ref_kill_and_confirm called more than once on blk_queue_usage_counter_release!
> WARNING: CPU: 0 PID: 11854 at lib/percpu-refcount.c:336 percpu_ref_kill_and_confirm+0x99/0xb0
> 
> But the most unpleasant effect is a hang of a blk_mq_freeze_queue_wait(),
> which waits for a zero of a q_usage_counter, which never happens
> because percpu-ref was reinited (instead of being killed) and stays in
> PERCPU state forever.
> 
> How to reproduce:
>  - "insmod null_blk.ko shared_tags=1 nr_devices=0 queue_mode=2"
>  - cpu0: python Script.py 0; taskset the corresponding process running on cpu0
>  - cpu1: python Script.py 1; taskset the corresponding process running on cpu1
> 
>  Script.py:
>  ------
>  #!/usr/bin/python3
> 
> import os
> import sys
> 
> while True:
>     on = "echo 1 > /sys/kernel/config/nullb/%s/power" % sys.argv[1]
>     off = "echo 0 > /sys/kernel/config/nullb/%s/power" % sys.argv[1]
>     os.system(on)
>     os.system(off)
> ------
> 
> This bug was first reported and fixed by Roman, previous discussion:
> [1] Message id: 1443287365-4244-7-git-send-email-akinobu.mita@gmail.com
> [2] Message id: 1443563240-29306-6-git-send-email-tj@kernel.org
> [3] https://patchwork.kernel.org/patch/9268199/

Applied, thanks.

-- 
Jens Axboe

