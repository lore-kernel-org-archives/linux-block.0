Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FDDC4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 09:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE8060FC4
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 09:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhHLJPf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 05:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhHLJPe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 05:15:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7DAC0613D5;
        Thu, 12 Aug 2021 02:15:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so12232352lfu.5;
        Thu, 12 Aug 2021 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNZvgEwzNlv74EhPdPOrR7WRv0hD45zwdbp38WU3FKg=;
        b=h+hLzT97yAPBswp6hlz/ItmWV82FKo/j+KipuGYmmIkHRfMdCpQ4nRsjYf/G2s4IUg
         vqOnTqFl99HsyPm7PSqdTBXXD92aSpv/v99/qAlIHe/lwu7BiqG5hQKEej6P/b0T2NV4
         Udz6ivLrGOfK56DTIbmUd174WN8GtlnNBbxR8orB/XeIqCVgK3TtdHqCZ5GJr2LfmMCD
         7A6Wa7loVfIzoBSBXoYU7AHWix5PR28hudeN7AAJZIAZB5SBuDT52j8hI9mgDGC98C4j
         x9lIik0UvW9/+8AOxMk5NPWf6yTiSD1k8xc8iWBNi219thpwwFED9gL5D5F7jv8jnqKq
         hTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNZvgEwzNlv74EhPdPOrR7WRv0hD45zwdbp38WU3FKg=;
        b=OaTMlvSpX+AlBHKCuQbzxdQpBIb1fCH0etR3FLO83SoHY7/fMKAgeaKv9fUOZRxBLz
         lcMCD3WuhvKcgGRYM7mvldYgN6+Ewurjrg0x2+wb7kg0cqNR3C3GKpgLm+O1M5Tz7uB6
         Nzlf52VOvyBPMvg2MnEDHpAIjZS8ZflS+D0IiznnhtS3DFg3LpSSLvaaKWSyCG69t6xM
         SEpZabaSl8x9aKoLrPqdQX8+dX54xeP8mDjiLhz+ABar0O5jwNlzLvcB09oj5mRo2usi
         pzBrN42wxKkGigstnJ/Bqb8jA43Wsw6vvC3nAejPYCJp6g1D29m8kKP/Q5NxeCXdidsY
         +bnQ==
X-Gm-Message-State: AOAM530WfC9Couhl5wm1B5mdgyZ+v3n1xu+E7eP/PTNASrxGHOrqd5rk
        Z823s8c52GxjHEWJfrEGsdc=
X-Google-Smtp-Source: ABdhPJxVB+cmqliIX3pFzzoc6Q63jgJhn4JTxvzkGi0+AkKwc7iI4rwUk/r3BxhQZ79Dfg7ticWITQ==
X-Received: by 2002:ac2:4e8c:: with SMTP id o12mr1925327lfr.374.1628759706519;
        Thu, 12 Aug 2021 02:15:06 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.232])
        by smtp.gmail.com with ESMTPSA id q66sm246264ljb.83.2021.08.12.02.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:15:06 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com
Subject: [PATCH] block: nbd: add sanity check for first_minor
Date:   Thu, 12 Aug 2021 12:15:01 +0300
Message-Id: <20210812091501.22648-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Syzbot hit WARNING in internal_create_group(). The problem was in
too big disk->first_minor.

disk->first_minor is initialized by value, which comes from userspace
and there wasn't any sanity checks about value correctness. It can cause
duplicate creation of sysfs files/links, because disk->first_minor will
be passed to MKDEV() which causes truncation to byte. Since maximum
minor value is 0xff, let's check if first_minor is correct minor number.

NOTE: the root case of the reported warning was in wrong error handling
in register_disk(), but we can avoid passing knowingly wrong values to
sysfs API, because sysfs error messages can confuse users. For example:
user passed 1048576 as index, but sysfs complains about duplicate
creation of /dev/block/43:0. It's not obvious how 1048576 becomes 0.
Log and reproducer for above example can be found on syzkaller bug
report page.

Link: https://syzkaller.appspot.com/bug?id=03c2ae9146416edf811958d5fd7acfab75b143d1
Fixes: b0d9111a2d53 ("nbd: use an idr to keep track of nbd devices")
Reported-by: syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/block/nbd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c38317979f74..600e9bab5d43 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1725,7 +1725,17 @@ static int nbd_dev_add(int index)
 	refcount_set(&nbd->refs, 1);
 	INIT_LIST_HEAD(&nbd->list);
 	disk->major = NBD_MAJOR;
+
+	/* Too big first_minor can cause duplicate creation of
+	 * sysfs files/links, since first_minor will be truncated to
+	 * byte in __device_add_disk().
+	 */
 	disk->first_minor = index << part_shift;
+	if (disk->first_minor > 0xff) {
+		err = -EINVAL;
+		goto out_free_idr;
+	}
+
 	disk->minors = 1 << part_shift;
 	disk->fops = &nbd_fops;
 	disk->private_data = nbd;
-- 
2.32.0

