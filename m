Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:56806 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbcEQSbs (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 17 May 2016 14:31:48 -0400
From: Jon Derrick <jonathan.derrick@intel.com>
To: linux-block@vger.kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	"Jens Axboe" <axboe@fb.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	"Dan Williams" <dan.j.williams@intel.com>,
	"Jeff Moyer" <jmoyer@redhat.com>,
	"Stephen Bates" <stephen.bates@microsemi.com>,
	"Keith Busch" <keith.busch@intel.com>,
	"Christoph Hellwig" <hch@infradead.org>,
	"Robert Elliott" <elliott@hpe.com>
Subject: [PATCH] Fix S_DAX setting in __blkdev_get
Date: Tue, 17 May 2016 12:29:56 -0600
Message-Id: <1463509797-10324-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a continuation of the HIPRI series [1]. I've dropped the HIPRI
flag patch for now to investigate how to have HIPRI reads and/or writes
in a similar method.

This patch is mainly to try and fix S_DAX setting in __blkdev_get.

[1]: http://lists.infradead.org/pipermail/linux-nvme/2016-May/004606.html

Jon Derrick (1):
  block: Fix S_DAX inode flag locking

 fs/block_dev.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

-- 
1.8.3.1

