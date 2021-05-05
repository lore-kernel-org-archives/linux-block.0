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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A7C433B4
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 19:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5690261175
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 19:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhEETh6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 May 2021 15:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhEETh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 May 2021 15:37:58 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB81C061574
        for <linux-block@vger.kernel.org>; Wed,  5 May 2021 12:37:01 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id h4-20020ac858440000b029019d657b9f21so1784646qth.9
        for <linux-block@vger.kernel.org>; Wed, 05 May 2021 12:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DECfES4gltk1bCrgnt3DA92sSGOoRfPZbukm1as2NRM=;
        b=RsL7w+3qCdYSOGhyGuVk3nLK2EQXR0FZjtCl/dEdh3r+XEMyTQFWcXp8MSpRSLdj0W
         +7BY1cfbkwmLKyN0u/gonChxdMNlJTs5b3GaSD0uSl4l8x3p0aZIuZ0tNhPxVDAT273r
         i2sLjN1SQo+2cccE2PXr5CUM1cZuZc9gSbF1nJWH3FRXiTxAyfjIkMGOMwUhfVNHDGOZ
         Fn5MjkLlP+B5Idnkw/n6Bp8UQSt2faaYBAjVPmvrlD0E8OR25voyr09tR9OfipXTcJLo
         I7qEgvVMPz+s4J90dCwycIEW4/WastVt7a0nXPubihLwA6tOOhlgMhrhqVzYAjHu8Gq4
         B56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DECfES4gltk1bCrgnt3DA92sSGOoRfPZbukm1as2NRM=;
        b=sjSN/2YmN3RI3bSUo4o9YbrDj6H6w09nyfmOpLkMAwdiqMMeb61npS8oCk/0sk0pk5
         efL3IBOioA+ZyKZTSVc2omXgtRbY+SjS4UbQu90xmCuOQhuVjKrOJ1rF7YcSLXWR/u8F
         YzRr94/S4JZxh5AhFuTOBQwbKW2rvheHCCwTV2WAkm/IQfOlsXu6gHFQb3yleVSetAf5
         mHXdfFke3+dBU+OZ0rV0aSXmPfE4I4CpighAAO2JW78CTLMVShI+QCrmv51NTTmwWyF0
         CGtntiJ5b1Q0MgJsDst6o4WC0DWN5mCY9xZv+gc3XgMcY6zv9Cgm2P6V1O0WCmmbkDwA
         5aRA==
X-Gm-Message-State: AOAM530dVte1T1e+gA75/T64D3iPP0ug+axNICJKlGoxpbSeKhgH9Wlh
        dbrQ8/pCiVfyP5hqdbuaFRv43jc3MA662w==
X-Google-Smtp-Source: ABdhPJxcSbaZd/VNzzgcAf4t0YfTjs+M85HlbNuGMf10RB7z2Gqd57PEJtS5OVDUzji6XtqucefjnoWIhRzHCw==
X-Received: from egcloud.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:35b5])
 (user=egranata job=sendgmr) by 2002:a0c:8d07:: with SMTP id
 r7mr625802qvb.7.1620243420349; Wed, 05 May 2021 12:37:00 -0700 (PDT)
Date:   Wed,  5 May 2021 19:36:55 +0000
Message-Id: <20210505193655.2414268-1-egranata@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2] Provide detailed specification of virtio-blk lifetime metrics
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
Changes in v2:
  - clarified JEDEC references;
  - added VIRTIO_BLK prefix and cleaned up comment syntax;
  - clarified reserved block references

 content.tex | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/content.tex b/content.tex
index 9232d5c..804383a 100644
--- a/content.tex
+++ b/content.tex
@@ -4668,14 +4668,28 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 };
 \end{lstlisting}
 
-The device lifetime metrics \field{pre_eol_info}, \field{device_lifetime_est_a}
-and \field{device_lifetime_est_b} have the semantics described by the JESD84-B50
-specification for the extended CSD register fields \field{PRE_EOL_INFO}
-\field{DEVICE_LIFETIME_EST_TYP_A} and \field{DEVICE_LIFETIME_EST_TYP_B}
-respectively.
+The \field{pre_eol_info} specifies the percentage of reserved blocks
+that are consumed and will have one of these values:
 
-JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
-pursuant to JEDEC's licensing terms and conditions.
+\begin{lstlisting}
+/* Value not available */
+#define VIRTIO_BLK_PRE_EOL_INFO_UNDEFINED    0
+/* < 80% of reserved blocks are consumed */
+#define VIRTIO_BLK_PRE_EOL_INFO_NORMAL       1
+/* 80% of reserved blocks are consumed */
+#define VIRTIO_BLK_PRE_EOL_INFO_WARNING      2
+/* 90% of reserved blocks are consumed */
+#define VIRTIO_BLK_PRE_EOL_INFO_URGENT       3
+/* All others values are reserved */
+\end{lstlisting}
+
+The \field{device_lifetime_est_typ_a} refers to wear of SLC cells and is provided
+in increments of 10%, with 0 meaning undefined, 1 meaning up-to 10% of lifetime
+used, and so on, thru to 11 meaning estimated lifetime exceeded.
+All values above 11 are reserved.
+
+The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided
+with the same semantics as \field{device_lifetime_est_typ_a}.
 
 The final \field{status} byte is written by the device: either
 VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
@@ -4812,7 +4826,17 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 or UFS persistent storage), the device SHOULD offer the VIRTIO_BLK_F_LIFETIME
 flag. The flag MUST NOT be offered if the device is backed by storage for which
 the lifetime metrics described in this document cannot be obtained or for which
-such metrics have no useful meaning.
+such metrics have no useful meaning. If the metrics are offered, the device MUST NOT
+send any reserved values, as defined in this specification.
+
+\begin{note}
+  The device lifetime metrics \field{pre_eol_info}, \field{device_lifetime_est_a}
+  and \field{device_lifetime_est_b} are discussed in the JESD84-B50 specification.
+
+  The complete JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
+  pursuant to JEDEC's licensing terms and conditions. This information is provided to
+  simplfy passthrough implementations from eMMC devices.
+\end{note}
 
 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
 When using the legacy interface, transitional devices and drivers
-- 
2.31.1.527.g47e6f16901-goog

