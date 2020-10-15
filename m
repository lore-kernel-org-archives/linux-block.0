Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B0CC43457
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 21:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB1420776
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 21:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vC3eeJ6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgJOVq7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 17:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbgJOVqq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 17:46:46 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A382DC0613D3
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 14:46:46 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id x42so159252qta.13
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jJ0XSGNBD3tY7euVB543fHYlpP3eBszAe3/uk5F5Rds=;
        b=vC3eeJ6AWKOK6CgMzXd0FxGlRUk8myAzlN+70++340FYOMYD15ktWn91DBrYrWR47c
         jFA+Mx2y1wdC7z7njaKJYotyVpJFBfEi+nhsDxqAmfSduj1NT0+zRFdNwy9e9toc+a53
         NJf02KjD+XK/Y9RUvU4YlofHQOHM7sjLb/D2JZOAeMyZCfBgMo4PBB923Ff+cqQ5QNlH
         sfa5nZTJBkXVAyFUF484hZemQyPmym8Cd7g4aDAnTqA10dEpyLim6nt2Z6wcu2sjtTXE
         ccSjY2r4S+2LUylMM+L5ZFdT1Qpar5gD1MraOicAQkB6m/eRUxx33mnCLx+qOq4uCB5v
         CAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jJ0XSGNBD3tY7euVB543fHYlpP3eBszAe3/uk5F5Rds=;
        b=JVreYujUM1lBRwQU0DywfpCDXnxlUjxjFj2v/wzyzWu9SRxlFkwD3WlFvwbsGPWR28
         wbUUtYlDlCZwaZwlAi5nj+NJxvUs3EoEALLpI1aJHMn2/7024docxbsaAYTDSmV5rXFT
         a2fKPdySz0zdOD2jcyCj28z3cC3Vm0c0Kd8HiLDVs3BmKSuSlJZX4PCL3vGwl1rDzcE9
         lTUFUjYeSfhiymwdD+W+uFexqtywoXSZ42n4N/45aCv3xwLmvyzkgEdNgBDQWnTlk4ZT
         VXwJ79326nGDUaUZKkm2fv5l9VbQpOn/JIbA1LCHRmany7iRXPuMISAd7zTxFfQojtRy
         5wzA==
X-Gm-Message-State: AOAM533F4WzliblHSMrS7BWVey1vnYa22q6w/1n5HDmFC1QRUEEae4R+
        cQR6pOA4RPZurGmm32Zcw5bKk+5aVw54mDxTeoReS8dvskYVQ13XIB6rt6Cv+PlycoF0C7t4pG3
        W+vdrLs5q17X5t1iD3xhoABIgeyFf9nJctfPX3pI3BxriVag7cUd99D+tw2fSlzMQLC4c
X-Google-Smtp-Source: ABdhPJy/gKbvbPaKedo5PE3S0DBqu189VWoYKJIviBQq1cp6yrPskRaTZNVZkmirHKdPnYKENw3tPx1dOJs=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:14b4:: with SMTP id
 bo20mr957599qvb.24.1602798405757; Thu, 15 Oct 2020 14:46:45 -0700 (PDT)
Date:   Thu, 15 Oct 2020 21:46:32 +0000
In-Reply-To: <20201015214632.41951-1-satyat@google.com>
Message-Id: <20201015214632.41951-5-satyat@google.com>
Mime-Version: 1.0
References: <20201015214632.41951-1-satyat@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 4/4] dm: enable may_passthrough_inline_crypto on some targets
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dm-linear and dm-flakey obviously can pass through inline crypto support.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/md/dm-flakey.c | 1 +
 drivers/md/dm-linear.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index a2cc9e45cbba..655286dacc35 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -253,6 +253,7 @@ static int flakey_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->per_io_data_size = sizeof(struct per_bio_data);
 	ti->private = fc;
+	ti->may_passthrough_inline_crypto = true;
 	return 0;
 
 bad:
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 00774b5d7668..345e22b9be5d 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_same_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->may_passthrough_inline_crypto = true;
 	ti->private = lc;
 	return 0;
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

