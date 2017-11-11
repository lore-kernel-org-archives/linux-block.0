Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:34098 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdKKN0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Nov 2017 08:26:36 -0500
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        kernel-team@lge.com
Subject: [PATCH v3 0/5] Revise crossrelease.txt
Date: Sat, 11 Nov 2017 22:26:27 +0900
Message-Id: <1510406792-28676-1-git-send-email-byungchul.park@lge.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In this version, I've split a big one into small 5 patches so you can
review them more easily. But, choose between a big one and small 5
patches when you take it, as you prefer.

I will add a big one merging all of these.

---

Changes from v2
- Split a big patch into small 5 patches.
- Apply what Ingo pointed out.
- Leave original contents unchanged as much as possible.

Changes from v1
- Run several tools checking english spell and grammar over the text.
- Simplify the document more.

Byungchul Park (5):
  locking/Documentation: Remove meaningless examples and a note
  locking/Documentation: Fix typos and clear grammar errors
  locking/Documentation: Fix weird expressions.
  locking/Documentation: Add an example to help crossrelease.txt more
    readable
  locking/Documentation: Align crossrelease.txt with the width

 Documentation/locking/crossrelease.txt | 329 ++++++++++++++++-----------------
 1 file changed, 155 insertions(+), 174 deletions(-)

-- 
1.9.1
