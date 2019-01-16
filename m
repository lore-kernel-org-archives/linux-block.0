Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52791C43612
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211BE20675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="PS0Scexk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfAPXE3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:04:29 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:45738 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbfAPXD7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 18:03:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id C542FAE076;
        Wed, 16 Jan 2019 23:55:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547679336; i=@fjfi.cvut.cz;
        bh=EH3H6+qisnAdQ6BdapphBgL/BfYzJo3SPJE+Va5b2rE=;
        h=From:Date:Subject:To:Cc;
        b=PS0ScexklD8d7FLefZHVwraYGSudOp9GeRI80CRc4bcv7U3F1dKPG8uMgBV7MgmZZ
         d7dAeUWFxVg4lAcME0S7ezBUwqX465ARAR4KNFFpIgh7cv4lL7T6xRJydtdrwUH8c+
         UisEVJO6/29SRWS/hfAeOf2z5mA2dV3uOjIuy19c=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id MxrBWbZyYIoe; Wed, 16 Jan 2019 23:55:34 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 0A4EFADB5C;
        Wed, 16 Jan 2019 23:55:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 0A4EFADB5C
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id BD1396004E; Wed, 16 Jan 2019 23:55:33 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
Date:   Wed, 16 Jan 2019 22:56:51 +0100
Subject: [PATCH 00/16] block: sed-opal: support shadow MBR done flag and write
To:     Jens Axboe <axboe@kernel.dk>, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-Id: <20190116225533.BD1396004E@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series extends OPAL support: it adds IOCTL for setting the shadow
MBR done flag which can be useful for unlocking an OPAL disk on boot and it adds
IOCTL for writing to the shadow MBR. Also included are some minor fixes and
improvements.

This series is based on the original work done by Jonas Rabenstein which was
submitted in March 2018.[1] I tried to apply suggestions made in review on the
list and do some further improvements.

The most contentions issue in the original series was the IOCTL for shadow MBR
write but I think no better approach was found[2] so this was not changed. I'm
open to suggestions.

There is a fork of sed-opal-temp that can use these new IOCTLs.[3] I tested
these on Samsung 840 EVO and 850 EVO drives, on x86-64 and arm64 systems.

The series applies on v5.0-rc2.

[1] https://lore.kernel.org/lkml/cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de/
[2] https://lore.kernel.org/lkml/20180405203443.ye4gnw5aey2exlkn@sbauer-Z170X-UD5/
[3] https://github.com/ghostav/sed-opal-temp

David Kozub (8):
  block: sed-opal: fix typos and formatting
  block: sed-opal: close parameter list in cmd_finalize
  block: sed-opal: unify cmd start
  block: sed-opal: unify error handling of responses
  block: sed-opal: reuse response_get_token to decrease code duplication
  block: sed-opal: pass steps via argument rather than via opal_dev
  block: sed-opal: don't repeat opal_discovery0 in each steps array
  block: sed-opal: rename next to execute_steps

Jonas Rabenstein (8):
  block: sed-opal: use correct macro for method length
  block: sed-opal: unify space check in add_token_*
  block: sed-opal: print failed function address
  block: sed-opal: split generation of bytestring header and content
  block: sed-opal: add ioctl for done-mark of shadow mbr
  block: sed-opal: ioctl for writing to shadow mbr
  block: sed-opal: unify retrieval of table columns
  block: sed-opal: check size of shadow mbr

 block/opal_proto.h            |  18 +
 block/sed-opal.c              | 843 +++++++++++++++++-----------------
 include/linux/sed-opal.h      |   2 +
 include/uapi/linux/sed-opal.h |   9 +
 4 files changed, 449 insertions(+), 423 deletions(-)

-- 
2.20.1

