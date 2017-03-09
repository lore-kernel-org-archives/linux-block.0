Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35225 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbdCIN71 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Mar 2017 08:59:27 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Yi Zhang <yizhan@redhat.com>, Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 0/2] blk-mq: dying queue fix & improvement
Date: Thu,  9 Mar 2017 21:02:56 +0800
Message-Id: <1489064578-17305-2-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

The 1st patch fixes one race between timeout and dying queue.

The 2nd patch improves handling for dying queue.

thanks,
Ming


Ming Lei (2):
  blk-mq: don't complete un-started request in timeout handler
  blk-mq: start to freeze queue just after setting dying

 block/blk-core.c |  7 +++++--
 block/blk-mq.c   | 11 +----------
 2 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.7.4
