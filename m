Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6097C433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 08:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiKWIPQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 03:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiKWIPP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 03:15:15 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54186F1DAA
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 00:15:13 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6E1EF32007CF;
        Wed, 23 Nov 2022 03:15:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 23 Nov 2022 03:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1669191310; x=1669277710; bh=pl
        7fTdaArPm7Ws/Kt6crDC7cXpss918LJhonhX0gaMU=; b=Dig2gE5FocaA9PY+AC
        6Lh3AoKEwqebZEe0QbT2whZ8nDZcDWEHPmdKWVU8IGY4i075mNh0qhUpjaTgYUxE
        CdCqlLFEaGfYbxw89Oq2/VrSC4B2g/avBb+JFGzwRNyvFwdNKx1IvkowkyNgRX8+
        32XW8oUEajn5FPtNmG/GGZHK5OnmwtdIjbOOa93dmfygwmKB8sj0yxNsSoaMMW0N
        grT5ILe5C98jEC+t5vDcAxJ3xXP91cD/Hcjh9sAKmWG0TXhXpR3bDmiQ9pDr+qBC
        PluHsY6V96tsEmBOXBuAHIJB2aFw9uMJ/rG+ea5zYd6L/1cOWkCEadluO6cAmpys
        43Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669191310; x=1669277710; bh=pl7fTdaArPm7Ws/Kt6crDC7cXpss
        918LJhonhX0gaMU=; b=wuoqkAmSLht5TCvHRNqM2gL3q2lj32nVLSq/XZhDczgO
        7KXPfPdL/6U5VQqguhnnuKfV/2aisrWDS+4+04miBkLhhJ++64AWV3/0xAXfgmT+
        ptq22glzCATB4U/6gLe9EbGhb2mhg+N1aHVgztKxfjOVJ260iY5a85MrOEuD5evq
        tH3RAnrl2QIcJd3eUBWburkK09gnyS8zkKsumK1eEnyPXSHQovMEWt4bVyfjf5Kq
        1pNrc2nEYTo1eJoZt1ExGb+fooZOO4+e73DsGGXdsfsDyKd1iBHyW6qCXtS4Bz44
        iXOoT+DZX6hpWYAvV0v/8Nv0kDVRQtlPKS6OR2V3Gg==
X-ME-Sender: <xms:jdZ9Y6lI1wLaY8O0DclcEiX9-q06TW9RAFcsKIFs95WVzpS98t3EAg>
    <xme:jdZ9Yx3is3Jj3OM1iQPFvE1HGh0bm8o1IiTlMd28T1dA0-PUnS19zi7apSLl-VxSb
    aCUl0Bgy5lTZRllFW0>
X-ME-Received: <xmr:jdZ9Y4qs2QNysg9K_Xm7t1T5G40Fl0iJqjmCB6Oaw3_rHT1_7oVb8QF1bVtpLf0wUtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedtgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
    shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
    htvghrnhepffduvdfhheejudfgieejueeileegveduvdelhfekhffgteetffdtvdekveei
    leefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:jdZ9Y-nezTQ9SGja4BNEYKbWmNjZ0jmnVgxCR7CBd214jrR3UJt9KA>
    <xmx:jdZ9Y40D_Tq66rov5Aze-XjuY_E1alHFCd5Hj_fE4rhPhmViYZDKhg>
    <xmx:jdZ9Y1vNzXvnijLI4nMXoR18p9UDUaGTX59QQHwVo1FZ4hxWbI0CeA>
    <xmx:jtZ9Y5kt_s58Qh0P2sl2t6oMFYKK_1uYpo_Ubk-VTX-3V3UiL3JqPA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Nov 2022 03:15:07 -0500 (EST)
Date:   Wed, 23 Nov 2022 09:15:05 +0100
From:   Klaus Jensen <its@irrelevant.dk>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Message-ID: <Y33WiTAdIpEc6M6V@cormorant.local>
References: <20221117212210.934-1-jonathan.derrick@linux.dev>
 <Y3vlsF7KcRrY7vCW@kbusch-mbp>
 <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
 <7dcb9e3c-aa3e-b7b9-fc30-59281d581fd0@linux.dev>
 <Y3wED5m5JHOFMMg2@kbusch-mbp>
 <Y3yHvg27tKo11YCF@cormorant.local>
 <4f3c32a5-54cf-dcba-afe2-1f08b3f48b16@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PxQ2h2SZomuCkK6D"
