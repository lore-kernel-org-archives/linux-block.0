Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C655C3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6947222DBF
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 15:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfHTP3A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:29:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:61432 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTP3A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 11:29:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 08:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="202710914"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2019 08:29:00 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>
Subject: [PATCH v3 0/3] block: sed-opal: Code Cleanup Patches
Date:   Tue, 20 Aug 2019 09:30:48 -0600
Message-Id: <20190820153051.24704-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series of patch is a cleanup for sed-opal in kernel 5.4. It
1. Adds/removes spaces.
2. Removes an always false conditional statement.
3. Removes duplicate OPAL_METHOD_LENGTH definition.

These cleanup patches are submitted with the intend to submit a new feature
after this.

Changes from v2:
	1. Added reviewed-bys

Changes from v1:
	1. Fixed up commit messages

Revanth Rajashekar (3):
  block: sed-opal: Add/remove spaces
  block: sed-opal: Remove always false conditional statement
  block: sed-opal: Removed duplicate OPAL_METHOD_LENGTH definition

 block/opal_proto.h |  5 +----
 block/sed-opal.c   | 49 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 12 deletions(-)

--
2.17.1

