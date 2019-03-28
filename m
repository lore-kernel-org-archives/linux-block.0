Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E446AC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 14:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DD92075E
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 14:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfC1O6y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:58:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33991 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC1O6x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 10:58:53 -0400
Received: by mail-qk1-f193.google.com with SMTP id n68so12342349qka.1
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2019 07:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aLbGbLxSf7WBLyAunf2B1iAfMxd+vLzlbspAcMY1Es=;
        b=OZtKItBYygrBkycMgVNHfOsziXFLi8Emg4tvDupCGaaFrkAvwDxpiY/vXSF7QY390D
         o3rMygwr8iTO+P7E2E/TKH9KeBpkfwi3/NLEI3d91a+iNqHL3gNbzPxS9Aui4fhz2tXg
         Fi6H2+u6LWny04rxkbyMjET7zOkVAubSxdbVof3X8lIPl67f27R58IpZcKbgbaT28b/M
         zaQbqYdZoMIBc5DeXGhGdOYRecT24BDefu3WeRAH1AXaR1Vv7f396iLPYSYt/NIa455P
         KuIarQiMHNAJaycjCpDH/hdkcvJkN6gfRvlCMMdtI0o5i4pMnHEfDwuPdnSr/slU4Dsq
         fNWw==
X-Gm-Message-State: APjAAAUQ6aG2wIUs28aTyd4W+3TkUGxZyi5ENkj3dvJBfviGIF19x2Dg
        Ht5uijm6/44tPOCzzYCcN1oPElPFJFM=
X-Google-Smtp-Source: APXvYqzQDX2EjP1I4cPUfk6ULplIB+3d8xNem5WZwHMYOs+6y7WDq+YclJkLSgz5W5Gx8yXzKcaaJA==
X-Received: by 2002:a37:4d53:: with SMTP id a80mr35963937qkb.247.1553785132039;
        Thu, 28 Mar 2019 07:58:52 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:422c:9885:a6c:81b2])
        by smtp.gmail.com with ESMTPSA id u26sm9348456qtb.81.2019.03.28.07.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 07:58:51 -0700 (PDT)
Message-ID: <f1414550876007cee564551561e3b21065b5d7a8.camel@redhat.com>
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
From:   Laurence Oberman <loberman@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, jianchao.w.wang@oracle.com,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Thu, 28 Mar 2019 10:58:49 -0400
In-Reply-To: <20190328013116.GC19708@ming.t460p>
References: <7858e19ce3fc3ebf7845494a2209c58cd9e3086d.camel@redhat.com>
         <1553113730.65329.60.camel@acm.org>
         <3645c45e88523d4b242333d96adbb492ab100f97.camel@redhat.com>
         <d9febee1de759206bbf4d66f6570415ae64e4f33.camel@redhat.com>
         <8a6807100283a0c1256410f4f0381979b18398fe.camel@redhat.com>
         <CACVXFVOfZvnDo_ccVm1+cFRo_oSoiexgLfe_pyXp84v=0eQ7rQ@mail.gmail.com>
         <38a35a9c6a74371ebaea6cdf210184b8dee4dbeb.camel@redhat.com>
         <5d79ef69efecba45718c87110e8a37a37f973bea.camel@redhat.com>
         <74e767afc0e10054f87fc821fa15966449d3dd2a.camel@redhat.com>
         <d8c921e8df338e789b0a5bbe5e5e6944556ff2b8.camel@redhat.com>
         <20190328013116.GC19708@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-03-28 at 09:31 +0800, Ming Lei wrote:
