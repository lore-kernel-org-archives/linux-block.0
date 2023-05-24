Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C37C7EE23
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 03:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbjEXDHE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 23:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbjEXDHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 23:07:01 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8582B3
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 20:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1684897612; i=@fujitsu.com;
        bh=PPANGGd9VGrzdHuFb2ggj+mYc7g1DO8EDGsxpIuui3s=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=kTNNpWH3yN9aDwfY9j6lVK+j0DTn2VATe/Ia9SNocmCNxYsNHF5eBeRN6QjXs+RPX
         ooOUd8+4xlPZNnJT7EuhE30BriPJ9z/T0Y9B3sxavcdYAB+18dToxRvhI+1cyAdRzO
         h84EeuTcL7i8y0DLEYk1cVn7SeKp8S4srUUAitLhAewV8XDJk2Mupyc/OnIo5gJVvw
         tih1kMfUroS9PanhxmxxDmTsIA9HWhifbTqI+mgqtNbWWZ4nKwumdC+KuWI4wIk6Xz
         BvXxZNflffCHdvt8CbwYlXAOKRz8tMUSvJCNChPbdFIkPA+3M0P5blzpNlruIgi+lH
         vgf2wToC/BgjQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRWlGSWpSXmKPExsViZ8ORpOtVn5t
  i8HmrgcXhx5PYLfbe0rbYN8vTgdlj8+lqj8+b5DzaD3QzBTBHsWbmJeVXJLBmrPnTz1RwgK3i
  0afJTA2Mx1m7GLk4hAQ2Mkq8ntfABuGsYpTY3rkYKMPJwSagJrFz+ksWEFtEQF5i5exmsDizQ
  IjE0j2bmEFsYQF/iYerZ4LVsAioSkzc+hBoEAcHr4CVxJTeApCwBFDrza79YOW8AoISJ2c+YY
  EYIy/RvHU2M0SNmsTVc5uYJzDyzEJSNgtJ2QJGplWMpsWpRWWpRbpmeklFmekZJbmJmTl6iVW
  6iXqppbrlqcUlukZ6ieXFeqnFxXrFlbnJOSl6eaklmxiBAZZSrKi5g/HDzr96hxglOZiURHl5
  vmanCPEl5adUZiQWZ8QXleakFh9ilOHgUJLgzarITRESLEpNT61Iy8wBBjtMWoKDR0mE93AwU
  Jq3uCAxtzgzHSJ1ilFRSpy3qgYoIQCSyCjNg2uDRdglRlkpYV5GBgYGIZ6C1KLczBJU+VeM4h
  yMSsK8D0HG82TmlcBNfwW0mAloseq8bJDFJYkIKakGJsnnJ78YJivc9d3AvGDrbo5rIvbhX1h
  nzb9Vav1GckP+/veqVb/iOcJlhFODV9+Oz64q2H87cW1zCIvoKhc15Qc/Eoxc3jJYqPi/LPi0
  p/n6lDPLd8oaxqYfF4nKlX0mUZD564VuXK6l1bJPLnPPc19MM3btU61bXn1AiOvI/iVMM5Yp6
  u790shV1ho75VWYtItASb/4E4tXN3hbqn5H1nn12oe9itSTE5iy+lXkg28ZGat5jYQjXn39os
  8T5/h0qazV55avbt0PO9Yscml78vT28Z/r7vGsEpihICHUc9X54+qlVsq1rCU7N1ZY7NG5WH0
  kf99sRQfP2meOkVelXs95+eDfC68rypuSGKXilViKMxINtZiLihMB/34OtCsDAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-4.tower-565.messagelabs.com!1684897610!141558!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24085 invoked from network); 24 May 2023 03:06:50 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-4.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 May 2023 03:06:50 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 83E0C1B3;
        Wed, 24 May 2023 04:06:50 +0100 (BST)
Received: from localhost.localdomain (unknown [10.167.215.54])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 4A3F11AF;
        Wed, 24 May 2023 04:06:47 +0100 (BST)
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     shinichiro.kawasaki@wdc.com
Cc:     linux-block@vger.kernel.org, dwagner@suse.de,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH blktests v2] srp/rc: Replace _have_module() with _have_driver()
Date:   Wed, 24 May 2023 11:06:43 +0800
Message-Id: <20230524030643.404546-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

srp test group can be executed with built-in scsi_dh_alua,
scsi_dh_emc and scsi_dh_rdac drivers.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tests/srp/rc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index fb3a113..252fd0c 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -37,6 +37,9 @@ group_requires() {
 	fi
 	_have_driver sd_mod
 	_have_driver sg
+	_have_driver scsi_dh_alua
+	_have_driver scsi_dh_emc
+	_have_driver scsi_dh_rdac
 
 	_have_module dm_multipath
 	_have_module dm_queue_length
@@ -50,9 +53,6 @@ group_requires() {
 	_have_module rdma_cm
 	_have_module rdma_rxe
 	_have_module scsi_debug
-	_have_module scsi_dh_alua
-	_have_module scsi_dh_emc
-	_have_module scsi_dh_rdac
 	_have_module target_core_iblock
 	_have_module target_core_mod
 
-- 
2.40.1

