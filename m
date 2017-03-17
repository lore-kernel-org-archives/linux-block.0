Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32881 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdCQJ7X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 05:59:23 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Yi Zhang <yizhan@redhat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <minlei@redhat.com>
Subject: [PATCH v1 0/3] blk-mq: dying queue fix & improvement
Date: Fri, 17 Mar 2017 17:57:08 +0800
Message-Id: <20170317095711.5819-1-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Ming Lei <minlei@redhat.com>

Hi,

The 1st patch fixes one race between timeout and dying queue.

The 2nd patch add comments on races with timeout handler.

The 3rd patch improves handling for dying queue.


V1:
	- add comments on races related with timeout handler
	- add Tested-by & Reviewed-by tag

thanks,
Ming

Ming Lei (3):
  blk-mq: don't complete un-started request in timeout handler
  blk-mq: comment on races related timeout handler
  blk-mq: start to freeze queue just after setting dying

 block/blk-core.c |  7 +++++--
 block/blk-mq.c   | 33 +++++++++++++++++++++++----------
 2 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.9.3