> On Wed, Mar 27, 2019 at 07:34:37PM -0400, Laurence Oberman wrote:
> > On Wed, 2019-03-27 at 18:00 -0400, Laurence Oberman wrote:
> > > On Wed, 2019-03-27 at 08:56 -0400, Laurence Oberman wrote:
> > > > Truncating email content, starting bisect again as suggested.
> > > > Email was getting too long with repetition.
> > > > 
> > > > Crux of the issue repeated here so easy to understand topic
> > > > 
> > > > We got to dispatch passing rq_list and the list is
> > > > corrupted/freed
> > > > so
> > > > we panic. Clearly a race and is in v5.x+ kernels.
> > > > This new bisect will find it.
> > > > 
> > > > crash> bt
> > > > PID: 9191   TASK: ffff9dea0a8395c0  CPU: 1   COMMAND:
> > > > "kworker/1:1H"
> > > >  #0 [ffffa9fe0759fab0] machine_kexec at ffffffff938606cf
> > > >  #1 [ffffa9fe0759fb08] __crash_kexec at ffffffff9393a48d
> > > >  #2 [ffffa9fe0759fbd0] crash_kexec at ffffffff9393b659
> > > >  #3 [ffffa9fe0759fbe8] oops_end at ffffffff93831c41
> > > >  #4 [ffffa9fe0759fc08] no_context at ffffffff9386ecb9
> > > >  #5 [ffffa9fe0759fcb0] do_page_fault at ffffffff93870012
> > > >  #6 [ffffa9fe0759fce0] page_fault at ffffffff942010ee
> > > >     [exception RIP: blk_mq_dispatch_rq_list+114]
> > > >     RIP: ffffffff93b9f202  RSP: ffffa9fe0759fd90  RFLAGS:
> > > > 00010246
> > > >     RAX: ffff9de9c4d3bbc8  RBX: ffff9de9c4d3bbc8  RCX:
> > > > 0000000000000004
> > > >     RDX: 0000000000000000  RSI: ffffa9fe0759fe20  RDI:
> > > > ffff9dea0dad87f0
> > > >     RBP: 0000000000000000   R8: 0000000000000000   R9:
> > > > 8080808080808080
> > > >     R10: ffff9dea33827660  R11: ffffee9d9e097a00  R12:
> > > > ffffa9fe0759fe20
> > > >     R13: ffff9de9c4d3bb80  R14: 0000000000000000  R15:
> > > > ffff9dea0dad87f0
> > > >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > > >  #7 [ffffa9fe0759fe18] blk_mq_sched_dispatch_requests at
> > > > ffffffff93ba455c
> > > >  #8 [ffffa9fe0759fe60] __blk_mq_run_hw_queue at
> > > > ffffffff93b9e3cf
> > > >  #9 [ffffa9fe0759fe78] process_one_work at ffffffff938b0c21
> > > > #10 [ffffa9fe0759feb8] worker_thread at ffffffff938b18d9
> > > > #11 [ffffa9fe0759ff10] kthread at ffffffff938b6ee8
> > > > #12 [ffffa9fe0759ff50] ret_from_fork at ffffffff94200215
> > > > 
> > > 
> > > Hello Jens, Jianchao
> > > Finally made it to this one.
> > > I will see if I can revert and test
> > > 
> > > 7f556a44e61d0b62d78db9a2662a5f0daef010f2 is the first bad commit
> > > commit 7f556a44e61d0b62d78db9a2662a5f0daef010f2
> > > Author: Jianchao Wang <jianchao.w.wang@oracle.com>
> > > Date:   Fri Dec 14 09:28:18 2018 +0800
> > > 
> > >     blk-mq: refactor the code of issue request directly
> > >     
> > >     Merge blk_mq_try_issue_directly and
> > > __blk_mq_try_issue_directly
> > >     into one interface to unify the interfaces to issue requests
> > >     directly. The merged interface takes over the requests
> > > totally,
> > >     it could insert, end or do nothing based on the return value
> > > of
> > >     .queue_rq and 'bypass' parameter. Then caller needn't any
> > > other
> > >     handling any more and then code could be cleaned up.
> > >     
> > >     And also the commit c616cbee ( blk-mq: punt failed direct
> > > issue
> > >     to dispatch list ) always inserts requests to hctx dispatch
> > > list
> > >     whenever get a BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE, this
> > > is
> > >     overkill and will harm the merging. We just need to do that
> > > for
> > >     the requests that has been through .queue_rq. This patch also
> > >     could fix this.
> > >     
> > >     Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> > >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > > 
> > > 
> > > 
> > 
> > Cannot clean revert 
> > 
> > loberman@ibclient linux]$ git revert
> > 7f556a44e61d0b62d78db9a2662a5f0daef010f2 
> > error: could not revert 7f556a4... blk-mq: refactor the code of
> > issue
> > request directly
> > hint: after resolving the conflicts, mark the corrected paths
> > hint: with 'git add <paths>' or 'git rm <paths>'
> > hint: and commit the result with 'git commit'
> > 
> > Revert "blk-mq: refactor the code of issue request directly"
> > 
> > This reverts commit 7f556a44e61d0b62d78db9a2662a5f0daef010f2.
> > 
> > Conflicts:
> >         block/blk-mq.c
> > 
> > No clear what in this commit is breaking things and causing the
> > race
> 
> Hi Laurence,
> 
> Could you test the following patch?
> 
> 'bypass' means the caller handle the dispatch result.
> 
> Also, we might remove the handling for 'force', so we can align to
> blk_mq_dispatch_rq_list(), but that shouldn't be related with this
> issue.
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index bc3524428b96..ee4bfd9cbde5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1848,12 +1848,14 @@ blk_status_t blk_mq_try_issue_directly(struct
> blk_mq_hw_ctx *hctx,
>  	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
>  out_unlock:
>  	hctx_unlock(hctx, srcu_idx);
> +	if (bypass)
> +		return ret;
>  	switch (ret) {
>  	case BLK_STS_OK:
>  		break;
>  	case BLK_STS_DEV_RESOURCE:
>  	case BLK_STS_RESOURCE:
> -		if (force) {
> +		if (force)
>  			blk_mq_request_bypass_insert(rq, run_queue);
>  			/*
>  			 * We have to return BLK_STS_OK for the DM
> @@ -1861,18 +1863,14 @@ blk_status_t blk_mq_try_issue_directly(struct
> blk_mq_hw_ctx *hctx,
>  			 * the real result to indicate whether the
>  			 * request is direct-issued successfully.
>  			 */
> -			ret = bypass ? BLK_STS_OK : ret;
> -		} else if (!bypass) {
> +		else
>  			blk_mq_sched_insert_request(rq, false,
>  						    run_queue, false);
> -		}
>  		break;
>  	default:
> -		if (!bypass)
> -			blk_mq_end_request(rq, ret);
> +		blk_mq_end_request(rq, ret);
>  		break;
>  	}
> -
>  	return ret;
>  }
>  
> Thanks,
> Ming

