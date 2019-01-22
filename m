Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4483C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 22:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0BB217D6
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 22:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="pbpRFlcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfAVWcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:32:19 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:45160 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfAVWcT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 17:32:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 35867B0664;
        Tue, 22 Jan 2019 23:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1548196336; i=@fjfi.cvut.cz;
        bh=gSCsnIkrDG/PwKOgkMCOsWlrMuMz1Qz/tzhM3T7IYxk=;
        h=From:To:Cc:Subject:Date;
        b=pbpRFlcE4qvLf8kWTNGhHNEVttY8duujwTTzfG2AiC4munk79tl0WwcsRgzr91pNS
         5xepgunGCiHL6wBKPb8QfOGbXznBvEGS9UyNoHXBOJxVqlICa3PiH0WG9v+O3MTCWY
         /n/Egjnk7vecezvfPlxvAEhftxwx3AzW/vqwHtfk=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id 8ZjyfmUs2t7x; Tue, 22 Jan 2019 23:32:14 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 84EF0B0661;
        Tue, 22 Jan 2019 23:32:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 84EF0B0661
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 400E56004E; Tue, 22 Jan 2019 23:32:13 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH v3 00/16] block: sed-opal: support shadow MBR done flag and write
Date:   Tue, 22 Jan 2019 23:31:31 +0100
Message-Id: <1548196307-12987-1-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
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

The most contentious issue in the original series was the IOCTL for shadow MBR
write but I think no better approach was found[2] so this was not changed. I'm
open to suggestions.

There is a fork of sed-opal-temp that can use these new IOCTLs.[3] I tested
these on Samsung 840 EVO and 850 EVO drives, on x86-64 and arm64 systems.

The series applies on v5.0-rc3.

Changes from v2 to v3:
* review suggestions from Scott Bauer

As Scott suggested I tried to do a more thorough testing, esp. with things like
wrong passwords/invalid values. I did not observe any crash or unexpected
behavior.

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
 block/sed-opal.c              | 845 +++++++++++++++++-----------------
 include/linux/sed-opal.h      |   2 +
 include/uapi/linux/sed-opal.h |   9 +
 4 files changed, 451 insertions(+), 423 deletions(-)

-- 
2.20.1

