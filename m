Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89529C433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 12:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609832063A
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 12:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEh+P/mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgHQMSk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:18:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26694 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726151AbgHQMSh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 08:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597666714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=CCHTGA+emK21p+/Di4y6g6om/6sEwz9DRMn1KmcuhK0=;
        b=PEh+P/mCBL2GqQfRr38GYtXsczR1YTHNuWltdX/EsO+Ix68Nh1tJ6CzA8LMv0YPxaUFDKn
        wkZRlSDW0xY/ryYUi2TMPbbIpBL7/iawcpHIPk+EcdS/tkOhmaacjgS6sBbDe9RBQmyVda
        ybaZU06fsWJFhol0Q3XQ/kw0HKZGfsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-o7MB8gK7Oy6ewrLiHlLV3w-1; Mon, 17 Aug 2020 08:18:32 -0400
X-MC-Unique: o7MB8gK7Oy6ewrLiHlLV3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECC6210082F9
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 12:18:31 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E71B5795AE
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 12:18:31 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id DFFB818095FF
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 12:18:31 +0000 (UTC)
Date:   Mon, 17 Aug 2020 08:18:30 -0400 (EDT)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block@vger.kernel.org
Message-ID: <1119948964.37908394.1597666710380.JavaMail.zimbra@redhat.com>
In-Reply-To: <1711769568.37907561.1597665999970.JavaMail.zimbra@redhat.com>
Subject: blktests block/001 triggered kernel BUG at lib/list_debug.c:23!
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.13]
Thread-Topic: blktests block/001 triggered kernel BUG at lib/list_debug.c:23!
Thread-Index: 5kAzE+tjVjKv4F7Fl1fcbKiNRG1nng==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

CKI obserbed kernel BUG[2] with commit[1] on aarch64, I tried to reproduce it but with no luck.

[1]
Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
      Commit: 4b6c093e21d3 - Merge tag 'block-5.9-2020-08-14' of git://git.kernel.dk/linux-block