Hello Ming

Thanks for the patch, unfortunately it did not help.
I stared at the changes for a while and could not see how it would make
a difference to the race.
However, thats is mostly because I still need to get my head around all
the block-mq code.

The test was with this commit I added

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 70b210a..8952116 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1834,12 +1834,15 @@ blk_status_t blk_mq_try_issue_directly(struct
blk_mq_hw_ctx *hctx,
        ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
 out_unlock:
        hctx_unlock(hctx, srcu_idx);
+        if (bypass)
+                return ret;
+
        switch (ret) {
        case BLK_STS_OK:
                break;
        case BLK_STS_DEV_RESOURCE:
        case BLK_STS_RESOURCE:
-               if (force) {
+                if (force)
                        blk_mq_request_bypass_insert(rq, run_queue);
                        /*
                         * We have to return BLK_STS_OK for the DM
@@ -1847,18 +1850,14 @@ blk_status_t blk_mq_try_issue_directly(struct
blk_mq_hw_ctx *hctx,
                         * the real result to indicate whether the
                         * request is direct-issued successfully.
                         */
-                       ret = bypass ? BLK_STS_OK : ret;
-               } else if (!bypass) {
+       else
                        blk_mq_sched_insert_request(rq, false,
                                                    run_queue, false);
-               }
                break;
        default:
-               if (!bypass)
-                       blk_mq_end_request(rq, ret);
+                blk_mq_end_request(rq, ret);
                break;
        }
-
        return ret;
 }



