Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752400AbeAOQ60 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 11:58:26 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/3] blk-mq: issue request directly for blk_insert_cloned_request
Date: Tue, 16 Jan 2018 00:58:07 +0800
Message-Id: <20180115165810.2515-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Guys,

The 3 paches changes the blk-mq part of blk_insert_cloned_request(),
in which we switch to blk_mq_try_issue_directly(), so that both dm-rq
and blk-mq can get the dispatch result of underlying queue, and with
this information, blk-mq can handle IO merge much better, then
sequential I/O performance is improved much.

In my dm-mpath over virtio-scsi test, this whole patchset improves
sequential IO by 3X ~ 5X.

V4:
	- remove dm patches which are in DM tree already
	- cleanup __blk_mq_issue_req as suggested by Jens

V3:
	- rebase on the latest for-4.16/block of block tree
	- add missed pg_init_all_paths() in patch 1, according to Bart's review

V2:
	- drop 'dm-mpath: cache ti->clone during requeue', which is a bit
	too complicated, and not see obvious performance improvement.
	- make change on blk-mq part cleaner

Ming Lei (3):
  blk-mq: move actual issue into one helper
  blk-mq: return dispatch result to caller in blk_mq_try_issue_directly
  blk-mq: issue request directly for blk_insert_cloned_request

 block/blk-mq.c | 85 +++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 21 deletions(-)

-- 
2.9.5
