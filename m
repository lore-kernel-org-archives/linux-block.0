Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E77EB64D9
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 02:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjF1C7l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 22:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF1C7k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 22:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7217171A
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 19:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687921127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHf64wmzfW9+hm6TK3O2bmp46tpQudGp2nslJmzIAdQ=;
        b=Dn0xFIwRZRnhquhdmKu2FETIkb0EbcEXbWeuDOav6nJuG//QbjFUD94xZfPxJjETIZ713Z
        vtvTfwqz3KDuZRxJWw/wugEhiOqt0tJQ2uqdShd2ioCwf4TTmT9M196zkRiM3wK+4+Lg+B
        MyKMBBKMDl05llvjdfkUkHjP0EIN9wI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-eIEPddVJNvGYTo0D7YTrag-1; Tue, 27 Jun 2023 22:58:43 -0400
X-MC-Unique: eIEPddVJNvGYTo0D7YTrag-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-262e9467fbaso1690298a91.3
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 19:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687921122; x=1690513122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHf64wmzfW9+hm6TK3O2bmp46tpQudGp2nslJmzIAdQ=;
        b=gSmWerFl79eiUmfLzH134eb9JR9uwLA14LckEUn6KilzEY+Mb4OHOj/WQWoeeBimWx
         cKmlDodSIjHp05T9UTr3upGuUxb5GGP0eAlUMrRYQ9Adby82GBsVkwt/IvDtqVRl/9nd
         OChhtezFuAsfgz5XdoT//rHIRDjBa0d8jvxZ1FZl45t9u9lOFwKK4Kc9x+AF278BW+/V
         l4/SijpuZP/PxKPHxrQ3jumFfX48Vhj8bsxrwRY7+pB/UDm9++5OAf5HSGp8m6RAm14E
         dohssIYay2il8sFdRGrmeLcr5ddinxqKhHB0cr/m3SsUPP9h4CnR5lPE0JN1P5JyGmMl
         bfxg==
X-Gm-Message-State: AC+VfDxv1buaKDJfzeUqFB3JgLSIQxt01tYnf3zu+48/GWlWD6Plvl4c
        KmgzcLhkg+K+MxViXb3fUieG08o3GISRtJ4jPIqIkqjrm/jreNwT3I2rqLsr58bL5LhBjC9khJT
        KlyRg8ZC0dhNzOjsa6DmSnlo2n8RRTnDO22ukHnPufvOlWQovKMeZ
X-Received: by 2002:a17:90a:fe0f:b0:262:e6c4:80db with SMTP id ck15-20020a17090afe0f00b00262e6c480dbmr6109549pjb.16.1687921122367;
        Tue, 27 Jun 2023 19:58:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Xk3pckjT2z7BspqSGf0Qm+R7sIMBNf3+ffNOr5NRJlicwBdOoZGIz4bn+Ce9rD0lCUdp5cxkrBAGL1PUHZPs=
X-Received: by 2002:a17:90a:fe0f:b0:262:e6c4:80db with SMTP id
 ck15-20020a17090afe0f00b00262e6c480dbmr6109537pjb.16.1687921121936; Tue, 27
 Jun 2023 19:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me> <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
In-Reply-To: <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 28 Jun 2023 10:58:29 +0800
Message-ID: <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux tree
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Chaitanya

Here is the code I used, and I will try to bisect it later today.

# git remote -v
origin https://github.com/torvalds/linux.git (fetch)
origin https://github.com/torvalds/linux.git (push)
# git log -1 --oneline
98be618ad030 (HEAD -> master, origin/master, origin/HEAD) Merge tag
'Smack-for-6.5' of https://github.com/cschaufler/smack-next

# cd ../blktests/
# git remote -v
origin https://github.com/osandov/blktests (fetch)
origin https://github.com/osandov/blktests (push)
# git log -1 --oneline
154e652 (HEAD -> master, origin/master, origin/HEAD) block/034: Test
memory is released by null-blk driver with memory_backed=3D1


