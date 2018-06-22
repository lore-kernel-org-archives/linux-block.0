Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59818 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933753AbeFVWTr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:47 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests 01/15] common/rc: Fix _have_tracepoint()
Date: Fri, 22 Jun 2018 15:19:32 -0700
Message-Id: <20180622221946.10987-2-bart.vanassche@wdc.com>
In-Reply-To: <20180622221946.10987-1-bart.vanassche@wdc.com>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
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