[  193.068245] device-mapper: multipath: Failing path 66:96.
[  193.092929] device-mapper: multipath: Failing path 8:96.
[  193.137068] #PF error: [normal kernel read fault]
[  195.217691] PGD 0 P4D 0 
[  195.231958] Oops: 0000 [#1] SMP PTI
[  195.250796] CPU: 4 PID: 8525 Comm: kworker/4:1H Tainted: G        W
I       5.1.0-rc2+ #2
[  195.295820] Hardware name: HP ProLiant DL380 G7, BIOS P67 08/16/2015
[  195.330339] Workqueue: kblockd blk_mq_run_work_fn
[  195.355613] RIP: 0010:blk_mq_dispatch_rq_list+0x72/0x570
[  195.385494] Code: 08 84 d2 0f 85 cf 03 00 00 45 31 f6 c7 44 24 38 00
00 00 00 c7 44 24 3c 00 00 00 00 80 3c 24 00 4c 8d 6b b8 48 8b 6b c8 75
24 <48> 8b 85 b8 00 00 00 48 8b 40 40 48 8b 40 10 48 85 c0 74 10 48 89
[  195.489501] RSP: 0018:ffffbb074781bd90 EFLAGS: 00010246
[  195.519090] RAX: ffff9f7e6e1de148 RBX: ffff9f7e6e1de148 RCX:
0000000000000004
[  195.560254] RDX: 0000000000000000 RSI: ffffbb074781be20 RDI:
ffff9f8aa95297d0
[  195.601196] RBP: 0000000000000000 R08: 0000000000000000 R09:
8080808080808080
[  195.642186] R10: 0000000000000001 R11: 0000000000000000 R12:
ffffbb074781be20
[  195.683094] R13: ffff9f7e6e1de100 R14: 0000000000000000 R15:
ffff9f8aa95297d0
[  195.724153] FS:  0000000000000000(0000) GS:ffff9f7eb7880000(0000)
knlGS:0000000000000000
[  195.769427] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  195.801687] CR2: 00000000000000b8 CR3: 000000020d20e004 CR4:
00000000000206e0
[  195.841126] Call Trace:
[  195.854014]  ? blk_mq_flush_busy_ctxs+0xca/0x120
[  195.879448]  blk_mq_sched_dispatch_requests+0x15c/0x180
[  195.908389]  __blk_mq_run_hw_queue+0x5f/0x100
[  195.932961]  process_one_work+0x171/0x380
[  195.956414]  worker_thread+0x49/0x3f0
[  195.976984]  kthread+0xf8/0x130
[  195.995078]  ? max_active_store+0x80/0x80
[  196.018080]  ? kthread_bind+0x10/0x10
[  196.038383]  ret_from_fork+0x35/0x40
[  196.058435] Modules linked in: ib_isert iscsi_target_mod
target_core_mod ib_srp scsi_transport_srp rpcrdma ib_iser rdma_ucm
ib_umad rdma_cm ib_ipoib sunrpc libiscsi iw_cm scsi_transport_iscsi
ib_cm mlx5_ib ib_uverbs ib_core intel_powerclamp coretemp kvm_intel kvm
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
crypto_simd iTCO_wdt cryptd ipmi_ssif glue_helper gpio_ich
iTCO_vendor_support dm_service_time pcspkr joydev hpwdt hpilo ipmi_si
acpi_power_meter pcc_cpufreq sg ipmi_devintf i7core_edac lpc_ich
ipmi_msghandler dm_multipath ip_tables xfs libcrc32c radeon sd_mod
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops mlx5_core ttm mlxfw drm crc32c_intel serio_raw hpsa ptp
bnx2 scsi_transport_sas pps_core dm_mirror dm_region_hash dm_log dm_mod
[  196.451938] CR2: 00000000000000b8
[  196.469994] ---[ end trace b2b431da81df2e95 ]---
[  196.469996] BUG: unable to handle kernel NULL pointer dereference at
00000000000000b8
[  196.495380] RIP: 0010:blk_mq_dispatch_rq_list+0x72/0x570
[  196.540456] #PF error: [normal kernel read fault]
[  196.570957] Code: 08 84 d2 0f 85 cf 03 00 00 45 31 f6 c7 44 24 38 00
00 00 00 c7 44 24 3c 00 00 00 00 80 3c 24 00 4c 8d 6b b8 48 8b 6b c8 75
24 <48> 8b 85 b8 00 00 00 48 8b 40 40 48 8b 40 10 48 85 c0 74 10 48 89
[  196.597976] PGD 0 P4D 0 
[  196.705627] RSP: 0018:ffffbb074781bd90 EFLAGS: 00010246
[  196.720114] Oops: 0000 [#2] SMP PTI
[  196.749959] RAX: ffff9f7e6e1de148 RBX: ffff9f7e6e1de148 RCX:
0000000000000004
[  196.769936] CPU: 6 PID: 4034 Comm: kworker/6:1H Tainted: G      D W
I       5.1.0-rc2+ #2
[  196.809000] RDX: 0000000000000000 RSI: ffffbb074781be20 RDI:
ffff9f8aa95297d0
[  196.854098] Hardware name: HP ProLiant DL380 G7, BIOS P67 08/16/2015
[  196.893109] RBP: 0000000000000000 R08: 0000000000000000 R09:
8080808080808080
[  196.928283] Workqueue: kblockd blk_mq_run_work_fn
[  196.968750] R10: 0000000000000001 R11: 0000000000000000 R12:
ffffbb074781be20
[  196.995203] RIP: 0010:blk_mq_dispatch_rq_list+0x72/0x570
[  197.035808] R13: ffff9f7e6e1de100 R14: 0000000000000000 R15:
ffff9f8aa95297d0
[  197.065780] Code: 08 84 d2 0f 85 cf 03 00 00 45 31 f6 c7 44 24 38 00
00 00 00 c7 44 24 3c 00 00 00 00 80 3c 24 00 4c 8d 6b b8 48 8b 6b c8 75
24 <48> 8b 85 b8 00 00 00 48 8b 40 40 48 8b 40 10 48 85 c0 74 10 48 89
[  197.105262] FS:  0000000000000000(0000) GS:ffff9f7eb7880000(0000)
knlGS:0000000000000000
[  197.213467] RSP: 0018:ffffbb074722bd90 EFLAGS: 00010246
[  197.259374] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  197.289579] RAX: ffff9f7e6e25a908 RBX: ffff9f7e6e25a908 RCX:
0000000000000004
[  197.322352] CR2: 00000000000000b8 CR3: 000000020d20e004 CR4:
00000000000206e0
[  197.361122] RDX: 0000000000000000 RSI: ffffbb074722be20 RDI:
ffff9f8a19f60000
[  197.400084] Kernel panic - not syncing: Fatal exception
[  197.440204] RBP: 0000000000000000 R08: 0000000000000000 R09:
8080808080808080
[  197.509179] R10: 0000000000000001 R11: 0000000000000000 R12:
ffffbb074722be20
[  197.549143] R13: ffff9f7e6e25a8c0 R14: 0000000000000000 R15:
ffff9f8a19f60000
[  197.590162] FS:  0000000000000000(0000) GS:ffff9f7eb78c0000(0000)
knlGS:0000000000000000
[  197.636223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  197.668680] CR2: 00000000000000b8 CR3: 000000020d20e004 CR4:
00000000000206e0
[  197.708291] Call Trace:
[  197.722282]  ? blk_mq_flush_busy_ctxs+0xca/0x120
[  197.748285]  blk_mq_sched_dispatch_requests+0x15c/0x180
[  197.777145]  __blk_mq_run_hw_queue+0x5f/0x100
[  197.801406]  process_one_work+0x171/0x380
[  197.824021]  worker_thread+0x49/0x3f0
[  197.844756]  kthread+0xf8/0x130
[  197.862142]  ? max_active_store+0x80/0x80
[  197.883917]  ? kthread_bind+0x10/0x10
[  197.904609]  ret_from_fork+0x35/0x40
[  197.924992] Modules linked in: ib_isert iscsi_target_mod
target_core_mod ib_srp scsi_transport_srp rpcrdma ib_iser rdma_ucm
ib_umad rdma_cm ib_ipoib sunrpc libiscsi iw_cm scsi_transport_iscsi
ib_cm mlx5_ib ib_uverbs ib_core intel_powerclamp coretemp kvm_intel kvm
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
crypto_simd iTCO_wdt cryptd ipmi_ssif glue_helper gpio_ich
iTCO_vendor_support dm_service_time pcspkr joydev hpwdt hpilo ipmi_si
acpi_power_meter pcc_cpufreq sg ipmi_devintf i7core_edac lpc_ich
ipmi_msghandler dm_multipath ip_tables xfs libcrc32c radeon sd_mod
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops mlx5_core ttm mlxfw drm crc32c_intel serio_raw hpsa ptp
bnx2 scsi_transport_sas pps_core dm_mirror dm_region_hash dm_log dm_mod
[  198.317894] CR2: 00000000000000b8
[  198.336570] ---[ end trace b2b431da81df2e96 ]---
[  198.336571] BUG: unable to handle kernel NULL pointer dereference at
00000000000000b8
[  198.336572] #PF error: [normal kernel read fault]
[  198.362241] RIP: 0010:blk_mq_dispatch_rq_list+0x72/0x570
[  198.405359] PGD 0 P4D 0 
[  198.432068] Code: 08 84 d2 0f 85 cf 03 00 00 45 31 f6 c7 44 24 38
00[  198.461906] Oops: 0000 [#3] SMP PTI

