Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C0FC636C9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B20C61360
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhGOVCk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:02:40 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:35694 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhGOVCh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:37 -0400
Received: by mail-pf1-f180.google.com with SMTP id d12so6714114pfj.2;
        Thu, 15 Jul 2021 13:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48AZ/qhOfaMXLPR834miAP/l4Tu2tDCI53TPoFvW3ZA=;
        b=jrH9ec8peAMO9ItQfIpaaCyvRUOUxKMKaZ8KC0dt/NuIxm6DGMN1hrcZtvoE8njICC
         FyctYL1OQtCyIyQ1ekaFaohJ2Xk2R9HDxhDzemm80ZUj54g0PuiJ8V+5MdTE75ZGuI+K
         WX4AK/SORj1DAz5QPF7K1PSnyciLRihXZwCvS2xfNIx/n7lsvDcpskTzHZifEnivYskj
         JOA0pWvMozPJlaa7lr82iWwffTWKmve546a91+tdqypwI5zQ9ZMH/jjMhbSKOaFS7fnp
         GQCq3C6DW3UENekZfmANUVe7baE+tlkPfS1mba6N++fqGo3gvAedX5LHKoVtORWgu8se
         +70w==
X-Gm-Message-State: AOAM531M9czb7ZrxZgoB1nsMMPXGhgbotqFnF731aNMhfNQIJbK5uz4B
        Toke2EofKdjesx1SdeywaZ0=
X-Google-Smtp-Source: ABdhPJwzF9FdDK9OiEdoTso1FQF3WajfVq3Ea+XrXkn83yewqrVKo7cMRaouMjVlwxfeA1toQYQEeg==
X-Received: by 2002:a63:1a12:: with SMTP id a18mr6382582pga.269.1626382782644;
        Thu, 15 Jul 2021 13:59:42 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id i8sm10056563pjh.36.2021.07.15.13.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:41 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 06/12] scsi/sr: use blk_cleanup_disk() instead of put_disk()
Date:   Thu, 15 Jul 2021 13:59:14 -0700
Message-Id: <20210715205920.2023980-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715205920.2023980-1-mcgrof@kernel.org>
References: <20210715205920.2023980-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The single put_disk() is useful if you know you're not doing
a cleanup after add_disk(), but since we want to add support
for that, just use the normal form of blk_cleanup_disk() to
cleanup the queue and put the disk.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/scsi/sr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 94c254e9012e..362f04a3761a 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -789,7 +789,7 @@ static int sr_probe(struct device *dev)
 	clear_bit(minor, sr_index_bits);
 	spin_unlock(&sr_index_lock);
 fail_put:
-	put_disk(disk);
+	blk_cleanup_disk(disk);
 	mutex_destroy(&cd->lock);
 fail_free:
 	kfree(cd);
-- 
2.27.0

