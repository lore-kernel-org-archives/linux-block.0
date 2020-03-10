Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C1CC10F27
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C26D20848
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583860072;
	bh=QcyJpzqmrELO00E+qlbm2MBTehCp0dNT6xT29QhqFrU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FpCzjXbOmaIJQhR1acj6i0vHPCC+0b6aFtqmp7rDqIZNbC+MzmEClH/GLNooFDzj+
	 sL0Hj9QRiMRSpLffwVAaRqkAgnUH8fXwWOsdZFuhKFVZ/6tuoexjS/clrMUxRGeoWr
	 Rff8zUHFy14pO7Ox67iHS5Qb4+szEjWqkxM4lk78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgCJRHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:07:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44212 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJRHv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 13:07:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id f198so13400334qke.11;
        Tue, 10 Mar 2020 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QsUKZ0V5D0VdpsH159OxTwTzGxBhzIspzhMxQnG5cjo=;
        b=U0Lcd3v1KGrx3uAg/4J0RhHt7Mv2MZDvx198kwAdMJsCnaGhoBmLSTtgpSqFOvQRMb
         tvcrtceKx9EHZv1zIiyQkWHjqGoNY02kR5pKSotflJeN0sZBDp4aA6woTSXL9Sws31Op
         5Q+FTr5ctewX3L7FEsQr/ZJ5L/z+22CyM5qiTMIFHJ8Igsh3WC06ldDCA1Fo8llOHI0I
         6YQ1gE3Dy6d44lju4b+SunBKzNCJUjJw53qBn1BNqOMJ9q+I5WUHDUqPkYAVNSiCKhRF
         5dxBXk3p/sBf7YCPERyDH88fbug+PpvyhiO+SQgJUilvvwNZ8tUGJ+mhuNuo8G8g3I/5
         poxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=QsUKZ0V5D0VdpsH159OxTwTzGxBhzIspzhMxQnG5cjo=;
        b=EJedpufeywP9P9tQqEEQwaAKMrxRxEhCmPFy1HR7Yti0NsjLzFilzj9BWqpuYsrGAJ
         7EuoATpPqGaOM1A5j1JSUCCmlL14gKdyoAt2JKfs4t80juei4/25qQLBls0J1hlhrwUF
         qMfYrlZPdKxnp97vgyKVrhbuNB2IqlZ0tX2RsXI4OyrixR/NrLjGPE9iVOXRhxcGDeJS
         s/Rs2DW5N9subxed0cKpXo4tmNPFxNHONXDkl1m3iCyY2N9osqbJ2qSXsQ/duh8815Oh
         gFg7vEPXYTtmPvDtQcKRgbDLs1Pm3HSSBRp6iqYthScN88j6mE8bdGf77sGy12mqYnjE
         1FIA==
X-Gm-Message-State: ANhLgQ1S05GJrBaOqLIMamjrEYovxp4Lrs3OJbk7ak+eOKauIFCZGAcq
        2nCSArrOPl33WR9t06ArV3Cj1drw284=
X-Google-Smtp-Source: ADFU+vv/mJh8KEjDJUvYbmwKhXysmGg2oOqbk26yDD9NvcX4uTudt/qRWm8ZKAm6GbFoMax1HFW0Qg==
X-Received: by 2002:a37:2d04:: with SMTP id t4mr21003446qkh.105.1583860068625;
        Tue, 10 Mar 2020 10:07:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::23f8])
        by smtp.gmail.com with ESMTPSA id k202sm11575975qke.134.2020.03.10.10.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:07:48 -0700 (PDT)
Date:   Tue, 10 Mar 2020 13:07:46 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH block/for-5.6-fixes] blk-iocost: fix incorrect vtime
 comparison in iocg_is_idle()
Message-ID: <20200310170746.GD79873@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

vtimes may wrap and time_before/after64() should be used to determine
whether a given vtime is before or after another. iocg_is_idle() was
incorrectly using plain "<" comparison do determine whether done_vtime
is before vtime. Here, the only thing we're interested in is whether
done_vtime matches vtime which indicates that there's nothing in
flight. Let's test for inequality instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Cc: stable@vger.kernel.org # v5.4+
---
 block/blk-iocost.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 27ca68621137..9a599cc28c29 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1318,7 +1318,7 @@ static bool iocg_is_idle(struct ioc_gq *iocg)
 		return false;
 
 	/* is something in flight? */
-	if (atomic64_read(&iocg->done_vtime) < atomic64_read(&iocg->vtime))
+	if (atomic64_read(&iocg->done_vtime) != atomic64_read(&iocg->vtime))
 		return false;
 
 	return true;
