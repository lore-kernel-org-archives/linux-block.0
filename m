Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDD3C4332F
	for <linux-block@archiver.kernel.org>; Wed, 14 Dec 2022 02:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiLNCxD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Dec 2022 21:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237211AbiLNCwq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2022 21:52:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B5227145
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 18:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670986296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qQk9ADgibSy8NmUYT5gPp7mGF+QH9fTOK/8Sedoi10U=;
        b=gdBkaJln0KfqF1atW4zhO+dm2rNcoktV+Go7WVRSUsrK40Zzikuy4vFQlyBTMYpD8DeNZ5
        zaJr7GwPur9RTFTsokMs+lm2aAt5KsjtYufsiW3HHiQmE76H/Hc3/DYjh5UyUqrCcybBGN
        pEqLZ57jDiCxG0jkBXP7/zRV4O+9dGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-l95CNPfmNyibDInMNjPGhA-1; Tue, 13 Dec 2022 21:51:19 -0500
X-MC-Unique: l95CNPfmNyibDInMNjPGhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B0A985A5A6;
        Wed, 14 Dec 2022 02:51:18 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 630052166B26;
        Wed, 14 Dec 2022 02:51:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>, Dennis Zhou <dennis@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] lib/percpu-refcount: fix use-after-free by late ->release
Date:   Wed, 14 Dec 2022 10:50:58 +0800
Message-Id: <20221214025101.1268437-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The pattern of wait_event(percpu_ref_is_zero()) may cause
percpu_ref_exit() to be called before ->release() is done, so
user-after-free may be caused, fix the issue by draining ->release()
in percpu_ref_exit().


Ming Lei (3):
  lib/percpu-refcount: support to exit refcount automatically during
    releasing
  lib/percpu-refcount: apply PERCPU_REF_AUTO_EXIT
  lib/percpu-refcount: drain ->release() in perpcu_ref_exit()

 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  4 +--
 include/linux/percpu-refcount.h        | 36 ++++++++++++++++++++++++--
 lib/percpu-refcount.c                  | 31 +++++++++++++++++++---
 mm/memcontrol.c                        |  5 ++--
 4 files changed, 66 insertions(+), 10 deletions(-)

-- 
2.38.1

