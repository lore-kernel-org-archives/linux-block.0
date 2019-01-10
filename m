Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF9AC43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50586214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LqQ3M1/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfAJJiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:38:11 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25576 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfAJJiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113097; x=1578649097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jVwSaPPGPxBy8T2rj8Y+/TioJuCb2a9sAlKrvvDZMcQ=;
  b=LqQ3M1/+R5oR8o2jGitebuC70UAELSXg/Qt9ct+Q87YB5piwwgOJQhHc
   wqdFSX/FwYuV88i76mJwmv47TbmV+2klkdI6F/0V+A6GRrSsy5Y/obHGf
   1i8cuL7Ou897WNVjSk0ua6ubr1SdIgRrutavB5Z1N5Dem+h1km6whpGye
   auZ/nWhQ10h+K2cNem+H9DcdxFVNFPmgvVxcfTkCsixxHIG3mgj8hfUF+
   9QEh8FGhgss+P3iekyQ9YzNlrBm5U/ZgMEu9TiAXlRzj/t/aSvnfJu7+s
   rT8Knxc0BVnt9sGbwLBXHb7JZrJRmGzzV52xYzGM780+zONg49p8wxXvK
   g==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="196469022"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:16 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:19:42 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:38:08 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v2 10/16] common: Introduce _dd() helper function
Date:   Thu, 10 Jan 2019 18:37:19 +0900
Message-Id: <20190110093725.32675-11-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To analyze dd command failures found by blktests, need to confirm dd
command options. Introduce the helper function which executes dd and
records dd command options in FULL file for quick analysis.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/common/rc b/common/rc
index 0b99e84..190e450 100644
--- a/common/rc
+++ b/common/rc
@@ -246,3 +246,34 @@ set_scheduler() {
 		return 1
 	fi
 }
+
+# Issue dd command with five arguments and record command line in FULL file.
+# args: target device, r/w, start sector, sector len, block size in bytes
+_dd() {
+	local target_dev=${1}
+	local rw=${2}
+	local -i start_sector=${3}
+	local -i start_byte=$(( start_sector * 512 ))
+	local -i sector_count=${4}
+	local -i bs=${5}
+	local -i block_count=$(( sector_count * 512 / bs ))
+
+	local _cmd="dd bs=${bs} count=${block_count}"
+
+	if [[ ${rw} = "read" ]]; then
+		_cmd="${_cmd} if=${target_dev} of=/dev/null"
+		_cmd="${_cmd} iflag=skip_bytes skip=${start_byte}"
+	elif [[ ${rw} = "write" ]]; then
+		_cmd="${_cmd} if=/dev/zero of=${target_dev}"
+		_cmd="${_cmd} oflag=seek_bytes,direct seek=${start_byte}"
+	fi
+
+	echo "${_cmd}" >> "$FULL" 2>&1
+
+	if ! eval "${_cmd}" >> "$FULL" 2>&1 ; then
+		echo "dd command failed"
+		return 1
+	fi
+
+	sync
+}
-- 
2.20.1

