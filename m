Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC63C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 07:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2928A61154
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 07:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhDTHdD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 03:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhDTHdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 03:33:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F8FC06174A
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 00:32:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s15so43818082edd.4
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x5fwlBu9fDHRHPv8lRqQ8ym/gckfhzKylsiDYkN3Aq4=;
        b=I8NMV1tUXV3AdilgGYVdhwRlLRSV7MPQndE3OzfDLSdfjYgI3ged2GenRoEN2e7n+O
         RXbH1C1AQyzXkfU3z2NmLIIrzhOfTR6NswvPItGulIlHqoXAurp1QTfXSIGl3f+zZbio
         PgWF38+fUpvDQYpAxj7At9Fh4TipT54jBI3vvyN3TZV18qm2kkFsKLQb41SpUHU6AU2G
         0dSjugeFmuNB9VL5f7w+iWJ1gnCM1HpRQqfABCxXpS7h8AAbxHk2zkiUXrClBJE6da/l
         DC18DT8LPw/QoskbVi2tV1E4K8Thvpose/XdBAt3paNX0OCI7Bdw6fU3ug/t56xBsvow
         gXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x5fwlBu9fDHRHPv8lRqQ8ym/gckfhzKylsiDYkN3Aq4=;
        b=oOH7axk7Fy7RGPJSbOcqHseN0vFnnb4EAVOmaZmw2SvEYeSuWwNc3oeWH4zbqDFFLp
         LnLEeSl7kVBHsm3m7dRSSY6UFwE7z95xidbjrLXh2f4kRFCQpcRx3udCclxFWqvLAp2v
         zuiUQ0Oabu6y8En2OC7Z6JffMehduuQUepkUU+6kUzUF3Bh/XzR5ObUxhWjwjPtNTa8F
         rfp3cpxblfk3WrB4VL27Tr+pc/Yqz+i91Qbs7S9I2iYsjvi+ZNIMycwyPxu2T44ymEpl
         oDHRhIR79rIueDlGGs1AavL0dNsscykf67lb2ACvaSrWUKR2Np26hbkVzweGeJ3IeKw5
         yYGw==
X-Gm-Message-State: AOAM533Vy/VxNTSCBN6uOUVPUzWr32lMeo0ZK2kIKEMUqolrM2C/t/Ta
        3Zz+7sq1QAsovgnK4ImfqxUkFQ==
X-Google-Smtp-Source: ABdhPJxkJ8hF9+zCnQGMEUT3CTQW9zuxYxW5bbsxGw6uqu4ZzBQuHVmPEnk9eB7ZvpNz92JEm+A/SQ==
X-Received: by 2002:a05:6402:441:: with SMTP id p1mr30533085edw.298.1618903949839;
        Tue, 20 Apr 2021 00:32:29 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id gt26sm12016525ejb.31.2021.04.20.00.32.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 00:32:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [bisected] bfq regression on latest linux-block/for-next
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CAHj4cs9+q-vH9qar+MTP-aECb2whT7O8J5OmR240yss1y=kWKw@mail.gmail.com>
Date:   Tue, 20 Apr 2021 09:33:32 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        Xiong Zhou <xzhou@redhat.com>, Li Wang <liwan@redhat.com>,
        Ming Lei <minlei@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B657F0B6-E999-467B-98CB-56C29B04B8F3@linaro.org>
References: <1366443410.1203736.1617240454513.JavaMail.zimbra@redhat.com>
 <4F41414B-05F8-4E7D-A312-8A47B8468C78@linaro.org>
 <c7d23258-0890-f79f-cc6a-9cb24bbaa437@redhat.com>
 <CAHj4cs9+q-vH9qar+MTP-aECb2whT7O8J5OmR240yss1y=kWKw@mail.gmail.com>
