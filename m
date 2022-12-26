Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951A4C46467
	for <linux-block@archiver.kernel.org>; Mon, 26 Dec 2022 03:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiLZDM5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Dec 2022 22:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiLZDMx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Dec 2022 22:12:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C564C15
        for <linux-block@vger.kernel.org>; Sun, 25 Dec 2022 19:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672024321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=gbCAEvr04zJLeeGmBnD7Vz8klws33Bd3z0dI9PVVmcU=;
        b=C1YP5b00YISKAcRREyOHXmstHpES0YhIGjdWOtjHUPD4f2YGgzm8chk3DBnBix01RJ/FL3
        qxhoJYTLIs7H54BEE9+fhz5j3q1ecUws4SJ1sbzpi5er8sop3WAP1WLOKnaF1JBMFMcKP2
        n8FvQE+Jmgw1k/GHf9d5xfmPTE8yNZs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-331-4pD_krs3MOKKyMfScjPqrg-1; Sun, 25 Dec 2022 22:11:59 -0500
X-MC-Unique: 4pD_krs3MOKKyMfScjPqrg-1
Received: by mail-ed1-f71.google.com with SMTP id h18-20020a05640250d200b004758e655ebeso6817059edb.11
        for <linux-block@vger.kernel.org>; Sun, 25 Dec 2022 19:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbCAEvr04zJLeeGmBnD7Vz8klws33Bd3z0dI9PVVmcU=;
        b=LNwHeCzcYYvBtAN+VWPHG6hpblSd7ZzM6+gwSjjyJ7n+cdFKJOj8P4YF4UVdNXVMuf
         yGZ6d75bEPXEg/XrlhXHmqB/o1svNMRvtPAR9Sllf/WcXa3JWeaRulFH2U0rQnhpxGFp
         8e9YI3JkYW+iwAobuPbLFnUqmCFwnKAV07SV3ynd6wzMC+ypNtSVP1RM7VWSVcE63i4c
         yjke+Lhr9WQMBBr7f3G33goL/eAwYUThKJ29MJBQvUVj4EUvMtOhM5B+v2PMQqNhuJTW
         RlB42BaN+dtJ/3CF/S0XxqN/sY/qBhwnT3xU53C0VyIZG/AAKSLqBgUWooBUVUSU1WbE
         x1eg==
X-Gm-Message-State: AFqh2koa4IS4nBoHjXcof2tnw1h8TPpGo92e56EHmT3gF6PKepwDwS+8
        6ee3Ykr8/BhZUXFwa963wy8hHsE1gkIKGVomQzQQ4KaHFQQFbcd/EatuEuhsQ2a0WZ8GyKm93AX
        mSd80xs2+nwBMCFweMSB0xy3IA2M4bgXcE3dOHyk=
X-Received: by 2002:a05:6402:104b:b0:469:dd6:bfee with SMTP id e11-20020a056402104b00b004690dd6bfeemr1949716edu.330.1672024316396;
        Sun, 25 Dec 2022 19:11:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuvw5TupuxcVHBSfHETJwCgsdb9oU2zGREX2BGHQW4wu3WJwxAxS91sRhEpVwMMONjh57KFHtAzLaCAd3p6eOE=
X-Received: by 2002:a05:6402:104b:b0:469:dd6:bfee with SMTP id
 e11-20020a056402104b00b004690dd6bfeemr1949715edu.330.1672024316056; Sun, 25
 Dec 2022 19:11:56 -0800 (PST)
MIME-Version: 1.0
From:   Changhui Zhong <czhong@redhat.com>
Date:   Mon, 26 Dec 2022 11:11:44 +0800
Message-ID: <CAGVVp+WS5aHiF2Odc-C+fO56qKyV7vPsPRz35v9eWsPJDNj=ng@mail.gmail.com>
Subject: [bug report] Unable to handle kernel NULL pointer dereference at
 virtual address 0000000000000058
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,
Below issue was triggered with ( v6.0.15-996-g988abd970566), pls help check it

