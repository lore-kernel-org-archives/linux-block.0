Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21F5ECE588
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 15:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C538C20872
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571154571;
	bh=qrkECs8EPOblTLNK5YQpv+7hHZe2oC7EUaC0B/evstE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=L6v9j7ArzRTp+A5vDiNlkc8YMMnaZ6WeoC10WxCuCwjYYNt6esiSZgkjRK44eQw1Q
	 Sprx1iDWqJ0ui/5H5kkIL6h+4Cv00Oxih8OjC76qE1ZKBpZ5xBKDLGndbLqHeEFxNW
	 iyoMWxuga6xzzI/qYOEN+fiQzkQ/DOZ55RJmIVcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfJOPtb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:49:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44074 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJOPtb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 11:49:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so31191323qth.11;
        Tue, 15 Oct 2019 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QgGOoaivsP13ncdYe+e0HS3grjl2RNNvS3rS/NxMpw0=;
        b=Ear/Z+JsGwsEIGGeff61RqmTg4O6EfLoNJ+bVEF/iQ5hM6jdTu0vOsWAGVRzT0NKAr
         WPRhPN9SrLctcHatVTS/FODk2frtFD4T/CxzoKmoKKrcKz/gmWeXXCncOAE7OLDng3U2
         mKZXI+Ni5WJe0C3X5mACM0pOT52RD2I5/OyQebO9eGmBMtlETJdUWaESOj53Ks/bDEeT
         AamRL6LFz5CXTFZ9HiWUQ5sf9Fe8os5ALKa9Vaih78YYsYLKs5Ort/N1+hdwCjeHd+lV
         8wfpQ9Xvv3dcMofDzzPW++6jH3V8+WXQpWHWGaCDfb7sM6iq0im2BMWj+7w9B8n23mQg
         juNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=QgGOoaivsP13ncdYe+e0HS3grjl2RNNvS3rS/NxMpw0=;
        b=aCMc7YncsEJ+RWMfSiXVf+D6BDLul9mgjxZVdTopNNDm3ZZgMHuhGYg5MPM+AATaeK
         +z5hh/WEWwt9tuumsdwyfy2YDVYzcKdSB5T/BU93DWfUSxgpCtXfeXZSrr31cTvXV66t
         nciT3N5LtW2n0+vTZH1yplxvj6SsBP/TA3tvjZb6lKFP21hEBDhXUFa8evCE5A96RkRZ
         FXkjp0ti01ZuRwe7n0yhNM/5/aEJsDYWJ3qsQE+RDHQPl1zxaXTwbw+HI6FdDJ6dp2N6
         HuKd4W0asxQA4e3LQF8EYq0FpdspLEXKz5XtwJ6brHPyucYjVfagUo9SdzJbmhF3+luj
         mRWg==
X-Gm-Message-State: APjAAAVZepGoVBqwuw7ONgwoV+r/H/3nO+le9JPyfyCAfDIvmJnWiZgw
        /Cp3VVFagULrFd0KundmFkATiw17
X-Google-Smtp-Source: APXvYqwWTeZP1bEs8h+XrAjzqFvI0NMU9xGpqXyfsO/EDcRL1UYT9y9GjWoMf2PvwgSaUtrpWjKj2Q==
X-Received: by 2002:a0c:c58c:: with SMTP id a12mr37796402qvj.235.1571154569698;
        Tue, 15 Oct 2019 08:49:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2a53])
        by smtp.gmail.com with ESMTPSA id v85sm8137484qkb.25.2019.10.15.08.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 08:49:29 -0700 (PDT)
Date:   Tue, 15 Oct 2019 08:49:27 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH block/for-linus] blk-rq-qos: fix first node deletion of
 rq_qos_del()
Message-ID: <20191015154927.GL18794@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rq_qos_del() incorrectly assigns the node being deleted to the head if
it was the first on the list in the !prev path.  Fix it by iterating
with ** instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Fixes: a79050434b45 ("blk-rq-qos: refactor out common elements of blk-wbt")
Cc: stable@vger.kernel.org # v4.19+
---
 block/blk-rq-qos.h |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -108,16 +108,13 @@ static inline void rq_qos_add(struct req
 
 static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
 {
-	struct rq_qos *cur, *prev = NULL;
-	for (cur = q->rq_qos; cur; cur = cur->next) {
-		if (cur == rqos) {
-			if (prev)
-				prev->next = rqos->next;
-			else
-				q->rq_qos = cur;
+	struct rq_qos **cur;
+
+	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
+		if (*cur == rqos) {
+			*cur = rqos->next;
 			break;
 		}
-		prev = cur;
 	}
 
 	blk_mq_debugfs_unregister_rqos(rqos);
