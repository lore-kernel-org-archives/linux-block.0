Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17889 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932070AbeEWMag (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 May 2018 08:30:36 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, marcin.dziegielewski@intel.com,
        Igor Konopko <igor.j.konopko@intel.com>
Subject: [PATCH 0/3] lightnvm: Error paths handling
Date: Wed, 23 May 2018 14:29:53 +0200
Message-Id: <20180523122956.24137-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patchset provides a proper handling for some of the errors which
are not gracefully handled right now.

Igor Konopko (3):
  lightnvm: Proper error handling for pblk_bio_add_pages
  lightnvm: Handling when whole line is bad
  lightnvm: Fix partial read error path

 drivers/lightnvm/pblk-core.c | 10 ++++++++--
 drivers/lightnvm/pblk-read.c |  8 ++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.14.3