Content-Disposition: inline
In-Reply-To: <4f3c32a5-54cf-dcba-afe2-1f08b3f48b16@linux.dev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--PxQ2h2SZomuCkK6D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 22 13:30, Jonathan Derrick wrote:
>=20
>=20
> On 11/22/2022 1:26 AM, Klaus Jensen wrote:
> > On Nov 21 16:04, Keith Busch wrote:
> >> [cc'ing Klaus]
> >>
> >> On Mon, Nov 21, 2022 at 03:49:45PM -0700, Jonathan Derrick wrote:
> >>> On 11/21/2022 3:34 PM, Jonathan Derrick wrote:
> >>>> On 11/21/2022 1:55 PM, Keith Busch wrote:
> >>>>> On Thu, Nov 17, 2022 at 02:22:10PM -0700, Jonathan Derrick wrote:
> >>>>>> I seem to have isolated the error mechanism for older kernels, but=
 6.2.0-rc2
> >>>>>> reliably segfaults my QEMU instance (something else to look into) =
and I don't
> >>>>>> have any 'real' hardware to test this on at the moment. It looks l=
ike several
> >>>>>> passthru commands are able to enqueue prior/during/after resetting=
/connecting.
> >>>>>
> >>>>> I'm not seeing any problem with the latest nvme-qemu after several =
dozen
> >>>>> iterations of this test case. In that environment, the formats and
> >>>>> resets complete practically synchronously with the call, so everyth=
ing
> >>>>> proceeds quickly. Is there anything special I need to change?
> >>>>> =20
> >>>> I can still repro this with nvme-fixes tag, so I'll have to dig into=
 it myself
> >>> Here's a backtrace:
> >>>
> >>> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation faul=
t.
> >>> [Switching to Thread 0x7ffff7554400 (LWP 531154)]
> >>> 0x000055555597a9d5 in nvme_ctrl (req=3D0x7fffec892780) at ../hw/nvme/=
nvme.h:539
> >>> 540         return sq->ctrl;
> >>> (gdb) backtrace
> >>> #0  0x000055555597a9d5 in nvme_ctrl (req=3D0x7fffec892780) at ../hw/n=
vme/nvme.h:539
> >>> #1  0x0000555555994360 in nvme_format_bh (opaque=3D0x5555579dd000) at=
 ../hw/nvme/ctrl.c:5852
> >>
> >> Thanks, looks like a race between the admin queue format's bottom half,
> >> and the controller reset tearing down that queue. I'll work with Klaus
> >> on that qemu side (looks like a well placed qemu_bh_cancel() should do
> >> it).
> >>
> >=20
> > Yuck. Bug located and quelched I think.
> >=20
> > Jonathan, please try
> >=20
> >   https://lore.kernel.org/qemu-devel/20221122081348.49963-2-its@irrelev=
ant.dk/
> >=20
> > This fixes the qemu crash, but I still see a "nvme still not live after
> > 42 seconds!" resulting from the test. I'm seeing A LOT of invalid
> > submission queue doorbell writes:
> >=20
> >   pci_nvme_ub_db_wr_invalid_sq in nvme_process_db: submission queue doo=
rbell write for nonexistent queue, sqid=3D0, ignoring
> >=20
> > Tested on a 6.1-rc4.
>=20
> Good change, just defers it a bit for me:
>=20
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7ffff7554400 (LWP 559269)]
> 0x000055555598922e in nvme_enqueue_req_completion (cq=3D0x0, req=3D0x7fff=
ec141310) at ../hw/nvme/ctrl.c:1390
> 1390        assert(cq->cqid =3D=3D req->sq->cqid);
> (gdb) backtrace
> #0  0x000055555598922e in nvme_enqueue_req_completion (cq=3D0x0, req=3D0x=
7fffec141310) at ../hw/nvme/ctrl.c:1390
> #1  0x000055555598a7a7 in nvme_misc_cb (opaque=3D0x7fffec141310, ret=3D0)=
 at ../hw/nvme/ctrl.c:2002
> #2  0x000055555599448a in nvme_do_format (iocb=3D0x55555770ccd0) at ../hw=
/nvme/ctrl.c:5891
> #3  0x00005555559942a9 in nvme_format_ns_cb (opaque=3D0x55555770ccd0, ret=
=3D0) at ../hw/nvme/ctrl.c:5828
> #4  0x0000555555dda018 in blk_aio_complete (acb=3D0x7fffec1fccd0) at ../b=
lock/block-backend.c:1501
> #5  0x0000555555dda2fc in blk_aio_write_entry (opaque=3D0x7fffec1fccd0) a=
t ../block/block-backend.c:1568
> #6  0x0000555555f506b9 in coroutine_trampoline (i0=3D-331119632, i1=3D327=
67) at ../util/coroutine-ucontext.c:177
> #7  0x00007ffff77c84e0 in __start_context () at ../sysdeps/unix/sysv/linu=
x/x86_64/__start_context.S:91
> #8  0x00007ffff4ff2bd0 in  ()
> #9  0x0000000000000000 in  ()
>=20

Bummer.

I'll keep digging.

--PxQ2h2SZomuCkK6D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmN91ogACgkQTeGvMW1P
DelmXwgAtDtbHg0UyMOHAMXxlwcae40EQtzxORGpkwz7Ft5aThmNEEuAaIhAjBky
JqC7vL8GDiWdOSZ54aRHNN1vKyNnmuflXgEVBewZhVn2kgoXZliMnTL9AWWAjIB7
S3RK9jNPNGNCj0IfWn4xylthv5frdaKQnVa4hATaybqknlBFY+szOiBXbWZh4Bkz
0KZY3H3E1ac7Umk9GGxj4XP42JoiwRlhHCFPVskmFAuMk1YQZF8HuepSjqzbSPTh
2Im9Is2BJFlGhbrhMRcBsdRSnivMvAhL5yDWiApvdb1YFiGcV8G0iTg+jcsrJrcJ
3+aU9sdQkV0R3A9mSVEAf0/6u0a2KA==
=5p9N
-----END PGP SIGNATURE-----

--PxQ2h2SZomuCkK6D--