[ 7845.648246] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000058
[ 7845.648776] Mem abort info:
[ 7845.648938]   ESR = 0x0000000096000004
[ 7845.649155]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 7845.649462]   SET = 0, FnV = 0
[ 7845.649639]   EA = 0, S1PTW = 0
[ 7845.649821]   FSC = 0x04: level 0 translation fault
[ 7845.650105] Data abort info:
[ 7845.650274]   ISV = 0, ISS = 0x00000004
[ 7845.650496]   CM = 0, WnR = 0
[ 7845.650670] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000103cba000
[ 7845.651043] [0000000000000058] pgd=0000000000000000, p4d=0000000000000000
[ 7845.651446] Internal error: Oops: 96000004 [#1] SMP
[ 7845.651764] Modules linked in: snd_aloop snd_dummy snd_seq
snd_seq_device snd_pcm snd_timer snd soundcore ansi_cprng crypto_user
veth vrf ipvlan echainiv esp4 des_generic libdes tun geneve ip6_tables
ip_vs ip_set xt_sctp nf_conntrack_netlink nft_chain_nat xt_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables
nfnetlink tcp_dctcp ah6 ah4 binfmt_misc can_j1939 l2tp_core bnep hidp
can_bcm pptp gre can_raw rfcomm bluetooth ieee802154_socket ieee802154
af_key qrtr pppoe pppox ppp_generic slhc mpls_router ip_tunnel
vsock_loopback vmw_vsock_virtio_transport_common
vmw_vsock_vmci_transport vmw_vmci vsock fcrypt pcbc rxrpc smc ib_core
kcm can macsec llc sctp ip6_udp_tunnel udp_tunnel mlx4_en mlx4_core
nfp tls loop nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver fscache
netfs rfkill sunrpc vfat fat virtio_net net_failover failover fuse
zram xfs crct10dif_ce polyval_ce virtio_console polyval_generic
ghash_ce virtio_blk virtio_mmio qemu_fw_cfg [last unloaded: vxlan]
[ 7845.656785] CPU: 5 PID: 789199 Comm: bash Not tainted 6.0.15 #1
[ 7845.657126] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[ 7845.657523] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 7845.657932] pc : blk_mq_quiesce_queue+0x50/0xa0
[ 7845.658208] lr : blk_mq_quiesce_queue+0x4c/0xa0
[ 7845.658489] sp : ffff80000dcdbb30
[ 7845.658696] x29: ffff80000dcdbb30 x28: ffff0007fe9cc480 x27: 0000000000000000
[ 7845.659137] x26: 0000000000000000 x25: 0000000000001000 x24: ffff0000c2e4d140
[ 7845.659577] x23: ffffb77a8eef4db0 x22: ffffb77a8eeeee50 x21: ffff0000ca8042f8
[ 7845.660019] x20: 0000000000000000 x19: ffff0000ca804280 x18: 0000000000000000
[ 7845.660457] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaacb2fb7c0
[ 7845.660899] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[ 7845.661348] x11: ffffb77a8eeef6d8 x10: 0000000000001db0 x9 : ffffb77a8d727ab8
[ 7845.661788] x8 : ffff80000dcdbac8 x7 : 0000000000000000 x6 : ffff80000dcdbb20
[ 7845.662230] x5 : ffff80000dcd8000 x4 : ffff80000dcdbb10 x3 : ffff0000ca8042e8
[ 7845.662671] x2 : 0000000000000001 x1 : ffff0007fe9cc480 x0 : 0000000000000000
[ 7845.663110] Call trace:
[ 7845.663264]  blk_mq_quiesce_queue+0x50/0xa0
[ 7845.663524]  del_gendisk+0x1e4/0x32c
[ 7845.663748]  zram_remove+0xd0/0xec [zram]
[ 7845.664003]  hot_remove_store+0x6c/0x100 [zram]
[ 7845.664286]  class_attr_store+0x24/0x40
[ 7845.664527]  sysfs_kf_write+0x4c/0x5c
[ 7845.664758]  kernfs_fop_write_iter+0x120/0x1f0
[ 7845.665032]  vfs_write+0x1cc/0x380
[ 7845.665245]  ksys_write+0x68/0xf0
[ 7845.665452]  __arm64_sys_write+0x24/0x30
[ 7845.665696]  invoke_syscall+0x78/0x100
[ 7845.665931]  el0_svc_common.constprop.0+0x4c/0xf4
[ 7845.666225]  do_el0_svc+0x34/0x4c
[ 7845.666432]  el0_svc+0x34/0x10c
[ 7845.666631]  el0t_64_sync_handler+0xf4/0x120
[ 7845.666898]  el0t_64_sync+0x190/0x194
[ 7845.667129] Code: aa1403e1 aa1503e0 94257716 f9419660 (b9405801)
[ 7845.667507] ---[ end trace 0000000000000000 ]---
[ 7845.667794] Kernel panic - not syncing: Oops: Fatal exception
[ 7845.668150] SMP: stopping secondary CPUs
[ 7845.668403] Kernel Offset: 0x377a846d0000 from 0xffff800008000000
[ 7845.668770] PHYS_OFFSET: 0x40000000
[ 7845.668971] CPU features: 0x0000,0085c021,19805c82
[ 7845.669251] Memory Limit: none
[ 7845.669426] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---


--
Best Regards,
Changhui Zhong

