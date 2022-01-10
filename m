Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE70C433EF
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 07:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbiAJHzy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 02:55:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239583AbiAJHxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 02:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641801185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q9ppmqNfCqmmOi8yLo5NgG53QLd7SQJ80Mvj1etEsnk=;
        b=PxU8YdTs2rbzva/TcC+TbUZAoXdEMfFBIwsud0QVU0rcSX6awDf8wYpgd4apR5UrA4VbsA
        o8wJCKSf/6sdHYiEYe+0MVZd6vDlTsTAWDIa/wrXHy23S+yuCqjQRp+7zKWledoc11mAUK
        bDYOPXWKBRqrVZZPTTylIYa5XPClmC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-YWDNQg49PES79JBFr8VdUQ-1; Mon, 10 Jan 2022 02:53:01 -0500
X-MC-Unique: YWDNQg49PES79JBFr8VdUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B355118397A7;
        Mon, 10 Jan 2022 07:53:00 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72BCB694D9;
        Mon, 10 Jan 2022 07:52:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>, lining <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>
Subject: [PATCH 2/2] dm: use resubmit_bio_noacct to submit split bio
Date:   Mon, 10 Jan 2022 15:51:41 +0800
Message-Id: <20220110075141.389532-3-ming.lei@redhat.com>
In-Reply-To: <20220110075141.389532-1-ming.lei@redhat.com>
References: <20220110075141.389532-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

lining reported that blk-throttle iops limit doesn't work correctly
for dm-thin. Turns out it is same issue with the one addressed by commit
4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios").

So use the new added block layer API for addressing the same issue.

Reported-by: lining <lining2020x@163.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Chunguang Xu <brookxu@tencent.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 280918cdcabd..8a58379e737c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1562,7 +1562,7 @@ static void __split_and_process_bio(struct mapped_device *md,
 
 			bio_chain(b, bio);
 			trace_block_split(b, bio->bi_iter.bi_sector);
-			submit_bio_noacct(bio);
+			resubmit_bio_noacct(bio);
 		}
 	}
 
-- 
2.31.1

