Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAE7C433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 15:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A03C20FC3
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596036078;
	bh=ggN5vPQlwdLsORrTFW8C5v5h3TvmlDoXTxFeQPJAUUU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mQMNRTUjKWkET92Qk7Rkoo5wF3FVniiVuvldeK5VtQU2ieoehRyakQrE/YKeAKcHE
	 qD5GiASH3QL1idePwL8MY2E0TOytF829jNH5uH+3JwrsQm3tgAJN11ipH4UYP7RcfP
	 S4bnD9bMH4Hiota2cm1AhR32dXG8yeXgiQWbDnsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2PVR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:21:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47041 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2PVR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 11:21:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id 74so4835910pfx.13
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 08:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hS9e9YSAvMGDF0Jmes1U9/XCm3nlVfx/AP4j2RDGs1Y=;
        b=l/8goN5rUEnNvRamb5Bar0JMtN/8bavQ4CthzRGSSVpCodrLA+XO5wa/mK8TYACIvS
         A2YpaEQPlDwCWKF7SJf/zYPTfgDblbkRRHyhwMF9iXIG53u7PSAJGlZtm8iLBu7s3hSR
         G4PDxZmBtUKuygc3V88fO/RrmUB7NHjScO3OclNgpvOgYmC/efJ+EyMAcjiJ3bSkU0te
         hO3fLE+SbmUsrT0uSXzDgjz91tKrquIPUhWgkNwgUCFdYge4QbdqgEBUVX2ieMtJPL0+
         VJPwvj1j7ik5ivaNkR3hbzYLfSDu91lBKbs9Ca+LScHyDu0IQeT2rTj331Ra+apVJxb/
         6d+w==
X-Gm-Message-State: AOAM533TI1Y4rdcJssiYmBm3wVymQH1s20cT4IWnBPGCEHBOk2yXl8rG
        0pNAyGCCqa87cPWxXkZoYpg=
X-Google-Smtp-Source: ABdhPJyqbh/h+FfVVOxo41wErlLwTXopaHlSSmMq819JJjBxetF8Lp02vEY5gBVoViiUaFc3gzdZKA==
X-Received: by 2002:aa7:92cb:: with SMTP id k11mr1452155pfa.233.1596036076398;
        Wed, 29 Jul 2020 08:21:16 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id nk22sm2561477pjb.51.2020.07.29.08.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:21:15 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4A42940945; Wed, 29 Jul 2020 15:21:14 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     Sebastian.Chlad@suse.com, daniel.wagner@suse.com, hare@suse.com,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] common/multipath-over-rdma: make block scheduler directory optional
Date:   Wed, 29 Jul 2020 15:21:13 +0000
Message-Id: <20200729152113.1250-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We currently fail if the following tests if the directory
/lib/modules/$(uname -r)/kernel/block does not exist. Just make
this optional. Older distributions won't have this directory.

srp/001
srp/002
srp/013
srp/014

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/multipath-over-rdma | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 676d283..f004124 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -696,10 +696,13 @@ setup_test() {
 
 	# Load the I/O scheduler kernel modules
 	(
-		cd "/lib/modules/$(uname -r)/kernel/block" &&
-			for m in *.ko; do
-				[ -e "$m" ] && modprobe "${m%.ko}"
-			done
+		KERNEL_BLOCK="/lib/modules/$(uname -r)/kernel/block"
+		if [ -d $KERNEL_BLOCK ]; then
+			cd $KERNEL_BLOCK &&
+				for m in *.ko; do
+					[ -e "$m" ] && modprobe "${m%.ko}"
+				done
+		fi
 	)
 
 	if [ -d /sys/kernel/debug/dynamic_debug ]; then
-- 
2.27.0

