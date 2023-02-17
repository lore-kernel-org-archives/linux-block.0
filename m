Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563BCC61DA4
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 01:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBQBjz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 20:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBQBjy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 20:39:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C43A0A1
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 17:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676597946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ST15Vr5tlQxxpUbLwRiBnw4DD44/toSDhcuBqnheUag=;
        b=PKxMN/in4IMyC9CZR79/8kpk1Nztd1Suv+ARtPwBiNmndhgwSvjYqfTrj1L/nGcVQXXzEW
        VI6V+YfDUJbFKqsVfZX5a5qXuF2qaGHi5+ffZkWn1sYXEl/a+ACN57/2eQFQ5CJ1ob++yq
        JIQVAjPzY5JhmFh+rOo+7BVStnj9iBs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-IRHkcwr9P3aXx5w9b7CP9g-1; Thu, 16 Feb 2023 20:39:03 -0500
X-MC-Unique: IRHkcwr9P3aXx5w9b7CP9g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEF0D101A55E;
        Fri, 17 Feb 2023 01:39:02 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D74E4492B17;
        Fri, 17 Feb 2023 01:39:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH blktests v2 0/2] blktests: add mini ublk source and blktests/033
Date:   Fri, 17 Feb 2023 09:38:49 +0800
Message-Id: <20230217013851.1402864-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch adds one mini ublk program, which only supports null &
loop targets.

The 2nd patch add blktests/033 for covering gendisk leak issue.

v2:
	- cleanup & bugfix on miniublk.c
	- avoid ignoring build warning just for addressing missed liburing
	  or ublk kernel header
	- patch style fix
	- make 'make check' happy


Ming Lei (2):
  src: add mini ublk source code
  block/033: add test to cover gendisk leak

 Makefile            |    2 +-
 common/ublk         |   34 ++
 src/Makefile        |   18 +
 src/ublk/miniublk.c | 1376 +++++++++++++++++++++++++++++++++++++++++++
 tests/block/033     |   40 ++
 tests/block/033.out |    2 +
 6 files changed, 1471 insertions(+), 1 deletion(-)
 create mode 100644 common/ublk
 create mode 100644 src/ublk/miniublk.c
 create mode 100755 tests/block/033
 create mode 100644 tests/block/033.out

-- 
2.31.1

