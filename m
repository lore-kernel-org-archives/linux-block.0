Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87637C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5D82086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GIRwV1Yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfARJpn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:45:43 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8856 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbfARJpn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 04:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547804744; x=1579340744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wONpaa8KC9keYspWe5/MYQFaOwEXehto04D3/Q6+B3w=;
  b=GIRwV1YddwvkEDdz5Q9zUEfKuSDaCgraGWzhbg2CaxHE7MiZiAOKQZiD
   tC8AMRv9zWgnhU9blSVQXNFSs6r6M6IGLI7rjk1fkO07qezhW6liop4FQ
   fijzlaI5IadrNLA3sPLAwJEzTrpfc1bhfgcE7+D3SJ1OHVqmN0s1gKSWZ
   8bZqrJfBFQD1GqcsD0V9Oet08DoripPtHS2ZpBI/Dm+67tfhejwD4uVJ+
   28zKN2ledMyTrJV4tSEhLZY0pHP/A253Dj9FsZgWYr0B06ErhzoFeQW1b
   MyYRd1GRAb8xnm6cHCNOKmqmhsOwK65mDI+7RMrNezvE3yUfUNDMwd/SV
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="99182284"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 17:45:25 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 18 Jan 2019 01:26:43 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2019 01:45:21 -0800
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
Subject: [PATCH blktests v3 06/13] common: Introduce _dd() helper function
Date:   Fri, 18 Jan 2019 18:44:46 +0900
Message-Id: <20190118094453.13773-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To analyze dd command failures found by blktests, need to confirm dd
command options. Introduce the helper function which executes dd and
records dd command options in FULL file for quick analysis.

Reviewed-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/common/rc b/common/rc
index 153a323..fe0e5d8 100644
--- a/common/rc
+++ b/common/rc
@@ -214,3 +214,34 @@ _test_dev_in_hotplug_slot() {
 _filter_xfs_io_error() {
 	sed -e 's/^\(.*\)64\(: .*$\)/\1\2/'
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

