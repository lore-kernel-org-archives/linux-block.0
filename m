Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7DBC10F29
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C502B24655
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="ZBZh/okU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgCIVmM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:42:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34389 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgCIVmM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 17:42:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id c21so13821628edt.1
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 14:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nl3ftXdHghC43OEZSA68wd9xadErx72C0gMm8BJ3QBQ=;
        b=ZBZh/okUemtdK0XIqnmv/gaJXnSMq4udeh3oAb8bb1TvveFjp/RabWUGMowG4MptA/
         6HvbxkVZaaPWLNfm4Lxn9DGlHKlVsDA6Eqz+gcOS8fkkxQvPZK9Z9bIY/6qxmTm5I1/V
         UMMhlB6vYGI1Acnh7WUVj6R4afUr+0ezbmIz8Y7aM46BHTmeDfXhK3ArxI0xVtqacXVO
         D0ECYqs5w+MNOyFAx6KiHUU1vPhBzXXLy43C0CYWwZLEfcwbUYSEfNZoJGBanGNsFcLa
         HWDIHn/SYXfURaRcsgUVJix4aY/BgFyNKHKH8ypifBGpwLSiMQINYGPDzfYl94u9PfWp
         PlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nl3ftXdHghC43OEZSA68wd9xadErx72C0gMm8BJ3QBQ=;
        b=ENMHam2YCGjXlbo3/u6QqwCm5hvjM+/gzMiJOiwiNUXask3s5rOx21pz9aSqMXpybF
         5P5UVuMNB7OJJSEsPFMYFGOL3snJ3vh3tZszIHfYzcTfrUcEKFn5vnYJrG0iCGfT+Aon
         7nXI3P+NFsntaLlTXej+0nvtXRw+PQkLmM22OcxxkfZg5wIEO6vqHVGoNkhd/s1i4VP7
         mzXGDQtCL9B5wcakKe3G2fFXRB6REnHpJ15N9V2ohLfuUA/gyYVTLaReVaGx+Sj8vNWh
         VYyQjnM4OY9PbzkPz4g1mslUODBAJDRyBY338dfsLwltJr1ON3gfRal6p7yd4jKaco32
         2EVg==
X-Gm-Message-State: ANhLgQ2r2ZKY+zcz4Dq8h4P0RzDNktv6S6b9yduQL6/xlPyU9MvaOIKN
        XkzbC8xrC2Rco3ORYmRo4SOxoQ==
X-Google-Smtp-Source: ADFU+vvqCe35qx7Npm9bYwoOqXY+7cGX7hkgUm2qW+bxVVAnycFDAQ3Xxn7l0/R/vnZrRVrS44Ymbg==
X-Received: by 2002:a05:6402:310b:: with SMTP id dc11mr18255782edb.122.1583790130421;
        Mon, 09 Mar 2020 14:42:10 -0700 (PDT)
Received: from nb01257.fritz.box ([2001:16b8:4824:700:55b0:6e1e:26ab:27a5])
        by smtp.gmail.com with ESMTPSA id g6sm3828488edm.29.2020.03.09.14.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:42:09 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 1/6] block: fix comment for blk_cloned_rq_check_limits
Date:   Mon,  9 Mar 2020 22:41:33 +0100
Message-Id: <20200309214138.30770-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
References: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the later description mentioned "checked against the new queue
limits", so make the change to avoid confusion.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..fd43266029be 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1203,7 +1203,7 @@ EXPORT_SYMBOL(submit_bio);
 
 /**
  * blk_cloned_rq_check_limits - Helper function to check a cloned request
- *                              for new the queue limits
+ *                              for the new queue limits
  * @q:  the queue
  * @rq: the request being checked
  *
-- 
2.17.1

