Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:47258 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751993AbeDLGih (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Apr 2018 02:38:37 -0400
From: tang.junhui@zte.com.cn
To: kent.overstreet@gmail.com, colyli@suse.de, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: [PATCH 0/4] bcache: incremental GC and dirty data init
Date: Thu, 12 Apr 2018 14:38:40 +0800
Message-Id: <1523515124-2021-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi maintainers and folks,

Some patches of this patch set have been sent before, they are not merged
yet, and I add two new patches to solve some issues I found while testing.
since They are interdependent, so I make a patch set and resend them.

[PATCH 1/4] bcache: finish incremental GC
[PATCH 2/4] bcache: calculate the number of incremental GC nodes according to
			the total of btree nodes
[PATCH 3/4] bcache: notify allocator to prepare for GC
[PATCH 4/4] bcache: fix I/O significant decline while backend devices registering

These patches are useful to prevent I/O fluctuations or even jump 0 while GC or
cached devices registering. I have test them for some times, I hope somebody could
have a review for these patch, any comment would be welcome.
