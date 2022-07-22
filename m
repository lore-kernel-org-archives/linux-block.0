Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C466C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 05:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiGVFJs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGVFJr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 01:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9DBC4AD60
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 22:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658466585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BM7a/bHFa41Mb8dtrCu5RaI304UMlv+YtbwvTcz5wYA=;
        b=YG4CQD+cQ9VRS2m+H8cHwboUZEeoVoNOe7xfoSZYnKNPq9+aWqiIkwRW55Q7Xy4iGWB9qy
        wD8qVhvMfD+9+ih4Nz/zMBFSW402qHGn2WXHujWNgVzPrHneHZ3H5e5thiaO0mUitrfw+o
        RpKPFFrLbEIH34ejLAwksxEXgSOwcWA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-r82eqDz2MQKfoLOb9t9nXg-1; Fri, 22 Jul 2022 01:09:38 -0400
X-MC-Unique: r82eqDz2MQKfoLOb9t9nXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 366B4101A589;
        Fri, 22 Jul 2022 05:09:38 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D6961121314;
        Fri, 22 Jul 2022 05:09:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] ublk_drv: make sure that correct flags(features) returned to userspace
Date:   Fri, 22 Jul 2022 13:09:28 +0800
Message-Id: <20220722050930.611232-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

The 1st patch cleans ublk_add_dev a bit, meantime fix one potential
free un-allocated buffer issue.

The 2nd one makes sure that driver supported flags returned to
userspace, this way is important for maintaining compatibility.



Ming Lei (2):
  ublk_drv: fix error handling of ublk_add_dev
  ublk_drv: make sure that correct flags(features) returned to userspace

 drivers/block/ublk_drv.c      | 43 +++++++++++++++++++++++++++--------
 include/uapi/linux/ublk_cmd.h | 11 +++++++--
 2 files changed, 43 insertions(+), 11 deletions(-)

-- 
2.31.1

