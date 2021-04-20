Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079FC433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A332613CD
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 16:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhDTQ0d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhDTQ0c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 12:26:32 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932D9C06174A
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 09:25:59 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id f19-20020a056a0022d3b02902608c8a75e0so2998102pfj.13
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w4P4bl96nfTU9TN2I1VG4xof40yu3Q9O1ZEOPxGBTVY=;
        b=QFSjfe/QUuthXxK8cRCA01d+9Br8F12lmfmBda2JHej7P3JBhcFiP6059cPOprXh57
         h4aceVxZrdwJnqc7799ABc25KoKK40nQAEo0n6itJkv8pZGQtZ0dEn+Xs27yg62+WmUw
         EJRV8qiJUidXQubiqQjFqdxd18rykQ0iyGeRE9lLA51NNYC/5b1iF6ShshWx42vaw2JQ
         X9ZJfRkaejCymz6L2FN3W8Av8vDlw888CW0hq3Ea8kRx5SyUYJIORS3cnu74mF9n6xX4
         lsCKRh+//uhYaGN2ZCIXwzee6r3VhJTDsv/9h7+P1zkeNSc/MbeYtHWuQpERYGnEmO27
         7pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w4P4bl96nfTU9TN2I1VG4xof40yu3Q9O1ZEOPxGBTVY=;
        b=lIpB2bbIZ03KxRYMW4Gl01Pzv4RuC3A4y8tM7sLaZyO5DlQPQF+ISV097UV6I3Esk6
         nCTqXogzrVvmOsfh3Wagi8cA6ewAEAEifIfQgcIN3WnYlq2owqqg1DuK2VhlpalEA8k8
         QBBULC2AlDW2TJn21eobwOENy1GnZT3ljTK0Nw1jUD4ufaaTVM9H4FJwQmp7kF0C50x0
         81E6mh/4Av6mExb2hBYkXz7ezqgvS4aJI1HFqLrenVsVET5Wd9k6HrlCqQ99FxZkMkUb
         a81EId9uA6anvEuOJYQ6sDTuKEocyaZPemmBZbK3rnFFOHXWh0ZyfVz/LDQd05W8NwYT
         CeTw==
X-Gm-Message-State: AOAM533lG2fn9dTrCg1+OPLrJ7Y3sWPF4b3jVxMxPGGlgMXBT2Dty8NJ
        K9GwUfWIURQ606OyXOIVsLNZMc57CXPeXA==
X-Google-Smtp-Source: ABdhPJxEn0Ex7eVOLTlXGP9gTkeBV0++MdXr1WWO2IWd1/PMvRW0UcSCC/ZE9kFs4P2PnAP8mjMrlsZCDkhmeQ==
X-Received: from egcloud.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:35b5])
 (user=egranata job=sendgmr) by 2002:a62:7642:0:b029:25c:7cdd:3cf4 with SMTP
 id r63-20020a6276420000b029025c7cdd3cf4mr16276312pfc.9.1618935959100; Tue, 20
 Apr 2021 09:25:59 -0700 (PDT)
Date:   Tue, 20 Apr 2021 16:25:56 +0000
Message-Id: <20210420162556.217350-1-egranata@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH] Provide detailed specification of virtio-blk lifetime metrics
From:   Enrico Granata <egranata@google.com>
To:     virtio-dev@lists.oasis-open.org
Cc:     egranata@google.com, hch@infradead.org, mst@redhat.com,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the course of review, some concerns were surfaced about the
original virtio-blk lifetime proposal, as it depends on the eMMC
spec which is not open

Add a more detailed description of the meaning of the fields
added by that proposal to the virtio-blk specification, as to
make it feasible to understand and implement the new lifetime
metrics feature without needing to refer to JEDEC's specification

This patch does not change the meaning of those fields nor add
any new fields, but it is intended to provide an open and more
clear description of the meaning associated with those fields.

Signed-off-by: Enrico Granata <egranata@google.com>
---
 content.tex | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/content.tex b/content.tex
index 9232d5c..7e14ccc 100644
--- a/content.tex
+++ b/content.tex
@@ -4669,13 +4669,32 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 \end{lstlisting}
 
 The device lifetime metrics \field{pre_eol_info}, \field{device_lifetime_est_a}
-and \field{device_lifetime_est_b} have the semantics described by the JESD84-B50
-specification for the extended CSD register fields \field{PRE_EOL_INFO}
-\field{DEVICE_LIFETIME_EST_TYP_A} and \field{DEVICE_LIFETIME_EST_TYP_B}
-respectively.
+and \field{device_lifetime_est_b} are discussed in the JESD84-B50 specification.
 
-JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
-pursuant to JEDEC's licensing terms and conditions.
+The complete JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
+pursuant to JEDEC's licensing terms and conditions. For the purposes of this
+specification, these fields are defined as follows.
+
+The \field{pre_eol_info} will have one of these values:
+
+\begin{lstlisting}
+// Value not available
+#define PRE_EOL_INFO_UNDEFINED    0
+// < 80% of blocks are consumed
+#define PRE_EOL_INFO_NORMAL       1
+// 80% of blocks are consumed
+#define PRE_EOL_INFO_WARNING      2
+// 90% of blocks are consumed
+#define PRE_EOL_INFO_URGENT       3
+// All others values are reserved
+\end{lstlisting}
+
+The \field{device_lifetime_est_typ_a} refers to wear of SLC cells and is provided in
+increments of 10%, with 0 meaning undefined, 1 meaning up-to 10% of lifetime used, and so on,
+thru to 11 meaning estimated lifetime exceeded. All values above 11 are reserved.
+
+The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided with
+the same semantics as \field{device_lifetime_est_typ_a}.
 
 The final \field{status} byte is written by the device: either
 VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
@@ -4812,7 +4831,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 or UFS persistent storage), the device SHOULD offer the VIRTIO_BLK_F_LIFETIME
 flag. The flag MUST NOT be offered if the device is backed by storage for which
 the lifetime metrics described in this document cannot be obtained or for which
-such metrics have no useful meaning.
+such metrics have no useful meaning. If the metrics are offered, the device MUST NOT
+send any reserved values, as defined in this specification.
 
 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
 When using the legacy interface, transitional devices and drivers
-- 
2.31.1.368.gbe11c130af-goog

