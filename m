Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A67C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 11:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhLGLSJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:18:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234406AbhLGLSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Dec 2021 06:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638875678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=woyO8x30vWQR5gsoY007hJolQxQANRLhaXQp/mpzWho=;
        b=CMy2M1jiuIcQ3QxKG+V8NbW6zppt+ssQjWZ/jc+44bFOUFgurq3Pek6GeWhRsPJsQ3H0YI
        naQSg2YaBMr552VN9xj6qM2aIOTxxaiCJ5y/Mqd8tmyDYADCghTBJHKPvnjhOTECSWldb2
        gxk5yBrp4L7G/TLUykrfD92t5DebovM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-MAEFMZLKNb6k1rsS9ARrWQ-1; Tue, 07 Dec 2021 06:14:35 -0500
X-MC-Unique: MAEFMZLKNb6k1rsS9ARrWQ-1
Received: by mail-yb1-f198.google.com with SMTP id y125-20020a25dc83000000b005c2326bf744so24978907ybe.21
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 03:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=woyO8x30vWQR5gsoY007hJolQxQANRLhaXQp/mpzWho=;
        b=4vURQm87DFXG4N8yFeuZ/Ed+5TU25KsqItomOkU9o1NN02gKzz/GhU1kmfHaqswM/q
         5MUPkReTJdTGbvHhPbrMdFANGN2uyjuCIWhgcB1GkpR7uM95iIzNdWUUWgc6LKYQdoak
         5Jf11KJCsrjP/vG2/FVaBUx70UfBifClLH+RuEMpn+8x7nxJrHs1cLRtFeOBf/zYBa4j
         Uz+tC/iT3nZ3CN/Vi0KYhZZMlEFy9hIEuQHT25TZDyaJ+R/tfntRNMnHaAQF8YLXEYbs
         Bh8fdx3bMrfzs6JaiOkwOH0TRmfzuNy5ClJDar+BWeEEuqB+HtMt020C9nz0RK9s9fd9
         KgDw==
X-Gm-Message-State: AOAM533chZnRRAFaQNj801Nkz9+E79bCb/D7Wt4SvSNZ2juaOQy6ayBi
        5HPsYTOo/ccQfO9L5tFAmxSIzxi7BW3o9CiDI9hgeMHnB1Cj4Mkn8xWHZ1gaHaFbPjZcW5+DG7W
        9SORYnMEftKPDen/6QKLvArt1YlHyNfTXYH+1IJo=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr50629769ybt.156.1638875674787;
        Tue, 07 Dec 2021 03:14:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2u8EChYmLefbHGcoDCHl6ptiFKDe0pArYdfO/bTUJeqXajynEttcgg8tAo0q30Jw3SZ1XqcJpKrXocN4ADhU=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr50629740ybt.156.1638875674555;
 Tue, 07 Dec 2021 03:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20211207104000.1360015-1-pasic@linux.ibm.com>
In-Reply-To: <20211207104000.1360015-1-pasic@linux.ibm.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 7 Dec 2021 19:14:23 +0800
Message-ID: <CAHj4cs96tX1ozhw5tKC-3XrFvOtSvPPNjMsi=C3Q05uvxCvAnw@mail.gmail.com>
Subject: Re: [bug report][bisected] WARNING: CPU: 4 PID: 10482 at
 block/mq-deadline.c:597 dd_exit_sched+0x198/0x1d0'
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Changhui Zhong <czhong@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        skt-results-master@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 7, 2021 at 6:40 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> Hi Jens!
>
> What is the status of this?

Hi Halil
This issue should be already fixed, here is the commit:

