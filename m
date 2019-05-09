Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C47C04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 15:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA2520989
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 15:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5qiIONr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEIPPC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 11:15:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45179 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIPPB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 May 2019 11:15:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so3545211wra.12
        for <linux-block@vger.kernel.org>; Thu, 09 May 2019 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WIoalgfl9sB38qAJBElhkuBUCSWiSCsmyfEgfkSYiRQ=;
        b=H5qiIONrxB7hLFsb9rrnuiuqPc+zrOGv70fqWwcEd7WxVsAdDfJ+bE7awRHt3RmGbJ
         TXzwG9OHdHnppDFSDyHUCN4WFnA2OBNvgRIm9kTznr0eDnm33auw4h64LL05vR08L1S3
         dze/b46aeC96NPTDNPMNnBuasyWP6zIFcugwDAGOoullVhtOMGYxQTvt7YrmoWXzw9hs
         k6Uv4JrPSnbJsIou9gB5q72aignrfjgIrN+lKI3DqwuJRa8P2/pWhb7i8YL0GjrV7Vqw
         341XOWVcmsXG7pJOjB9GRWh6HmtLFtLW5d5iO6mJyHDwKDLZFQcm1EwGQcnNXRqyLtco
         rxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WIoalgfl9sB38qAJBElhkuBUCSWiSCsmyfEgfkSYiRQ=;
        b=DouBvSjq1MF77Jqw1SRTuZ+HaIKmB/NVqteEriuQURpEgcBHSdPEhVz6jvBRVows3G
         ea4qdVcI4rcLH2JRJc+yUn1aUm2P4CiUBX3yP9EzVYQO4eLXB1YSBVNqQvPaNusdBQQA
         Waks9dg4d9n/2hN2hlxNUPNQcxCfq+ow02bsXHPPe0NGwOnQ1dsyH6QhG2sXAFRKisk9
         7IfGJdb93Q9SyJgwXtLGqUKk0abf4sN1sGaxq7A3I/ILlnyPKfws02UKjSnktfPzehIR
         hNYWfKvfuPFoNmVF8+5eHP3V7pyiYe1xFVKS5tWenMqaivCaFSD5OJcX47ZpgKQMrUzF
         enJg==
X-Gm-Message-State: APjAAAWUjBtE3joVD2batM+muRxhlKYnBU23rGms3dLO9SxkoC1b2gXy
        405IWwh3VEScOQSGmwFHG/TUlwkxWwE=
X-Google-Smtp-Source: APXvYqwMm0zjMX5F2Wrypephb4Ds8LTa3vdggOVjM2ghxNW5OeG9W/7z9xoPa/KB5kSQSk1jJPcSpw==
X-Received: by 2002:adf:c503:: with SMTP id q3mr3742761wrf.263.1557414900058;
        Thu, 09 May 2019 08:15:00 -0700 (PDT)
Received: from [192.168.0.100] (146-241-119-67.dyn.eolo.it. [146.241.119.67])
        by smtp.gmail.com with ESMTPSA id x17sm3356570wru.27.2019.05.09.08.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 08:14:59 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: use-after-free in bfq_idle_slice_timer()
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190508195047.GA28280@roeck-us.net>
Date:   Thu, 9 May 2019 17:14:57 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CFD68161-8AE4-48A1-9884-B8B4A93A50EB@linaro.org>
References: <20190508195047.GA28280@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I couldn't find any explanation.  Would you be willing to apply a
patch that adds runtime checks in bfq?  It'd take me a few days to
prepare it.

Thanks,
Paolo

> Il giorno 8 mag 2019, alle ore 21:50, Guenter Roeck =
<linux@roeck-us.net> ha scritto:
>=20
> Hi,
>=20
> we have seen the attached use-after-free in bfq_idle_slice_timer()
> while running reboot tests. The code in these tests includes all
> bfq patches up to and including commit eed47d19d936 ("block, bfq:
> fix use after free in bfq_bfqq_expire").
>=20
> gdb points to the dereference of struct bfq_queue *bfqq in
> bfq_bfqq_budget_timeout(). My suspicion is that the cleanup path
> in bfq_put_queue() may not clear bfqd->in_service_queue, but I don't
> understand the code well enough to be sure.
>=20
> Any thoughts / comments ?
>=20
> Thanks,
> Guenter
>=20
> ---
> [   25.307269] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   25.314555] BUG: KASAN: use-after-free in =
bfq_idle_slice_timer+0x88/0x1d4
> [   25.321359] Read of size 8 at addr fffffff089360440 by task =
swapper/0/0
> [   25.327975]=20
> [   25.329487] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S              =
  4.19.38 #37