On Wed, Jun 28, 2023 at 10:05=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 6/27/23 15:37, Chaitanya Kulkarni wrote:
> > On 6/27/23 14:21, Sagi Grimberg wrote:
> >>> Hello
> >>>
> >>> I found this failure on the latest linux tree, and it cannot be
> >>> reproduced on v6.4,
> >>> it should be one regression recently merged to linux tree after v6.4.
> >>> I check the commit recently merged after v6.4, and found below commit
> >>> touched the related code, not sure if it was introduced by this
> >>> commit.
> >>>
> >>> commit 959ffef13bac792e4e2e3321d6e2bd2b00c0f5f9
> >>> Author: Chaitanya Kulkarni <kch@nvidia.com>
> >>> Date:   Thu Jun 1 23:47:42 2023 -0700
> >>>
> >>>       nvme-fabrics: open code __nvmf_host_find()
> >> That just moved code, no functional change,
> >> most likely the below was the offender:
> >> ae8bd606e09b ("nvme-fabrics: prevent overriding of existing host")
> > For nvme-6.5 blktests are passing with nvme_trtype "loop" and "tcp"
> > see [1] with following HEAD :-
> >
> > commit 99160af413b4ff1c3b4741e8a7583f8e7197f201 (origin/nvme-6.5)
> > Author: Sagi Grimberg <sagi@grimberg.me>
> > Date:   Tue Jun 20 16:07:36 2023 +0300
> >
> >       nvme-mpath: fix I/O failure with EAGAIN when failing over I/O
> >
> > Also, didn't find the following error messsage in dmesg.
> > blktests (master) # dmesg | grep "found same hostid"
> > blktests (master) #
> >
> > confused exactly how blktests are passing on nvme-6.5 branch ?
> >
> > I'll try linux v6.4 next and update you soon ..
> >
> > -ck
> >
> >
>
> I ran the blktests on linux-block/for-next with following HEAD:-
> commit 3261ea42710e9665c9151006049411bd23b5411f (origin/for-next)
> Merge: ad73f31646e0 6d85ebf95c44
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Jun 26 09:53:41 2023 -0600
>
>      Merge branch 'for-6.5/block-late' into for-next
>
>      * for-6.5/block-late:
>        blk-sysfs: add a new attr_group for blk_mq
>        blk-iocost: move wbt_enable/disable_default() out of spinlock
>        blk-wbt: cleanup rwb_enabled() and wbt_disabled()
>        blk-wbt: remove dead code to handle wbt enable/disable with io
> inflight
>        blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disable=
d
>
>
>
> It's passing, can you pleas share :-
>
> 1. git repo link
> 2. git repo HEAD
> 3. blktests head
>
> I'll continue to debug the problem  ...
>
> -ck
>
> [1]
> linux-block (for-next) # git log -2
> commit 0be6b9ec7bd1aa1b5629ebf2701fa3aa7237d313 (HEAD -> for-next)
> Merge: 7bbb53e97bb3 3261ea42710e
> Author: Chaitanya Kulkarni <kch@nvidia.com>
> Date:   Tue Jun 27 15:40:14 2023 -0700
>
>      Merge branch 'for-next' of git://git.kernel.dk/linux-block into
> for-next
>
> commit 3261ea42710e9665c9151006049411bd23b5411f (origin/for-next)
> Merge: ad73f31646e0 6d85ebf95c44
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Jun 26 09:53:41 2023 -0600
>
>      Merge branch 'for-6.5/block-late' into for-next
>
>      * for-6.5/block-late:
>        blk-sysfs: add a new attr_group for blk_mq
>        blk-iocost: move wbt_enable/disable_default() out of spinlock
>        blk-wbt: cleanup rwb_enabled() and wbt_disabled()
>        blk-wbt: remove dead code to handle wbt enable/disable with io
> inflight
>        blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disable=
d
> linux-block (for-next) # cdblktests
> blktests (master) # ./test-nvme.sh
> ################nvme_trtype=3Dloop############
> nvme/002 (create many subsystems and test discovery) [passed]
>      runtime    ...  19.523s
> nvme/003 (test if we're sending keep-alives to a discovery controller)
> [passed]
>      runtime  10.095s  ...  10.082s
> nvme/004 (test nvme and nvmet UUID NS descriptors) [passed]
>      runtime  1.458s  ...  1.456s
> nvme/005 (reset local loopback target) [passed]
>      runtime  1.199s  ...  1.808s
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>      runtime  0.059s  ...  0.066s
> nvme/007 (create an NVMeOF target with a file-backed ns) [passed]
>      runtime  0.044s  ...  0.033s
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>      runtime  1.148s  ...  1.476s
> nvme/009 (create an NVMeOF host with a file-backed ns) [passed]
>      runtime  1.139s  ...  1.435s
> nvme/010 (run data verification fio job on NVMeOF block device-backed
> ns) [passed]
>      runtime  113.605s  ...  113.720s
> nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed=
]
>      runtime  83.124s  ...  80.072s
> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> device-backed ns) [passed]
>      runtime  86.374s  ...  93.449s
> nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed
> ns) [passed]
>      runtime  78.565s  ...  64.751s
> nvme/014 (flush a NVMeOF block device-backed ns) [passed]
>      runtime  6.617s  ...  7.489s
> nvme/015 (unit test for NVMe flush for file backed ns) [passed]
>      runtime  5.939s  ...  6.214s
> nvme/016 (create/delete many NVMeOF block device-backed ns and test
> discovery) [passed]
>      runtime    ...  12.590s
> nvme/017 (create/delete many file-ns and test discovery) [passed]
>      runtime    ...  12.932s
> nvme/018 (unit test NVMe-oF out of range access on a file backend) [passe=
d]
>      runtime  1.120s  ...  1.422s
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passe=
d]
>      runtime  1.148s  ...  1.437s
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.124s  ...  1.437s
> nvme/021 (test NVMe list command on NVMeOF file-backed ns) [passed]
>      runtime  1.127s  ...  1.414s
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns) [passed]
>      runtime  1.164s  ...  1.767s
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>      runtime  1.151s  ...  1.442s
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.112s  ...  1.440s
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.121s  ...  1.420s
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>      runtime  1.121s  ...  1.418s
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>      runtime  1.121s  ...  1.430s
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.130s  ...  1.415s
> nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
>      runtime  1.261s  ...  1.564s
> nvme/030 (ensure the discovery generation counter is updated
> appropriately) [passed]
>      runtime  0.115s  ...  0.205s
> nvme/031 (test deletion of NVMeOF controllers immediately after setup)
> [passed]
>      runtime  0.802s  ...  3.861s
> nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
>      runtime  0.015s  ...  0.012s
> nvme/040 (test nvme fabrics controller reset/disconnect operation during
> I/O) [passed]
>      runtime  7.296s  ...  8.020s
> nvme/041 (Create authenticated connections) [passed]
>      runtime  0.448s  ...  0.759s
> nvme/042 (Test dhchap key types for authenticated connections) [passed]
>      runtime  2.757s  ...  4.790s
> nvme/043 (Test hash and DH group variations for authenticated
> connections) [passed]
>      runtime  0.705s  ...  6.904s
> nvme/044 (Test bi-directional authentication) [passed]
>      runtime  1.227s  ...  1.835s
> nvme/045 (Test re-authentication) [passed]
>      runtime  3.646s  ...  3.791s
> nvme/047 (test different queue types for fabric transports)  [not run]
>      runtime  1.718s  ...
>      nvme_trtype=3Dloop is not supported in this test
> nvme/048 (Test queue count changes on reconnect)             [not run]
>      runtime  6.242s  ...
>      nvme_trtype=3Dloop is not supported in this test
> ################nvme_trtype=3Dtcp############
> nvme/002 (create many subsystems and test discovery)         [not run]
>      runtime  19.523s  ...
>      nvme_trtype=3Dtcp is not supported in this test
> nvme/003 (test if we're sending keep-alives to a discovery controller)
> [passed]
>      runtime  10.082s  ...  10.087s
> nvme/004 (test nvme and nvmet UUID NS descriptors) [passed]
>      runtime  1.456s  ...  1.145s
> nvme/005 (reset local loopback target) [passed]
>      runtime  1.808s  ...  1.210s
> nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
>      runtime  0.066s  ...  0.055s
> nvme/007 (create an NVMeOF target with a file-backed ns) [passed]
>      runtime  0.033s  ...  0.045s
> nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
>      runtime  1.476s  ...  1.164s
> nvme/009 (create an NVMeOF host with a file-backed ns) [passed]
>      runtime  1.435s  ...  1.120s
> nvme/010 (run data verification fio job on NVMeOF block device-backed
> ns) [passed]
>      runtime  113.720s  ...  93.167s
> nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed=
]
>      runtime  80.072s  ...  81.600s
> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> device-backed ns) [passed]
>      runtime  93.449s  ...  95.264s
> nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed
> ns) [passed]
>      runtime  64.751s  ...  66.072s
> nvme/014 (flush a NVMeOF block device-backed ns) [passed]
>      runtime  7.489s  ...  6.727s
> nvme/015 (unit test for NVMe flush for file backed ns) [passed]
>      runtime  6.214s  ...  5.914s
> nvme/016 (create/delete many NVMeOF block device-backed ns and test
> discovery) [not run]
>      runtime  12.590s  ...
>      nvme_trtype=3Dtcp is not supported in this test
> nvme/017 (create/delete many file-ns and test discovery)     [not run]
>      runtime  12.932s  ...
>      nvme_trtype=3Dtcp is not supported in this test
> nvme/018 (unit test NVMe-oF out of range access on a file backend) [passe=
d]
>      runtime  1.422s  ...  1.121s
> nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passe=
d]
>      runtime  1.437s  ...  1.161s
> nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.437s  ...  1.122s
> nvme/021 (test NVMe list command on NVMeOF file-backed ns) [passed]
>      runtime  1.414s  ...  1.123s
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns) [passed]
>      runtime  1.767s  ...  1.172s
> nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
>      runtime  1.442s  ...  1.144s
> nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
>      runtime  1.440s  ...  1.122s
> nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.420s  ...  1.119s
> nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
>      runtime  1.418s  ...  1.114s
> nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
>      runtime  1.430s  ...  1.140s
> nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed=
]
>      runtime  1.415s  ...  1.117s
> nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
>      runtime  1.564s  ...  1.258s
> nvme/030 (ensure the discovery generation counter is updated
> appropriately) [passed]
>      runtime  0.205s  ...  0.137s
> nvme/031 (test deletion of NVMeOF controllers immediately after setup)
> [passed]
>      runtime  3.861s  ...  0.849s
> nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
>      runtime  0.012s  ...  0.016s
> nvme/040 (test nvme fabrics controller reset/disconnect operation during
> I/O) [passed]
>      runtime  8.020s  ...  7.273s
> nvme/041 (Create authenticated connections) [passed]
>      runtime  0.759s  ...  0.440s
> nvme/042 (Test dhchap key types for authenticated connections) [passed]
>      runtime  4.790s  ...  2.712s
> nvme/043 (Test hash and DH group variations for authenticated
> connections) [passed]
>      runtime  6.904s  ...  0.731s
> nvme/044 (Test bi-directional authentication) [passed]
>      runtime  1.835s  ...  1.240s
> nvme/045 (Test re-authentication) [passed]
>      runtime  3.791s  ...  3.630s
> nvme/047 (test different queue types for fabric transports) [passed]
>      runtime    ...  1.701s
> nvme/048 (Test queue count changes on reconnect) [passed]
>      runtime    ...  6.244s
> blktests (master) #
>


--=20
Best Regards,
  Yi Zhang

