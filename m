Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B77BECAAD5
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 20:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiH3UDx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiH3UDU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 16:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D343228700
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661889728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cW58ouZi5bApb29zm+DkyKyBdHjuVGS0ZeiR6baf+Ic=;
        b=DVqGHQEBP9CCeF/Lj+m9xp+NQU8sRDEuMuGH1x2u2qAioAMwp/k3Ey2/WR5HpP9p5hBLSG
        zfh0PkCONAbFCsQEmpX1CXmDOqDmZXa63Q7Ik4GHHhwal7oYZcTQChZtwTAiSWBPZ0Vmv1
        TEEiTyAa184Xn5wQomm8EQnrKu842/c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-NVjpObPfOwWOMI5ORS92Kg-1; Tue, 30 Aug 2022 16:02:05 -0400
X-MC-Unique: NVjpObPfOwWOMI5ORS92Kg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FC4E3C01DE6;
        Tue, 30 Aug 2022 20:02:04 +0000 (UTC)
Received: from localhost (unknown [10.39.193.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE8EE492C3B;
        Tue, 30 Aug 2022 20:02:03 +0000 (UTC)
Date:   Tue, 30 Aug 2022 16:02:02 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        acourbot@chromium.org, hch@infradead.org,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <Yw5suoV+pYAJ26VV@fedora>
References: <20220830150153.12627-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZK6dBVToNTN+i8uE"
Content-Disposition: inline
In-Reply-To: <20220830150153.12627-1-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--ZK6dBVToNTN+i8uE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 31, 2022 at 12:01:53AM +0900, Suwan Kim wrote:
> If a request fails at virtio_queue_rqs(), it is inserted to requeue_list
> and passed to virtio_queue_rq(). Then blk_mq_start_request() can be called
> again at virtio_queue_rq() and trigger WARN_ON_ONCE like below trace beca=
use
> request state was already set to MQ_RQ_IN_FLIGHT in virtio_queue_rqs()
> despite the failure.
>=20
> [    1.890468] ------------[ cut here ]------------
> [    1.890776] WARNING: CPU: 2 PID: 122 at block/blk-mq.c:1143
> blk_mq_start_request+0x8a/0xe0
> [    1.891045] Modules linked in:
> [    1.891250] CPU: 2 PID: 122 Comm: journal-offline Not tainted 5.19.0+ =
#44
> [    1.891504] Hardware name: ChromiumOS crosvm, BIOS 0
> [    1.891739] RIP: 0010:blk_mq_start_request+0x8a/0xe0
> [    1.891961] Code: 12 80 74 22 48 8b 4b 10 8b 89 64 01 00 00 8b 53
> 20 83 fa ff 75 08 ba 00 00 00 80 0b 53 24 c1 e1 10 09 d1 89 48 34 5b
> 41 5e c3 <0f> 0b eb b8 65 8b 05 2b 39 b6 7e 89 c0 48 0f a3 05 39 77 5b
> 01 0f
> [    1.892443] RSP: 0018:ffffc900002777b0 EFLAGS: 00010202
> [    1.892673] RAX: 0000000000000000 RBX: ffff888004bc0000 RCX: 000000000=
0000000
> [    1.892952] RDX: 0000000000000000 RSI: ffff888003d7c200 RDI: ffff88800=
4bc0000
> [    1.893228] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff88800=
4bc0100
> [    1.893506] R10: ffffffffffffffff R11: ffffffff8185ca10 R12: ffff88800=
4bc0000
> [    1.893797] R13: ffffc90000277900 R14: ffff888004ab2340 R15: ffff88800=
3d86e00
> [    1.894060] FS:  00007ffa143a4640(0000) GS:ffff88807dd00000(0000)
> knlGS:0000000000000000
> [    1.894412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.894682] CR2: 00005648577d9088 CR3: 00000000053da004 CR4: 000000000=
0170ee0
> [    1.894953] Call Trace:
> [    1.895139]  <TASK>
> [    1.895303]  virtblk_prep_rq+0x1e5/0x280
> [    1.895509]  virtio_queue_rq+0x5c/0x310
> [    1.895710]  ? virtqueue_add_sgs+0x95/0xb0
> [    1.895905]  ? _raw_spin_unlock_irqrestore+0x16/0x30
> [    1.896133]  ? virtio_queue_rqs+0x340/0x390
> [    1.896453]  ? sbitmap_get+0xfa/0x220
> [    1.896678]  __blk_mq_issue_directly+0x41/0x180
> [    1.896906]  blk_mq_plug_issue_direct+0xd8/0x2c0
> [    1.897115]  blk_mq_flush_plug_list+0x115/0x180
> [    1.897342]  blk_add_rq_to_plug+0x51/0x130
> [    1.897543]  blk_mq_submit_bio+0x3a1/0x570
> [    1.897750]  submit_bio_noacct_nocheck+0x418/0x520
> [    1.897985]  ? submit_bio_noacct+0x1e/0x260
> [    1.897989]  ext4_bio_write_page+0x222/0x420
> [    1.898000]  mpage_process_page_bufs+0x178/0x1c0
> [    1.899451]  mpage_prepare_extent_to_map+0x2d2/0x440
> [    1.899603]  ext4_writepages+0x495/0x1020
> [    1.899733]  do_writepages+0xcb/0x220
> [    1.899871]  ? __seccomp_filter+0x171/0x7e0
> [    1.900006]  file_write_and_wait_range+0xcd/0xf0
> [    1.900167]  ext4_sync_file+0x72/0x320
> [    1.900308]  __x64_sys_fsync+0x66/0xa0
> [    1.900449]  do_syscall_64+0x31/0x50
> [    1.900595]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [    1.900747] RIP: 0033:0x7ffa16ec96ea
> [    1.900883] Code: b8 4a 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3
> 48 83 ec 18 89 7c 24 0c e8 e3 02 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 43 03 f8 ff 8b
> 44 24
> [    1.901302] RSP: 002b:00007ffa143a3ac0 EFLAGS: 00000293 ORIG_RAX:
> 000000000000004a
> [    1.901499] RAX: ffffffffffffffda RBX: 0000560277ec6fe0 RCX: 00007ffa1=
6ec96ea
> [    1.901696] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000016
> [    1.901884] RBP: 0000560277ec5910 R08: 0000000000000000 R09: 00007ffa1=
43a4640
> [    1.902082] R10: 00007ffa16e4d39e R11: 0000000000000293 R12: 000056027=
73f59e0
> [    1.902459] R13: 0000000000000000 R14: 00007fffbfc007ff R15: 00007ffa1=
3ba4000
> [    1.902763]  </TASK>
> [    1.902877] ---[ end trace 0000000000000000 ]---
>=20
> To avoid calling blk_mq_start_request() twice, This patch moves the
> execution of blk_mq_start_request() to the end of virtblk_prep_rq().
> And instead of requeuing failed request to plug list in the error path of
> virtblk_add_req_batch(), it uses blk_mq_requeue_request() to change failed
> request state to MQ_RQ_IDLE. Then virtblk can safely handle the request
> on the next trial.
>=20
> Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> Reported-by: Alexandre Courbot <acourbot@chromium.org>
> Tested-by: Alexandre Courbot <acourbot@chromium.org>
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
> v1 -> v2
>  - Call blk_mq_start_request() after virtblk_add_req() can break the time=
stamp.
>    So move virtblk_add_req() before blk_mq_start_request().
>  - Use blk_mq_requeue_request() instead of requeuing failed request to pl=
ug list
>    if virtblk_add_req() fails within virtblk_add_req_batch().=20
>=20
>=20
>  drivers/block/virtio_blk.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Thanks for solving the timestamp issue. I'm not familiar enough which
blk_mq_requeue_request() to confirm this version is correct, but from
the virtio_blk perspective:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZK6dBVToNTN+i8uE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMObLkACgkQnKSrs4Gr
c8g1uAgAlDNL1Yig+q7heahlaW2ccDoI9dZJl6M88hP41Ca5gwd65HTZ4nweFfhd
yvckcUdxf2V8X9IvbR6ia3EufRFpn64aEZ3a3ar2IGrPHYKp9ZL4pDitzoP6zif+
UMW8GJJ3kUPVN4IwsTzaw0UffMwQ1Nt1rYkPUrh/drGp8O0UJ/CbX3PmbDnvDnpR
EyYyUyhOahuXOfwiHLG++bGC+SKB4pnw2s8TCj65uzhp4qqZa01pnn7hKWL3SN/d
vqbAW42SaFKsLbRxuA0ETW725HGpoXTVi+LUPpF2aUwlsAiTqAFvILsi9j5rypsE
iu7bFOJ0NQqaKZyfX6jMY2mnWi/BKg==
=cnOA
-----END PGP SIGNATURE-----

--ZK6dBVToNTN+i8uE--