To:     Yi Zhang <yi.zhang@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 20 apr 2021, alle ore 04:00, Yi Zhang <yi.zhang@redhat.com> =
ha scritto:
>=20
>=20
> On Wed, Apr 7, 2021 at 11:15 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>=20
>=20
> On 4/2/21 9:39 PM, Paolo Valente wrote:
> >
> >> Il giorno 1 apr 2021, alle ore 03:27, Yi Zhang =
<yi.zhang@redhat.com> ha scritto:
> >>
> >> Hi
> > Hi
> >
> >> We reproduced this bfq regression[3] on ppc64le with blktests[2] on =
the latest linux-block/for-next branch, seems it was introduced with [1] =
from my bisecting, pls help check it. Let me know if you need any =
testing for it, thanks.
> >>
> > Thanks for reporting this bug and finding the candidate offending =
commit. Could you try this test with my dev kernel, which might provide =
more information? The kernel is here:
> > https://github.com/Algodev-github/bfq-mq
> >
> > Alternatively, I could try to provide you with patches to instrument =
your kernel.
> HI Paolo
> I tried your dev kernel, but with no luck to reproduce it, could you=20=

> provide the debug patch based on latest linux-block/for-next?
>=20
> Hi Paolo
> This issue has been consistently reproduced with LTP/fstests/blktests =
on recent linux-block/for-next, do you have a chance to check it?

Hi Yi, all,
I've been working hard to port my code-instrumentation layer to the =
kernel in for-next. I seem I finished the porting yesterday. I tested it =
but the system crashed. I'm going to analyze the oops. Maybe this freeze =
is caused by mistakes in this layer, maybe the instrumentation is =
already detecting a bug. In the first case, I'll fix the mistakes and =
try the tests suggested in this thread.

Thanks,
Paolo

