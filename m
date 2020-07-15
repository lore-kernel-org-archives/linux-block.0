Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A5C433E0
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 11:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820DE2067D
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 11:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GkaBGqWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGOLQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGOLQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 07:16:03 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E66C061755;
        Wed, 15 Jul 2020 04:16:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B6FDs4szfz9sRf;
        Wed, 15 Jul 2020 21:15:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594811759;
        bh=3WOh8dyM4Vi1i0NxC/9yQndiresf1N+xQQw5HKnVsqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GkaBGqWroEWltm8HhGQzyaVmSkDXgfMKwzCEeTOkAItaY8Y39meiPHPS4mMnGsgIj
         6Lo4BFiF+GZDIwxdWsIOQVqY+WGmnFoO3XLeFEMNoD7yyssBTW1PmE6RfYukR7Jliy
         BkL42vqKecgwC60UQCQ6d6yLfUHihrxQouON6bHCkfx41epvvs2mdnln1GvlXhjWgZ
         MWqhyt4kro4RBdLWOxUZHmWSyXYz59z9A/T9fgewg6qmeP5Gobab0jLXeAbNHvuL0C
         Z1hUi9E1T6JGN5SRYLi1YdvCIZdH/n+5bZA0S+zl50wFudi0K+2cK0Da8N2uvUj52s
         JRK810a0dRk4g==
Date:   Wed, 15 Jul 2020 21:15:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     syzbot <syzbot+fa64e680a1ff32087778@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, qiang.zhang@windriver.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in kthread_queue_work
Message-ID: <20200715211556.61705064@canb.auug.org.au>
In-Reply-To: <00000000000031a14405aa780bdb@google.com>
References: <000000000000e6807f05aa4608b7@google.com>
        <00000000000031a14405aa780bdb@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ahPpGGhSCtt9pBV9/XE.=pa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Sig_/ahPpGGhSCtt9pBV9/XE.=pa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi syzbot,

On Wed, 15 Jul 2020 03:04:04 -0700 syzbot <syzbot+fa64e680a1ff32087778@syzk=
aller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>=20
> commit 4977caef05aa154f5e45a232fc4f0e1c74a0c739
> Author: Zhang Qiang <qiang.zhang@windriver.com>
> Date:   Tue Jul 7 02:29:47 2020 +0000
>=20
>     kthread: work could not be queued when worker being destroyed
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12c58f5710=
0000
> start commit:   89032636 Add linux-next specific files for 20200708
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D11c58f5710=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16c58f57100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D64a250ebabc6c=
320
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfa64e680a1ff320=
87778
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16bf9f2f100=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D118380ed100000
>=20
> Reported-by: syzbot+fa64e680a1ff32087778@syzkaller.appspotmail.com
> Fixes: 4977caef05aa ("kthread: work could not be queued when worker being=
 destroyed")
>=20
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

#syz invalid

This patch was removed.
--=20
Cheers,
Stephen Rothwell

--Sig_/ahPpGGhSCtt9pBV9/XE.=pa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8O5WwACgkQAVBC80lX
0Gw+DQf/fLLZPQPNoACTbZnOrP7NSSsjaXnens7+3QkbZlSCAiUCedarlTPop4Wm
YHGepi0ykJtd1pFFHJg7+0fzSjqdHlr6JES5zMaWoTo9xjqj4Z2ko4e6ulCV51NA
7FOSUJ7KN7pbCuABwSx5sliQgD7tZaY7ZNYQJqiV9p1Eg4XD9tgqR9wjm/hH764b
U1nJzaUwrhPZBFuKqyMuWDqiYarBVM+P6DrC8yNnIEt6LH89yeWYm9ew/zsjHKHz
WKXtH7mFX904r5m92spjsHVJtQkJZpq7imBPLgKjy2nY4lKmQJtaqn+HsXkLJqGt
SMRpnu8zcLsUNDXpOlj4HI/rcQYjMg==
=Rc9o
-----END PGP SIGNATURE-----

--Sig_/ahPpGGhSCtt9pBV9/XE.=pa--