> [   25.336974] Hardware name: <...> rev2 board (DT)
> [   25.342378] Call trace:
> [   25.344844]  dump_backtrace+0x0/0x358
> [   25.348521]  show_stack+0x20/0x2c
> [   25.351849]  dump_stack+0x130/0x19c
> [   25.355353]  print_address_description+0x74/0x250
> [   25.360068]  kasan_report+0x27c/0x2a0
> [   25.363742]  __asan_report_load8_noabort+0x2c/0x38
> [   25.368546]  bfq_idle_slice_timer+0x88/0x1d4
> [   25.372829]  __hrtimer_run_queues+0x794/0xa34
> [   25.377197]  hrtimer_interrupt+0x278/0x600
> [   25.381310]  arch_timer_handler_phys+0x5c/0x6c
> [   25.385767]  handle_percpu_devid_irq+0x2e4/0x754
> [   25.390399]  __handle_domain_irq+0xd4/0x158
> [   25.394593]  gic_handle_irq+0x208/0x260
> [   25.398437]  el1_irq+0xb0/0x128
> [   25.401591]  arch_cpu_idle+0x20c/0x548
> [   25.405352]  do_idle+0x184/0x4dc
> [   25.408590]  cpu_startup_entry+0x24/0x28
> [   25.412526]  rest_init+0x114/0x148
> [   25.415939]  start_kernel+0x4c8/0x5c4
> [   25.419605]=20
> [   25.421105] Allocated by task 1430:
> [   25.424606]  kasan_kmalloc+0xe0/0x1ac
> [   25.428279]  kasan_slab_alloc+0x14/0x1c
> [   25.432127]  kmem_cache_alloc+0x178/0x278
> [   25.436149]  bfq_get_queue+0x160/0x650
> [   25.439911]  bfq_get_bfqq_handle_split+0xcc/0x2fc
> [   25.444627]  bfq_init_rq+0x254/0x18c0
> [   25.448301]  bfq_insert_requests+0x5d0/0x1048
> [   25.452669]  blk_mq_sched_insert_requests+0x130/0x204
> [   25.457734]  blk_mq_flush_plug_list+0x844/0x91c
> [   25.462278]  blk_flush_plug_list+0x3e4/0x778
> [   25.466559]  blk_finish_plug+0x54/0x78
> [   25.470322]  read_pages+0x294/0x2f0
> [   25.473824]  __do_page_cache_readahead+0x1a4/0x354
> [   25.478628]  filemap_fault+0x8ec/0xbb4
> [   25.482389]  ext4_filemap_fault+0x84/0xa4
> [   25.486409]  __do_fault+0x128/0x338
> [   25.489909]  handle_mm_fault+0x1de0/0x2588
> [   25.494017]  do_page_fault+0x464/0x8d8
> [   25.497777]  do_translation_fault+0x6c/0x88
> [   25.501969]  do_mem_abort+0xd8/0x2d0
> [   25.505554]  do_el0_ia_bp_hardening+0x13c/0x1a8
> [   25.510094]  el0_ia+0x18/0x1c
> [   25.513065]=20
> [   25.514562] Freed by task 1430:
> [   25.517715]  __kasan_slab_free+0x13c/0x21c
> [   25.521821]  kasan_slab_free+0x10/0x1c
> [   25.525582]  kmem_cache_free+0x7c/0x5f8
> [   25.529429]  bfq_put_queue+0x19c/0x2e4
> [   25.533191]  bfq_exit_icq_bfqq+0x108/0x228
> [   25.537299]  bfq_exit_icq+0x20/0x38
> [   25.540798]  ioc_exit_icq+0xe4/0x16c
> [   25.544384]  put_io_context_active+0x174/0x234
> [   25.548836]  exit_io_context+0x84/0x94
> [   25.552599]  do_exit+0x13b4/0x18e4
> [   25.556013]  do_group_exit+0x1cc/0x204
> [   25.559775]  __wake_up_parent+0x0/0x5c
> [   25.563537]  __se_sys_exit_group+0x0/0x24
> [   25.567558]  el0_svc_common+0x124/0x1ec
> [   25.571407]  el0_svc_compat_handler+0x84/0xb0
> [   25.575774]  el0_svc_compat+0x8/0x18
> [   25.579351]=20
> [   25.580854] The buggy address belongs to the object at =
fffffff089360338
> [   25.580854]  which belongs to the cache bfq_queue of size 464
> [   25.587350] cros-ec-spi spi2.0: SPI transfer timed out
> [   25.593209] The buggy address is located 264 bytes inside of
> [   25.593209]  464-byte region [fffffff089360338, fffffff089360508)
> [   25.593216] The buggy address belongs to the page:
> [   25.593234] page:ffffffbfc224d800 count:1 mapcount:0 =
mapping:fffffff09916d880 index:0xfffffff089360cc8
> [   25.598388] cros-ec-spi spi2.0: spi transfer failed: -110
> [   25.610092]  compound_mapcount: 0
> [   25.610109] flags: 0x4000000000008100(slab|head)
> [   25.610133] raw: 4000000000008100 ffffffbfc14c1908 fffffff0991668a0 =
fffffff09916d880
> [   25.615021] cros-ec-spi spi2.0: Command xfer error (err:-110)
> [   25.624225] raw: fffffff089360cc8 000000000014000d 00000001ffffffff =
0000000000000000
> [   25.624233] page dumped because: kasan: bad access detected
> [   25.624237]=20
> [   25.624243] Memory state around the buggy address:
> [   25.624257]  fffffff089360300: fc fc fc fc fc fc fc fb fb fb fb fb =
fb fb fb fb
> [   25.624271]  fffffff089360380: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb
> [   25.630223] cros-ec-i2c-tunnel 11012000.spi:ec@0:i2c-tunnel: Error =
transferring EC i2c message -110
> [   25.632977] >fffffff089360400: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb
> [   25.632985]                                            ^
> [   25.632997]  fffffff089360480: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb
> [   25.633010]  fffffff089360500: fb fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc
> [   25.633016] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20

