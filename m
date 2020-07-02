Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B46C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7FC207CD
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Ijpl1v1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGBEhd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgGBEhc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 00:37:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39955C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 21:37:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v19so20268063qtq.10
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=szIFiXYH4CvaS6ofus2uHd3YnC/+TewVLFcdawFc/zU=;
        b=Ijpl1v1fmYZXRgNfcbt3bOwF9ZvKslRedn0uEO+IBqjjWflvEXyWxIO+y4uI/1eRMc
         XVBjoZzm5tVxGkrr0AqCwkOTtgv1Wgs5xkg5XCI7xoT6qfw9T8JIcf9L6p2/1rsKEJ2+
         EwhXkKnHA6GQFoo00QIngEfp77c/W4SIx3Pf8d2zsHMiG3IrgfibI+a5MdiI1F67kE8b
         4ewMF51Izxjy8QKFuiEMy2s7sAP/Ikp+ouooBZjy6VsrmCoJWJarzVVw5EIOpbl/NmsI
         3emmLMChjvdmz6Y3xYMvFQbEwE+Eq9u+GGsKLHk9rWIdhDMjC+DD0iAar9RhJJ8Ar6JH
         Ytfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=szIFiXYH4CvaS6ofus2uHd3YnC/+TewVLFcdawFc/zU=;
        b=F4PcM945USu/vGyrRopFj30J4+4AVr/4b0LtDHFhGqcFId4qSqi4h1tuuN8tD0TiNO
         YeWVICusjnWyKiTAuAuqksygXc5euluvIioQmRyfCb2kJFxh3oMmaV0/ODSLEUaQ1kBl
         Mb5PSTkaHhz0qh1qPx+AFGX1qGqWahfZzokS4yBMScNnfLKX3A/OLHR2PCskIJzsM1mM
         bTUKOMqQLvKU4CA5QOuPBM1RfKxHwC2/+Wa/2irYCskzvtrYYeHCnfYMydkdAAuQ00GH
         tIhPBAFtDkLK58zYIOX8r65ADxo/CL+Hpm6Qoo3rSNlTH61BuO4lkKXxnzPsdJxljrUR
         S0BA==
X-Gm-Message-State: AOAM530EchjjFcE1q50FsDleBO9YEI52smtoFy0AnyCyHxWQsOsSSCmC
        uBf4xnPeXGtZBoYXALT+NQVjwA==
X-Google-Smtp-Source: ABdhPJwOlqB5EbB7pkJCKVxroiOVJOAiMR6u/GbWuoyWUAlIVzW+94Yx4HcDWIxW9UldBDvXJnAjdg==
X-Received: by 2002:ac8:7ca1:: with SMTP id z1mr27695545qtv.334.1593664650116;
        Wed, 01 Jul 2020 21:37:30 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u20sm7923931qtj.39.2020.07.01.21.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:37:29 -0700 (PDT)
Date:   Thu, 2 Jul 2020 00:37:21 -0400
From:   Qian Cai <cai@lca.pw>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, m.szyprowski@samsung.com
Subject: Re: [PATCH V3 3/3] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
Message-ID: <20200702043721.GA1087@lca.pw>
References: <20200630140357.2251174-1-ming.lei@redhat.com>
 <20200630140357.2251174-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630140357.2251174-4-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 30, 2020 at 10:03:57PM +0800, Ming Lei wrote:
> Move .nr_active update and request assignment into blk_mq_get_driver_tag(),
> all are good to do during getting driver tag.
> 
> Meantime blk-flush related code is simplified and flush request needn't
> to update the request table manually any more.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reverting this commit on the top of next-20200701 fixed an issue where
swapping is unable to move progress for hours while it will only take
5-min after the reverting.

# time ./random 0
- start: alloc_mmap
- mmap 10% memory: 13473664204
- mmap 10% memory: 13473664204
- mmap 10% memory: 13473664204
- mmap 10% memory: 13473664204
- mmap 10% memory: 13473664204
- mmap 10% memory: 13473664204
- mmap 10% memory: 13473664204
- mmap 10% memory: 13473664204
- mmap 10% memory: 13473664204
- mmap 10% memory: 13473664204
real	2m12.333s
user	0m1.131s
sys	4m15.689s

# git clone https://github.com/cailca/linux-mm
# cd linux-mm; make
# ./random 0 (just malloc and CoW to trigger swapping.)

x86.config is also included there.

The server is,

HP Proliant BL660Gen9
Intel(R) Xeon(R) CPU E5-4650 v3 @ 2.10GHz
131072 MB memory, 1000 GB disk space

The swap device is on LVM,
06:00.0 RAID bus controller: Hewlett-Packard Company Smart Array Gen9 Controllers (rev 01)

# lvs
  LV   VG                     Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  home rhel_hpe-bl660cgen9-01 -wi-ao---- 875.89g
  root rhel_hpe-bl660cgen9-01 -wi-ao----  50.00g
  swap rhel_hpe-bl660cgen9-01 -wi-ao----   4.00g

With the commit, the system will be totally locked up (unable to login
etc) when pageout. After the while, some of those messages are in the
serial console,

