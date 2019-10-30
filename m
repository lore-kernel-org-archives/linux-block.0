Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C955CA9EC7
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A5E2080F
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 19:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O1BJxm2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfJ3TxF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:53:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25749 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJ3TxF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 15:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572465185; x=1604001185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7W8UQyH9VKozvCDdJfCBpq1x6IqZopmBHKyNCZoGU6E=;
  b=O1BJxm2AJmnQ83dUzuEeVJbE/fPaO/4nwI78IhrZsKfSa90lZP5c22b2
   iQf4FtxS8UASR3yVSxMU8VYEm6YLL1sv1Kvng1+9N0kMg4xpIWZuh8TbG
   SVVFhBvf7HTV8pjmrbJrT6BdJvK7Ud3T3TRR2Saj/uTorr2jqu4WJifpO
   YRp1MfXEjXXJYC1QrB84qyD96iPjZ9/dQreWOA4HbsGQFtUEO7XS2KBQJ
   D26pSuP3qzQLAJn6Ruw6V0hUrHrtVHzwv6d9/pFoc2G4lfzMJAI43djDw
   NlKzAWAqarS3w0Ode6liG+LV280Lqp5UveoWpcDm02O16A/QbmpHytP2+
   Q==;
IronPort-SDR: kgPymFQJLi0OY4sVcQyNTHrfbJFnUjLxyzyA0fDcTZuZHD7GhcSlavu0CVAicUFXl9OMhJl/WW
 3AMCE0AOpz/0hbIAmZaoIQkzQuERU1iZ7TO/Xxkg9dGDkJvz3lJi+Ck+bNJB0rrGDvNJxwDVaW
 geBADYExR2LSGOB5F8nhd+UevFXp2BcKfkFr6VZ5FjguyF/wZsIRRxGvoK7sUKWnI59Wfa3lkD
 b6HvMLx7fIfAbvOC/sVQQdSF4wnzvVrre9YWQ6Pvayu8ZXNln/dw1axl3xHBzjzclid3cdLyOj
 ZyA=
X-IronPort-AV: E=Sophos;i="5.68,248,1569254400"; 
   d="scan'208";a="126145672"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2019 03:53:05 +0800
IronPort-SDR: 3n6pR4W6bfodqOq9QseL3C3QHDeGbcksCLeq8gikj34A4LE5N1JMXTa4YadyPPDB2GirOG+z8b
 2tIpeQBhhtQNrXPvXGwf3B8OqE2pbBPDbk5G18RsSJ0C6Jt1WZfwUCRWuvWXA9+8UrfvGvmWOl
 ttu5o29qym0p0827hHVTBC4MZbU0RrVSVA24E2v0obqCs3xzFXSwOlwQkdrlizNQEvFhP9FgaZ
 chd9f+A2ON5jlFqA6sYsiI2L6wijn0CA0CmEZgN7Eqj8h8VDVJxRQbuZ+LqGcrkkTAqwxrpi7L
 bjKfLNYo3kN7HWZbgoVlGV/S
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 12:48:27 -0700
IronPort-SDR: ycSuKK3J0jDjgYw8W0XWpmrdY7HzS8Lls+QUuuV7fIgEUpyTGqYNR9vNtsF5AdiR4y5ZnjB8GC
 zESwco+E10/WUhhH0O6JR2cWTfvyH8/rKNETBQn7vLREfp/tv0yWqaJnRLv66tgYYp+rx3Kkbu
 ELUu8oyXkpEZG1EycgFjIgzC3kGkD8MtPYUrmH/hdI7k9e0MK653uVpwYnPR/cYA6ieomVZiFd
 W+sFA8pNBza7efbeeZqlJU2Ouh/8DcfLvw+OfqQTrQKzvYuYwfgyu+EdEf1cGojUTvsvcTmpIp
 hKc=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2019 12:53:05 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [blktests PATCH 1/2] nvme: handle model attr in subsys create helper
Date:   Wed, 30 Oct 2019 12:52:57 -0700
Message-Id: <20191030195258.31108-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191030195258.31108-1-chaitanya.kulkarni@wdc.com>
References: <20191030195258.31108-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch allows _create_nvmet_subsystem to handle and optionally
set model attribute for the subsys.
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 40f0413..2d11e2e 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -121,10 +121,14 @@ _create_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local blkdev="$2"
 	local uuid=$3
+	local model=$4
 	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
+	if [ -f "${cfs_path}/attr_model" ] && [ ! -z ${model+x} ]; then
+		echo -n ${model} > "${cfs_path}/attr_model"
+	fi
 	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
 }
 
-- 
2.22.1

