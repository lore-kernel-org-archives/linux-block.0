Return-Path: <SRS0=FTzM=TI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A924C04A6B
	for <linux-block@archiver.kernel.org>; Wed,  8 May 2019 19:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6AA21726
	for <linux-block@archiver.kernel.org>; Wed,  8 May 2019 19:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cseHpGBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfEHTuv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 May 2019 15:50:51 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:34502 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfEHTuu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 May 2019 15:50:50 -0400
Received: by mail-pf1-f180.google.com with SMTP id n19so10201pfa.1;
        Wed, 08 May 2019 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sVzcVct3OhKIVO1uKbdc1BVq2xvg3RVVsgKGJi0AZW8=;
        b=cseHpGBdh55JU0T6FkwMyaK/8411GC0h1zdOplsKutTf4bk7JZhyO9CsxHxiyD1KL9
         yio/FEmE7+eTB44MAbysqEFFglwKiikR0zUCT5K1zozDJZAG2qy/MRkGGGhgb819TmBA
         ktYWgDkQa8+DG2o4pBJlGoEVAVSi0jvQ846JfMFE7XILGOhnIm6+eE9xB4vmVicxaU/s
         oMlxwwLubEYT9vdupfBsMhB0Tw+zHFc2uEMImOljfYXOXan5gBjLLGg7/BqZ/+LObgFj
         //bqNPsRsS68h5ANIBEYHfvVe8KGuB6aFVPsk6kPtjH6EX0/zUv/IWqIzO796p6fN2xP
         74/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=sVzcVct3OhKIVO1uKbdc1BVq2xvg3RVVsgKGJi0AZW8=;
        b=VB2kjGG7OBqedly1jygNNaiSey0LJhX7NFuWLsZeT3qM4k6b1LBCMc+YI8d2hOiTSY
         tQMxXkk2NdhUiUI2cyQg0VTotpDrxC0p1oTB7XG07U9S/Uy8Gw9rWdUxlIqs29u8IUcf
         a11+KSJ5RduihFcK2EaqTmWivV5B94Hec/fuzwCJ3CgvIEAaWKn8kKSXvry6Fd7iKNRq
         xs/kKM9cdpmrZUACmPsDgOjtt4wNWOn6kwY/qaoj+1z8Vlbr/doZNMyUnUAVhI7QUGdg
         8wBOgsGZ9lk6ZHCMypwOr1lhh6L/mdyvDfjoNF42fS9YjSwZq60dC0d7N9LAEzuhMMbe
         wCsQ==
X-Gm-Message-State: APjAAAX2sEaOo+uj65BCez9F/6NnWQ2RigkBU6NFfZu0fgamkrSLO/3x
        2SiiYmzsGukj3cyklsA0Pfo=
X-Google-Smtp-Source: APXvYqxuTkubfEktoXwttohtSOJZ0MD5Qai9wrYiyVgT8pcUPbAebRuzAlQ0cjf8yNKq6XwhET253Q==
X-Received: by 2002:aa7:93ba:: with SMTP id x26mr32759120pff.238.1557345049723;
        Wed, 08 May 2019 12:50:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t9sm18886814pgp.66.2019.05.08.12.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 12:50:49 -0700 (PDT)
Date:   Wed, 8 May 2019 12:50:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: use-after-free in bfq_idle_slice_timer()
Message-ID: <20190508195047.GA28280@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

