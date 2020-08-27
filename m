Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3B2C433E3
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14176207F7
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="D6qR5M8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgH0TuR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:50:17 -0400
Received: from ale.deltatee.com ([204.191.154.188]:54896 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgH0TtW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 15:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zXeGK/7+sQwwlqdp4+FvdJPQZh6zoxvuHVtp/tDmIC0=; b=D6qR5M8EB2osdSpNYqcFi5o3JU
        MiWBaJJIsQ3oOaQbK1roenXRwyCIZvRhk6HZALlSt7juKT1TAFG+z6M7mP64rPJAkQBdEZjzgwNU0
        +nxDMf3sEiaxqSaS0bS0CCbPODMtY6v1uhQPCwsCj4kmGQlJ7N4xBL4t4yQ6HfEVrj8muXXqZCyh0
        3/RTDnEyAv+Z+Bw4EtLviW0ci5c5QeEHiprb89yh2OudAxWrNORvCk8xEiE8p5pVsZUV+qteFW8K8
        13m9ZPfrqFz46urEIgRqmWv/lStAqp2lV7orJna2EtoTpNNlUkgEovB8JtNLCUvmBBmL8bkwif/ap
        xCyVyQHQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNtg-0000Ce-JP; Thu, 27 Aug 2020 13:49:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNta-0001c5-5n; Thu, 27 Aug 2020 13:49:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 27 Aug 2020 13:49:06 -0600
Message-Id: <20200827194912.6135-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827194912.6135-1-logang@deltatee.com>
References: <20200827194912.6135-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 05/11] nvme: Add common helpers for passthru tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add some simple helpers to setup a passthru target that
passes through to a nvme test device.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/rc | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 8865d543f4c1..9553dc64b05c 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -24,6 +24,17 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_test_dev_nvme_ctrl() {
+	local dev
+
+	dev=$(cat "${TEST_DEV_SYSFS}/device/dev")
+	echo "/dev/char/${dev}"
+}
+
+_test_dev_nvme_nsid() {
+	cat "${TEST_DEV_SYSFS}/nsid"
+}
+
 _cleanup_nvmet() {
 	local dev
 	local port
@@ -146,6 +157,27 @@ _remove_nvmet_subsystem() {
 	rmdir "${subsys_path}"
 }
 
+_create_nvmet_passthru() {
+	local nvmet_subsystem="$1"
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local passthru_path="${subsys_path}/passthru"
+
+	mkdir -p "${subsys_path}"
+	printf 1 > "${subsys_path}/attr_allow_any_host"
+
+	printf "%s" "$(_test_dev_nvme_ctrl)" > "${passthru_path}/device_path"
+	printf 1 > "${passthru_path}/enable"
+}
+
+_remove_nvmet_passhtru() {
+	local nvmet_subsystem="$1"
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local passthru_path="${subsys_path}/passthru"
+
+	printf 0 > "${passthru_path}/enable"
+	rmdir "${subsys_path}"
+}
+
 _add_nvmet_subsys_to_port() {
 	local port="$1"
 	local nvmet_subsystem="$2"
@@ -181,6 +213,55 @@ _find_nvme_loop_dev() {
 	done
 }
 
+_find_nvme_passthru_loop_dev() {
+	local subsys=$1
+	local nsid
+	local dev
+
+	dev=$(_find_nvme_loop_dev "${subsys}")
+	nsid=$(_test_dev_nvme_nsid)
+	echo "/dev/${dev}n${nsid}"
+}
+
+_nvmet_passthru_target_setup() {
+	local subsys_name=$1
+
+	_create_nvmet_passthru "${subsys_name}"
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	echo "$port"
+}
+
+_nvmet_passthru_target_connect() {
+	local subsys_name=$1
+
+	nvme connect -t loop -n "${subsys_name}" >>"${FULL}" 2>&1
+	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
+
+	# The following tests can race with the creation
+	# of the device so ensure the block device exists
+	# before continuing
+	while [ ! -b "${nsdev}" ]; do sleep 1; done
+
+	echo "${nsdev}"
+}
+
+_nvmet_passthru_target_disconnect() {
+	local subsys_name=$1
+
+	nvme disconnect -n "${subsys_name}" >>"${FULL}" 2>&1
+}
+
+_nvmet_passthru_target_cleanup() {
+	local port=$1
+	local subsys_name=$2
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_port "${port}"
+	_remove_nvmet_passhtru "${subsys_name}"
+}
+
 _filter_discovery() {
 	sed -n -r -e "s/Generation counter [0-9]+/Generation counter X/" \
 		  -e '/Discovery Log Number|Log Entry|trtype|subnqn/p'
-- 
2.20.1

