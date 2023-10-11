Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECE4CD98F6
	for <linux-block@archiver.kernel.org>; Wed, 11 Oct 2023 07:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbjJKH0k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 03:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344701AbjJKH0j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 03:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A969D
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697009152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dSXw5lcK0e0ofOaHtrsjR9yCe5tbBhDZ30IPdaDC3ME=;
        b=BcOugZB7SNK5oEky0h3QqEIsFr33hmtEdse36z+O/7+ZDcZ5IVU9GRZvvPi/pJJZrhAc0x
        +9FY84e+Tb8g86uGGUCvd36l/7PGFFt7nf5LXM2f4YppvdcyEKc37dvDjmjBi1ABC6vCok
        jg7vcfUjR/N5CH19v8WN55ScmFMe17g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-hkJ0qGzONqC1iZtWfbMHOQ-1; Wed, 11 Oct 2023 03:25:49 -0400
X-MC-Unique: hkJ0qGzONqC1iZtWfbMHOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E4072825E9E;
        Wed, 11 Oct 2023 07:25:49 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB7021B94;
        Wed, 11 Oct 2023 07:25:47 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     shinichiro.kawasaki@wdc.com, dwagner@suse.de
Subject: [PATCH blktests V2] check: define TMPDIR earlier in _run_group
Date:   Wed, 11 Oct 2023 15:25:30 +0800
Message-Id: <20231011072530.1659810-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The TMPDIR was defined in _call_test before running test_func, but it
was used in nvme/rc which has not yet defined, so move the definiation
before calling tests/${group}/rc in _run_group.

Fixes: b6356f6 ("nvme/rc: Add common file_path name define")
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 check | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/check b/check
index 55871b0..99d8a69 100755
--- a/check
+++ b/check
@@ -364,9 +364,6 @@ _call_test() {
 
 		unset TEST_CLEANUP
 		trap _cleanup EXIT
-		if ! TMPDIR="$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
-			return
-		fi
 
 		TIMEFORMAT="%Rs"
 		pushd . >/dev/null || return
@@ -559,6 +556,10 @@ _run_group() {
 	local tests=("$@")
 	local group="${tests["0"]%/*}"
 
+	if ! TMPDIR="$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
+		return
+	fi
+
 	# shellcheck disable=SC1090
 	. "tests/${group}/rc"
 
-- 
2.34.3

