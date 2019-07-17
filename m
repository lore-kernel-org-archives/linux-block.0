Return-Path: <SRS0=ez2/=VO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2696EC76196
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 17:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F2F21841
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 17:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbfGQRNQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:13:16 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60214 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731204AbfGQRNP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jul 2019 13:13:15 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hnnUM-00012v-Uz; Wed, 17 Jul 2019 11:13:14 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hnnUK-0000sg-SK; Wed, 17 Jul 2019 11:13:08 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 17 Jul 2019 11:12:55 -0600
Message-Id: <20190717171259.3311-9-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717171259.3311-1-logang@deltatee.com>
References: <20190717171259.3311-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, osandov@fb.com, chaitanya.kulkarni@wdc.com, tytso@mit.edu, mmoese@suse.de, jthumshirn@suse.de, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v2 08/12] check: Add the ability to call a cleanup function after a test ends
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In order to ensure tests properly clean themselves up, even if
they are subject to interruption, add the ability to call a test
specified function at cleanup time.

Any test can call _register_test_cleanup with the first argument
as a function to call after the test ends or is interrupted
(similar to using 'trap <func> EXIT').

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 check | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/check b/check
index 029095e7cf38..981058c59c12 100755
--- a/check
+++ b/check
@@ -288,7 +288,15 @@ _output_test_run() {
 	) | column -t -s $'\t'
 }
 
+_register_test_cleanup() {
+	TEST_CLEANUP=$1
+}
+
 _cleanup() {
+	if [[ -v TEST_CLEANUP ]]; then
+		${TEST_CLEANUP}
+	fi
+
 	if [[ "${TMPDIR:-}" ]]; then
 		rm -rf "$TMPDIR"
 		unset TMPDIR
@@ -337,6 +345,7 @@ _call_test() {
 	fi
 	$LOGGER_PROG "run blktests $TEST_NAME"
 
+	unset TEST_CLEANUP
 	trap _cleanup EXIT
 	if ! TMPDIR="$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
 		return
-- 
2.17.1