commit 2b504bd4841bccbf3eb83c1fec229b65956ad8ad (tag: block-5.16-2021-11-19=
)
Author: Ming Lei <ming.lei@redhat.com>
Date:   Thu Nov 18 23:30:41 2021 +0800

    blk-mq: don't insert FUA request with data into scheduler queue

    We never insert flush request into scheduler queue before.

    Recently commit d92ca9d8348f ("blk-mq: don't handle non-flush requests =
in
    blk_insert_flush") tries to handle FUA data request as normal request.
    This way has caused warning[1] in mq-deadline dd_exit_sched() or io han=
g in
    case of kyber since RQF_ELVPRIV isn't set for flush request, then
    ->finish_request won't be called.

    Fix the issue by inserting FUA data request with
blk_mq_request_bypass_insert()
    when the device supports FUA, just like what we did before.

>
> I see just one fix for e0d78afeb8d1 ("block: fix too broad elevator check=
 in
> blk_mq_free_request()") which pre-dates this bug report.
>
> We see something similar (i.e. the exact same warning) in our CI occasion=
ally,
> when the nbd module is unloaded. Unfortunately I can't trigger it reliabl=
y and
> frequently enough to confirm that the problem is caused by the aforementi=
oned
> commit. All I know is that we occasionally do hit the same warning.
>
> Thanks in advance!
>
> Regards,
> Halil
>
> If your interested, here are the  relevant kernel messages we observed:
>
> [ 2697.795977] block nbd0: shutting down sockets
> [ 2697.949807] ------------[ cut here ]------------
> [ 2697.949816] statistics for priority 1: i 2736 m 0 d 2739 c 2735
> [ 2697.949839] WARNING: CPU: 5 PID: 163229 at block/mq-deadline.c:597 dd_=
exit_sched+0x118/0x138
> [ 2697.949849] Modules linked in: nbd(-) crc32_generic algif_hash dm_mirr=
or dm_region_hash dm_log algif_skcipher af_alg paes_s390 dm_crypt encrypted=
_keys loop lcs ctcm fsm kvm binfmt_misc sunrpc nft_fib_inet nft_fib_ipv4 nf=
t_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject=
 nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_=
set nf_tables nfnetlink dm_service_time dm_multipath scsi_dh_rdac scsi_dh_e=
mc scsi_dh_alua zfcp scsi_transport_fc mlx5_ib ib_uverbs ib_core s390_trng =
vfio_ccw mdev vfio_iommu_type1 zcrypt_cex4 vfio eadm_sch sch_fq_codel confi=
gfs ip_tables x_tables ghash_s390 prng chacha_s390 libchacha aes_s390 des_s=
390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 mlx5_core sh=
a1_s390 sha_common nvme nvme_core pkey zcrypt rng_core autofs4 [last unload=
ed: trace_printk]
> [ 2697.949904] CPU: 5 PID: 163229 Comm: modprobe Not tainted 5.16.0-20211=
122.rc1.git0.b2753a24042f.300.fc34.s390x #1
> [ 2697.949907] Hardware name: IBM 8561 T01 703 (LPAR)
> [ 2697.949908] Krnl PSW : 0704c00180000000 00000002eac7f4f4 (dd_exit_sche=
d+0x11c/0x138)
> [ 2697.949912]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 P=
M:0 RI:0 EA:3
> [ 2697.949915] Krnl GPRS: 00000000ffffffea 0000000200000027 0000000000000=
033 00000000fffeffff
> [ 2697.949917]            00000002f6cfc000 0000038000000001 0000000000000=
ab3 0000000100000000
> [ 2697.949919]            000000025d5caf48 000000025d5cae00 0000000000000=
001 000000025d5cae80
> [ 2697.949920]            00000002b31f2100 000000025d5caf4a 00000002eac7f=
4f0 0000038007167af8
> [ 2697.949927] Krnl Code: 00000002eac7f4e4: e310f0a00024        stg     %=
r1,160(%r15)
>                           00000002eac7f4ea: c0e50025381f        brasl   %=
r14,00000002eb126528
>                          #00000002eac7f4f0: af000000            mc      0=
,0
>                          >00000002eac7f4f4: a7f4ffca            brc     1=
5,00000002eac7f488
>                           00000002eac7f4f8: b9040028            lgr     %=
r2,%r8
>                           00000002eac7f4fc: c0e50008acda        brasl   %=
r14,00000002ead94eb0
>                           00000002eac7f502: a7f4ffb5            brc     1=
5,00000002eac7f46c
>                           00000002eac7f506: af000000            mc      0=
,0
> [ 2697.949941] Call Trace:
> [ 2697.949943]  [<00000002eac7f4f4>] dd_exit_sched+0x11c/0x138
> [ 2697.949946] ([<00000002eac7f4f0>] dd_exit_sched+0x118/0x138)
> [ 2697.949948]  [<00000002eac5fddc>] blk_mq_exit_sched+0xb4/0xd8
> [ 2697.949951]  [<00000002eac44e38>] __elevator_exit+0x40/0x60
> [ 2697.949955]  [<00000002eac4abda>] blk_release_queue+0xc2/0x168
> [ 2697.949958]  [<00000002ead7f78a>] kobject_cleanup+0x5a/0x180
> [ 2697.949961]  [<00000002eac62270>] disk_release+0x70/0x90
> [ 2697.949963]  [<00000002eae04b38>] device_release+0x48/0xb0
> [ 2697.949968]  [<00000002ead7f78a>] kobject_cleanup+0x5a/0x180
> [ 2697.949970]  [<000003ff806b724a>] nbd_dev_remove+0x3a/0x90 [nbd]
> [ 2697.949976]  [<000003ff806bc1c2>] nbd_cleanup+0xda/0x120 [nbd]
> [ 2697.949980]  [<00000002ea67838a>] __do_sys_delete_module+0x1a2/0x268
> [ 2697.949984]  [<00000002eb1369ec>] __do_syscall+0x1d4/0x200
> [ 2697.949987]  [<00000002eb143f32>] system_call+0x82/0xb0
> [ 2697.949990] Last Breaking-Event-Address:
> [ 2697.949991]  [<00000002eb126588>] __warn_printk+0x60/0x68
> [ 2697.949996] Kernel panic - not syncing: panic_on_warn set ...
>


--=20
Best Regards,
  Yi Zhang

