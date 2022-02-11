Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA5BC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 10:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiBKKMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:12:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348809AbiBKKMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 05:12:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32B0EAF
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 02:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644574364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BlFNnKkpaFl+jjXxY9bOqnLqcjVA8RMFTfMaKXNA1c=;
        b=DYeNyuafUEq3mSTjeshjfDD/TGKoJYdiXq3oXRtClB0pX6cLZuXppmwlnuR3l+2CSExuhS
        DleYDqwWwPXruZvrpad7TxiU36Kx8ZDzWxCRIHgbq1UZvYbnWqIYOhvfTopIsnpZ4qwz4X
        ocNC2epVnilWzFXluNGDiLodKFndoRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-YTkNjmr4PW2xX10NIeofxA-1; Fri, 11 Feb 2022 05:12:41 -0500
X-MC-Unique: YTkNjmr4PW2xX10NIeofxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F5E586A8A2;
        Fri, 11 Feb 2022 10:12:40 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 303915E4A5;
        Fri, 11 Feb 2022 10:12:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] block: remove THROTL_IOPS_MAX
Date:   Fri, 11 Feb 2022 18:11:47 +0800
Message-Id: <20220211101149.2368042-2-ming.lei@redhat.com>
In-Reply-To: <20220211101149.2368042-1-ming.lei@redhat.com>
References: <20220211101149.2368042-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No one uses THROTL_IOPS_MAX any more, so remove it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk-cgroup.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b4de2010fba5..bdc49bd4eef0 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -28,8 +28,6 @@
 /* percpu_counter batch for blkg_[rw]stats, per-cpu drift doesn't matter */
 #define BLKG_STAT_CPU_BATCH	(INT_MAX / 2)
 
-/* Max limits for throttle policy */
-#define THROTL_IOPS_MAX		UINT_MAX
 #define FC_APPID_LEN              129
 
 
-- 
2.31.1