[ 1250.372489][  T352] INFO: task xfsaild/dm-0:795 blocked for more than 122 seconds.
[ 1250.410651][  T352]       Not tainted 5.8.0-rc3-next-20200701 #4
[ 1250.440777][  T352] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1250.480718][  T352] xfsaild/dm-0    D26184   795      2 0x00004000
[ 1250.509775][  T352] Call Trace:
[ 1250.524445][  T352]  __schedule+0x768/0x1ba0
[ 1250.544935][  T352]  ? kcore_callback+0x1d/0x1d
[ 1250.566408][  T352]  ? lockdep_hardirqs_on_prepare+0x550/0x550
[ 1250.594339][  T352]  schedule+0xc1/0x2b0
[ 1250.612820][  T352]  schedule_timeout+0x390/0x8f0
[ 1250.635556][  T352]  ? usleep_range+0x120/0x120
[ 1250.656769][  T352]  ? lock_downgrade+0x720/0x720
[ 1250.679531][  T352]  ? rcu_read_unlock+0x50/0x50
[ 1250.701174][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1250.728811][  T352]  ? _raw_spin_unlock_irq+0x1f/0x30
[ 1250.752964][  T352]  ? trace_hardirqs_on+0x20/0x1b5
[ 1250.776427][  T352]  wait_for_completion+0x15e/0x250
[ 1250.799632][  T352]  ? wait_for_completion_interruptible+0x2f0/0x2f0
[ 1250.830311][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1250.858125][  T352]  ? _raw_spin_unlock_irq+0x1f/0x30
[ 1250.881934][  T352]  __flush_work+0x42a/0x930
[ 1250.903256][  T352]  ? queue_delayed_work_on+0x90/0x90
[ 1250.929838][  T352]  ? init_pwq+0x340/0x340
[ 1250.951021][  T352]  ? trace_hardirqs_on+0x20/0x1b5
[ 1250.974344][  T352]  xlog_cil_force_lsn+0x105/0x520
[ 1250.997409][  T352]  ? xfs_log_commit_cil+0x27f0/0x27f0
[ 1251.022702][  T352]  ? xfsaild_push+0x320/0x2170
[ 1251.044523][  T352]  ? rcu_read_lock_sched_held+0xaa/0xd0
[ 1251.070639][  T352]  ? do_raw_spin_lock+0x121/0x290
[ 1251.093099][  T352]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 1251.116765][  T352]  ? rwlock_bug.part.1+0x90/0x90
[ 1251.138491][  T352]  ? xfsaild_push+0x320/0x2170
[ 1251.160021][  T352]  xfs_log_force+0x283/0x8b0
[ 1251.181024][  T352]  xfsaild_push+0x320/0x2170
[ 1251.201236][  T352]  ? usleep_range+0x120/0x120
[ 1251.222285][  T352]  ? lock_downgrade+0x720/0x720
[ 1251.244945][  T352]  ? rcu_read_unlock+0x50/0x50
[ 1251.267111][  T352]  ? xfs_trans_ail_cursor_first+0x180/0x180
[ 1251.294879][  T352]  xfsaild+0x172/0x870
[ 1251.313497][  T352]  ? rwlock_bug.part.1+0x90/0x90
[ 1251.338272][  T352]  ? xfsaild_push+0x2170/0x2170
[ 1251.361313][  T352]  ? __kthread_parkme+0x4d/0x1a0
[ 1251.384386][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1251.413272][  T352]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[ 1251.440768][  T352]  ? trace_hardirqs_on+0x20/0x1b5
[ 1251.464454][  T352]  ? __kthread_parkme+0xcc/0x1a0
[ 1251.487684][  T352]  ? xfsaild_push+0x2170/0x2170
[ 1251.511076][  T352]  kthread+0x358/0x420
[ 1251.529882][  T352]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[ 1251.556883][  T352]  ret_from_fork+0x22/0x30
[ 1251.577642][  T352] INFO: task systemd-logind:1255 blocked for more than 124 seconds.
[ 1251.614691][  T352]       Not tainted 5.8.0-rc3-next-20200701 #4
[ 1251.643014][  T352] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1251.682935][  T352] systemd-logind  D21280  1255      1 0x00004320
[ 1251.711905][  T352] Call Trace:
[ 1251.726589][  T352]  __schedule+0x768/0x1ba0
[ 1251.747076][  T352]  ? kcore_callback+0x1d/0x1d
[ 1251.768197][  T352]  ? lockdep_hardirqs_on_prepare+0x550/0x550
[ 1251.797042][  T352]  schedule+0xc1/0x2b0
[ 1251.816384][  T352]  schedule_timeout+0x390/0x8f0
[ 1251.839135][  T352]  ? print_irqtrace_events+0x270/0x270
[ 1251.864164][  T352]  ? usleep_range+0x120/0x120
[ 1251.886086][  T352]  ? mark_held_locks+0xb0/0x110
[ 1251.908092][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1251.936499][  T352]  ? _raw_spin_unlock_irq+0x1f/0x30
[ 1251.961908][  T352]  ? trace_hardirqs_on+0x20/0x1b5
[ 1251.986191][  T352]  wait_for_completion+0x15e/0x250
[ 1252.011073][  T352]  ? wait_for_completion_interruptible+0x2f0/0x2f0
[ 1252.041028][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1252.068947][  T352]  ? _raw_spin_unlock_irq+0x1f/0x30
[ 1252.092838][  T352]  __flush_work+0x42a/0x930
[ 1252.113605][  T352]  ? queue_delayed_work_on+0x90/0x90
[ 1252.138605][  T352]  ? mark_lock+0x147/0x1800
[ 1252.159065][  T352]  ? init_pwq+0x340/0x340
[ 1252.178604][  T352]  ? __lock_acquire+0x1920/0x4da0
[ 1252.202405][  T352]  xlog_cil_force_lsn+0x105/0x520
[ 1252.225340][  T352]  ? xfs_log_commit_cil+0x27f0/0x27f0
[ 1252.250481][  T352]  ? xfs_iunpin_wait+0x25d/0x570
[ 1252.275021][  T352]  ? rcu_read_lock_sched_held+0xaa/0xd0
[ 1252.301548][  T352]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 1252.326485][  T352]  ? xfs_iunpin_wait+0x25d/0x570
[ 1252.350295][  T352]  xfs_log_force_lsn+0x237/0x590
[ 1252.372860][  T352]  xfs_iunpin_wait+0x25d/0x570
[ 1252.395136][  T352]  ? xfs_reclaim_inode+0x1d6/0x860
[ 1252.418578][  T352]  ? xfs_inactive+0x350/0x350
[ 1252.439965][  T352]  ? rcu_read_unlock+0x50/0x50
[ 1252.462896][  T352]  ? var_wake_function+0x150/0x150
[ 1252.488702][  T352]  ? xfs_reclaim_inode_grab+0xbf/0x100
[ 1252.513940][  T352]  xfs_reclaim_inode+0x1d6/0x860
[ 1252.536360][  T352]  ? xfs_inode_clear_reclaim_tag+0xa0/0xa0
[ 1252.562673][  T352]  ? do_raw_spin_unlock+0x4f/0x250
[ 1252.587647][  T352]  xfs_reclaim_inodes_ag+0x505/0xb00
[ 1252.612344][  T352]  ? xfs_reclaim_inode+0x860/0x860
[ 1252.635670][  T352]  ? mark_held_locks+0xb0/0x110
[ 1252.657425][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1252.685355][  T352]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[ 1252.712212][  T352]  ? trace_hardirqs_on+0x20/0x1b5
[ 1252.735256][  T352]  ? try_to_wake_up+0x6d1/0xf40
[ 1252.757809][  T352]  ? migrate_swap_stop+0xbf0/0xbf0
[ 1252.780846][  T352]  ? do_raw_spin_unlock+0x4f/0x250
[ 1252.803908][  T352]  xfs_reclaim_inodes_nr+0x93/0xd0
[ 1252.828191][  T352]  ? xfs_reclaim_inodes+0x90/0x90
[ 1252.851060][  T352]  ? list_lru_count_one+0x177/0x300
[ 1252.875228][  T352]  super_cache_scan+0x2fd/0x430
[ 1252.897411][  T352]  do_shrink_slab+0x317/0x990
[ 1252.919083][  T352]  shrink_slab+0x3a8/0x4b0
[ 1252.939077][  T352]  ? do_shrink_slab+0x990/0x990
[ 1252.962308][  T352]  ? mem_cgroup_protected+0x228/0x470
[ 1252.988350][  T352]  shrink_node+0x49c/0x17b0
[ 1253.010025][  T352]  do_try_to_free_pages+0x348/0x1250
[ 1253.036410][  T352]  ? shrink_node+0x17b0/0x17b0
[ 1253.058428][  T352]  ? rcu_read_lock_sched_held+0xaa/0xd0
[ 1253.083861][  T352]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 1253.108752][  T352]  try_to_free_pages+0x244/0x690
[ 1253.131224][  T352]  ? free_unref_page_prepare.part.42+0x160/0x170
[ 1253.161131][  T352]  ? reclaim_pages+0x9a0/0x9a0
[ 1253.183202][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1253.211059][  T352]  __alloc_pages_slowpath.constprop.73+0x7b8/0x2410
[ 1253.241737][  T352]  ? warn_alloc+0x120/0x120
[ 1253.262497][  T352]  ? __alloc_pages_nodemask+0x3b7/0x7c0
[ 1253.288529][  T352]  ? lock_downgrade+0x720/0x720
[ 1253.310739][  T352]  ? __isolate_free_page+0x570/0x570
[ 1253.336306][  T352]  ? rcu_read_lock_sched_held+0xaa/0xd0
[ 1253.361726][  T352]  __alloc_pages_nodemask+0x658/0x7c0
[ 1253.386922][  T352]  ? __alloc_pages_slowpath.constprop.73+0x2410/0x2410
[ 1253.418811][  T352]  allocate_slab+0x378/0x680
[ 1253.439933][  T352]  new_slab+0x3c/0x60
[ 1253.458006][  T352]  ___slab_alloc+0x49b/0x7b0
[ 1253.479756][  T352]  ? getname_kernel+0x49/0x290
[ 1253.502868][  T352]  ? getname_kernel+0x49/0x290
[ 1253.525982][  T352]  ? __slab_alloc+0x35/0x70
[ 1253.547838][  T352]  __slab_alloc+0x35/0x70
[ 1253.567937][  T352]  ? getname_kernel+0x49/0x290
[ 1253.590116][  T352]  kmem_cache_alloc+0x230/0x2a0
[ 1253.612752][  T352]  getname_kernel+0x49/0x290
[ 1253.634286][  T352]  kern_path+0xc/0x30
[ 1253.652442][  T352]  unix_find_other+0xab/0x620
[ 1253.673847][  T352]  ? unix_stream_recvmsg+0xc0/0xc0
[ 1253.697111][  T352]  ? find_held_lock+0x33/0x1c0
[ 1253.719156][  T352]  ? __might_fault+0xea/0x1a0
[ 1253.740036][  T352]  unix_dgram_sendmsg+0x79f/0xe70
[ 1253.763719][  T352]  ? unix_dgram_connect+0x650/0x650
[ 1253.787501][  T352]  ? _copy_from_user+0xbe/0x100
[ 1253.810230][  T352]  ? rw_copy_check_uvector+0x5e/0x380
[ 1253.834712][  T352]  ? move_addr_to_kernel.part.25+0x28/0x40
[ 1253.861330][  T352]  ? __x64_sys_shutdown+0x70/0x70
[ 1253.883957][  T352]  ? dup_iter+0x240/0x240
[ 1253.903962][  T352]  ? unix_dgram_connect+0x650/0x650
[ 1253.927796][  T352]  ____sys_sendmsg+0x5f5/0x820
[ 1253.949832][  T352]  ? sock_create_kern+0x10/0x10
[ 1253.972027][  T352]  ? __copy_msghdr_from_user+0x3e0/0x3e0
[ 1253.999411][  T352]  ? sock_setsockopt+0x37c/0x1f60
[ 1254.024662][  T352]  ? sock_setsockopt+0x37c/0x1f60
[ 1254.048119][  T352]  ___sys_sendmsg+0xe5/0x170
[ 1254.069009][  T352]  ? sock_getsockopt+0x577/0x1ba3
[ 1254.092402][  T352]  ? copy_msghdr_from_user+0xe0/0xe0
[ 1254.116532][  T352]  ? sk_get_meminfo+0x4b0/0x4b0
[ 1254.139128][  T352]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 1254.162917][  T352]  ? ___bpf_prog_run+0x30c6/0x76a0
[ 1254.186532][  T352]  ? lockdep_hardirqs_on_prepare+0x550/0x550
[ 1254.214390][  T352]  ? lockdep_init_map_waits+0x267/0x7b0
[ 1254.239719][  T352]  ? __bpf_prog_run64+0xc0/0xc0
[ 1254.261805][  T352]  ? __sys_setsockopt+0x39a/0x430
[ 1254.285143][  T352]  ? __fget_light+0x4c/0x220
[ 1254.306399][  T352]  ? sockfd_lookup_light+0x17/0x140
[ 1254.330417][  T352]  __sys_sendmsg+0xba/0x150
[ 1254.351957][  T352]  ? __sys_sendmsg_sock+0xa0/0xa0
[ 1254.375087][  T352]  ? seccomp_do_user_notification.isra.14+0xa60/0xa60
[ 1254.406754][  T352]  ? sockfd_lookup_light+0x140/0x140
[ 1254.431071][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1254.459401][  T352]  ? do_syscall_64+0x24/0x310
[ 1254.480731][  T352]  do_syscall_64+0x5f/0x310
[ 1254.502045][  T352]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1254.530295][  T352] RIP: 0033:0x7fd5b4dbdad5
[ 1254.551521][  T352] Code: Bad RIP value.
[ 1254.570837][  T352] RSP: 002b:00007ffd4294cdb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 1254.610502][  T352] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd5b4dbdad5
[ 1254.647167][  T352] RDX: 0000000000004000 RSI: 00007ffd4294cdf0 RDI: 0000000000000010
[ 1254.684282][  T352] RBP: 00007ffd4294cef0 R08: 000000000000006c R09: 0000000000017be2
[ 1254.721279][  T352] R10: 00007ffd4294cd90 R11: 0000000000000246 R12: 0000000000000010
[ 1254.758535][  T352] R13: 00007ffd4294cfc0 R14: 00007ffd4294ce30 R15: 0000000000000000
[ 1254.794642][  T352] INFO: task random:1774 blocked for more than 127 seconds.
[ 1254.827372][  T352]       Not tainted 5.8.0-rc3-next-20200701 #4
[ 1254.854803][  T352] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1254.893736][  T352] random          D22488  1774   1765 0x00000000
[ 1254.921952][  T352] Call Trace:
[ 1254.936322][  T352]  __schedule+0x768/0x1ba0
[ 1254.955756][  T352]  ? kcore_callback+0x1d/0x1d
[ 1254.976489][  T352]  schedule+0xc1/0x2b0
[ 1254.994120][  T352]  schedule_preempt_disabled+0xc/0x20
[ 1255.019851][  T352]  __mutex_lock+0xa1e/0x1390
[ 1255.042999][  T352]  ? xfs_reclaim_inodes_ag+0x68c/0xb00
[ 1255.068241][  T352]  ? mutex_lock_io_nested+0x1270/0x1270
[ 1255.092922][  T352]  ? rcu_read_lock_sched_held+0xaa/0xd0
[ 1255.117517][  T352]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 1255.141068][  T352]  ? xfs_perag_get_tag+0x463/0x550
[ 1255.163710][  T352]  ? __lock_acquire+0x1920/0x4da0
[ 1255.186068][  T352]  ? xfs_reclaim_inodes_ag+0x68c/0xb00
[ 1255.210506][  T352]  xfs_reclaim_inodes_ag+0x68c/0xb00
[ 1255.233939][  T352]  ? lockdep_hardirqs_on_prepare+0x550/0x550
[ 1255.260536][  T352]  ? xfs_reclaim_inode+0x860/0x860
[ 1255.283185][  T352]  ? print_irqtrace_events+0x270/0x270
[ 1255.307491][  T352]  ? find_held_lock+0x33/0x1c0
[ 1255.328782][  T352]  ? xfs_ail_push_all+0x86/0xd0
[ 1255.350848][  T352]  ? lock_downgrade+0x720/0x720
[ 1255.372513][  T352]  ? rcu_read_unlock+0x50/0x50
[ 1255.393928][  T352]  ? do_raw_spin_lock+0x121/0x290
[ 1255.416127][  T352]  ? rwlock_bug.part.1+0x90/0x90
[ 1255.437997][  T352]  ? do_raw_spin_unlock+0x4f/0x250
[ 1255.460633][  T352]  xfs_reclaim_inodes_nr+0x93/0xd0
[ 1255.483981][  T352]  ? xfs_reclaim_inodes+0x90/0x90
[ 1255.507264][  T352]  ? list_lru_count_one+0x177/0x300
[ 1255.532061][  T352]  super_cache_scan+0x2fd/0x430
[ 1255.556560][  T352]  do_shrink_slab+0x317/0x990
[ 1255.579834][  T352]  shrink_slab+0x141/0x4b0
[ 1255.599330][  T352]  ? do_shrink_slab+0x990/0x990
[ 1255.620934][  T352]  ? mem_cgroup_iter+0x3c3/0x800
[ 1255.642930][  T352]  shrink_node+0x49c/0x17b0
[ 1255.662858][  T352]  do_try_to_free_pages+0x348/0x1250
[ 1255.687403][  T352]  ? shrink_node+0x17b0/0x17b0
[ 1255.710188][  T352]  ? rcu_read_lock_sched_held+0xaa/0xd0
[ 1255.736054][  T352]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 1255.760640][  T352]  try_to_free_pages+0x244/0x690
[ 1255.784242][  T352]  ? free_unref_page_prepare.part.42+0x160/0x170
[ 1255.813938][  T352]  ? reclaim_pages+0x9a0/0x9a0
[ 1255.835127][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1255.861708][  T352]  __alloc_pages_slowpath.constprop.73+0x7b8/0x2410
[ 1255.891312][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1255.918103][  T352]  ? get_page_from_freelist+0x3b8/0x3930
[ 1255.943221][  T352]  ? __lock_acquire+0xc57/0x4da0
[ 1255.965030][  T352]  ? warn_alloc+0x120/0x120
[ 1255.984934][  T352]  ? __isolate_free_page+0x570/0x570
[ 1256.008474][  T352]  __alloc_pages_nodemask+0x658/0x7c0
[ 1256.032319][  T352]  ? handle_mm_fault+0x1ec/0x32f0
[ 1256.056694][  T352]  ? __alloc_pages_slowpath.constprop.73+0x2410/0x2410
[ 1256.089900][  T352]  ? mark_held_locks+0xb0/0x110
[ 1256.111356][  T352]  alloc_pages_vma+0xa5/0x4c0
[ 1256.132001][  T352]  handle_mm_fault+0x1b1e/0x32f0
[ 1256.153941][  T352]  ? copy_page_range+0x6b0/0x6b0
[ 1256.175764][  T352]  do_user_addr_fault+0x2ba/0x90d
[ 1256.198277][  T352]  exc_page_fault+0x56/0xa0
[ 1256.218256][  T352]  ? asm_exc_page_fault+0x8/0x30
[ 1256.240143][  T352]  asm_exc_page_fault+0x1e/0x30
[ 1256.261573][  T352] RIP: 0033:0x402a91
[ 1256.278694][  T352] Code: Bad RIP value.
[ 1256.296570][  T352] RSP: 002b:00007f2470abeec0 EFLAGS: 00010206
[ 1256.323772][  T352] RAX: 00007f2381af2000 RBX: 0000000000000000 RCX: 00007f3a69f4e8c7
[ 1256.360556][  T352] RDX: 00007f214d118000 RSI: 00000003231a6ccc RDI: 0000000000000000
[ 1256.396710][  T352] RBP: 00007f2470abeef0 R08: 00000000ffffffff R09: 0000000000000000
[ 1256.432457][  T352] R10: 0000000000000022 R11: 0000000000000246 R12: 00007ffd23f27bbe
[ 1256.468370][  T352] R13: 00007ffd23f27bbf R14: 0000000000000000 R15: 00007f2470abefc0
[ 1256.505273][  T352] INFO: task kworker/47:0:1815 blocked for more than 129 seconds.
[ 1256.541387][  T352]       Not tainted 5.8.0-rc3-next-20200701 #4
[ 1256.571909][  T352] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1256.614949][  T352] kworker/47:0    D27512  1815      2 0x00004000
[ 1256.642844][  T352] Workqueue: xfs-sync/dm-0 xfs_log_worker
[ 1256.668278][  T352] Call Trace:
[ 1256.682654][  T352]  __schedule+0x768/0x1ba0
[ 1256.702137][  T352]  ? kcore_callback+0x1d/0x1d
[ 1256.722824][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1256.749518][  T352]  ? _raw_spin_unlock_irq+0x1f/0x30
[ 1256.772548][  T352]  ? trace_hardirqs_on+0x20/0x1b5
[ 1256.794901][  T352]  schedule+0xc1/0x2b0
[ 1256.812834][  T352]  schedule_timeout+0x390/0x8f0
[ 1256.834068][  T352]  ? print_irqtrace_events+0x270/0x270
[ 1256.858477][  T352]  ? usleep_range+0x120/0x120
[ 1256.879398][  T352]  ? mark_held_locks+0xb0/0x110
[ 1256.900894][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1256.927501][  T352]  ? _raw_spin_unlock_irq+0x1f/0x30
[ 1256.950506][  T352]  ? trace_hardirqs_on+0x20/0x1b5
[ 1256.972875][  T352]  wait_for_completion+0x15e/0x250
[ 1256.995628][  T352]  ? wait_for_completion_interruptible+0x2f0/0x2f0
[ 1257.025057][  T352]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1257.051673][  T352]  ? _raw_spin_unlock_irq+0x1f/0x30
[ 1257.076481][  T352]  __flush_work+0x42a/0x930
[ 1257.099817][  T352]  ? queue_delayed_work_on+0x90/0x90
[ 1257.124652][  T352]  ? init_pwq+0x340/0x340
[ 1257.143723][  T352]  ? lockdep_hardirqs_on_prepare+0x550/0x550
[ 1257.170447][  T352]  xlog_cil_force_lsn+0x105/0x520
[ 1257.193048][  T352]  ? xfs_log_commit_cil+0x27f0/0x27f0
[ 1257.216868][  T352]  ? xfs_log_worker+0x70/0x200
[ 1257.237854][  T352]  ? rcu_read_lock_sched_held+0xaa/0xd0
[ 1257.262124][  T352]  ? do_raw_spin_lock+0x121/0x290
[ 1257.284432][  T352]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 1257.307963][  T352]  ? rwlock_bug.part.1+0x90/0x90
[ 1257.329862][  T352]  ? xfs_log_worker+0x70/0x200
[ 1257.351537][  T352]  xfs_log_force+0x283/0x8b0
[ 1257.372051][  T352]  xfs_log_worker+0x70/0x200
[ 1257.392452][  T352]  process_one_work+0x8ee/0x17c0
[ 1257.414642][  T352]  ? lock_acquire+0x1ac/0xaf0
[ 1257.435337][  T352]  ? pwq_dec_nr_in_flight+0x310/0x310
[ 1257.459227][  T352]  ? do_raw_spin_lock+0x121/0x290
[ 1257.481653][  T352]  worker_thread+0x82/0xb30
[ 1257.501638][  T352]  ? __kthread_parkme+0xcc/0x1a0
[ 1257.523429][  T352]  ? process_one_work+0x17c0/0x17c0
[ 1257.546492][  T352]  kthread+0x358/0x420
[ 1257.564555][  T352]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[ 1257.593534][  T352]  ret_from_fork+0x22/0x30
[ 1257.614307][  T352] 
[ 1257.614307][  T352] Showing all locks held in the system:
[ 1257.653989][  T352] 2 locks held by systemd/1:
[ 1257.674581][  T352]  #0: ffff88a033931658 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x167/0x90d
[ 1257.719434][  T352]  #1: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1257.764101][  T352] 2 locks held by kworker/u97:9/270:
[ 1257.787648][  T352]  #0: ffff88a035e6cd38 ((wq_completion)xfs-cil/dm-0){+.+.}-{0:0}, at: process_one_work+0x7c8/0x17c0
[ 1257.837506][  T352]  #1: ffffc900077d7e00 ((work_completion)(&cil->xc_push_work)){+.+.}-{0:0}, at: process_one_work+0x7fc/0x17c0
[ 1257.892615][  T352] 1 lock held by khungtaskd/352:
[ 1257.915428][  T352]  #0: ffffffff905887e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.29+0x0/0x30
[ 1257.964163][  T352] 1 lock held by khugepaged/360:
[ 1257.986155][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1258.030582][  T352] 1 lock held by kswapd0/366:
[ 1258.051264][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30
[ 1258.094152][  T352] 1 lock held by kswapd1/367:
[ 1258.117184][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30
[ 1258.161954][  T352] 1 lock held by kswapd2/368:
[ 1258.182634][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30
[ 1258.224967][  T352] 1 lock held by kswapd3/369:
[ 1258.245638][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30
[ 1258.287356][  T352] 1 lock held by systemd-journal/896:
[ 1258.311276][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1258.357096][  T352] 1 lock held by systemd-udevd/934:
[ 1258.380380][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1258.425357][  T352] 1 lock held by gmain/1221:
[ 1258.445231][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1258.489822][  T352] 1 lock held by irqbalance/1163:
[ 1258.512203][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1258.556285][  T352] 1 lock held by sshd/1232:
[ 1258.576151][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1258.622963][  T352] 5 locks held by systemd-logind/1255:
[ 1258.650245][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1258.696041][  T352]  #1: ffffffff90676850 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x219/0x4b0
[ 1258.738489][  T352]  #2: ffff88a005f040e0 (&type->s_umount_key#28){++++}-{3:3}, at: trylock_super+0x11/0xb0
[ 1258.783155][  T352]  #3: ffff88a00cd3d228 (&pag->pag_ici_reclaim_lock){+.+.}-{3:3}, at: xfs_reclaim_inodes_ag+0x135/0xb00
[ 1258.833254][  T352]  #4: ffff8897c3b57828 (&xfs_nondir_ilock_class){++++}-{3:3}, at: xfs_reclaim_inode+0xdf/0x860
[ 1258.880242][  T352] 2 locks held by agetty/1264:
[ 1258.901291][  T352]  #0: ffff889ff8159378 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: __do_execve_file+0x2f2/0x1a50
[ 1258.947820][  T352]  #1: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1258.992410][  T352] 1 lock held by crond/1509:
[ 1259.012721][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1259.057395][  T352] 1 lock held by in:imjournal/1523:
[ 1259.080494][  T352]  #0: ffff889fdeaee7c0 (&(&ip->i_mmaplock)->mr_lock){++++}-{3:3}, at: xfs_ilock+0xf3/0x370
[ 1259.127855][  T352] 3 locks held by restraintd/1520:
[ 1259.153828][  T352]  #0: ffff88a00bf4ea30 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x9c/0xb0
[ 1259.194996][  T352]  #1: ffff88a005f04430 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x371/0x4d0
[ 1259.234636][  T352]  #2: ffff88838caed050 (&sb->s_type->i_mutex_key#12){++++}-{3:3}, at: xfs_ilock+0x27c/0x370
[ 1259.280335][  T352] 1 lock held by runtest.sh/1567:
[ 1259.302796][  T352]  #0: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1259.347545][  T352] 2 locks held by random/1768:
[ 1259.369261][  T352]  #0: ffff888fbda3ce58 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x167/0x90d
[ 1259.414349][  T352]  #1: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1259.458977][  T352] 2 locks held by random/1769:
[ 1259.480409][  T352]  #0: ffff888fbda3ce58 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x167/0x90d
[ 1259.525545][  T352]  #1: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1259.571368][  T352] 2 locks held by random/1770:
[ 1259.592131][  T352]  #0: ffff888fbda3ce58 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x167/0x90d
[ 1259.641941][  T352]  #1: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1259.689771][  T352] 2 locks held by random/1771:
[ 1259.710979][  T352]  #0: ffff888fbda3ce58 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x167/0x90d
[ 1259.757004][  T352]  #1: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1259.801644][  T352] 2 locks held by random/1772:
[ 1259.822791][  T352]  #0: ffff888fbda3ce58 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x167/0x90d
[ 1259.867692][  T352]  #1: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1259.912339][  T352] 2 locks held by random/1773:
[ 1259.933571][  T352]  #0: ffff888fbda3ce58 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x167/0x90d
[ 1259.980366][  T352]  #1: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1260.026630][  T352] 5 locks held by random/1774:
[ 1260.048812][  T352]  #0: ffff888fbda3ce58 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x167/0x90d
[ 1260.094328][  T352]  #1: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1260.138919][  T352]  #2: ffffffff90676850 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0xb8/0x4b0
[ 1260.184545][  T352]  #3: ffff88a005f040e0 (&type->s_umount_key#28){++++}-{3:3}, at: trylock_super+0x11/0xb0
[ 1260.228764][  T352]  #4: ffff88a00cd3d228 (&pag->pag_ici_reclaim_lock){+.+.}-{3:3}, at: xfs_reclaim_inodes_ag+0x68c/0xb00
[ 1260.278792][  T352] 2 locks held by random/1775:
[ 1260.300785][  T352]  #0: ffff888fbda3ce58 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x167/0x90d
[ 1260.348139][  T352]  #1: ffffffff906d07c0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.64+0x0/0x30
[ 1260.393623][  T352] 1 lock held by awk/1785:
[ 1260.413577][  T352]  #0: ffff8890186467c0 (&(&ip->i_mmaplock)->mr_lock){++++}-{3:3}, at: xfs_ilock+0xf3/0x370
[ 1260.458941][  T352] 2 locks held by kworker/47:0/1815:
[ 1260.482420][  T352]  #0: ffff88a005d8b938 ((wq_completion)xfs-sync/dm-0){+.+.}-{0:0}, at: process_one_work+0x7c8/0x17c0
[ 1260.531638][  T352]  #1: ffffc9000a64fe00 ((work_completion)(&(&log->l_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7fc/0x17c0
[ 1260.585778][  T352] 
[ 1260.595753][  T352] =============================================
[ 1260.595753][  T352] 

> ---
>  block/blk-flush.c  | 17 ++++++-----------
>  block/blk-mq-tag.h | 12 ------------
>  block/blk-mq.c     | 30 ++++++++++++++----------------
>  block/blk.h        |  5 -----
>  4 files changed, 20 insertions(+), 44 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 21108a550fbf..e756db088d84 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -236,12 +236,10 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>  		error = fq->rq_status;
>  
>  	hctx = flush_rq->mq_hctx;
> -	if (!q->elevator) {
> -		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
> -		flush_rq->tag = -1;
> -	} else {
> -		flush_rq->internal_tag = -1;
> -	}
> +	if (!q->elevator)
> +		flush_rq->tag = BLK_MQ_NO_TAG;
> +	else
> +		flush_rq->internal_tag = BLK_MQ_NO_TAG;
>  
>  	running = &fq->flush_queue[fq->flush_running_idx];
>  	BUG_ON(fq->flush_pending_idx == fq->flush_running_idx);
> @@ -315,13 +313,10 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>  	flush_rq->mq_ctx = first_rq->mq_ctx;
>  	flush_rq->mq_hctx = first_rq->mq_hctx;
>  
> -	if (!q->elevator) {
> -		fq->orig_rq = first_rq;
> +	if (!q->elevator)
>  		flush_rq->tag = first_rq->tag;
> -		blk_mq_tag_set_rq(flush_rq->mq_hctx, first_rq->tag, flush_rq);
> -	} else {
> +	else
>  		flush_rq->internal_tag = first_rq->internal_tag;
> -	}
>  
>  	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
>  	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 3945c7f5b944..b1acac518c4e 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -101,18 +101,6 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
>  	return atomic_read(&hctx->nr_active) < depth;
>  }
>  
> -/*
> - * This helper should only be used for flush request to share tag
> - * with the request cloned from, and both the two requests can't be
> - * in flight at the same time. The caller has to make sure the tag
> - * can't be freed.
> - */
> -static inline void blk_mq_tag_set_rq(struct blk_mq_hw_ctx *hctx,
> -		unsigned int tag, struct request *rq)
> -{
> -	hctx->tags->rqs[tag] = rq;
> -}
> -
>  static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
>  					  unsigned int tag)
>  {
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e7a2d2d44b51..a20647139c95 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -277,26 +277,20 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  {
>  	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
>  	struct request *rq = tags->static_rqs[tag];
> -	req_flags_t rq_flags = 0;
>  
>  	if (data->q->elevator) {
>  		rq->tag = BLK_MQ_NO_TAG;
>  		rq->internal_tag = tag;
>  	} else {
> -		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
> -			rq_flags = RQF_MQ_INFLIGHT;
> -			atomic_inc(&data->hctx->nr_active);
> -		}
>  		rq->tag = tag;
>  		rq->internal_tag = BLK_MQ_NO_TAG;
> -		data->hctx->tags->rqs[rq->tag] = rq;
>  	}
>  
>  	/* csd/requeue_work/fifo_time is initialized before use */
>  	rq->q = data->q;
>  	rq->mq_ctx = data->ctx;
>  	rq->mq_hctx = data->hctx;
> -	rq->rq_flags = rq_flags;
> +	rq->rq_flags = 0;
>  	rq->cmd_flags = data->cmd_flags;
>  	if (data->flags & BLK_MQ_REQ_PREEMPT)
>  		rq->rq_flags |= RQF_PREEMPT;
> @@ -1127,9 +1121,10 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
>  {
>  	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
>  	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
> -	bool shared = blk_mq_tag_busy(rq->mq_hctx);
>  	int tag;
>  
> +	blk_mq_tag_busy(rq->mq_hctx);
> +
>  	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
>  		bt = &rq->mq_hctx->tags->breserved_tags;
>  		tag_offset = 0;
> @@ -1142,19 +1137,22 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
>  		return false;
>  
>  	rq->tag = tag + tag_offset;
> -	if (shared) {
> -		rq->rq_flags |= RQF_MQ_INFLIGHT;
> -		atomic_inc(&rq->mq_hctx->nr_active);
> -	}
> -	rq->mq_hctx->tags->rqs[rq->tag] = rq;
>  	return true;
>  }
>  
>  static bool blk_mq_get_driver_tag(struct request *rq)
>  {
> -	if (rq->tag != BLK_MQ_NO_TAG)
> -		return true;
> -	return __blk_mq_get_driver_tag(rq);
> +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> +
> +	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_get_driver_tag(rq))
> +		return false;
> +
> +	if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
> +		rq->rq_flags |= RQF_MQ_INFLIGHT;
> +		atomic_inc(&hctx->nr_active);
> +	}
> +	hctx->tags->rqs[rq->tag] = rq;
> +	return true;
>  }
>  
>  static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
> diff --git a/block/blk.h b/block/blk.h
> index 41a50880c94e..0184a31fe4df 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -25,11 +25,6 @@ struct blk_flush_queue {
>  	struct list_head	flush_data_in_flight;
>  	struct request		*flush_rq;
>  
> -	/*
> -	 * flush_rq shares tag with this rq, both can't be active
> -	 * at the same time
> -	 */
> -	struct request		*orig_rq;
>  	struct lock_class_key	key;
>  	spinlock_t		mq_flush_lock;
>  };
> -- 
> 2.25.2
> 
