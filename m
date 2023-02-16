Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D11C636D4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 03:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBPDDZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 22:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBPDDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 22:03:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405A92006F
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 19:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676516554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jBquSDaAF70XHabBdbq26FvtAoUG++yitrHfM320HhU=;
        b=bB3fFx6orENN/6mGI4ozu0PsL+HcCmgj4m7dtGPZFUjH6WuYHzC9QP9ncmlP0Bm4Dp7O+k
        X67G4+Iq+2XJDOb1HKK3E9zmCBzhkL8yDwktFJcEWH40QTMsna+DFt4IaUoatAl+vJWckm
        J7SRrMwBbHwtTXbDJ8Ugq2a7JpRqh1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-scA2KZAKN1q9U1vO3UckkA-1; Wed, 15 Feb 2023 22:02:32 -0500
X-MC-Unique: scA2KZAKN1q9U1vO3UckkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E75DD101A5B4;
        Thu, 16 Feb 2023 03:02:31 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EAC02166B30;
        Thu, 16 Feb 2023 03:02:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blktests: add mini ublk source and blktests/033
Date:   Thu, 16 Feb 2023 11:01:32 +0800
Message-Id: <20230216030134.1368607-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch adds one mini ublk program, which only supports null &
loop targets.

The 2nd patch add blktests/033 for covering gendisk leak issue.

Ming Lei (2):
  blktests/src: add mini ublk source code
  blktests/033: add test to cover gendisk leak

 Makefile            |    2 +-
 common/ublk         |   32 +
 src/Makefile        |   13 +-
 src/ublk/miniublk.c | 1385 +++++++++++++++++++++++++++++++++++++++++++
 src/ublk/ublk_cmd.h |  278 +++++++++
 tests/block/033     |   33 ++
 tests/block/033.out |    2 +
 7 files changed, 1741 insertions(+), 4 deletions(-)
 create mode 100644 common/ublk
 create mode 100644 src/ublk/miniublk.c
 create mode 100644 src/ublk/ublk_cmd.h
 create mode 100755 tests/block/033
 create mode 100644 tests/block/033.out

-- 
2.31.1

