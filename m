Return-Path: <SRS0=XfYF=YY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFFCCA9ECB
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 16:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D2520873
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 16:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfJaQKc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:10:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:11861 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJaQKc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 12:10:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 09:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,252,1569308400"; 
   d="scan'208";a="190675591"
Received: from revanth.lm.intel.com ([10.232.116.91])
  by orsmga007.jf.intel.com with ESMTP; 31 Oct 2019 09:10:31 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 0/3] block: sed-opal: Generic Read/Write Opal Tables
Date:   Thu, 31 Oct 2019 10:13:19 -0600
Message-Id: <20191031161322.16624-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series of patches aims at extending SED Opal support:
1. Generalizing write data to any opal table
2. Add an IOCTL for reading/writing any Opal Table with Admin-1 authority
3. Introduce Opal Datastore UID, which can be accessed using above ioctl

Datastore feature described in:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_Feature_Set-Additional_DataStore_Tables_v1_00_r1_00_Final.pdf

Opal Application Note:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Opal_SSC_Application_Note_1-00_1-00-Final.pdf

This feature has been successfully tested on OPAL Datastore and MBR table using
internal tools with an Intel SSD and an Intel Optane.

Changes from v2:
	1. Drop a patch which exposes UIDs in UAPI.
	2. Fix coding styles wherever required based on LKML feedbacks.
	3. Eliminate a few redundant assignments in the code.
	4. Add a break under copy_from_user error condition in
           generic_table_write_data func.
	5. A few refactoring/cleanups in both the patches.
	6. Introduce a new patch which introduces Opal Datastore table UID.

Changes from v1:
	1. Fix the spelling mistake in the commit message.
	2. Introduce a length check condition before Copy To User in
           opal_read_table function to facilitate user with easy debugging.
	3. Introduce switch cases in the opal_generic_read_write_table ioctl
           function.
	4. Move read/write table opal_step to discrete functions to reduce the
           load on the ioctl function.
	5. Introduce 'opal table operations' enumeration in uapi.
	6. Remove tabs before the #defines in opal_read_write_table structure
           to improve the code readability.
	7. Drop a patch which exposes UIDs in UAPI.
	8. Eliminate a few redundant assignments in the code.
	9. Add a break under copy_from_user error condition in
           generic_table_write_data func.
	10. A few refactoring/cleanups in both the patches
	11. Introduce a new patch which introduces Opal Datastore table UID.


Revanth Rajashekar (3):
  block: sed-opal: Generalizing write data to any opal table
  block: sed-opal: Add support to read/write opal tables generically
  block: sed-opal: Introduce Opal Datastore UID

 block/opal_proto.h            |   2 +-
 block/sed-opal.c              | 312 +++++++++++++++++++++++++++-------
 include/linux/sed-opal.h      |   1 +
 include/uapi/linux/sed-opal.h |  20 +++
 4 files changed, 270 insertions(+), 65 deletions(-)

-- 
2.17.1