we have seen the attached use-after-free in bfq_idle_slice_timer()
while running reboot tests. The code in these tests includes all
bfq patches up to and including commit eed47d19d936 ("block, bfq:
fix use after free in bfq_bfqq_expire").

gdb points to the dereference of struct bfq_queue *bfqq in
bfq_bfqq_budget_timeout(). My suspicion is that the cleanup path
in bfq_put_queue() may not clear bfqd->in_service_queue, but I don't
understand the code well enough to be sure.

Any thoughts / comments ?

Thanks,
Guenter

---
[   25.307269] ==================================================================
[   25.314555] BUG: KASAN: use-after-free in bfq_idle_slice_timer+0x88/0x1d4
[   25.321359] Read of size 8 at addr fffffff089360440 by task swapper/0/0
[   25.327975] 
[   25.329487] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S                4.19.38 #37
[   25.336974] Hardware name: <...> rev2 board (DT)
[   25.342378] Call trace:
[   25.344844]  dump_backtrace+0x0/0x358
[   25.348521]  show_stack+0x20/0x2c
[   25.351849]  dump_stack+0x130/0x19c
[   25.355353]  print_address_description+0x74/0x250
[   25.360068]  kasan_report+0x27c/0x2a0
[   25.363742]  __asan_report_load8_noabort+0x2c/0x38
[   25.368546]  bfq_idle_slice_timer+0x88/0x1d4
[   25.372829]  __hrtimer_run_queues+0x794/0xa34
[   25.377197]  hrtimer_interrupt+0x278/0x600
[   25.381310]  arch_timer_handler_phys+0x5c/0x6c
[   25.385767]  handle_percpu_devid_irq+0x2e4/0x754
[   25.390399]  __handle_domain_irq+0xd4/0x158
[   25.394593]  gic_handle_irq+0x208/0x260
[   25.398437]  el1_irq+0xb0/0x128
[   25.401591]  arch_cpu_idle+0x20c/0x548
[   25.405352]  do_idle+0x184/0x4dc
[   25.408590]  cpu_startup_entry+0x24/0x28
[   25.412526]  rest_init+0x114/0x148
[   25.415939]  start_kernel+0x4c8/0x5c4
[   25.419605] 
[   25.421105] Allocated by task 1430:
[   25.424606]  kasan_kmalloc+0xe0/0x1ac
[   25.428279]  kasan_slab_alloc+0x14/0x1c
[   25.432127]  kmem_cache_alloc+0x178/0x278
[   25.436149]  bfq_get_queue+0x160/0x650
[   25.439911]  bfq_get_bfqq_handle_split+0xcc/0x2fc
[   25.444627]  bfq_init_rq+0x254/0x18c0
[   25.448301]  bfq_insert_requests+0x5d0/0x1048
[   25.452669]  blk_mq_sched_insert_requests+0x130/0x204
[   25.457734]  blk_mq_flush_plug_list+0x844/0x91c
[   25.462278]  blk_flush_plug_list+0x3e4/0x778
[   25.466559]  blk_finish_plug+0x54/0x78
[   25.470322]  read_pages+0x294/0x2f0
[   25.473824]  __do_page_cache_readahead+0x1a4/0x354
[   25.478628]  filemap_fault+0x8ec/0xbb4
[   25.482389]  ext4_filemap_fault+0x84/0xa4
[   25.486409]  __do_fault+0x128/0x338
[   25.489909]  handle_mm_fault+0x1de0/0x2588
[   25.494017]  do_page_fault+0x464/0x8d8
[   25.497777]  do_translation_fault+0x6c/0x88
[   25.501969]  do_mem_abort+0xd8/0x2d0
[   25.505554]  do_el0_ia_bp_hardening+0x13c/0x1a8
[   25.510094]  el0_ia+0x18/0x1c
[   25.513065] 
[   25.514562] Freed by task 1430:
[   25.517715]  __kasan_slab_free+0x13c/0x21c
[   25.521821]  kasan_slab_free+0x10/0x1c
[   25.525582]  kmem_cache_free+0x7c/0x5f8
[   25.529429]  bfq_put_queue+0x19c/0x2e4
[   25.533191]  bfq_exit_icq_bfqq+0x108/0x228
[   25.537299]  bfq_exit_icq+0x20/0x38
[   25.540798]  ioc_exit_icq+0xe4/0x16c
[   25.544384]  put_io_context_active+0x174/0x234
[   25.548836]  exit_io_context+0x84/0x94
[   25.552599]  do_exit+0x13b4/0x18e4
[   25.556013]  do_group_exit+0x1cc/0x204
[   25.559775]  __wake_up_parent+0x0/0x5c
[   25.563537]  __se_sys_exit_group+0x0/0x24
[   25.567558]  el0_svc_common+0x124/0x1ec
[   25.571407]  el0_svc_compat_handler+0x84/0xb0
[   25.575774]  el0_svc_compat+0x8/0x18
[   25.579351] 
[   25.580854] The buggy address belongs to the object at fffffff089360338
[   25.580854]  which belongs to the cache bfq_queue of size 464
[   25.587350] cros-ec-spi spi2.0: SPI transfer timed out
[   25.593209] The buggy address is located 264 bytes inside of
[   25.593209]  464-byte region [fffffff089360338, fffffff089360508)
[   25.593216] The buggy address belongs to the page:
[   25.593234] page:ffffffbfc224d800 count:1 mapcount:0 mapping:fffffff09916d880 index:0xfffffff089360cc8
[   25.598388] cros-ec-spi spi2.0: spi transfer failed: -110
[   25.610092]  compound_mapcount: 0
[   25.610109] flags: 0x4000000000008100(slab|head)
[   25.610133] raw: 4000000000008100 ffffffbfc14c1908 fffffff0991668a0 fffffff09916d880
[   25.615021] cros-ec-spi spi2.0: Command xfer error (err:-110)
[   25.624225] raw: fffffff089360cc8 000000000014000d 00000001ffffffff 0000000000000000
[   25.624233] page dumped because: kasan: bad access detected
[   25.624237] 
[   25.624243] Memory state around the buggy address:
[   25.624257]  fffffff089360300: fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb fb
[   25.624271]  fffffff089360380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   25.630223] cros-ec-i2c-tunnel 11012000.spi:ec@0:i2c-tunnel: Error transferring EC i2c message -110
[   25.632977] >fffffff089360400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   25.632985]                                            ^
[   25.632997]  fffffff089360480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   25.633010]  fffffff089360500: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   25.633016] ==================================================================

