Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F501C433E2
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 07:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D592168B
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 07:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wluZ61Yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIGHFR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgIGHFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Sep 2020 03:05:15 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0F3C061573
        for <linux-block@vger.kernel.org>; Mon,  7 Sep 2020 00:05:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v4so13074308wmj.5
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2020 00:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3nWvURN4RC+T1s2KWqTGaOX8m3Gy3EOIc2Purt5eWGA=;
        b=wluZ61YtwMY5gM3IsJn9EjblZcOyPnYIXgxEPejXnY06Y0cmaFGNeNvtvuqV/L/2oG
         WBI8jUfmR3qcwpKL0Ca1YuFLk2YiwmyZFXxdePt1/B9OTOR1L5m+tEtHjekommP+tcxb
         ro+Z4rj5PFxAgHeVx9iiFlAnf1MuSItTm4lJLrsGXB3MbamXzaOC9jbhCgLcL3E0a9vX
         Lx+Uqp6UQaI2BR2Lwqj7qOzqb8veqtPgFDaU7aztWfXSctYDwf6EwtGavavpvLUFxKIv
         fNZ9JxATWkWsRmhMjDiB3t6ps3b01MUTZsuGvwMDxrZ7enPBJmiYVBeWA3ljp/f4KAFz
         tTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3nWvURN4RC+T1s2KWqTGaOX8m3Gy3EOIc2Purt5eWGA=;
        b=P7mKa4vfkKgtNLtpT7DongCIp5+wwjB5W2P+fKyCdXvUkngrH6xaCDHfkeIeRk1tFd
         o4G6Y3euep7GNAki97CrDg6G1gNBexxcPJhDa9RoF8slXioIwEA9y42uHaewaPPWV577
         aYz64EBrGYgj/BCmfECe9BFZY/fmJ4XHCU+KqzOeTaiP5NMxidpfLcLkKUxgywkR+Fxo
         Hg6hY5jZBmrVF3ZXAxctHJOYf56rjFxQOuVA4lQ5rJ7l5h/Mo4sUv3rvdZqJzJvebEqS
         cE0f99ZYzU6I8YFmC29GXO9WVj0cPOrSAIKK2IkNQviHK3BV8t3rHAm97xm3ThkPd9VJ
         ZlYw==
X-Gm-Message-State: AOAM530Kp6/Qr3uPemalqvl6HH+RgzOBCEUkZR9TZ9qtdVEtpqt6Mumb
        QB2SILjeAMjEUPqqWq3IdNw/LA==
X-Google-Smtp-Source: ABdhPJzlDMnvsJk/W8VDKHiWgnoDdeeDEnNswseU8R3tD/G5Gz2uIPLpgC7/yrhcAjgB/Mf/TRmD8g==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr9607325wma.88.1599462312262;
        Mon, 07 Sep 2020 00:05:12 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id v2sm25818831wrm.16.2020.09.07.00.05.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 00:05:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: panic happened on 5.8.6-rc2-650d8f2
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <7fe5bdcc-b366-2139-01f3-da613323eaba@kernel.dk>
Date:   Mon, 7 Sep 2020 09:05:29 +0200
Cc:     Jianlin Shi <jishi@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Rachel Sibley <rasibley@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D322EAC5-3C07-4752-A171-3FF74A766F5C@linaro.org>
References: <CABE0yyhP+MSNM4-GJ7hDN+kNMg=LWrg9eze5zFt3S6jCN9P7_Q@mail.gmail.com>
 <CABE0yyj4YBD+DQumY6a3uvahfqY+4D4AAUs2Ja3+JGMfxPQxfQ@mail.gmail.com>
 <7fe5bdcc-b366-2139-01f3-da613323eaba@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jianlin,