[2]
[11648.279035] run blktests block/001 at 2020-08-16 03:48:51 
[11648.342401] scsi host4: scsi_debug: version 0190 [20200710] 
[11648.342401]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0 
[11648.354678] scsi 4:0:0:0: Direct-Access     Linux    scsi_debug       0190 PQ: 0 ANSI: 7 
[11648.354714] scsi host5: scsi_debug: version 0190 [20200710] 
[11648.354714]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0 
[11648.363216] sd 4:0:0:0: Power-on or device reset occurred 
[11648.363664] sd 4:0:0:0: Attached scsi generic sg1 type 0 
[11648.374907] scsi 5:0:0:0: Direct-Access     Linux    scsi_debug       0190 PQ: 0 ANSI: 7 
[11648.374979] scsi host6: scsi_debug: version 0190 [20200710] 
[11648.374979]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0 
[11648.375262] scsi 6:0:0:0: Direct-Access     Linux    scsi_debug       0190 PQ: 0 ANSI: 7 
[11648.375338] scsi host7: scsi_debug: version 0190 [20200710] 
[11648.375338]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0 
[11648.375616] scsi 7:0:0:0: Direct-Access     Linux    scsi_debug       0190 PQ: 0 ANSI: 7 
[11648.400135] sd 4:0:0:0: [sdb] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB) 
[11648.405595] sd 5:0:0:0: Power-on or device reset occurred 
[11648.413527] sd 5:0:0:0: Attached scsi generic sg2 type 0 
[11648.423377] sd 4:0:0:0: [sdb] Write Protect is off 
[11648.443435] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA 
[11648.445986] sd 5:0:0:0: [sdc] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB) 
[11648.446269] sd 6:0:0:0: Power-on or device reset occurred 
[11648.446289] sd 6:0:0:0: Attached scsi generic sg3 type 0 
[11648.446595] sd 7:0:0:0: Power-on or device reset occurred 
[11648.446618] sd 7:0:0:0: Attached scsi generic sg4 type 0 
[11648.466430] sd 6:0:0:0: [sdd] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB) 
[11648.466741] sd 7:0:0:0: [sde] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB) 
[11648.476765] sd 7:0:0:0: [sde] Write Protect is off 
[11648.481274] sd 4:0:0:0: [sdb] Optimal transfer size 524288 bytes 
[11648.481796] sd 5:0:0:0: [sdc] Write Protect is off 
[11648.487151] sd 6:0:0:0: [sdd] Write Protect is off 
[11648.501850] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA 
[11648.507193] sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA 
[11648.527654] sd 7:0:0:0: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA 
[11648.537247] sd 6:0:0:0: [sdd] Optimal transfer size 524288 bytes 
[11648.558071] sd 5:0:0:0: [sdc] Optimal transfer size 524288 bytes 
[11648.574968] sd 7:0:0:0: [sde] Optimal transfer size 524288 bytes 
[11648.813097] list_add corruption. next->prev should be prev (ffff800011c25d68), but was 0000000000000000. (next=ffff00038764eb10). 
[11648.824719] ------------[ cut here ]------------ 
[11648.829313] kernel BUG at lib/list_debug.c:23! 
[11648.833734] Internal error: Oops - BUG: 0 [#1] SMP 
[11648.838500] Modules linked in: scsi_debug btrfs blake2b_generic raid10 raid1 raid0 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq loop tun af_key crypto_user scsi_transport_iscsi xt_multiport overlay xt_CONNSECMARK xt_SECMARK nft_counter xt_state xt_conntrack nft_compat ah6 ah4 nft_objref nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink sctp dm_log_writes dm_flakey rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache rfkill xgene_enet sunrpc vfat fat at803x mdio_xgene xgene_rng xgene_hwmon xgene_edac mailbox_xgene_slimpro drm ip_tables xfs libcrc32c sdhci_of_arasan crct10dif_ce i2c_xgene_slimpro sdhci_pltfm sdhci gpio_dwapb cqhci xhci_plat_hcd gpio_xgene_sb gpio_keys aes_neon_bs 
[11648.905363] CPU: 7 PID: 684482 Comm: systemd-udevd Kdump: loaded Not tainted 5.8.0-4b6c093.cki #1 
[11648.914192] Hardware name: AppliedMicro X-Gene Mustang Board/X-Gene Mustang Board, BIOS 3.06.25 Oct 17 2016 
[11648.923885] pstate: 40400085 (nZcv daIf +PAN -UAO BTYPE=--) 
[11648.929434] pc : __list_add_valid+0x54/0x90 
[11648.933595] lr : __list_add_valid+0x54/0x90 
[11648.937756] sp : ffff80001348bae0 
[11648.941052] x29: ffff80001348bae0 x28: ffff0003a076f070  
[11648.946336] x27: ffff0003a076f450 x26: ffff800011c24980  
[11648.951621] x25: ffff800011c25d68 x24: 0000000000000000  
[11648.956905] x23: ffff00038764eb10 x22: ffff800011c25000  
[11648.962189] x21: ffff00038764ea70 x20: ffff800011fb4000  
[11648.967472] x19: ffff00038764ea60 x18: 0000000000000000  
[11648.972755] x17: 0000000000000000 x16: 0000000000000000  
[11648.978039] x15: 0000000000000010 x14: 0720072007200720  
[11648.983323] x13: 0720072007200720 x12: 0720072007200720  
[11648.988606] x11: 0720072007200720 x10: 0720072007200720  
[11648.993890] x9 : ffff800010320f08 x8 : 0000000000002dcc  
[11648.999173] x7 : 072e072907300731 x6 : 0000000000000001  
[11649.004456] x5 : 0000000000000000 x4 : ffff0003fdf1ba48  
[11649.009740] x3 : ffff0003fdf29f80 x2 : ffff0003fdf1ba48  
[11649.015023] x1 : ffff8003ec899000 x0 : 0000000000000075  
[11649.020307] Call trace: 
[11649.022742]  __list_add_valid+0x54/0x90 
[11649.026559]  __percpu_counter_init+0x9c/0x288 
[11649.030894]  blkg_rwstat_init+0x54/0xd8 
[11649.034711]  bfq_pd_alloc+0x6c/0xb0 
[11649.038181]  blkcg_activate_policy+0x2e8/0x468 
[11649.042603]  bfq_create_group_hierarchy+0x2c/0x170 
[11649.047368]  bfq_init_queue+0x30c/0x3e8 
[11649.051184]  blk_mq_init_sched+0x110/0x310 
[11649.055259]  elevator_switch_mq+0x6c/0x108 
[11649.059334]  elevator_switch+0x38/0x60 
[11649.063063]  elv_iosched_store+0xe0/0x140 
[11649.067051]  queue_attr_store+0x58/0x88 
[11649.070869]  sysfs_kf_write+0x4c/0x60 
[11649.074511]  kernfs_fop_write+0x1e0/0x2e8 
[11649.078501]  vfs_write+0xf8/0x238 
[11649.081798]  ksys_write+0x60/0xe8 
[11649.085096]  __arm64_sys_write+0x24/0x30 
[11649.088999]  el0_svc_common.constprop.0+0x7c/0x188 
[11649.093764]  do_el0_svc+0x2c/0x98 
[11649.097062]  el0_sync_handler+0x84/0x110 
[11649.100964]  el0_sync+0x15c/0x180 
[11649.104264] Code: aa0403e3 f0005f00 91260000 97ed6f42 (d4210000)  
[11649.110328] ---[ end trace 756ad1407667582e ]--- 
[11649.116044] ------------[ cut here ]------------ 
[11649.120651] WARNING: CPU: 7 PID: 0 at kernel/rcu/tree.c:630 rcu_eqs_enter.isra.0+0x94/0xa0 
[11649.128874] Modules linked in: scsi_debug btrfs blake2b_generic raid10 raid1 raid0 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq loop tun af_key crypto_user scsi_transport_iscsi xt_multiport overlay xt_CONNSECMARK xt_SECMARK nft_counter xt_state xt_conntrack nft_compat ah6 ah4 nft_objref nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink sctp dm_log_writes dm_flakey rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache rfkill xgene_enet sunrpc vfat fat at803x mdio_xgene xgene_rng xgene_hwmon xgene_edac mailbox_xgene_slimpro drm ip_tables xfs libcrc32c sdhci_of_arasan crct10dif_ce i2c_xgene_slimpro sdhci_pltfm sdhci gpio_dwapb cqhci xhci_plat_hcd gpio_xgene_sb gpio_keys aes_neon_bs 
[11649.195725] CPU: 7 PID: 0 Comm: swapper/7 Kdump: loaded Tainted: G      D           5.8.0-4b6c093.cki #1 
[11649.205157] Hardware name: AppliedMicro X-Gene Mustang Board/X-Gene Mustang Board, BIOS 3.06.25 Oct 17 2016 
[11649.214850] pstate: 204003c5 (nzCv DAIF +PAN -UAO BTYPE=--) 
[11649.220394] pc : rcu_eqs_enter.isra.0+0x94/0xa0 
[11649.224902] lr : rcu_idle_enter+0x18/0x28 
[11649.228889] sp : ffff800012613f30 
[11649.232185] x29: ffff800012613f30 x28: 75bf6987bbfbfd24  
[11649.237470] x27: 00000000746ba289 x26: ffff0003fc2e4100  
[11649.242754] x25: 0000000000000000 x24: 0000000000000000  
[11649.248037] x23: ffff800011b38454 x22: ffff800011692bf8  
[11649.253322] x21: ffff800011b38418 x20: 0000000000000007  
[11649.258605] x19: ffff800011b37bb8 x18: 0000000000000000  
[11649.263889] x17: 0000000000000000 x16: 0000000000000000  
[11649.269172] x15: 0000000000000010 x14: 0000000000000000  
[11649.274455] x13: 0000000000000000 x12: 0000000000000002  
[11649.279739] x11: 0000000000000000 x10: 0000000000001c20  
[11649.285022] x9 : ffff8000101f6c38 x8 : ffff0003fc2e5d80  
[11649.290307] x7 : 0000000000000040 x6 : 00000088bd273200  
[11649.295591] x5 : 00ffffffffffffff x4 : ffff8003ec899000  
[11649.300875] x3 : 4000000000000002 x2 : 4000000000000000  
[11649.306159] x1 : ffff0003fdf2df40 x0 : ffff800011694f40  
[11649.311443] Call trace: 
[11649.313876]  rcu_eqs_enter.isra.0+0x94/0xa0 
[11649.318037]  rcu_idle_enter+0x18/0x28 
[11649.321681]  do_idle+0x1e8/0x250 
[11649.324892]  cpu_startup_entry+0x30/0x98 
[11649.328794]  secondary_start_kernel+0x13c/0x178 
[11649.333300] ---[ end trace 756ad1407667582f ]--- 


Best Regards,
  Yi Zhang


