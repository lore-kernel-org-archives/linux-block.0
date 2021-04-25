Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681FFC433B4
	for <linux-block@archiver.kernel.org>; Sun, 25 Apr 2021 16:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D856610FA
	for <linux-block@archiver.kernel.org>; Sun, 25 Apr 2021 16:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhDYQTq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Apr 2021 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhDYQTq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Apr 2021 12:19:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C99C061574
        for <linux-block@vger.kernel.org>; Sun, 25 Apr 2021 09:19:04 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q2so5406338pfk.9
        for <linux-block@vger.kernel.org>; Sun, 25 Apr 2021 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pjjKDZJNCKRc9gCsKZj4s8CMxYsP1xRyQBwAaM4PuiI=;
        b=UtrUJDLbkZnWnOiTl9FHRxrBqRg+BDze7QYuKOV11CGrQfi4lXoJOySP2KU/MlWPBm
         1KLI58ONymYQivGW365Bey1pJ2er88LSRRLeHNlk9ac1qWYIlga0nM3F47F9axCyw0sC
         XABIKunS3L6PJJBAIheGlI3XtskntQZRZppjTNE6I6dZE7kDl09emNQwM4dsmISkAPwY
         Jiwb6Jwsv3/lYdvnb2leSH24x20fQmdSn1qdU+nBPWw+wL+TCWzILK1qo4rO6UPwiHrY
         XYO2pIy6QVXeQzdMlAZCHUMSwXIkJxpbYQXrYIQS3SMuDZqeLP/Om/GdYqcNcBHf6qyv
         Y1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pjjKDZJNCKRc9gCsKZj4s8CMxYsP1xRyQBwAaM4PuiI=;
        b=b9gk+SM445kUpb9TfwxWyaYfbu25HYRpK5MNZTsVekUa3t2TLXKPr2PSnDGefPmwtn
         R41sHYteTYkdCJdfWopTVEaTW6OqGWCc0Dj0e+mKpgJfNASNeCsHPUrtq0J+NzrALzE9
         nerGNDoaokwINgyWeiThqVATMiOxIwCvn87RM7pJ1bkk8eoi8AlQXR/BJyP7WhsvK5Ij
         F4xAM9ormXiU5KaKnV3+5niPl/Ng/8Z/cTyc+MJc2Dy710SjYBo9imaS18yhxHkC0UFv
         J1oTVZ1ViONUSes38Z5OMXOtCT08aqbrdf1LZUBV20RlRL9XM18kBdVhMa7EFYTZdQMP
         6BNA==
X-Gm-Message-State: AOAM530tcvHAelhN+0+lC1aJb4li9W2PJ8VwrO+AkzD/UJBKt2V4Z1+2
        q+VVpZIOWDHUrclONCGhA9LqvA==
X-Google-Smtp-Source: ABdhPJxUPCM1OAt6ZCE2v7ppfRjmN6VV+9rpeJS2E401RgSAAya5Rs5pV6WYNeR9pGO7MZ/9BzXYxQ==
X-Received: by 2002:a62:cd83:0:b029:272:7675:6339 with SMTP id o125-20020a62cd830000b029027276756339mr6678210pfg.73.1619367544326;
        Sun, 25 Apr 2021 09:19:04 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u12sm13351577pji.45.2021.04.25.09.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 09:19:03 -0700 (PDT)
Subject: Re: [PATCH v2] block: Improve limiting the bio size
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210425043020.30065-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a6d1b5a0-01ca-5f17-d7f1-31257457c13f@kernel.dk>
Date:   Sun, 25 Apr 2021 10:19:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210425043020.30065-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/21 10:30 PM, Bart Van Assche wrote:
> bio_max_size() may get called before device_add_disk() and hence needs to
> check whether or not the block device pointer is NULL. Additionally, more
> code needs to be modified than __bio_try_merge_page() to limit the bio size
> to bio_max_size().
> 
> This patch prevents that bio_max_size() triggers the following kernel
> crash during a SCSI LUN scan:
> 
> BUG: KASAN: null-ptr-deref in bio_add_hw_page+0xa6/0x310
> Read of size 8 at addr 00000000000005a8 by task kworker/u16:0/7
> Workqueue: events_unbound async_run_entry_fn
> Call Trace:
>  show_stack+0x52/0x58
>  dump_stack+0x9d/0xcf
>  kasan_report.cold+0x4b/0x50
>  __asan_load8+0x69/0x90
>  bio_add_hw_page+0xa6/0x310
>  bio_add_pc_page+0xaa/0xe0
>  bio_map_kern+0xdc/0x1a0
>  blk_rq_map_kern+0xcd/0x2d0
>  __scsi_execute+0x9a/0x290 [scsi_mod]
>  scsi_probe_lun.constprop.0+0x17c/0x660 [scsi_mod]
>  scsi_probe_and_add_lun+0x178/0x750 [scsi_mod]
>  __scsi_add_device+0x18c/0x1a0 [scsi_mod]
>  ata_scsi_scan_host+0xe5/0x260 [libata]
>  async_port_probe+0x94/0xb0 [libata]
>  async_run_entry_fn+0x7d/0x2d0
>  process_one_work+0x582/0xac0
>  worker_thread+0x8f/0x5a0
>  kthread+0x222/0x250
>  ret_from_fork+0x1f/0x30
> 
> This patch also fixes the following kernel warning:
> 
> WARNING: CPU: 1 PID: 15449 at block/bio.c:1034
> __bio_iov_iter_get_pages+0x324/0x350
> Call Trace:
>  bio_iov_iter_get_pages+0x6c/0x360
>  __blkdev_direct_IO_simple+0x291/0x580
>  blkdev_direct_IO+0xb5/0xc0
>  generic_file_direct_write+0x10d/0x290
>  __generic_file_write_iter+0x120/0x290
>  blkdev_write_iter+0x16e/0x280
>  new_sync_write+0x268/0x380
>  vfs_write+0x3e0/0x4f0
>  ksys_write+0xd9/0x180
>  __x64_sys_write+0x43/0x50
>  do_syscall_64+0x32/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae

Since I had to shuffle patches anyway, I folded in this fix. Thanks
Bart.

-- 
Jens Axboe

