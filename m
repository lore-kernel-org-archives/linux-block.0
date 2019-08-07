Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D73C433FF
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 10:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEA821E6C
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 10:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfHGKKf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:10:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36720 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfHGKKf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 06:10:35 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 593DC8034F; Wed,  7 Aug 2019 12:10:20 +0200 (CEST)
Date:   Wed, 7 Aug 2019 12:10:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Subject: slab corruption in 5.3-rc3 while inserting an usb key
Message-ID: <20190807101031.GA18652@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Machine is thinkpad x220. BFQ related?

=09

[ 8224.904413] usb 2-1.1.4: Product: Intenso Twister Line
[ 8224.904421] usb 2-1.1.4: Manufacturer: Alcor Tech
[ 8224.904428] usb 2-1.1.4: SerialNumber: 12102500210755
[ 8224.905778] usb-storage 2-1.1.4:1.0: USB Mass Storage device
detected
[ 8224.906519] scsi host6: usb-storage 2-1.1.4:1.0
[ 8225.938476] scsi 6:0:0:0: Direct-Access     Intenso  Twister Line
8.07 PQ: 0 ANSI: 4
[ 8225.941857] sd 6:0:0:0: Attached scsi generic sg2 type 0
[ 8225.944342] sd 6:0:0:0: [sdc] 15257600 512-byte logical blocks:
(7.81 GB/7.28 GiB)
[ 8225.945541] sd 6:0:0:0: [sdc] Write Protect is off
[ 8225.945551] sd 6:0:0:0: [sdc] Mode Sense: 23 00 00 00
[ 8225.946669] sd 6:0:0:0: [sdc] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[ 8225.961509]  sdc: sdc1
[ 8225.966286] sd 6:0:0:0: [sdc] Attached SCSI removable disk
[ 8226.351785] FAT-fs (sdc1): Volume was not properly unmounted. Some
data may be corrupt. Please run fsck.
[ 8685.026976] perf: interrupt took too long (3142 > 3141), lowering
kernel.perf_event_max_sample_rate to 63500
[ 8710.270064] Slab corruption (Not tainted): bfq_queue
start=3Dffff8880befb0cd8, len=3D512
[ 8710.270073] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
[ 8710.270081] Last user: (bfq_put_queue+0xb0/0xe0)
[ 8710.270085] 1f0: 18 e5 44 93 81 88 ff ff 6b 6b 6b 6b 6b 6b 6b a5
=2E.D.....kkkkkkk.
[ 8710.270092] Prev obj: start=3Dffff8880befb0ac0, len=3D512
[ 8710.270097] Redzone: 0xd84156c5635688c0/0xd84156c5635688c0
[ 8710.270102] Last user: (bfq_get_queue+0x13a/0x290)
[ 8710.270105] 000: 02 00 00 00 00 00 00 00 00 38 a6 95 81 88 ff ff
=2E........8......
[ 8710.270110] 010: 07 00 03 00 07 00 03 00 00 00 00 00 00 00 00 00
=2E...............
[ 8711.077572] Slab corruption (Not tainted): bfq_queue
start=3Dffff8880c20b7710, len=3D512
[ 8711.077577] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
[ 8711.077584] Last user: (bfq_put_queue+0xb0/0xe0)
[ 8711.077586] 1f0: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00 00 00 00
kkkkkkkk........
[ 8711.077591] Prev obj: start=3Dffff8880c20b74f8, len=3D512
[ 8711.077593] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
[ 8711.077596] Last user: (bfq_put_queue+0xb0/0xe0)
[ 8711.077598] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
[ 8711.077601] 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
[ 8711.077604] Next obj: start=3Dffff8880c20b7928, len=3D512
[ 8711.077606] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
[ 8711.077609] Last user: (bfq_put_queue+0xb0/0xe0)
[ 8711.077611] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
[ 8711.077614] 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
[ 8764.014525] Slab corruption (Not tainted): bfq_queue
start=3Dffff888049b0c108, len=3D512
[ 8764.014534] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
[ 8764.014542] Last user: (bfq_put_queue+0xb0/0xe0)
[ 8764.014546] 1f0: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00 00 00 00
kkkkkkkk........
[ 8764.014553] Next obj: start=3Dffff888049b0c320, len=3D512
[ 8764.014558] Redzone: 0xd84156c5635688c0/0xd84156c5635688c0
[ 8764.014562] Last user: (bfq_get_queue+0x13a/0x290)
[ 8764.014566] 000: 01 00 00 00 00 00 00 00 00 50 df 96 81 88 ff ff
=2E........P......
[ 8764.014571] 010: 04 00 02 00 04 00 02 00 00 00 00 00 00 00 00 00
=2E...............
[10593.478355] perf: interrupt took too long (3936 > 3927), lowering
kernel.perf_event_max_sample_rate to 50750
[10745.055650] Slab corruption (Not tainted): bfq_queue
start=3Dffff88818f6a9088, len=3D512
[10745.055660] Redzone: 0x9f911029d74e35b/0x9f911029d74e35b
[10745.055670] Last user: (bfq_put_queue+0xb0/0xe0)
[10745.055675] 1f0: a0 f6 71 d4 80 88 ff ff 6b 6b 6b 6b 6b 6b 6b a5
=2E.q.....kkkkkkk.
[10745.055683] Next obj: start=3Dffff88818f6a92a0, len=3D512
[10745.055688] Redzone: 0xd84156c5635688c0/0xd84156c5635688c0
[10745.055693] Last user: (bfq_get_queue+0x13a/0x290)
[10745.055698] 000: 01 00 00 00 00 00 00 00 00 38 a6 95 81 88 ff ff
=2E........8......
[10745.055704] 010: 04 00 02 00 04 00 02 00 00 00 00 00 00 00 00 00
=2E...............
[12141.101100] usb 2-1.1.4: USB disconnect, device number 8
pavel@duo:/data/l/linux-olpc$

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1Ko5cACgkQMOfwapXb+vLXrgCgrNpwkvTY9XC6mfglSc4kqxCK
DsEAoLKklQ9aswxRDYmTPJoev5KGYEXo
=TCiE
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
