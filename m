Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56589 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751610AbcGPRml (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Sat, 16 Jul 2016 13:42:41 -0400
Date: Sat, 16 Jul 2016 11:42:34 -0600
From: Jens Axboe <axboe@fb.com>
To: <torvalds@linuxfoundation.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] NVMe fix for 4.7
Message-ID: <20160716174234.GA11578@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

Late addition here, it's basically a revert of a patch that was added in
this merge window, but has proven to cause problems. This is swapping
out the RCU based namespace protection with a good old mutex instead.
Does not cause merge conflicts with my 4.8 branch, so should not give us
any issues there either.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Keith Busch (1):
      nvme: Remove RCU namespace protection

 drivers/nvme/host/core.c | 74 +++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

-- 
Jens Axboe

