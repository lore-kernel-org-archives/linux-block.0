Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294BEC04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39B02084C
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="zyHXHLpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39B02084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeLEPeK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:34:10 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46550 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEPeK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 10:34:10 -0500
Received: by mail-yw1-f66.google.com with SMTP id t13so8676604ywe.13
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 07:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=PNem2NL5fu2OhKSUpx777wY1UDGuyATbaD4VZNtn5yg=;
        b=zyHXHLpt5UmQYp9dfvz/yrgPzsC4TeWMh6ctsF4gtatudS2y5h9DjezFZpB3IOaIaS
         eRRXwCECRfInNoEdYyz8DH17F31QR6pmtmvUinftiROWIifSAzOS5cTtRTjbvXFg3EMB
         FoGd+4AhWpiIiPzx9G2v8626AMWxrwQAhFqQ92IDqnfcLfAKKt7WJ77JB6c6mOBrra3d
         i76iha3V5LrPZRDt6sKO2xXDXHoi7R8ScN5D1X9azD2q6htwHsExskWXWNwoLkklBkpy
         tN9g7fLCwVQvATKl/TbPR9zalgd8t7O9/Dq1PQ1wAsZvTI4nXKUWumxJmopes/xdwail
         IR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=PNem2NL5fu2OhKSUpx777wY1UDGuyATbaD4VZNtn5yg=;
        b=CUL3TPr5RInRF+60b/+hTQASEQ1VzmFjKTYMlSIGyzMJWhvX/MeGAXaYNiKs7Y66JB
         4bUfa6ypIAf+P4nIgnyEKWWjOxwZD7vgb1UaMw5m8Ew0wW7sDWhnXVPdtiuSpY+lQio2
         G2moqxEfn/F1wmkmnp7Pt/B8Y2bBPpcSUMgORAYLs1kMTamjVZctr7w17WGRv4A4w8LE
         /UDnENRLsr7eiujme82I5E5pExcClRLxvZMvc+8fh87KqJAXrRkTzoOLuPHJ0cxRXSQ5
         bodxMrdDKgsAeeWQVEhrKRIV+r1CebGeklHeidJfXS071YQE5TxZMgMQuEYyycwN19t2
         76OQ==
X-Gm-Message-State: AA+aEWZNwH3MC/MXGpk4LDdODynWO2Q4rtvaMZ5BBjIdXlUY9vANq0PE
        mlsQbFiFJn8VHEZRIkWvo9klT4FqH+Q=
X-Google-Smtp-Source: AFSGD/WwTiz27dSoaNR9koCohXVi5oCAm7eS+fYOlRycMfsQGQOy0mg5adjc5+VC9EWmGA8kuGh82w==
X-Received: by 2002:a81:4ac6:: with SMTP id x189mr24629654ywa.249.1544024048772;
        Wed, 05 Dec 2018 07:34:08 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e189sm6275589ywc.101.2018.12.05.07.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 07:34:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-block@vger.kernel.org, kernel-team@fb.com, osandov@fb.com
Subject: [PATCH 1/2] blktests: add cgroup2 infrastructure
Date:   Wed,  5 Dec 2018 10:34:03 -0500
Message-Id: <20181205153404.26634-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181205153404.26634-1-josef@toxicpanda.com>
References: <20181205153404.26634-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In order to test io.latency and other cgroup related things we need some
supporting helpers to setup and tear down cgroup2.  This adds support
for checking that we can even configure cgroup2 things, set them up if
need be, and then add the cleanup stuff to the main cleanup function so
everything is always in a clean state.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check     |  2 ++
 common/rc | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/check b/check
index ebd87c097e25..1c9dbc518fa1 100755
--- a/check
+++ b/check
@@ -294,6 +294,8 @@ _cleanup() {
 		done
 		unset RESTORE_CPUS_ONLINE
 	fi
+
+	_cleanup_cgroup2
 }
 
 _call_test() {
diff --git a/common/rc b/common/rc
index 8a892bcd5fde..a785f2329687 100644
--- a/common/rc
+++ b/common/rc
@@ -202,3 +202,51 @@ _test_dev_in_hotplug_slot() {
 _filter_xfs_io_error() {
 	sed -e 's/^\(.*\)64\(: .*$\)/\1\2/'
 }
+
+_cgroup2_base_dir()
+{
+	grep cgroup2 /proc/mounts | awk '{ print $2 }'
+}
+
+_cleanup_cgroup2()
+{
+	_dir=$(_cgroup2_base_dir)/blktests
+	[ -d "${_dir}" ] || return
+
+	for i in $(find ${_dir} -type d | tac)
+	do
+		rmdir $i
+	done
+}
+
+_have_cgroup2()
+{
+	if ! grep -q 'cgroup2' /proc/mounts; then
+		SKIP_REASON="This test requires cgroup2"
+		return 1
+	fi
+	return 0
+}
+
+_have_cgroup2_controller_file()
+{
+	_have_cgroup2 || return 1
+
+	_controller=$1
+	_file=$2
+	_dir=$(_cgroup2_base_dir)
+
+	if ! grep -q ${_controller} ${_dir}/cgroup.controllers; then
+		SKIP_REASON="No support for ${_controller} cgroup controller"
+		return 1
+	fi
+
+	mkdir ${_dir}/blktests
+	echo "+${_controller}" > ${_dir}/cgroup.subtree_control
+	if [ ! -f ${_dir}/blktests/${_file} ]; then
+		_cleanup_cgroup2
+		SKIP_REASON="Cgroup file ${_file} doesn't exist"
+		return 1
+	fi
+	return 0
+}
-- 
2.14.3

