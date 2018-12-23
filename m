Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F34DC43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1969E21903
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeLWLKR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:10:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:49462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeLWLKR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Dec 2018 06:10:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E3A0AF0B;
        Sun, 23 Dec 2018 11:10:15 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 00/11] fixes for setting values via sysfs interface 
Date:   Sun, 23 Dec 2018 19:09:26 +0800
Message-Id: <20181223110937.11559-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When setting bcache parameters via sysfs interface, current code has
potential overflow and results unexpected value got set. Once such
condition happens, it is very hard to find out in product environment.

This patch set is an effort to fix such overflow, to avoid further
unpected problems.

Coly Li
---
Coly Li (11):
  bcache: fix input integer overflow of congested threshold
  bcache: fix input overflow to sequential_cutoff
  bcache: add sysfs_strtoul_bool() for setting bit-field variables
  bcache: use sysfs_strtoul_bool() to set bit-field variables
  bcache: fix input overflow to writeback_delay
  bcache: fix potential div-zero error of writeback_rate_i_term_inverse
  bcache: fix potential div-zero error of writeback_rate_p_term_inverse
  bcache: fix input overflow to writeback_rate_minimum
  bcache: fix input overflow to journal_delay_ms
  bcache: fix input overflow to cache set io_error_limit
  bcache: fix input overflow to cache set sysfs file io_error_halflife

 drivers/md/bcache/sysfs.c | 61 ++++++++++++++++++++++++++++++-----------------
 drivers/md/bcache/sysfs.h | 10 ++++++++
 2 files changed, 49 insertions(+), 22 deletions(-)

-- 
2.16.4

