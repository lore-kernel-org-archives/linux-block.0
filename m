Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CD7CA9EBC
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 21:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1250D21928
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 21:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfJXVED (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:04:03 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:40122 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfJXVED (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 17:04:03 -0400
Received: by mail-pg1-f174.google.com with SMTP id 15so48904pgt.7
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 14:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qoQi7SAaxDczqYDQpy3vOS9up78X8ZTS/VQcH+bp4mg=;
        b=IxwyvgUTmDuASTNBLHewTmdzzCOk2hKdxZBtsHkaLqmbCRDXJ42qfs1MgIj9w54Y6s
         B5LgpvHI0apDqmQq51sCBG6I5Fia5jcu+U4kaEoVbRyn7oY9KCibdYdGDdNQk+DJcacv
         JiyhOkl1nGSLLYXdKKiu2RpiuGdmPD/Vxt9KUnOtX/IXc5oLM4orGVNXhMi8YLez2I2m
         oKeXhAYhHJd8/GeG/hYRMjZ8N9LMaBXCLyl9m60YLAIj3a5i0f6r4Gyk5bv8F7vyVW9J
         4IzWhm40zg5lChla+rd2N5RXbChoLIjczNfFPodOT28hqnMXIKOEg3jEkAPKLw0A8wAT
         vg9A==
X-Gm-Message-State: APjAAAWIHWZkyKU6EqfEtzK4fsTa6ZoVzN0RvuDMy2CH8ovC40yIBnlB
        3fMiwq7S30PMm2aB1nDA7WU=
X-Google-Smtp-Source: APXvYqypn+Zb33wrTk7jLV/HR48JDoln5rG6kAzUh2FSPpYoBGrR76byn1PkFbJU1VHXS0zJ2Y82BA==
X-Received: by 2002:a17:90a:654b:: with SMTP id f11mr9523225pjs.49.1571951040718;
        Thu, 24 Oct 2019 14:04:00 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id i22sm28270127pgg.20.2019.10.24.14.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 14:03:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v2 1/2] Move and rename uptime_s()
Date:   Thu, 24 Oct 2019 14:03:51 -0700
Message-Id: <20191024210352.71080-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191024210352.71080-1-bvanassche@acm.org>
References: <20191024210352.71080-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make it easy to use the uptime_s() function from block tests. Change the
implementation of this function into something that is easier to read.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/multipath-over-rdma | 9 +--------
 common/rc                  | 5 +++++
 tests/nvmeof-mp/rc         | 2 +-
 tests/srp/014              | 2 +-
 tests/srp/rc               | 2 +-
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 65ebb7b7f5f7..545a81e8c18e 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -129,19 +129,12 @@ held_by() {
 	done
 }
 
-# System uptime in seconds.
-uptime_s() {
-	local a b
-
-	echo "$(</proc/uptime)" | { read -r a b && echo "${a%%.*}"; }
-}
-
 # Sleep until either $1 seconds have elapsed or until the deadline $2 has been
 # reached. Return 1 if and only if the deadline has been met.
 sleep_until() {
 	local duration=$1 deadline=$2 u
 
-	u=$(uptime_s)
+	u=$(_uptime_s)
 	if [ $((u + duration)) -le "$deadline" ]; then
 		sleep "$duration"
 	else
diff --git a/common/rc b/common/rc
index 41aee3aaa735..87b1e0718382 100644
--- a/common/rc
+++ b/common/rc
@@ -246,3 +246,8 @@ _test_dev_is_partition() {
 _filter_xfs_io_error() {
 	sed -e 's/^\(.*\)64\(: .*$\)/\1\2/'
 }
+
+# System uptime in seconds.
+_uptime_s() {
+	awk '{ print int($1) }' /proc/uptime
+}
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index 2493fcee12de..278843a1270d 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -113,7 +113,7 @@ simulate_network_failure_loop() {
 
 	[ -e "$dev" ] || return $?
 	[ -n "$duration" ] || return $?
-	deadline=$(($(uptime_s) + duration))
+	deadline=$(($(_uptime_s) + duration))
 	while [ $rc = 0 ]; do
 		sleep_until 5 ${deadline} || break
 		for d in $(held_by "$dev"); do
diff --git a/tests/srp/014 b/tests/srp/014
index 8ecd8a439a82..7afde6284b83 100755
--- a/tests/srp/014
+++ b/tests/srp/014
@@ -69,7 +69,7 @@ sg_reset_loop() {
 	[ -e "$dev" ] || return $?
 	[ -n "$duration" ] || return $?
 	reset_type=(-d -b)
-	deadline=$(($(uptime_s) + duration))
+	deadline=$(($(_uptime_s) + duration))
 	while true; do
 		sleep_until 1 ${deadline} || break
 		cmd="sg_reset --no-esc ${reset_type[i++ % 2]} $dev"
diff --git a/tests/srp/rc b/tests/srp/rc
index 696d94e5fb97..a1bc09b496ec 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -247,7 +247,7 @@ simulate_network_failure_loop() {
 
 	[ -e "$dev" ] || return $?
 	[ -n "$duration" ] || return $?
-	deadline=$(($(uptime_s) + duration))
+	deadline=$(($(_uptime_s) + duration))
 	s=5
 	while [ $rc = 0 ]; do
 		sleep_until 5 ${deadline} || break
-- 
2.24.0.rc0.303.g954a862665-goog

