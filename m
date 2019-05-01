Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44519C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9FB20866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Av+W0aiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfEAE2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:28:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9392 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfEAE2v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556684932; x=1588220932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tgnlW100bAVPltHviwzLPX/wODtBzPmUp+r3uZEoQqw=;
  b=Av+W0aiFeAUO7hLxOuEwh6oA/DvvJCXvENJrFqbD1LdSlTlyEdgxsd45
   8dmKupYZc6noaWkzNIXe4pjBlhxJyLZJAmI8dvQqFmkDnObN5z3dhol/Z
   ieM5+BV7gDwVDvgYzCLWR5joVcUuAueyAiOa6Kr1dNsYx3r35arkekeAa
   k5kofmQJAFaGciHBAPbp/cz0rOi6eM2HO2MpAUDELb8HqiYbjKRz3BC3L
   ZS72YIYsVk80Q1F3gTQ3YBGgB6x/IR00eDNLpQHLbHjke6B0znBdiRlYw
   +MJj1rOD13T8W7qGL/A5ofsHPa6vqD70XQj3uUZbAXk4Rn7IpeS7xUe9I
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="108436749"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:28:52 +0800
IronPort-SDR: jGVoatQf6DukUibKbrG8T/C9xXlIewDUQ6UcR0+jeZx3M9A6E1l+iO02HvXwLX+9RpSikdowbw
 9/B1Rz+52yeamjdjCBKARsJlAMi21cnD0S7bMyauE7N68KT1I0hyHYjMj/bM5PeFQ7oowtATUe
 kWDwnXtCXDy/qfOr3KAX10gCJubMlnoY+YsmT7YaV2PCMkePt3jZ1qNC/4VRlr3hnPNUMRutgw
 uewScgqXsW2fekIWhedO3PCewzNHrIOIC34AJFJKJRqQ0Ru3QhKGMTM6cXgd4M5ET9PfE5B9DE
 aCr8ZS7JE6q7G2ocuimOq4BT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:20 -0700
IronPort-SDR: 3ybr8MmRhHo8fChxtAC59g1cECUb1NYgwwl3KEem5M6f7944xX+JZTeVnDQAkvXjgET5pAq+NW
 6rP3YgLD1A3FJsmvxpXYdyftziT8wQ1IybuttIsWGWQYElM3UggEdwVxm4vHO+WYkPG9EUJb4C
 YkZ/IcinbA5ncK9B2aKQYf536Z9TxweDtJdbIOo0Zwq1UkSJJzQpfJBTR/zfOcH03mIfh2ngU9
 HKX4nSByzi2eR1DO/uW8EY9BGpsAk1ijmYcIqKdJkTHc0gOJ06W3OUlvPycXa9sWM5Ze+wKpz6
 e5c=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:28:51 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 04/18] kernel/trace: add KConfig to enable blktrace_ext
Date:   Tue, 30 Apr 2019 21:28:17 -0700
Message-Id: <20190501042831.5313-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add kernel kconfig option for blktrace extension.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/Kconfig | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 8bd1d6d001d7..5f8c938e495f 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -456,6 +456,31 @@ config BLK_DEV_IO_TRACE
 
 	  If unsure, say N.
 
+config BLKTRACE_EXT
+	bool "Support for tracing block IO actions extensions like priority"
+	depends on BLK_DEV_IO_TRACE
+	depends on BLOCK
+	select TRACEPOINTS
+	select GENERIC_TRACER
+	select STACKTRACE
+	help
+	  Say Y here if you want to be able to trace the extended block layer
+	  actions on a given queue. Tracing allows you to see any traffic
+	  happening on a block device queue with this extension one can see
+	  the request like write-zeroes and zone reset along with the request
+	  priority. For more information (and the userspac support tools
+          needed), fetch the blktrace tools from:
+
+	  git://git.kernel.dk/blktrace.git
+
+	  Tracing also is possible using the ftrace interface, e.g.:
+
+	    echo 1 > /sys/block/sda/sda1/trace/enable
+	    echo blk > /sys/kernel/debug/tracing/current_tracer
+	    cat /sys/kernel/debug/tracing/trace_pipe
+
+	  If unsure, say N.
+
 config KPROBE_EVENTS
 	depends on KPROBES
 	depends on HAVE_REGS_AND_STACK_ACCESS_API
-- 
2.19.1

