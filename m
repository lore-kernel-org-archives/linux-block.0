Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647E1C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EA820855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="r4pm19eE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfAQVcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:32:39 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:34748 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfAQVcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 16:32:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id DB71AA393B;
        Thu, 17 Jan 2019 22:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547760755; i=@fjfi.cvut.cz;
        bh=YNxX4HXoPgsHqfyMaZl/kE99by/oLg/H/mm5gNkiEBE=;
        h=From:To:Cc:Subject:Date;
        b=r4pm19eEm5V2ojho4PHUZhZnXV3FY43y8kZLFVJRzC4muvCuTLv2pwDB9ddx/mvRP
         fpT8IMHo+XZjjE5O68ZKoK5CYbECf6pmuyDv/2YGiEmAJsFlgTJ0b+yNJV7jQtZSpM
         Obj4MTCyNuVfLtFdb29n38rv79uuwONBCibLyPgU=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id jAWCj5gbDjW8; Thu, 17 Jan 2019 22:32:33 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 45399A355E;
        Thu, 17 Jan 2019 22:32:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 45399A355E
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 034B16004E; Thu, 17 Jan 2019 22:32:32 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH v2 00/16] block: sed-opal: support shadow MBR done flag and write
Date:   Thu, 17 Jan 2019 22:31:40 +0100
Message-Id: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
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

The series applies on v5.0-rc2.

I'm resending this as v2 because I sent the first attempt incorrectly. I
apologize for the noise.

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

