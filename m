Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DADFC67839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 23:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C7720870
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544656206;
	bh=42G6tzoNx23Dr5Udphk5WF62rIBu3lUdPMsYxocULgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w0vtuWvwKx1mgFAISS+JvJlgNrGvW5fQpEB/BX9VqvTrId8VWo5OZnFjcI5mpukzv
	 3L5yO2MO4w4ybPFl9QccYjasI5nArEJMaafyWO32bQhRZpXuIVNs0zyIdGa5GGgKCM
	 ghecVj39fN5R+9z4iL5pMeuE2bulVBlyMS4fyHF4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C7720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLLXKE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:10:04 -0500
Received: from mail-yw1-f48.google.com ([209.85.161.48]:42980 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeLLXKE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 18:10:04 -0500
Received: by mail-yw1-f48.google.com with SMTP id x2so47267ywc.9
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 15:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bTvLJoxvowriT86ggcJOB2/6d3/zjRLTJV+ZHwfKSUI=;
        b=ElAKo2LfDBwiDKAuEFAz2K/6hK6xcxJLn5UjVEmEVTanraI1HrBbrSdPEsGvcxwbzR
         ccwDuViviMcxflfMw3/LeSofW1ZQaLw/OfsDfRF2MyvW0Ubd0PuCZAjVVP9DG10Sy7Az
         rcHk4eYDANjZEKSbNfBBG10Apbb+Gj/j6bJVONKUi/JPEXCE+BzzqcmhTZOdYAhY/C5J
         G6IEgJIh8tZYtWS65C5lzJ1poBeh/cNngtMFVdxBHVNjXqRQbs8h8L4JMzUJtChCb3Kr
         ZcN2aPtW3MiJj7SZwpo6kD3U8Xi1hJVVSUfFh+XKOEZpum31m4IQHx+41CCvMFpBocwa
         lXOw==
X-Gm-Message-State: AA+aEWa0NQqIaNi43m/3seM/qH5qh4WPKb220IIbLtUeB5DjwXhMEGFB
        ug/8Tj2cqP+z3XZa6R/fbX8=
X-Google-Smtp-Source: AFSGD/XRdlwifncuY0NJ2Wtv5lkUFUwB+jOyRMUgLzPLlJSHQfUt4LmswcIPAK15RN4iLY5iKTjSVw==
X-Received: by 2002:a81:2714:: with SMTP id n20mr22603385ywn.77.1544656202559;
        Wed, 12 Dec 2018 15:10:02 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id i21sm137832ywg.5.2018.12.12.15.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Dec 2018 15:10:01 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH blktests 1/2] blktests: split out cgroup2 controller and file check
Date:   Wed, 12 Dec 2018 18:09:58 -0500
Message-Id: <20181212230959.69975-2-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181212230959.69975-1-dennis@kernel.org>
References: <20181212230959.69975-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a prep patch for a new test that will race blkg association and
request_queue cleanup. As blkg association is a underlying cgroup io
controller feature, we need the ability to check if the controller is
available.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 common/cgroup | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/common/cgroup b/common/cgroup
index d445093..3481458 100644
--- a/common/cgroup
+++ b/common/cgroup
@@ -37,19 +37,27 @@ _have_cgroup2()
 	return 0
 }
 
-_have_cgroup2_controller_file()
+_have_cgroup2_controller()
 {
-	_have_cgroup2 || return 1
-
 	local controller="$1"
-	local file="$2"
-	local dir
+
+	_have_cgroup2 || return 1
 
 	dir="$(_cgroup2_base_dir)"
+
 	if ! grep -q "$controller" "$dir/cgroup.controllers"; then
 		SKIP_REASON="no support for $controller cgroup controller; if it is enabled, you may need to boot with cgroup_no_v1=$controller"
 		return 1
 	fi
+}
+
+_have_cgroup2_controller_file()
+{
+	local controller="$1"
+	local file="$2"
+	local dir
+
+	_have_cgroup_2_controller "$controller" || return 1
 
 	mkdir "$dir/blktests"
 	echo "+$controller" > "$dir/cgroup.subtree_control"
-- 
2.17.1

