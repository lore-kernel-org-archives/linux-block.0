Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05276C00140
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 08:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbiHLISx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 04:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiHLISw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 04:18:52 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DD7A5C47
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 01:18:50 -0700 (PDT)
Date:   Fri, 12 Aug 2022 08:18:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1660292326; x=1660551526;
        bh=N86e1FVKKaBZfqhjlqhl/25/VzybXi4OXsmL1MxlZFY=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=Sff+VKvVH8kstqxUMPbTBrgeMNOMLqP0jgOuIqEnAcoL5iaRdumTbAoy8PKYJcbrt
         e9DNPhPZ1nJk25BBE1Xt7vl4jMmJRHJv5Yxoj/3pNj+fzrlAIgmamkWppJR6Lo1C/9
         BXkbxqjzamFxV5Ea/BUQlHz0FJzSSFwJADice5hUZlD6JItM164a4SPHxxQiR+Kdkp
         iVII7LChqVtvro/68CwKvo2lxYPVp1OhJZV7izrCQNOCR4+DeXB+5m49I6R98gDwf/
         AQ+Oc2106G7WWXbrv+r+drADcwPh0f1cf0wSj92Q5jEj63x5YGIsOT9xlJhi89nYOe
         fKknbmGwO79NQ==
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jasper Surmont <JasperSurmont@proton.me>
Reply-To: Jasper Surmont <JasperSurmont@proton.me>
Subject: [Question] Why dm_bufio_read bugs_on an active bio in current
Message-ID: <xM2EoJoJmV6GKSrOVGt_obG9V1W98uf-vhnmhpEo1XXOkL4CQNCfr8kp0Cnmi6X3VbGvkWgGOLFPcEPasUmcfGtQNTzwv0eUYz_MXTxksPE=@proton.me>
Feedback-ID: 51886783:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------9c4200bd8803bed386d4eb0a4d625374e471a1efe9677a2d3f7843b1dcd26785"; charset=utf-8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------9c4200bd8803bed386d4eb0a4d625374e471a1efe9677a2d3f7843b1dcd26785
Content-Type: multipart/mixed;boundary=---------------------2c743e0d996dbd97d38f52c4c51e8ea6

-----------------------2c743e0d996dbd97d38f52c4c51e8ea6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hey,

Trying to understand the dm_bufio code, I saw that it cannot perform dm_bu=
fio_read(...)
while there is an active bio request (at least that's what I think !!curre=
nt->bio_list means).

What is the reason for this?

Sincerely,

Jasper Surmont
-----------------------2c743e0d996dbd97d38f52c4c51e8ea6--

--------9c4200bd8803bed386d4eb0a4d625374e471a1efe9677a2d3f7843b1dcd26785
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKAAYFAmL2DNEAIQkQUVUNKQ/Zin4WIQRKKWZrKhiHyC+KFLRRVQ0p
D9mKftU7APwJaOb9WtzdUorwpheulX5q07UC0GA52L/o2PlnEHQoNwD/Z4Ds
B7I4i6RbZ+Z2NMP8GTKDO5sIqglK7xpdgEDPMgg=
=mbeM
-----END PGP SIGNATURE-----


--------9c4200bd8803bed386d4eb0a4d625374e471a1efe9677a2d3f7843b1dcd26785--

