Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8C0C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07A62146F
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 13:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Dfiz9Nb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07A62146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeK1Ahr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:37:47 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:36575 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeK1Ahr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 19:37:47 -0500
Received: by mail-ed1-f53.google.com with SMTP id f23so19043090edb.3
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 05:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCpRI7dJqR+q7rKBPcIE9oILTzgYUC2hoAfKGvAJl+w=;
        b=Dfiz9Nb4wVLuV3kEGbWu/KL9q1KPJh2KfXsgyy4ysXzeKK6yEzRLzpOqVFgOQmjVWh
         vUkcnS49NG9fjQm+76+NJl9HU6v+iNVLa1X9PpWMVn8Vd3YFL2rqvISqQbvDa2lm6arf
         UhW5+TreQ+K8HbxIxCD7LwSN62S4q17jUcclaD2T9ed8yLGxIE/jg/8Trqn5actOgfSR
         ZJmjSCGp6vs+MEshPXmM94rqPd4dEAsTmmGWWGmtyjuyIdxTGoM//D8EfRslEcakGxdS
         LLwj6to6PUgexudONvXbYFGHST2kPJ50EGWdJ38+X+WxAEAMFHnys3eY18IFgQXZkv5z
         uXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCpRI7dJqR+q7rKBPcIE9oILTzgYUC2hoAfKGvAJl+w=;
        b=lm2sug//JI96iQ1Ylv9xNWRBKhEzEHTzfbxMzEOBtl53AC8sDRssF4t1d+JZ8f/+eH
         cfDIq6INQ9iFVFWzQuahAe6Lmmrr9kkqTM/ERpbp6CR4unjsZ73lzcfOWUwHqauGKdWF
         AERq06EbF45qBEopEXOtsumLHgI75ZMmEWpmLOtdiyWDKYaWkdnKCwaZRcC6IM7qRgZD
         G3sB8sDm874m9cQJ2dt/xmSh1karZKFf5aSWYQkWyvRj5MuF2oDg2gWL/ObWT4hKk7r8
         wQ3R+avqguenqly+1KxDOKUyTrsJc7IJD7ZKFPZhD8qBYn+C5UMVohbgtIJ9wjEpFoh+
         sLIA==
X-Gm-Message-State: AGRZ1gJSZPJx9hZxdWMeIgsSNSd80uhE2y4X9trE4vgkcgkBwyQ54+nf
        kQl0NQRJfl2Wm4g4rcUrN2J1CoQW554=
X-Google-Smtp-Source: AJdET5cwA3H2sBaKO3RFuoa7f9tHcITWMLOpCHAN0lK5G/7CcBBNnuhSXGsg7t4ip/w7EA9X2cc3lw==
X-Received: by 2002:a17:906:1489:: with SMTP id x9-v6mr23589224ejc.222.1543325988534;
        Tue, 27 Nov 2018 05:39:48 -0800 (PST)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id t26sm1024945eda.22.2018.11.27.05.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 05:39:47 -0800 (PST)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     igor.j.konopko@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: lightnvm: remove dma alloc/free helpers
Date:   Tue, 27 Nov 2018 14:39:31 +0100
Message-Id: <1543325972-15136-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch applies on top of Igor's lightnvm: Flexible metadata (V3). I
took the liberty to rename the new nvm_alloc_dma_pool() to
nvm_create_dma_pool() as it is what is does. Igor, feel free to squash
this part in your patchset. You can also carry this patch on your series
if you want, when you send the V4 to make it easier to Matias to track.

Thanks,
Javier

Javier González (1):
  lightnvm: remove dma alloc/free helpers

 drivers/lightnvm/core.c          | 25 +++++++------------------
 drivers/lightnvm/pblk-core.c     | 10 +++++-----
 drivers/lightnvm/pblk-read.c     |  3 ++-
 drivers/lightnvm/pblk-recovery.c |  5 +++--
 drivers/nvme/host/lightnvm.c     | 16 +---------------
 include/linux/lightnvm.h         |  8 +-------
 6 files changed, 19 insertions(+), 48 deletions(-)

-- 
2.7.4

