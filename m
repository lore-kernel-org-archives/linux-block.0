Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFAFC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C72F216F4
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 19:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfHUTI7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:08:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:63958 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfHUTI7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 15:08:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 12:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="169519673"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by orsmga007.jf.intel.com with ESMTP; 21 Aug 2019 12:08:58 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>
Subject: [PATCH 0/3] block: sed-opal - Generic Read/Write Opal Tables
Date:   Wed, 21 Aug 2019 13:10:48 -0600
Message-Id: <20190821191051.3535-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series of patches aims at extending SED Opal support:
1. Exposing enum opal_uid and opaluid definitions to the users to select
   the desired opal table UID.
2. Generalizing write data to any opal table
3. Adding an IOCTL for reading/writing any Opal Table with Admin-1 authority

Datastore feature described in:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_Feature_Set-Additional_DataStore_Tables_v1_00_r1_00_Final.pdf

Opal Application Note:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Opal_SSC_Application_Note_1-00_1-00-Final.pdf

This feature has been successfully tested on OPAL Datastore and MBR table using
internal tools with a Intel SSD and Intel Optane.


Revanth Rajashekar (3):
  block: sed-opal: Expose enum opal_uid and opaluid definitions to the
    users by moving it to "include/uapi/linux/sed-opal.h"
  block: sed-opal: Generalizing write data to any opal table
  block: sed-opal: Add support to read/write opal tables generically

 block/opal_proto.h            |  39 ----
 block/sed-opal.c              | 349 +++++++++++++++++++++-------------
 include/linux/sed-opal.h      |   1 +
 include/uapi/linux/sed-opal.h | 126 ++++++++++++
 4 files changed, 341 insertions(+), 174 deletions(-)

--
2.17.1

