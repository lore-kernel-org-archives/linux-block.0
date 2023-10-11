Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8114DCD98EB
	for <linux-block@archiver.kernel.org>; Wed, 11 Oct 2023 03:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjJKDto (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Oct 2023 23:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjJKDto (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Oct 2023 23:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201CCB8
        for <linux-block@vger.kernel.org>; Tue, 10 Oct 2023 20:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696996134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OUcO01oq8Dz2vL4ouhdS+Rz1zWEgeQosfyjDbjfrOVg=;
        b=eh3O6PVoVOKZ53ytGNZhSMg1qwf18XePedbVLqpVy/Rdxbaj/rODmWcRGuwe5L6gzn0gmX
        onx02gLjO++wt7swDEvdQXoX/fP2HZeoAJl6DkaL1+vRxgGkL88LC9fJ2+kVgR5/YhdhHm
        fe3ZIfp+DPvQIHWtyOhCyS2iIKWNalU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-9U0R4WDXPZ2Zz9eT8IPl4w-1; Tue, 10 Oct 2023 23:48:48 -0400
X-MC-Unique: 9U0R4WDXPZ2Zz9eT8IPl4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 401D3101A58B;
        Wed, 11 Oct 2023 03:48:48 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD61B1BA2;
        Wed, 11 Oct 2023 03:48:46 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     shinichiro.kawasaki@wdc.com, dwagner@suse.de
Subject: [PATCH blktests] check: define TMPDIR before running the test
Date:   Wed, 11 Oct 2023 11:48:32 +0800
Message-Id: <20231011034832.1650797-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The TMPDIR was defined in _call_test before running test_func, but it
was used in nvme/rc which has not yet defined, so move the definiation
before runng the test to fix it.

Fixes: b6356f6 ("nvme/rc: Add common file_path name define")
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 check | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/check b/check
index 55871b0..d25b56b 100755
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
@@ -478,6 +475,10 @@ _run_test() {
 	# runs to suppress job status output.
 	set +m
 
+	if ! TMPDIR="$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
+		return
+	fi
+
 	# shellcheck disable=SC1090
 	. "tests/${TEST_NAME}"
 
-- 
2.34.3

