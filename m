Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20831 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbdBMQUq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 11:20:46 -0500
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: David.Laight@ACULAB.COM, arnd@arndb.de, axboe@fb.com,
        keith.busch@intel.com, jonathan.derrick@intel.com,
        hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: SED Opal Fixups
Date: Mon, 13 Feb 2017 09:11:08 -0700
Message-Id: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

So we have a few patches here, they're pretty small. First patch changes
the sed-opal ioctl function parameters to take a void __user* instead of
an unsigned long, this required a small cast in the nvme driver.
Patch 2 is a UAPI fixup for the IOW to make an ioctl
the right size. Patch 3 fixes a compiliation error when building using
KSAN due to the stack frame being too large. And lastly we move the
Maintainers list from nvme to linux-block.
