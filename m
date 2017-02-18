Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:42880 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbdBRAAg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 19:00:36 -0500
From: Jon Derrick <jonathan.derrick@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 0/5] OPAL patche'd cont'd
Date: Fri, 17 Feb 2017 17:00:24 -0700
Message-Id: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

v1->v2:
Moved misplaced code from 5/5 to 4/5

The first three in the series have been reviewed already but I wanted to
squash them with the next two since they haven't been pulled yet.

The latter 2 are an attempt to refactor some of the awkward func data
and state separation into a common struct

Jon Derrick (5):
  block/sed: Use ssize_t on atom parsers to return errors
  block/sed: Add helper to qualify response tokens
  block/sed: Check received header lengths
  block/sed: Embed function data into the function sequence
  block/sed: Eliminate state variable

 block/sed-opal.c | 494 +++++++++++++++++++++++--------------------------------
 1 file changed, 202 insertions(+), 292 deletions(-)

-- 
1.8.3.1
