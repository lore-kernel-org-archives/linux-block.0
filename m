Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2A5CA9EB0
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1212084C
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfJUW5a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 18:57:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35315 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfJUW5a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 18:57:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id c8so3893491pgb.2
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 15:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1yeeTbnyVvdJTAkff/hnVliiaKOyas0k2rMKAXPg1qc=;
        b=KWy6cP1SiYOFmaTpirg3RtB3IQoB8WWcrWsXLk+Vq9TYpWz9aeJ4sc9fAWtCaC/4Ji
         ghhq+YJsWB5xq5e/8vNbKnSUg+M5Oi44aX4jeMc0F2xy1FBK+LJgNsHEiWkhmvAEo4wv
         be1wIivTcaj3GV+O5AHTFWss1SU+dxzRlorZ0iESH+BifOeahDEtg8HDGe4Kwg/5LqoC
         Pm4wSfROV6kOcfbc/gbaceF+q4FGbJScUgwxrdXONn2bmCEv9QHCv0fx2twWCvA0v3z1
         zNab+b4hhSpU+ZHodSXDyEPG7lOGGk3IIkqo3nd6DceRmnAY1IS2z/N6HwgjDop97qcq
         GGlw==
X-Gm-Message-State: APjAAAWVOV6prUxK7JpF4EocDAK4emBuEx5GSRaHlvsCc9jedGajnpqP
        K2WB2ekB/PjUHJo6FMf+5J4=
X-Google-Smtp-Source: APXvYqw2wiYQdTTr/+Bv/Z95m619C4BNn7k2+K0pT+L6Ig2oPd07kOR4oYrZuJwxQQPnDwgV3TOBXg==
X-Received: by 2002:a17:90a:8d13:: with SMTP id c19mr637073pjo.63.1571698649711;
        Mon, 21 Oct 2019 15:57:29 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x70sm255474pfd.132.2019.10.21.15.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 15:57:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 1/2] Move and rename uptime_s()
Date:   Mon, 21 Oct 2019 15:57:18 -0700
Message-Id: <20191021225719.211651-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021225719.211651-1-bvanassche@acm.org>
References: <20191021225719.211651-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make it easy to use the uptime_s() function from block tests.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/multipath-over-rdma | 9 +--------
 common/rc                  | 9 +++++++++
 tests/nvmeof-mp/rc         | 2 +-
 tests/srp/014              | 2 +-
 tests/srp/rc               | 2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)

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
index 41aee3aaa735..c00f2fe1f463 100644
--- a/common/rc
+++ b/common/rc
@@ -246,3 +246,12 @@ _test_dev_is_partition() {
 _filter_xfs_io_error() {
 	sed -e 's/^\(.*\)64\(: .*$\)/\1\2/'
 }
+
+# System uptime in seconds.
+_uptime_s() {
+	local a b
+
+	echo "$(</proc/uptime)" | {
+		read -r a b && echo "$b" >/dev/null && echo "${a%%.*}";
+	}
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
2.23.0.866.gb869b98d4c-goog

