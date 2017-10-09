Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:52465 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbdJIHho (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Oct 2017 03:37:44 -0400
Received: by mail-pf0-f174.google.com with SMTP id a1so9734611pfj.9
        for <linux-block@vger.kernel.org>; Mon, 09 Oct 2017 00:37:44 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: colyli@suse.de
Subject: 
Date: Mon,  9 Oct 2017 00:37:28 -0700
Message-Id: <20171009073730.8939-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

[PATCH v2 1/2] bcache: writeback rate shouldn't artifically clamp
[PATCH v2 2/2] bcache: rearrange writeback main thread ratelimit

This is a reroll of the previous "don't clamp" patch.  It corrects
type issues where negative numbers were handled badly (mostly for
display in writeback_rate_debug).

Additionally, a new, related patch-- during scanning for dirty
blocks, don't reset the ratelimiting counter.  This can prevent
undershoots/overshoots of the target rate relating to scanning.

Mike
