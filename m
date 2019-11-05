Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B8ACA9EDB
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 07:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943582190F
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 07:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bziUyqhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfKEHjc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:39:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39062 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387484AbfKEHjc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Nov 2019 02:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572939571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZgvYzo77uniDUKc2aqx71VEEXXZ0e9S9z+XubeLBmjA=;
        b=bziUyqhvlOdMIqVPBtL+riHmQQtH7s5WC4GK47Q3uxKM1sfeA6vdzlQN8mW6Al8pOKcc0x
        u/LNVsIa1QiAU2nqXVDpJ3THKcpl/l+fxyjrQTjL0RAiwuv9lJNzW2JW3BdujowhV637ZH
        +G8VYf7pJmhdT4dAsYhQS9TfOfD5Lns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-3kfZCS7OOTaFNRpdt14BCA-1; Tue, 05 Nov 2019 02:39:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D83E98017DD;
        Tue,  5 Nov 2019 07:39:26 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E4AB60BF4;
        Tue,  5 Nov 2019 07:39:19 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Julia Suvorova <jusual@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing v3 0/3] Fedora 31 RPM improvements
Date:   Tue,  5 Nov 2019 08:39:14 +0100
Message-Id: <20191105073917.62557-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3kfZCS7OOTaFNRpdt14BCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v3:
 * Remember to commit my changes ;-).  The changelog now contains user-visi=
ble
   changes in 0.2 and the https git.kernel.dk URL.

v2:
 * Wrap commit description to 72 characters
 * Put user-visible changes into 0.2 RPM changelog
 * Use https git.kernel.dk URL for tar.gz

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
 liburing.spec | 59 ++++++++++++++++++++++++++-------------------------
 2 files changed, 31 insertions(+), 30 deletions(-)

--=20
2.23.0

