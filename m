Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B8CC433E3
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1617619A7
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhC3Hii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhC3Hh7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:37:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643DAC061764
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:37:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id e14so23264949ejz.11
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kipd4FaBQ5PXB3dpojcZn5niu7bqNibIYxBeruWL79Q=;
        b=ajzJ7yr0PWVMqrOoFkFP+QvWcANuCNsyegdCxs6QWbftA4WWYYymWPYkIHyULrW6Iz
         ny2ZOz/JymE+uQuqKuTGbGSmLhl2Ik5D99otYQws+3KPl6hrwJhmmn3wNNm045sz1Fj8
         y5Dy3REoj8jqLLIpWUXObO0EKrPON4lIt7T56sDmBMflkErhd0M5/IZki2uMpV7U2bS0
         5B7QXILwmh0AAJIzKO3aVzS3kwzYLnx3rcVgSxGc583S7ZCFFjLC03HkdYk4qooPAtux
         PSIMB5kGFJ3SH21YCPNEtOBQth1FgHQMFkPD7FxssW6C2JMFS1J8ckkM+hdODQYtIkjC
         6Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kipd4FaBQ5PXB3dpojcZn5niu7bqNibIYxBeruWL79Q=;
        b=VsnwMbmbiREyO77Vu2cjcfyejxdXTC8/RXZzfZR9SrrUDt8z/uNnfnBukEVr9jSrsb
         kelxsIWwiepCi78WxhJPP600D+VLCYQkhAFS517URsUfWE9eHFAEkMfM0/e3JHZ2we3i
         u/ljY/0vTIyXg9d7KTimcWsBHse4+uXgY7/3PbdbJmvb2P6PhT3JG7IWtXebWH1ikko/
         wYgNsbQ8X/QhgKLbaXfYyNJSI2oxz8YE75B4eUf/OqmNsKBTBaoUn6elYL8uuVgqh/+1
         Q+lklfu5M28ONxZq0zVbWgmZNFn1r9H6N2EJ16kIHdVQan3m/wVcSg3vR7E41DDVlAyj
         rGNA==
X-Gm-Message-State: AOAM532oY5oSzvKXBWHDkvzH90pdA9vsM+ooPhN2liXjVNNDT2echT/4
        S4fm2gYuUjQ/g1ef2qBi7QpRPiPvMytx1g==
X-Google-Smtp-Source: ABdhPJwwjhVNUvEIH1Ty+4L5g8NWJTBSyHjm5qQeSTgFClyJ6/Nv+dgN5rwuXzjKuqVab0WZ+nsrIA==
X-Received: by 2002:a17:907:50a1:: with SMTP id fv33mr14623496ejc.14.1617089878071;
        Tue, 30 Mar 2021 00:37:58 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:37:57 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv2 for-next 02/24] Documentation/sysfs-block-rnbd: Add descriptions for remap_device and resize
Date:   Tue, 30 Mar 2021 09:37:30 +0200
Message-Id: <20210330073752.1465613-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Two sysfs entries, remap_device and resize, are missing.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block-rnbd | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-rnbd b/Documentation/ABI/testing/sysfs-block-rnbd
index 14a6fe9422b3..ec716e1c31a8 100644
--- a/Documentation/ABI/testing/sysfs-block-rnbd
+++ b/Documentation/ABI/testing/sysfs-block-rnbd
@@ -44,3 +44,15 @@ Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
 Description:	Contains the device access mode: ro, rw or migration.
+
+What:		/sys/block/rnbd<N>/rnbd/resize
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Write the number of sectors to change the size of the disk.
+
+What:		/sys/block/rnbd<N>/rnbd/remap_device
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Remap the disconnected device if the session is not destroyed yet.
-- 
2.25.1

