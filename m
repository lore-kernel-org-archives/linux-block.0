Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8DDC4167B
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 23:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLTXxj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 18:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiLTXxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 18:53:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C60A20188
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 15:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RJvEjCmsZjelPfE9vxNhiRlbVPKcFm3Ull0W0zN5YKU=; b=S+cnVgxJnajUaUCS2Yi+LIKuZM
        vIqkzlYV5Atr50USEF5/esBIx3ZJOd1+Vog2Ez8wtosFX4wDj5PlfaeEZ3rjW9q1jCGqDuC7txzY3
        sc3mzuM7VhzibCNgf9jOEzN7Kkcp2Km3jHf5Gl4wLa08EWbHt7Cgqq4qQpYkxkpsAubOXBdJduIsn
        iRT4g65/3PtR3GPFcuLPH/yh1O8GJkBVpln2AyjapOtHLkMJZt2VP76B7h8Cxt9cvK+5KucTltTHK
        1vVCfHXf08XME/7iUiezwPuOyZ6ehK5x2ZaeeynXY0RYv0G0eHOaxH0fTQ2dOBF2oiBsuzf0GUhh1
        +5hMNXPw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7mQK-00642m-B9; Tue, 20 Dec 2022 23:53:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, bvanassche@acm.org, mcgrof@kernel.org
Cc:     kch@nvidia.com, linux-block@vger.kernel.org
Subject: [PATCH v3 2/2] tests/srp/rc: replace module removal with patient module removal
Date:   Tue, 20 Dec 2022 15:53:24 -0800
Message-Id: <20221220235324.1445248-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221220235324.1445248-1-mcgrof@kernel.org>
References: <20221220235324.1445248-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart had put the remove_mpath_devs() call inside a loop because multipathd
keeps running while the loop is ongoing and hence can modify paths
while the loop is running. The races that multipathd can trigger with the
module refcnt is precisely the sort of races which patient module
removal is supposed to address.

I've tested blktests with this on kdevops without finding any
regressions in testing. srp tests were run with and without
use_siw=1.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/srp/rc | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index 4d504f7bd0cc..a5c0444a958e 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -320,19 +320,10 @@ start_srp_ini() {
 
 # Unload the SRP initiator driver.
 stop_srp_ini() {
-	local i
-
 	log_out
-	for ((i=40;i>=0;i--)); do
-		remove_mpath_devs || return $?
-		_unload_module ib_srp >/dev/null 2>&1 && break
-		sleep 1
-	done
-	if [ -e /sys/module/ib_srp ]; then
-		echo "Error: unloading kernel module ib_srp failed"
-		return 1
-	fi
-	_unload_module scsi_transport_srp || return $?
+	remove_mpath_devs || return $?
+	_patient_rmmod ib_srp || return 1
+	_patient_rmmod scsi_transport_srp || return $?
 }
 
 # Associate the LIO device with name $1/$2 with file $3 and SCSI serial $4.
-- 
2.35.1