given the stack trace and the goal of commit
2de791ab4918969d8108f15238a701968375f235 ("bfq: fix blkio cgroup
leakage v4"), this failure might be related to that commit.  Could you
please try reverting that commit and report back?

Thanks,
Paolo

> Il giorno 7 set 2020, alle ore 04:02, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> CC Paolo
>=20
>=20
> On 9/6/20 6:36 PM, Jianlin Shi wrote:
>> Hi,
>>=20
>> panic happened when we run jobs on 5.8.6-rc2-650d8f2:
>> https://beaker.engineering.redhat.com/recipes/8756377#task115008997
>>=20
>> and the core trace is as follows, have you ever seen this before?
>>=20
>> [ 7522.385926] BUG: kernel NULL pointer dereference, address: =
0000000000000000
>> [ 7522.393694] #PF: supervisor read access in kernel mode
>> [ 7522.399425] #PF: error_code(0x0000) - not-present page
>> [ 7522.405154] PGD 0 P4D 0
>> [ 7522.407977] Oops: 0000 [#1] SMP PTI
>> [ 7522.411866] CPU: 14 PID: 668 Comm: kworker/14:1H Kdump: loaded
>> Tainted: G             L    5.8.6-rc2-650d8f2.cki #1
>> [ 7522.423510] Hardware name: Dell Inc. PowerEdge R630/0CNCJW, BIOS
>> 1.2.10 03/09/2015
>> [ 7522.431959] Workqueue: kblockd blk_mq_run_work_fn
>> [ 7522.437206] RIP: 0010:__list_del_entry_valid+0x2d/0x4c
>> [ 7522.442936] Code: 4c 8b 47 08 48 b8 00 01 00 00 00 00 ad de 48 39
>> c2 0f 84 71 00 00 00 48 b8 22 01 00 00 00 00 ad de 49 39 c0 0f 84 91
>> 00 00 00 <49> 8b 30 48 39 fe 0f 85 71 00 00 00 48 8b 52 08 48 39 f2 =
0f
>> 85 56
>> [ 7522.463891] RSP: 0018:ffffa5b9009dfcd8 EFLAGS: 00010017
>> [ 7522.469719] RAX: dead000000000122 RBX: ffff8b458d4c9950 RCX:
>> 0000000000000000
>> [ 7522.477680] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>> ffff8b448a753938
>> [ 7522.485640] RBP: ffff8b448a753898 R08: 0000000000000000 R09:
>> ffff8b45bb6bb32c
>> [ 7522.493600] R10: 0000000000000018 R11: 0000000000000018 R12:
>> ffff8b448a753810
>> [ 7522.501560] R13: ffff8b44993e2800 R14: 0000000000000000 R15:
>> ffff8b458d07c900
>> [ 7522.509520] FS:  0000000000000000(0000) GS:ffff8b45bfd80000(0000)
>> knlGS:0000000000000000
>> [ 7522.518548] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 7522.524957] CR2: 0000000000000000 CR3: 0000000875570005 CR4:
>> 00000000001606e0
>> [ 7522.532917] Call Trace:
>> [ 7522.535647]  bfq_idle_extract+0x52/0xb0
>> [ 7522.539926]  bfq_put_idle_entity+0x12/0x60
>> [ 7522.544494]  bfq_bfqq_served+0xb0/0x190
>> [ 7522.548770]  bfq_dispatch_request+0x2c2/0x1070
>> [ 7522.553727]  blk_mq_do_dispatch_sched+0xa4/0x140
>> [ 7522.558879]  ? newidle_balance+0x1c0/0x390
>> [ 7522.563446]  __blk_mq_sched_dispatch_requests+0x159/0x160
>> [ 7522.569467]  blk_mq_sched_dispatch_requests+0x30/0x60
>> [ 7522.575102]  __blk_mq_run_hw_queue+0x49/0x110
>> [ 7522.579962]  process_one_work+0x1b4/0x370
>> [ 7522.584434]  worker_thread+0x53/0x3e0
>> [ 7522.588517]  ? process_one_work+0x370/0x370
>> [ 7522.593180]  kthread+0x119/0x140
>> [ 7522.596779]  ? __kthread_bind_mask+0x60/0x60
>> [ 7522.601541]  ret_from_fork+0x22/0x30
>> [ 7522.605528] Modules linked in: scsi_transport_iscsi crypto_user
>> can_bcm pptp gre l2tp_ip6 l2tp_ip l2tp_core ip6_udp_tunnel udp_tunnel
>> rfcomm can_raw hidp bnep nfc af_key mpls_router ip_tunnel
>> vsock_loopback vmw_vsock_virtio_transport_common
>> vmw_vsock_vmci_transport vsock vmw_vmci kcm ieee802154_socket
>> ieee802154 bluetooth ecdh_generic ecc fcrypt pcbc rxrpc pppoe pppox
>> smc ib_core atm can mlx4_en mlx4_core n_gsm pps_ldisc slcan
>> ppp_synctty n_hdlc mkiss ax25 ppp_async ppp_generic slip slhc =
nls_utf8
>> isofs minix binfmt_misc nfsv3 nfs_acl rds brd exfat vfat fat loop =
sctp
>> tun xt_multiport xt_nat xt_addrtype xt_mark xt_conntrack =
xt_MASQUERADE
>> nft_counter xt_comment nft_compat nft_chain_nat nf_nat nf_conntrack
>> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink overlay fuse
>> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace =
fscache
>> rfkill intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
>> intel_powerclamp coretemp iTCO_wdt intel_pmc_bxt iTCO_vendor_support
>> sunrpc dcdbas
>> [ 7522.605556]  kvm_intel kvm irqbypass rapl intel_cstate
>> intel_uncore pcspkr ipmi_ssif lpc_ich mei_me mei igb dca ipmi_si
>> ipmi_devintf ipmi_msghandler acpi_power_meter ip_tables xfs mgag200
>> lpfc drm_vram_helper drm_kms_helper cec nvmet_fc drm_ttm_helper nvmet
>> ttm crct10dif_pclmul nvme_fc crc32_pclmul crc32c_intel nvme_fabrics
>> drm ghash_clmulni_intel i2c_algo_bit nvme_core megaraid_sas
>> scsi_transport_fc wmi [last unloaded: dummy]
>> [ 7522.744918] CR2: 0000000000000000
>> [ 7522.748613] ---[ end trace ed34032a61d7e2a6 ]---
>>=20
>> Thanks & Best Regards,
>>=20
>> Jianlin Shi
>>=20
>=20
>=20
> --=20
> Jens Axboe
>=20

