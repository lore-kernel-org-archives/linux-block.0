Return-Path: <SRS0=0s1t=YC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63836C47404
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 09:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C34221848
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 09:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfJIJXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:23:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfJIJXE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Oct 2019 05:23:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA1EF87F0B;
        Wed,  9 Oct 2019 09:23:03 +0000 (UTC)
Received: from localhost (unknown [10.36.118.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E56D19C69;
        Wed,  9 Oct 2019 09:23:03 +0000 (UTC)
Date:   Wed, 9 Oct 2019 10:23:02 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: io_uring NULL pointer dereference on Linux v5.4-rc1
Message-ID: <20191009092302.GA5303@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Wed, 09 Oct 2019 09:23:03 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I hit this NULL pointer dereference when running qemu-iotests 052 (raw)
on both ext4 and XFS on dm-thin/luks.  The kernel is Linux v5.4-rc1 but
I haven't found any obvious fixes in Jens' tree, so it's likely that
this bug is still present:

BUG: kernel NULL pointer dereference, address: 0000000000000102
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0=20
Oops: 0000 [#1] SMP PTI
CPU: 2 PID: 6656 Comm: qemu-io Not tainted 5.4.0-rc1 #1
Hardware name: LENOVO 20BTS1N70V/20BTS1N70V, BIOS N14ET37W (1.15 ) 09/06/20=
16
RIP: 0010:__queue_work+0x1f/0x3b0
Code: eb df 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 49 89 f7 41 56 =
41 89 fe 41 55 41 89 fd 41 54 55 48 89 d5 53 48 83 ec 10 <f6> 86 02 01 00 0=
0 01 0f 85 bc 02 00 00 49 bc eb 83 b5 80 46 86 c8
RSP: 0018:ffffbef4884bbd58 EFLAGS: 00010082
RAX: 0000000000000246 RBX: 0000000000000246 RCX: 0000000000000000
RDX: ffff9903901f4460 RSI: 0000000000000000 RDI: 0000000000000040
RBP: ffff9903901f4460 R08: ffff9903901fb040 R09: ffff990398614700
R10: 0000000000000030 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000040 R14: 0000000000000040 R15: 0000000000000000
FS:  00007f7d2a4e4a80(0000) GS:ffff9903a5a80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000102 CR3: 0000000203da8004 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ? __io_queue_sqe+0xa1/0x200
 queue_work_on+0x36/0x40
 __io_queue_sqe+0x16e/0x200
 io_ring_submit+0xd2/0x230
 ? percpu_ref_resurrect+0x46/0x70
 ? __io_uring_register+0x207/0xa30
 ? __schedule+0x286/0x700
 __x64_sys_io_uring_enter+0x1a3/0x280
 ? __x64_sys_io_uring_register+0x64/0xb0
 do_syscall_64+0x5b/0x180
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f7d3439f1fd
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d 5b 8c 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007f7d2918d408 EFLAGS: 00000216 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 00007f7d2918d4f0 RCX: 00007f7d3439f1fd
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000008
R10: 0000000000000000 R11: 0000000000000216 R12: 00005616e3c32ab8
R13: 00005616e3c32b78 R14: 00005616e3c32ab0 R15: 0000000000000001
Modules linked in: fuse ccm xt_CHECKSUM xt_MASQUERADE tun bridge stp llc nf=
_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJEC=
T nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6tabl=
e_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat ipt=
able_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_def=
rag_ipv4 ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_table=
s iptable_filter ip_tables sunrpc vfat fat intel_rapl_msr rmi_smbus iwlmvm =
rmi_core intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp m=
ac80211 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi kvm_=
intel snd_hda_intel kvm snd_intel_nhlt snd_hda_codec snd_usb_audio irqbypas=
s uvcvideo snd_hda_core snd_usbmidi_lib snd_rawmidi iTCO_wdt snd_hwdep liba=
rc4 intel_cstate cdc_ether intel_uncore videobuf2_vmalloc iwlwifi mei_wdt m=
ei_hdcp iTCO_vendor_support snd_seq videobuf2_memops usbnet videobuf2_v4l2 =
snd_seq_device
 intel_rapl_perf pcspkr videobuf2_common joydev wmi_bmof snd_pcm cfg80211 r=
8152 videodev intel_pch_thermal i2c_i801 mii mc thinkpad_acpi snd_timer mei=
_me ledtrig_audio snd lpc_ich mei soundcore rfkill binfmt_misc xfs dm_thin_=
pool dm_persistent_data dm_bio_prison libcrc32c dm_crypt i915 i2c_algo_bit =
drm_kms_helper drm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni=
_intel serio_raw wmi video
CR2: 0000000000000102
---[ end trace 2ac747acabe218da ]---
RIP: 0010:__queue_work+0x1f/0x3b0
Code: eb df 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 49 89 f7 41 56 =
41 89 fe 41 55 41 89 fd 41 54 55 48 89 d5 53 48 83 ec 10 <f6> 86 02 01 00 0=
0 01 0f 85 bc 02 00 00 49 bc eb 83 b5 80 46 86 c8
RSP: 0018:ffffbef4884bbd58 EFLAGS: 00010082
RAX: 0000000000000246 RBX: 0000000000000246 RCX: 0000000000000000
RDX: ffff9903901f4460 RSI: 0000000000000000 RDI: 0000000000000040
RBP: ffff9903901f4460 R08: ffff9903901fb040 R09: ffff990398614700
R10: 0000000000000030 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000040 R14: 0000000000000040 R15: 0000000000000000
FS:  00007f7d2a4e4a80(0000) GS:ffff9903a5a80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000102 CR3: 0000000203da8004 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Unfortunately I don't have time to find the root cause.  What I've
figured out so far is:

  bool queue_work_on(int cpu, struct workqueue_struct *wq,
                     struct work_struct *work)
  {
      bool ret =3D false;
      unsigned long flags;

      local_irq_save(flags);

      if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)))=
 {
                                                     ~~~~~~~~~~~~~~~~~~~~

The address of work is 0x102 so this line causes a page fault when it
tries to access the data field (offset 0).

The caller provided the 0x102 pointer so let's see where it comes from:

  static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
                            struct sqe_submit *s, bool force_nonblock)
  {
      ...
      if (!io_add_to_prev_work(list, req)) {
          if (list)
              atomic_inc(&list->cnt);
          INIT_WORK(&req->work, io_sq_wq_submit_work);
          io_queue_async_work(ctx, req);
	  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

and queue_work() is called here:

  static inline void io_queue_async_work(struct io_ring_ctx *ctx,
                                         struct io_kiocb *req)
  {
      int rw =3D 0;

      if (req->submit.sqe) {
          switch (req->submit.sqe->opcode) {
          case IORING_OP_WRITEV:
          case IORING_OP_WRITE_FIXED:
              rw =3D !(req->rw.ki_flags & IOCB_DIRECT);
              break;
          }
      }

      queue_work(ctx->sqo_wq[rw], &req->work);
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I must be missing something though because it seems impossible to get
this far if req is NULL.  INIT_WORK() would have Oopsed already.  Also,
offsetof(struct io_kiocb, work) is 0xa0 according to pahole(1) so we
still haven't reached the 0x102 offset from the Oops report.

Any ideas?

Stefan

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2dpvYACgkQnKSrs4Gr
c8gNIggAon/eymFHv2MtNcc8TV8aWB0AmuxywVoN1Jyuc8MYyqJH8XlP7DfpxxjZ
OEWaAZKmtZrl/sIPmTRfwbZBhuATkyQ/eXBhuMDQotx4y+xUWLfK/NOi9c+NMkI9
ol+eDIej1Y3USzX5yLa8DRkXrtuYAPO2lrotUg85EJmk4e5gSznPB5YCgKGL82Lh
IaVn09IVCO32gFkXkcEFzU+oruf3xpyiDSk6jvzLk/7795xnaeBTezWzXvQtTEuS
eoR9HDPEO1AG3vuZEd+JwiBPj5LlTVAstdS9egQPao0LzQYsa+t6xFfzTtIsN3fA
nO6cdMF1wx8ncPWH2q/ssF3Ms0FRyQ==
=UNwo
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
