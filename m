Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeJRScS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Oct 2018 14:32:18 -0400
From: Jan Kara <jack@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 0/2] blktests: New loop tests
Date: Thu, 18 Oct 2018 12:31:45 +0200
Message-Id: <20181018103147.3567-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Hello,

these two patches create two new tests for blktests as regression tests
for my recently posted loopback device fixes. More details in individual
patches.

								Honza
