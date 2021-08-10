Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C6AC4320A
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86DFB61051
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbhHJFuK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:50:10 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9539 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbhHJFuH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 01:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628574586; x=1660110586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EIH026mlpK847URWOEkIJeSWTxgkrb13VQ8oOv5tb/A=;
  b=W/vrfAB++7+dIyU65/qyfAqk25H0rpuz6DJYEmRf5z5zrPyG4trrrJVJ
   FGlvhkqO+5Nql9XzhCEX7fDKN0a7WjgUguMzg22jipx7YOdSK6Rk/RHPK
   GpzwEx6PBZ1kavxzntlF+pa+Ak31AnDY9OtmP23aofCK7RHQEi/onRopN
   ZM4q5tWA0aEIK5zsHBkxqgqh+pNYcBzr1kqmMYP92BB7+g/26hoQ5Fvbw
   EaNmBRBDEkF3yKTISVn6p88Kgt0EEqqVJUbKLdNlIeL2BT94rKL9lGzlh
   kX1aN+HxBh9Y0Mix/ZPN/CrWl/iG222GHThlD+3/8uhz0YVSDKHFtaf4o
   g==;
X-IronPort-AV: E=Sophos;i="5.84,309,1620662400"; 
   d="scan'208";a="288340183"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 13:49:46 +0800
IronPort-SDR: Kb7wDenXCx/erdHc/4+ScDfo4vyH5oypjl5PmWBwcXX+Qce2OI1UmG9dSVjZR1jCCPBxpVIlj+
 Jk8xGO3l7lmNwUejqVTvo0SesTiBPDut+3WpwJ0OjnkixgCFY0UbX3IDxMGEAsTX1UW4XgD0Yy
 37D9Gt03o0TVhWosxdi0hQKUcscTr61LhpKqf7hB8Whibftz474TeY+YQFEvgQZINiLuen08MO
 lTPSOmvoq+o+Wtf1w8RMVWrHaOyX5qjRwUroF8aGVMN7T1uG3vXh6fV47hAloeb193y6ele8JN
 JumD08tTIdufpgp2BkNmWWVP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 22:27:08 -0700
IronPort-SDR: KaFeV7Cda16g3sRUQjPK5JqRL9J2DfaUq6F+e/1p+iIWNL6gtSv3Jakgm0wpeE4El5W8G685uE
 bf0u3hkGePxYeKOJ0o27+waUb4hUBoVIAXUbR6HntoICAWYKneMFSF/Q8jk2tsZYZTIdQAU6pk
 vy80cFqLypyYaJosfsAmO0JJuhmBjNBYp/+767S8PYesbG57kayDkQO2/Pfcp4kFQuAFR0dnzQ
 yBK/3dUHEOxBw9vPWV7E69IwspYvJD31MaiTkMv01qOog6y5Y7xp+NRVtU1JzhTblMVsmP0Iqs
 Mt4=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2021 22:49:45 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v5 2/9] libata: fix ata_host_start()
Date:   Tue, 10 Aug 2021 14:49:32 +0900
Message-Id: <20210810054939.30760-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810054939.30760-1-damien.lemoal@wdc.com>
References: <20210810054939.30760-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The loop on entry of ata_host_start() may not initialize host->ops to a
non NULL value. The test on the host_stop field of host->ops must then
be preceded by a check that host->ops is not NULL.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b237a718ea0f..d3f7830bda2e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5583,7 +5583,7 @@ int ata_host_start(struct ata_host *host)
 			have_stop = 1;
 	}
 
-	if (host->ops->host_stop)
+	if (host->ops && host->ops->host_stop)
 		have_stop = 1;
 
 	if (have_stop) {
-- 
2.31.1

