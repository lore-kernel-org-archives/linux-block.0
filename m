Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92468C3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 23:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333F82133F
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 23:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=manuel-bentele.de header.i=@manuel-bentele.de header.b="E46gHQ43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfHWXBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 19:01:45 -0400
Received: from host1.nc.manuel-bentele.de ([92.60.37.180]:55818 "EHLO
        host1.nc.manuel-bentele.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbfHWXBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 19:01:45 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Aug 2019 19:01:44 EDT
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: development@manuel-bentele.de)
        by host1.nc.manuel-bentele.de (Postcow) with ESMTPSA id 45EFA641F7;
        Sat, 24 Aug 2019 00:56:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manuel-bentele.de;
        s=dkim; t=1566600982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKfiPT0IqKfA9/aUidgAcWmdM9saHX+JVXPQsBjmxeA=;
        b=E46gHQ43qUwLJvSKx2QrjXNDt0/CkdVguii6iZKYtH0Tw5Yj79NN3iTKY3ZTlBY6AHCfis
        zM65CCeUsBF7zW3EPZXfz+pSkNLkKeq9eRwfG5+0JsckZAcYeE/+q6lRu+ZQhhrQTw0gIN
        bLukr48pI1LikdKHybRDvXD65sV8knjw+DwXDV8ksVgMlrICbC3em+3TZl8dFAicsVw22r
        B/++NHcwUODAg12+Kasf0WfWaY1w2KQsjOx+OFbQaRgZtlXGLSUhCKPKzoiOeBbobCjuxz
        HtDpNQpdS/kHsRKO43bj+XXe8YHvVtYG+ceIYG/f6Zrqe3QQBUboWSTLVn0lgA==
From:   development@manuel-bentele.de
To:     linux-block@vger.kernel.org
Cc:     Manuel Bentele <development@manuel-bentele.de>
Subject: [PATCH 5/5] doc: admin-guide: add QCOW2 file format to loop device documentation
Date:   Sat, 24 Aug 2019 00:56:19 +0200
Message-Id: <20190823225619.15530-6-development@manuel-bentele.de>
In-Reply-To: <20190823225619.15530-1-development@manuel-bentele.de>
References: <20190823225619.15530-1-development@manuel-bentele.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manuel-bentele.de; s=dkim; t=1566600982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKfiPT0IqKfA9/aUidgAcWmdM9saHX+JVXPQsBjmxeA=;
        b=bsP+PfwN9hvCP+PWn5EoR8NEZDX+DOA+wsvib4IH0FvLo8Kxf9WBEj6cy4yOnDKjahi8Gn
        0Z8JHliPk7NvNPd7uY+PAqtRsHTeTV+wQgTDXTCofCyIy9ZvWoxn241+quugUunTHbmAjC
        imf+v9ATP9fAqu6tPMjuCVwpvq07UJ+DeLRhgtvWonn21nRwmGo/HFY4sn3uXrTTWZqYpq
        96waZRaltkeHHyYmAJR093vbssj2jNrZo57wMP7BPH/kOAxCiOAbqkY/qcR3D2TGOA39Wo
        VYWt8MVvV1o7weCBv9u2hJEmPUgYY9yzt5gNb25+xJrFhM0vkuh0MdnE4qVilg==
ARC-Seal: i=1; s=dkim; d=manuel-bentele.de; t=1566600982; a=rsa-sha256;
        cv=none;
        b=mGpgmBdGnFEf0zNtuBd2Dcb+0E/VISiEv1KHcJjf9x5F/9jn3zwxZBRuIVbo+jc44eMrnj
        EM8kp3cJ57+LSOUxuRJqCujBizT4SpjaVXv9zVMx0PupV+JxcLPP5YkdfTEdarzHeWwwxD
        o/WrSIfm6vB9TS2OnfwQoZ6kI2tEB3+iYzqSrYKx7SIOgtiFZ89tyBMZO4qsFNXxwa3QCt
        F7ctIpDa+ARRbSzUi4C1RsrwzqwH6KFHCjKkYHZVqO2si3XZHv7Fp+qwso5xQ+f0R9tDou
        RBmx16g+vodZ7WEUOdBa4ljkCXtEkk0Abv7qO1LvbVbLeMC8rMXJP+W+3LtxSw==
ARC-Authentication-Results: i=1;
        host1.nc.manuel-bentele.de;
        auth=pass smtp.auth=development@manuel-bentele.de smtp.mailfrom=development@manuel-bentele.de
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Manuel Bentele <development@manuel-bentele.de>

The existing documentation about the loop block device is extended by
a section about the QCOW2 file format driver. The documentation is written
in the reST kernel documentation format.

Signed-off-by: Manuel Bentele <development@manuel-bentele.de>
---
 Documentation/admin-guide/blockdev/loop.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/blockdev/loop.rst b/Documentation/admin-guide/blockdev/loop.rst
index 69d8172c85db..3a5897a14c8b 100644
--- a/Documentation/admin-guide/blockdev/loop.rst
+++ b/Documentation/admin-guide/blockdev/loop.rst
@@ -72,3 +72,14 @@ image file. It supports discarding, asynchrounous IO, flushing and cryptoloop
 support.
 
 The driver's kernel module is named *loop_file_fmt_raw*.
+
+
+QCOW
+~~~~
+
+The QCOW file format driver implements QEMU's copy on write file format in
+version 2. At the moment, the file format driver only supports the reading
+of QCOW2 disk image files. It does not support writing to QCOW2 images, the
+recovery of broken QCOW images, snapshots and reference counts.
+
+The driver's kernel module is named *loop_file_fmt_qcow*.
-- 
2.23.0

