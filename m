Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B4AC19425
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F7B23B99
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgLIIVi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgLIIVh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 03:21:37 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735EEC061794
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 00:20:57 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id c7so585299edv.6
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 00:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1nkDS+t71lcZcyKCx1EdDkNSPvYcn8wLT9ZWpiLudM=;
        b=LRdITsDERTgvDHMgQpQKgIs34CL9uWsDYndYAFxesZIQtK9dEoQPV0OjxiFl/fGMHF
         F24OpbAq6FMA9ypVJxkl5PVT4eMKbBd2/cCefII1kV+WBZWw5EhgVSO5VV8Mx8pKWaI/
         He6dCS0YRfHXioBYgXnngJGqdumW/KTZFnhwE5HEVkWjBvH0rOn2hLwWoaeRsVHU+n5u
         /fyxSo+B2HpfhdvTnPcH59brgyj4ZxEee3zotzKERhAZclxybh7t4jpJCTgKSAYhHgF5
         1H2EJYcLj8whNpzwcUoDpudlK4ZctgRjniGd+q3dvRNiJ7ROT6JxZcKTjo7G4CO0j7TM
         9f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1nkDS+t71lcZcyKCx1EdDkNSPvYcn8wLT9ZWpiLudM=;
        b=DgG34e5QmOjEva3ZXoN2srPhGpbJfrpNfZyv3DYWPJfCl6dc0pYpCkEPchGW0xcJsX
         tv9GRgIRDRhtF3sA2AUrG24FvM1THxPkJ1/rz7/ZR9/ZKpd8ziuoAJwieWPHUdKyVX/F
         bbhjSfGMR05ZRln88RDIiofWEYglwrzFFH+K1BC+EKytFFN6tlpaVkq+HggY9e5SEUD4
         gWlnCoTT3ieqCSvwis5fdpcyeZtLnk2BOzA2K9e/6k9R02ovYHG14cBQwGGaKr/MduQ+
         kOjMHPSW+tHsuiDbqAjUBGIVS5jsvCr4MB+bYF4McCd1epwDmgOCHLHHgMeuFwiPXFGx
         S53A==
X-Gm-Message-State: AOAM532ahkc60y1cicg4II1703Ns7lbXAo0HFCocyhiyHF8ZmmL/axX0
        tnvrUJUeXcGCQhSGHB9Fp4R8T6K2wwX2kw==
X-Google-Smtp-Source: ABdhPJxtGAVLmA2bo9FrsyfjmZb3lmCvDri6XFBZOXp3X8XOqgji9Gi3rMUJXl9FJjPwQUQxvbuUdQ==
X-Received: by 2002:a50:ed17:: with SMTP id j23mr963804eds.218.1607502056062;
        Wed, 09 Dec 2020 00:20:56 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id cf17sm823225edb.16.2020.12.09.00.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 00:20:55 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-next 3/7] block/rnbd-srv: Protect dev session sysfs removal
Date:   Wed,  9 Dec 2020 09:20:47 +0100
Message-Id: <20201209082051.12306-4-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
References: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

Since the removal of the session sysfs can also be called from the
function destroy_sess, there is a need to protect the call from the
function rnbd_srv_sess_dev_force_close

Fixes: 786998050cbc ("block/rnbd-srv: close a mapped device from server side.")
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index d1ee72ed8384..066411cce5e2 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -338,9 +338,10 @@ static int rnbd_srv_link_ev(struct rtrs_srv *rtrs,
 
 void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev)
 {
+	mutex_lock(&sess_dev->sess->lock);
 	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
+	mutex_unlock(&sess_dev->sess->lock);
 	sess_dev->keep_id = true;
-
 }
 
 static int process_msg_close(struct rtrs_srv *rtrs,
-- 
2.25.1

