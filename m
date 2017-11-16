Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:52920 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759026AbdKPDOg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Nov 2017 22:14:36 -0500
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        kernel-team@lge.com, jack@suse.cz, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, npiggin@gmail.com,
        rgoldwyn@suse.com, vbabka@suse.cz, mhocko@suse.com,
        pombredanne@nexb.com, vinmenon@codeaurora.org,
        gregkh@linuxfoundation.org
Subject: [PATCH 0/3] lockdep/crossrelease: Apply crossrelease to page locks
Date: Thu, 16 Nov 2017 12:14:24 +0900
Message-Id: <1510802067-18609-1-git-send-email-byungchul.park@lge.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For now, wait_for_completion() / complete() works with lockdep.

Add lock_page() / unlock_page() and its family to lockdep support.

Byungchul Park (3):
  lockdep: Apply crossrelease to PG_locked locks
  lockdep: Apply lock_acquire(release) on __Set(__Clear)PageLocked
  lockdep: Move data of CONFIG_LOCKDEP_PAGELOCK from page to page_ext

 include/linux/mm_types.h   |   4 ++
 include/linux/page-flags.h |  43 +++++++++++++++-
 include/linux/page_ext.h   |   4 ++
 include/linux/pagemap.h    | 121 ++++++++++++++++++++++++++++++++++++++++++---
 lib/Kconfig.debug          |   8 +++
 mm/filemap.c               |  73 ++++++++++++++++++++++++++-
 mm/page_ext.c              |   4 ++
 7 files changed, 248 insertions(+), 9 deletions(-)

-- 
1.9.1
