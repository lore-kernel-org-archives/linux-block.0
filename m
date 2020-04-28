Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4AAC83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 07:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA31206A5
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 07:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixFyy45u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgD1HrP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:47:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50335 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726253AbgD1HrP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 03:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588060034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mUsPnTtoinlhbO1ZEzGOs4KPKpPJ2NFVfJYHbjze/Pc=;
        b=ixFyy45uixuODGttBXJnuz+J8kunQK3tWzI0nGBPKGAH0c6rxbgrbinR81aAe388nEJ5Zf
        S2ipN+M1SMAPSUDkNpkn5an2UlCZg7wUFZX4nDtxNXgvBzhegcMbFRzCO2S893yNAk0bCh
        6GmMF4UprZqDflkzTBccneia8Gv4W4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-9paYCXtzOLyJIHpAthR0vQ-1; Tue, 28 Apr 2020 03:47:13 -0400
X-MC-Unique: 9paYCXtzOLyJIHpAthR0vQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6CF8106B248;
        Tue, 28 Apr 2020 07:47:11 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E1E319634;
        Tue, 28 Apr 2020 07:47:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] block: prevent task hung from being triggered in sync dio
Date:   Tue, 28 Apr 2020 15:46:55 +0800
Message-Id: <20200428074657.645441-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch adds one helper of blk_default_io_timeout().

The 2nd patch adds blk_io_schedule for prevent task hung from being
triggered in sync dio.


Ming Lei (2):
  block: add blk_default_io_timeout() for avoiding task hung in sync IO
  block: add blk_io_schedule() for avoiding task hung in sync dio

 block/bio.c            |  9 +++------
 block/blk-exec.c       |  8 +++-----
 fs/block_dev.c         |  4 ++--
 fs/direct-io.c         |  2 +-
 fs/iomap/direct-io.c   |  2 +-
 include/linux/blkdev.h | 16 ++++++++++++++++
 6 files changed, 26 insertions(+), 15 deletions(-)

Cc: Salman Qazi <sqazi@google.com>
Cc: Jesse Barnes <jsbarnes@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>


--=20
2.25.2

