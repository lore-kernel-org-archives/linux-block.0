Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8524FC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5DA2081B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="wDVI6jyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5DA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLDRrj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:47:39 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36368 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeLDRrj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:47:39 -0500
Received: by mail-yb1-f196.google.com with SMTP id w203so3372489ybg.3
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=PNem2NL5fu2OhKSUpx777wY1UDGuyATbaD4VZNtn5yg=;
        b=wDVI6jycnOCyV2AAMdeVw432AAxBfktihv1TFNNpqOdkZq+xUYNkEMpjlx2CWmdy4P
         KA83CyS3ozd/cAaOGI9pMJjVZvmCWr7w/tdxxeHj7xod2XRWccb5BvRHd8WcZL9JnEVx
         XH7+aa9VP+jP3CNI21oBLiYhD+J5a3ah/nIyZf6Bw5n4vihqKj1vuH0q4ZLILzQm2NT9
         Sr0JpcRbI01DaSt8Ueq6eHItf3pyrKtFz6Dg5VzYsQX7goLnds2xnuw2aIElz93VaplB
         VdpibcKGkQtu+u8B8u+P6P7dLXWWnj4zxY1CfG3vUdB6YwV45ljz5lJJb5HaWj7hlyuk
         dUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=PNem2NL5fu2OhKSUpx777wY1UDGuyATbaD4VZNtn5yg=;
        b=oNEk3hMNaReiJxzzBnByRoUAZrCLn8HnxOHvthTOlh6zonU4JZujO7HVKwxZwgRO5N
         pxpLlareJSK7f3qjqNsDfJFkD7NguwzrtCA3JSeh+6wb6ltS6ljMV/XuEMoVceOKZ1yf
         4Sb2l/n8sJlnLnsGcF/HTlDiDMHlhrvLqSOO42HZMDlSw8fXR2PaNFTxOxZVVoAF10OH
         U54l1P0nY8+yIfCfgOcLTRBEOczw111LOJCW86+HdkD+g+CCDcxZ7wvkGJ7DAewGViyC
         Bi3d9h9ZTBVmmN7t48cK3mBnqVTMMRtWkRNQPEFKeZ/odxJAxXO28YCWHAvfWvTwwVl7
         D6Lg==
X-Gm-Message-State: AA+aEWZyNxwFEz3meh3WFkAk0qK86Shzw9ZZbzpFblGN1T8YY2A5QgXt
        IT071JG2+uoVcRbvCMg52naoCSDVprE=
X-Google-Smtp-Source: AFSGD/XZS2EL3Ihant6wuXWp9MCYzp8og9pJemLHJF0SMJTtX6OsS27GCpxdKrqfyYzHCwYRTpxumw==
X-Received: by 2002:a25:7a43:: with SMTP id v64-v6mr20806442ybc.187.1543945658197;
        Tue, 04 Dec 2018 09:47:38 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u81sm5453682ywf.6.2018.12.04.09.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:47:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-block@vger.kernel.org, kernel-team@fb.com, osandov@fb.com
Subject: [PATCH 1/3] blktests: add cgroup2 infrastructure
Date:   Tue,  4 Dec 2018 12:47:31 -0500
Message-Id: <20181204174733.7423-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181204174733.7423-1-josef@toxicpanda.com>
References: <20181204174733.7423-1-josef@toxicpanda.com>
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

