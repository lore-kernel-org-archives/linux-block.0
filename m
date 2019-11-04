Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE310CA9EA0
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 12:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA05217F4
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 12:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FeCGL9Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfKDMFp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:05:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27675 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbfKDMFo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 07:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572869144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=owkEEpwV48qHiAYAAWErpoqSbuDowbu0KGeupM4ZgyQ=;
        b=FeCGL9QjFDZv6ckgDabV56oYAmtrVDbkFzUTt2G993t2OwX6LQ9NbPfJPA/AtoUdFxN6tQ
        pwhEmVXgsuiby21BYMLGkjY3k1Gg7xl9GdDwR265sFJCSJLkszk9lO0vcaPndLaecly2Fv
        5DoS810EJG6bPVnzmWC/co8TIl0IKMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-1yswT0kpOpOBsf94efXBuw-1; Mon, 04 Nov 2019 07:05:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A52B1005500;
        Mon,  4 Nov 2019 12:05:39 +0000 (UTC)
Received: from localhost (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5F555DA7D;
        Mon,  4 Nov 2019 12:05:33 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 0/3] Fedora 31 RPM improvements
Date:   Mon,  4 Nov 2019 13:05:29 +0100
Message-Id: <20191104120532.32839-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 1yswT0kpOpOBsf94efXBuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jeff Moyer and I have been working on RPMs for liburing.  This patch series
contains fixes required to build Fedora 31 RPMs.

I have also tested on openSUSE Leap 15.1 to verify that these changes work =
on
other rpm-based distros.

Jeff Moyer (1):
  spec: Fedora RPM cleanups

Stefan Hajnoczi (2):
  spec: update RPM version number to 0.2
  Makefile: add missing .pc dependency on .spec file

 Makefile      |  2 +-
 liburing.spec | 49 ++++++++++++++++++++-----------------------------
 2 files changed, 21 insertions(+), 30 deletions(-)

--=20
2.23.0

