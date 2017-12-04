Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:34221 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753219AbdLDFQr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Dec 2017 00:16:47 -0500
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        kernel-team@lge.com, jack@suse.cz, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, npiggin@gmail.com,
        rgoldwyn@suse.com, vbabka@suse.cz, mhocko@suse.com,
        pombredanne@nexb.com, vinmenon@codeaurora.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 0/4] lockdep/crossrelease: Apply crossrelease to page locks
Date: Mon,  4 Dec 2017 14:16:19 +0900
Message-Id: <1512364583-26070-1-git-send-email-byungchul.park@lge.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For now, wait_for_completion() / complete() works with lockdep, add
lock_page() / unlock_page() and its family to lockdep support.

Changes from v1
 - Move lockdep_map_cross outside of page_ext to make it flexible
 - Prevent allocating lockdep_map per page by default
 - Add a boot parameter allowing the allocation for debugging

Byungchul Park (4):
  lockdep: Apply crossrelease to PG_locked locks
  lockdep: Apply lock_acquire(release) on __Set(__Clear)PageLocked
  lockdep: Move data of CONFIG_LOCKDEP_PAGELOCK from page to page_ext
  lockdep: Add a boot parameter enabling to track page locks using
    lockdep and disable it by default

 Documentation/admin-guide/kernel-parameters.txt |   7 ++
 include/linux/mm_types.h                        |   4 +
 include/linux/page-flags.h                      |  43 +++++++-
 include/linux/pagemap.h                         | 125 ++++++++++++++++++++++--
 lib/Kconfig.debug                               |  11 +++
 mm/filemap.c                                    | 114 ++++++++++++++++++++-
 mm/page_ext.c                                   |   4 +
 7 files changed, 299 insertions(+), 9 deletions(-)

-- 
1.9.1