>=20
> LTP
> [ 7223.279313] LTP: starting dio30 (diotest6 -b 65536 -n 100 -i 100 -o =
1024000)=20
> [ 7320.660837] ------------[ cut here ]------------=20
> [ 7320.660862] kernel BUG at mm/slub.c:314!=20
> [ 7320.660872] Oops: Exception in kernel mode, sig: 5 [#1]=20
> [ 7320.660882] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA =
pSeries=20
> [ 7320.660894] Modules linked in: dummy veth minix binfmt_misc can_raw =
can nfsv3 nfs_acl nfs lockd grace nfs_ssc fscache rds tun brd overlay =
fuse exfat vfat fat loop n_gsm pps_ldisc ppp_synctty mkiss ax25 =
ppp_async ppp_generic slcan slip slhc snd_hrtimer snd_seq snd_seq_device =
sctp ip6_udp_tunnel udp_tunnel snd_timer snd soundcore authenc pcrypt =
crypto_user sha3_generic n_hdlc rfkill sunrpc ibmveth pseries_rng =
crct10dif_vpmsum drm drm_panel_orientation_quirks i2c_core zram =
ip_tables xfs ibmvscsi scsi_transport_srp vmx_crypto crc32c_vpmsum [last =
unloaded: ltp_insmod01]=20
> [ 7320.661052] CPU: 7 PID: 145059 Comm: diotest6 Tainted: G           =
OE     5.12.0-rc7 #1=20
> [ 7320.661067] NIP:  c00000000049b9b8 LR: c0000000004a161c CTR: =
c000000000935870=20
> [ 7320.661079] REGS: c0000000a9ae2f60 TRAP: 0700   Tainted: G          =
 OE      (5.12.0-rc7)=20
> [ 7320.661091] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: =
44008242  XER: 20040000=20
> [ 7320.661118] CFAR: c0000000004a1618 IRQMASK: 1 =20
> [ 7320.661118] GPR00: c0000000004a161c c0000000a9ae3200 =
c000000001f10400 c000000007fdd500 =20
> [ 7320.661118] GPR04: c00c00000005a700 c0000000169c59b0 =
c0000000169c5ac8 0000000000000001 =20
> [ 7320.661118] GPR08: 0000000000000118 0000000000000001 =
c00c0000000586c0 0000000000000000 =20
> [ 7320.661118] GPR12: 0000000000008000 c00000001eca6280 =
0000000000000000 0000000000000000 =20
> [ 7320.661118] GPR16: 0000000002cba000 0000000000140000 =
0000000000000000 fffffffffffff77f =20
> [ 7320.661118] GPR20: c0000007e4042780 0000000000000001 =
c0000000169c59b0 0000000000210d00 =20
> [ 7320.661118] GPR24: c0000000169c59b0 0000000000000001 =
0000000000000001 c000000007fdd500 =20
> [ 7320.661118] GPR28: c0000000169c59b0 000000008075002e =
c0000000169c59b0 c00c00000005a700 =20
> [ 7320.661254] NIP [c00000000049b9b8] __slab_free+0x98/0x600=20
> [ 7320.661268] LR [c0000000004a161c] kmem_cache_free+0x25c/0x5e0=20
> [ 7320.661281] Call Trace:=20
> [ 7320.661286] [c0000000a9ae3200] [0000000000000005] 0x5 (unreliable)=20=

> [ 7320.661301] [c0000000a9ae32c0] [c0000000004a161c] =
kmem_cache_free+0x25c/0x5e0=20
> [ 7320.661316] [c0000000a9ae3380] [c0000000009329f8] =
bfq_put_queue+0x1d8/0x2d0=20
> [ 7320.661330] [c0000000a9ae3420] [c0000000009350ec] =
bfq_init_rq+0x72c/0xc00=20
> [ 7320.661344] [c0000000a9ae3500] [c000000000935aa4] =
bfq_insert_requests+0x234/0x1600=20
> [ 7320.661359] [c0000000a9ae3650] [c0000000008fb264] =
blk_mq_sched_insert_requests+0xb4/0x1f0=20
> [ 7320.661374] [c0000000a9ae36a0] [c0000000008f32c8] =
blk_mq_flush_plug_list+0x138/0x1f0=20
> [ 7320.661390] [c0000000a9ae3710] [c0000000008e1538] =
blk_flush_plug_list+0x48/0x64=20
> [ 7320.661406] [c0000000a9ae3740] [c0000000008f3b1c] =
blk_mq_submit_bio+0x38c/0x710=20
> [ 7320.661421] [c0000000a9ae37e0] [c0000000008e0a94] =
submit_bio_noacct+0x3d4/0x680=20
> [ 7320.661436] [c0000000a9ae3880] [c0000000005e1048] =
iomap_dio_submit_bio+0xd8/0x100=20
> [ 7320.661452] [c0000000a9ae38b0] [c0000000005e1b48] =
iomap_dio_bio_actor+0x2f8/0x570=20
> [ 7320.661467] [c0000000a9ae3950] [c0000000005dbfc4] =
iomap_apply+0x1f4/0x3e0=20
> [ 7320.661481] [c0000000a9ae3a40] [c0000000005e1424] =
__iomap_dio_rw+0x204/0x5b0=20
> [ 7320.661495] [c0000000a9ae3b10] [c0000000005e17f0] =
iomap_dio_rw+0x20/0x80=20
> [ 7320.661509] [c0000000a9ae3b30] [c008000001cb2c34] =
xfs_file_dio_read+0x11c/0x1a0 [xfs]=20
> [ 7320.661694] [c0000000a9ae3b70] [c008000001cb2dd4] =
xfs_file_read_iter+0x11c/0x170 [xfs]=20
> [ 7320.661876] [c0000000a9ae3bb0] [c0000000004f8900] =
do_iter_readv_writev+0x130/0x240=20
> [ 7320.661893] [c0000000a9ae3c10] [c0000000004f935c] =
do_iter_read+0x14c/0x2b0=20
> [ 7320.661906] [c0000000a9ae3c60] [c0000000004f9568] =
vfs_readv+0x78/0xb0=20
> [ 7320.661918] [c0000000a9ae3d50] [c0000000004f9630] =
do_readv+0x90/0x1a0=20
> [ 7320.661931] [c0000000a9ae3db0] [c00000000002da24] =
system_call_exception+0x104/0x270=20
> [ 7320.661947] [c0000000a9ae3e10] [c00000000000d25c] =
system_call_common+0xec/0x278=20
> [ 7320.661961] --- interrupt: c00 at 0x7fff8699e724=20
> [ 7320.661970] NIP:  00007fff8699e724 LR: 00000000100051f0 CTR: =
0000000000000000=20
> [ 7320.661982] REGS: c0000000a9ae3e80 TRAP: 0c00   Tainted: G          =
 OE      (5.12.0-rc7)=20
> [ 7320.661994] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: =
24002444  XER: 00000000=20
> [ 7320.662020] IRQMASK: 0 =20
> [ 7320.662020] GPR00: 0000000000000091 00007fffc2bb1e90 =
00007fff86a87100 0000000000000004 =20
> [ 7320.662020] GPR04: 000001001f590470 0000000000000014 =
0000000000000000 0000000000000000 =20
> [ 7320.662020] GPR08: 0000000000000000 0000000000000000 =
0000000000000000 0000000000000000 =20
> [ 7320.662020] GPR12: 0000000000000000 00007fff86b7a990 =
0000000000000000 0000000000000000 =20
> [ 7320.662020] GPR16: 0000000000000000 0000000000000000 =
0000000000000000 0000000000000000 =20
> [ 7320.662020] GPR20: 0000000000000000 0000000000000022 =
0000000000000000 0000000000000022 =20
> [ 7320.662020] GPR24: 0000000000000004 0000000000000003 =
000001001f590470 000001001f5905c0 =20
> [ 7320.662020] GPR28: 00000000100505c8 0000000000010000 =
0000000002b7a000 0000000000000014 =20
> [ 7320.662149] NIP [00007fff8699e724] 0x7fff8699e724=20
> [ 7320.662158] LR [00000000100051f0] 0x100051f0=20
> [ 7320.662167] --- interrupt: c00=20
> [ 7320.662174] Instruction dump:=20
> [ 7320.662182] fbc100b0 3ee00021 7f390734 62f70d00 3b400001 ebdf0020 =
811b0028 ebbf0028 =20
> [ 7320.662205] 7fc9e278 7cdc4214 7d290074 7929d182 <0b090000> 78c50022 =
54c7c03e e93b00b8 =20
> [ 7320.662229] ---[ end trace 817605fc936991f3 ]---=20
> [ 7320.666013]=20
>=20
>  fstests
> [ 1271.938817] run fstests generic/421 at 2021-04-16 16:03:05=20
> [ 1272.963661] EXT4-fs (sda3): mounted filesystem with ordered data =
mode. Opts: acl,user_xattr. Quota mode: none.=20
> [ 1272.969886] xfs_io (pid 192274) is setting deprecated v1 encryption =
policy; recommend upgrading to v2.=20
> [ 1273.764719] EXT4-fs (sda3): mounted filesystem with ordered data =
mode. Opts: acl,user_xattr. Quota mode: none.=20
> [ 1274.735175] Kernel attempted to read user page (30) - exploit =
attempt? (uid: 0)=20
> [ 1274.735210] BUG: Kernel NULL pointer dereference on read at =
0x00000030=20
> [ 1274.735223] Faulting instruction address: 0xc00000000092cc78=20
> [ 1274.735246] Oops: Kernel access of bad area, sig: 11 [#1]=20
> [ 1274.735257] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA =
PowerNV=20
> [ 1274.735273] Modules linked in: dm_flakey rfkill i40iw ib_uverbs =
ib_core sunrpc joydev ses at24 enclosure i40e scsi_transport_sas =
regmap_i2c ofpart ipmi_powernv ipmi_devintf powernv_flash rtc_opal =
ipmi_msghandler crct10dif_vpmsum mtd opal_prd i2c_opal fuse zram =
ip_tables xfs ast i2c_algo_bit drm_vram_helper drm_kms_helper =
syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm =
vmx_crypto crc32c_vpmsum i2c_core aacraid drm_panel_orientation_quirks=20=

> [ 1274.735391] CPU: 48 PID: 192676 Comm: xfs_io Not tainted 5.12.0-rc7 =
#1=20
> [ 1274.735406] NIP:  c00000000092cc78 LR: c000000000933c90 CTR: =
c000000000026570=20
> [ 1274.735430] REGS: c00000002e13f340 TRAP: 0300   Not tainted  =
(5.12.0-rc7)=20
> [ 1274.735443] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: =
84024800  XER: 20040000=20
> [ 1274.735478] CFAR: c00000000092cc58 DAR: 0000000000000030 DSISR: =
40000000 IRQMASK: 1 =20
> [ 1274.735478] GPR00: c000000000933c90 c00000002e13f5e0 =
c000000001f10400 c000000050803000 =20
> [ 1274.735478] GPR04: c000000050806a60 0000000002045800 =
c00000002e13f688 0000000000000000 =20
> [ 1274.735478] GPR08: 0000000000000002 c000000069474ef8 =
0000000000000000 0000000100017cbc =20
> [ 1274.735478] GPR12: 0000000000002000 c000001ffffbb800 =
0000000000000000 c0000008438c9ff8 =20
> [ 1274.735478] GPR16: c0000008438c9e80 0000000000010000 =
0000000000000000 0000000000080001 =20
> [ 1274.735478] GPR20: c00000002e13fa40 c000000042b04f60 =
0000000000060800 c000000069474ec0 =20
> [ 1274.735478] GPR24: c0000000425ed800 0000000000000000 =
c000000841f10d20 0000000002045800 =20
> [ 1274.735478] GPR28: c0000000508031f0 c000000069474ec0 =
0000000000000000 c000000050803000 =20
> [ 1274.735694] NIP [c00000000092cc78] =
bfq_rq_pos_tree_lookup+0x48/0x110=20
> [ 1274.735729] LR [c000000000933c90] bfq_setup_cooperator+0x2f0/0x4f0=20=

> [ 1274.735763] Call Trace:=20
> [ 1274.735779] [c00000002e13f5e0] [c000000000934ed4] =
bfq_init_rq+0x534/0xc00 (unreliable)=20
> [ 1274.735819] [c00000002e13f650] [c000000000933c90] =
bfq_setup_cooperator+0x2f0/0x4f0=20
> [ 1274.735845] [c00000002e13f6c0] [c000000000935bfc] =
bfq_insert_requests+0x3ac/0x1600=20
> [ 1274.735872] [c00000002e13f810] [c0000000008fb244] =
blk_mq_sched_insert_requests+0xb4/0x1f0=20
> [ 1274.735888] [c00000002e13f860] [c0000000008f32a8] =
blk_mq_flush_plug_list+0x138/0x1f0=20
> [ 1274.735906] [c00000002e13f8d0] [c0000000008de4a8] =
blk_finish_plug+0x68/0x90=20
> [ 1274.735922] [c00000002e13f900] [c0000000003d64e0] =
read_pages+0x1d0/0x4b0=20
> [ 1274.735938] [c00000002e13f980] [c0000000003d6e8c] =
page_cache_ra_unbounded+0x21c/0x300=20
> [ 1274.735954] [c00000002e13fa20] [c0000000003c778c] =
filemap_get_pages+0x11c/0x7d0=20
> [ 1274.735981] [c00000002e13fae0] [c0000000003c7f30] =
filemap_read+0xf0/0x4a0=20
> [ 1274.735997] [c00000002e13fc10] [c00000000063e3ac] =
ext4_file_read_iter+0x7c/0x270=20
> [ 1274.736013] [c00000002e13fc60] [c0000000004f85c0] =
new_sync_read+0x120/0x190=20
> [ 1274.736038] [c00000002e13fd00] [c0000000004fb5a0] =
vfs_read+0x1d0/0x240=20
> [ 1274.736052] [c00000002e13fd50] [c0000000004fb6c4] =
sys_pread64+0xb4/0xe0=20
> [ 1274.736067] [c00000002e13fdb0] [c00000000002da24] =
system_call_exception+0x104/0x270=20
> [ 1274.736084] [c00000002e13fe10] [c00000000000d25c] =
system_call_common+0xec/0x278=20
> [ 1274.736100] --- interrupt: c00 at 0x7fff8d1899c8=20
> [ 1274.736111] NIP:  00007fff8d1899c8 LR: 00007fff8d1899a8 CTR: =
0000000000000000=20
> [ 1274.736125] REGS: c00000002e13fe80 TRAP: 0c00   Not tainted  =
(5.12.0-rc7)=20
> [ 1274.736138] MSR:  900000000280f033 =
<SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 24022400  XER: 00000000=20
> [ 1274.736178] IRQMASK: 0 =20
> [ 1274.736178] GPR00: 00000000000000b3 00007fffeb4b8360 =
00007fff8d1b7f00 0000000000000003 =20
> [ 1274.736178] GPR04: 000000013a220000 0000000000001000 =
0000000000200000 00007fff8d256d08 =20
> [ 1274.736178] GPR08: 0000000000000000 0000000000000000 =
0000000000000000 0000000000000000 =20
> [ 1274.736178] GPR12: 0000000000000000 00007fff8d25e400 =
0000000000000000 0000000000000000 =20
> [ 1274.736178] GPR16: 0000000000000000 00007fff8d0601a8 =
0000000000000000 0000000000000000 =20
> [ 1274.736178] GPR20: 0000000000000000 0000000000000000 =
0000000000000003 0000000000000000 =20
> [ 1274.736178] GPR24: 0000000000200000 000000010aac3508 =
0000000000000000 0000000000200000 =20
> [ 1274.736178] GPR28: 0000000000000000 0000000000000003 =
0000000000001000 0000000000200000 =20
> [ 1274.736407] NIP [00007fff8d1899c8] 0x7fff8d1899c8=20
> [ 1274.736509] LR [00007fff8d1899a8] 0x7fff8d1899a8=20
> [ 1274.736560] --- interrupt: c00=20
> [ 1274.736695] Instruction dump:=20
> [ 1274.736767] f8010010 f821ff91 e9240000 2c290000 4082001c 480000d4 =
ebe90008 38890008 =20
> [ 1274.736885] 2c3f0000 4182002c 7fe9fb78 e9490028 <e94a0030> 7c255040 =
4181ffe0 4080005c =20
> [ 1274.737028] ---[ end trace 25f5fc09dd3c38dd ]---=20
>=20
>=20
> blktests nvme-tcp/011
>=20
> [10384.975371] run blktests nvme/011 at 2021-04-16 16:43:37=20
> [10385.017040] nvmet: adding nsid 1 to subsystem blktests-subsystem-1=20=

> [10385.028953] nvmet_tcp: enabling port 0 (
> 127.0.0.1:4420
> )=20
> [10385.186103] nvmet: creating controller 1 for subsystem =
blktests-subsystem-1 for NQN =
nqn.2014-08.org.nvmexpress:uuid:688053f17e1241f385cf0632cd1d173a.=20
> [10385.200147] nvmet: unhandled identify cns 6 on qid 0=20
> [10385.205293] nvme nvme0: creating 128 I/O queues.=20
> [10385.224831] nvme nvme0: mapped 128/0/0 default/read/poll queues.=20
> [10385.259232] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr=20=

> 127.0.0.1:4420
> =20
> [10387.700391] ------------[ cut here ]------------=20
> [10387.705007] kernel BUG at mm/slub.c:314!=20
> [10387.708920] Internal error: Oops - BUG: 0 [#1] SMP=20
> [10387.713701] Modules linked in: nvme_tcp nvme_fabrics nvmet_tcp =
nvmet nvme nvme_core loop dm_log_writes dm_flakey rpcrdma rdma_ucm =
ib_srpt ib_isert iscsi_target_mod target_core_mod ib_iser libiscsi =
ib_umad scsi_transport_iscsi rdma_cm iw_cm ib_ipoib ib_cm rfkill mlx5_ib =
ib_uverbs ib_core sunrpc coresight_etm4x i2c_smbus coresight_tmc =
coresight_replicator coresight_tpiu joydev mlx5_core mlxfw acpi_ipmi =
ipmi_ssif ipmi_devintf ipmi_msghandler coresight_funnel thunderx2_pmu =
coresight vfat fat fuse zram ip_tables xfs ast i2c_algo_bit =
drm_vram_helper crct10dif_ce ghash_ce drm_kms_helper syscopyarea =
sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm gpio_xlp =
i2c_xlp9xx uas usb_storage aes_neon_bs [last unloaded: nvmet]=20
> [10387.777601] CPU: 13 PID: 0 Comm: swapper/13 Not tainted 5.12.0-rc7 =
#1=20
> [10387.784030] Hardware name: HPE Apollo 70             /C01_APACHE_MB =
        , BIOS L50_5.13_1.16 07/29/2020=20
> [10387.793756] pstate: 60400089 (nZCv daIf +PAN -UAO -TCO BTYPE=3D--)=20=

> [10387.799751] pc : set_freepointer+0x30/0x34=20
> [10387.8038 39] lr : kmem_cf fff000886aea300  x24: ffff8000126 aea300 =
x20: fff00 000000000001 x113: 0000000000000068 x12: ffff8000110e84e8 =20
> [10387.859102] x11: ffff800012973d90 x10: 000000000000002f =20
> [10387.864402] x9 : ffff8000106fd7ac x8 : 0000000000000017 =20
> [10387.869702] x7 : 0000000000000001 x6 : 000001eca7a44c15 =20
> [10387.875002] x5 : 00ffffffffffffff x4 : 0000000000000118 =20
> [10387.880302] x3 : ffff000886aea418 x2 : ffff000886aea300 =20
> [10387.885602] x1 : ffff000886aea300 x0 : ffff00080814f400 =20
> [10387.890903] Call trace:=20
> [10387.893337]  set_freepointer+0x30/0x34=20
> [10387.897075]  bfq_put_queue+0x15c/0x1e4=20
> [10387.900815]  bfq_finish_requeue_request+0xdc/0x114=20
> [10387.905594]  blk_mq_free_request+0x4c/0x1c0=20
> [10387.909767]  __blk_mq_end_request+0x108/0x13c=20
> [10387.914111]  scsi_end_request+0xcc/0x1f0=20
> [10387.918023]  scsi_io_completion+0x70/0x180=20
> [10387.922107]  scsi_finish_command+0x108/0x140=20
> [10387.926367]  scsi_softirq_done+0x7c/0x190=20
> [10387.930364]  blk_complete_reqs+0x5c/0x74=20
> [10387.934277]  blk_done_softirq+0x2c/0x3c=20
> [10387.938100]  __do_softirq+0x128/0x388=20
> [10387.941752]  __irq_exit_rcu+0x16c/0x174=20
> [10387.945578]  irq_exit+0x1c/0x30=20
> [10387.948708]  __handle_domain_irq+0x8c/0xec=20
> [10387.952794]  gic_handle_irq+0x5c/0xdc=20
> [10387.956443]  el1_irq+0xb8/0x140=20
> [10387.959573]  arch_cpu_idle+0x18/0x30=20
> [10387.963138]  default_idle_call+0x4c/0x160=20
> [10387.967137]  cpuidle_idle_call+0x14c/0x1a0=20
> [10387.971224]  do_idle+0xb4/0x104=20
> [10387.974354]  cpu_startup_entry+0x30/0x9c=20
> [10387.978265]  secondary_start_kernel+0xf4/0x120=20
> [10387.982699]  0x0=20
> [10387.984530] Code: ca000042 ca030042 f8246822 d65f03c0 (d4210000) =20=

> [10387.990612] ---[ end trace fcc292b65af7c325 ]---=20
> [10387.995218] Kernel panic - not syncing: Oops - BUG: Fatal exception =
in interrupt=20
> [10388.002601] SMP: stopping secondary CPUs=20
> [10389.075031] SMP: failed to stop secondary CPUs 0-12,14-223=20
> [10389.080513] Kernel Offset: disabled=20
> [10389.083988] CPU features: 0x00046002,63000838=20
> [10389.088333] Memory Limit: none=20
> [10389.091454] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal =
exception in interrupt ]---=20
>=20

