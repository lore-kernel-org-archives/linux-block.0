Return-Path: <SRS0=wO3m=ZI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D99AC43141
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 05:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBF920733
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 05:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pm46Fv/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725308AbfKPFuY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Nov 2019 00:50:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37455 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbfKPFuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Nov 2019 00:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573883423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nFrCecqxGljrezuAX5/Vyfjl2ytF0eRdx/OWnRPI/lc=;
        b=Pm46Fv/5fX3olo+RUnUB/2K6JznEtNci4OcGOsxBb9JYs6cbzCKtHo2Oqkvr9Nd0ZpyNs+
        q5SHi1Sr0xD9QxkO8hNECRF6XNBIHxoGfmG/m95fp100IKWC08bPwAkuikfyR0PB30YOuc
        cZPYN/me4S6TV3BMMOcE1EYGZflxVvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-exV4rIO2Nx6i0em8c5CmDQ-1; Sat, 16 Nov 2019 00:50:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B9E2477;
        Sat, 16 Nov 2019 05:50:19 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-125-253.rdu2.redhat.com [10.10.125.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D11F69183;
        Sat, 16 Nov 2019 05:50:18 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     nbd@other.debian.org, axboe@kernel.dk, josef@toxicpanda.com,
        linux-block@vger.kernel.org
Subject: [PATCH 0/2] nbd: local daemon restart support
Date:   Fri, 15 Nov 2019 23:50:15 -0600
Message-Id: <20191116055017.6253-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: exV4rIO2Nx6i0em8c5CmDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following patches made over Linus's tree allow setups that are
using AF_UNIX sockets with a local daemon to recover from crashes
or to upgrade the daemon while IO is running without having to
disrupt the application (no need to reopen the device or handle IO
errors). They basically just use the existing failover
infrastructure, but to failover to a new socket from a non-dead
socket.


