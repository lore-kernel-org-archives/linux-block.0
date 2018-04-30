Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756365AbeD3TpY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 15:45:24 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: damien.lemoal@wdc.com
Cc: hare@suse.de, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH dm-zoned-tools 2/2] README: fix example script
Date: Mon, 30 Apr 2018 12:45:20 -0700
Message-Id: <20180430194520.9065-2-mcgrof@kernel.org>
In-Reply-To: <20180430194520.9065-1-mcgrof@kernel.org>
References: <20180430194520.9065-1-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The target type should be "zoned", not "dm-zoned".

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

The README does note explain if one should use dmzadm to format a drive
if using dm zone or only if one is to use a filesystem which supports
zones, such as f2fs. Or if we should *always* use dmzadm format regardless
of the circumstance.

Could this be clarfied? What are the downsides to not using dmzadm
format on a drive and say a user just going straight to use the dm zone
and then mkfs on top of it?

diff --git a/README b/README
index 7762694..9aea28e 100644
--- a/README
+++ b/README
@@ -184,7 +184,7 @@ options="$@"
 
 modprobe dm-zoned
 
-echo "0 `blockdev --getsize ${dev}` dm-zoned ${dev} ${options}" | \
+echo "0 `blockdev --getsize ${dev}` zoned ${dev} ${options}" | \
 dmsetup create zoned-`basename ${dev}`
 ]]
 
-- 
2.17.0
