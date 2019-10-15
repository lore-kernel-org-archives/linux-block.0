Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAD0ECE58F
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 23:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D2820659
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 23:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbfJOXAJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:00:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:53365 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbfJOXAJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 19:00:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 16:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,301,1566889200"; 
   d="scan'208";a="395700624"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by fmsmga005.fm.intel.com with ESMTP; 15 Oct 2019 16:00:08 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 0/3] block: sed-opal: Generic Read/Write Opal Tables
Date:   Tue, 15 Oct 2019 17:02:43 -0600
Message-Id: <20191015230246.10171-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series of patches aims at extending SED Opal support:
1. Exposing enum opal_uid and opaluid definitions to the users to select
   the desired opal table UID.
2. Generalizing write data to any opal table
3. Add an IOCTL for reading/writing any Opal Table with Admin-1 authority

Datastore feature described in:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_Feature_Set-Additional_DataStore_Tables_v1_00_r1_00_Final.pdf

Opal Application Note:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Opal_SSC_Application_Note_1-00_1-00-Final.pdf

This feature has been successfully tested on OPAL Datastore and MBR table using
internal tools with a Intel SSD and Intel Optane.

Changes from v1(https://lore.kernel.org/linux-block/20190821191051.3535-1-revanth.rajashekar@intel.com/):
	1. Fix the spelling mistake in the commit message.
	2. Introduce a length check condition before Copy To User in opal_read_table
	   function to facilitate user with easy debugging.
	3. Introduce switch cases in the opal_generic_read_write_table ioctl function.
	4. Move read/write table opal_step to discrete functions to reduce the load
	   on the ioctl function.
	5. Introduce 'opal table operations' enumeration in uapi.
	6. Remove tabs before the #defines in opal_read_write_table structure
           to improve the code readability

Revanth Rajashekar (3):
  block: sed-opal: Expose enum opal_uid and opaluid
  block: sed-opal: Generalizing write data to any opal table
  block: sed-opal: Add support to read/write opal tables generically

 block/opal_proto.h            |  39 ----
 block/sed-opal.c              | 375 ++++++++++++++++++++++------------
 include/linux/sed-opal.h      |   1 +
 include/uapi/linux/sed-opal.h | 132 ++++++++++++
 4 files changed, 373 insertions(+), 174 deletions(-)

--
2.17.1

