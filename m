Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5718 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbcLLDrK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Dec 2016 22:47:10 -0500
Date: Mon, 12 Dec 2016 11:56:23 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Jens Axboe <axboe@kernel.dk>, Freddy Xin <freddy@asix.com.tw>,
        Robert Foss <robert.foss@collabora.com>
Cc: linux-block@vger.kernel.org, Rui Zhang <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [RFC] Why ax88772a_hw_reset sleeps for 200ms? Can we reduce the
 value?
Message-ID: <20161212035623.GA4101@yu-desktop-1.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi guys,
Currently I'm experiencing long time latency of resuming
from S3 on my MacBookPro 2015, according to the log of ftrace,
one of the suspicious time consumers is ax88772a_hw_reset has an
explicit msleep of 200ms in the code, is this mandatory or
can we reduce this sleep time of it?
https://bugzilla.kernel.org/show_bug.cgi?id=190111

Thanks in advance,
Yu
