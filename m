Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31673 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757081AbeFSUX4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jun 2018 16:23:56 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 1/9] common/rc: Fix _have_tracepoint()
Date: Tue, 19 Jun 2018 13:23:45 -0700
Message-Id: <20180619202353.23631-2-bart.vanassche@wdc.com>
In-Reply-To: <20180619202353.23631-1-bart.vanassche@wdc.com>
References: <20180619202353.23631-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make sure that _have_tracepoint() uses the argument passed to that
function instead of using an undefined variable.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 common/rc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/rc b/common/rc
index 7f1728025364..7592400dda82 100644
--- a/common/rc
+++ b/common/rc
@@ -112,6 +112,8 @@ _have_tracefs() {
 }
 
 _have_tracepoint() {
+	local event=$1
+
 	if [[ ! -d /sys/kernel/debug/tracing/events/${event} ]]; then
 		SKIP_REASON="tracepoint ${event} does not exist"
 		return 1
-- 
2.17.1
