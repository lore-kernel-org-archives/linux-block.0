Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76013C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiFWTB4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiFWTBm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:42 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603C460F1B
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:51 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id jb13so5238239plb.9
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANaLQsYq39oxXtFTb+4mxeNrtDqVwkMZazBpJYrq+bg=;
        b=qJZvgPIX4qk3w7RHJepDkZ/RmD9vMBvoombTRtZpRKj0vx98W7QLvi1qqBybNIquNp
         wXVnjFBYaN4+s4td7oPCW4Fq2lKJBEKMDkW8gzcGT7v4N8Av0rXaGNtYSEQ7br46ZDxX
         o+tU3pGRI0GD6CTvjzrjZhO+2TP+tkiwZJenkY6jtuFzD5pdZD8dtT24MQyMoxL0a841
         bXZyCvaDzg9W3aboweMzf7FqR2hdIFlRKeSW1ycfU1FQUi8PLbxGIgT0QXn1nkFYLSBn
         aHRaejxa/A7KxE+71L8DVsjIiLFpX+VsAJrkNvE5HKse/DJ+2gGEsBJ478tOsunxvJFF
         8zuQ==
X-Gm-Message-State: AJIora8ftdLm1pGr94E2hyx+a/DJD/BT43G7iQQnpV5P2Pt+4uMWZQDC
        0JSiFfxFpe4a9wn4TIrYf9I=
X-Google-Smtp-Source: AGRyM1tyDMaWOv6txGSJknbXRVugxZC23u3Px/Nnpz+Q1CAxjIC43DNcd0lH2nNfRKLDbV59pjTYJA==
X-Received: by 2002:a17:902:c943:b0:16a:3ab8:3678 with SMTP id i3-20020a170902c94300b0016a3ab83678mr13852779pla.56.1656007610719;
        Thu, 23 Jun 2022 11:06:50 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 48/51] fs/ocfs2: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:05:25 -0700
Message-Id: <20220623180528.3595304-49-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/ocfs2/cluster/heartbeat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index ea0e70c0fce0..e955aca87936 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -503,8 +503,8 @@ static void o2hb_bio_end_io(struct bio *bio)
 static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 				      struct o2hb_bio_wait_ctxt *wc,
 				      unsigned int *current_slot,
-				      unsigned int max_slots, int op,
-				      int op_flags)
+				      unsigned int max_slots, enum req_op op,
+				      blk_opf_t op_flags)
 {
 	int len, current_page;
 	unsigned int vec_len, vec_start;
