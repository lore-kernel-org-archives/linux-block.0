Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36484 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934834AbcIWV7M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2016 17:59:12 -0400
Received: by mail-pf0-f176.google.com with SMTP id q2so45776526pfj.3
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2016 14:59:12 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: get rid of manual run of queue with
 __blk_mq_run_hw_queue()
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <1474555980-2787-2-git-send-email-axboe@fb.com>
 <20160922185603.GA32468@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, jbacik@fb.com
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <82480512-8c91-eca1-b6ca-c61fb098ce1d@grimberg.me>
Date: Fri, 23 Sep 2016 14:59:12 -0700
MIME-Version: 1.0
In-Reply-To: <20160922185603.GA32468@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> ---
> From c69bf02929d9c37d193b004a4c3c85c1142fa996 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Thu, 22 Sep 2016 11:38:23 -0700
> Subject: blk-mq: remove non-blocking pass in blk_mq_map_request
>
> bt_get already does a non-blocking pass as well as running the queue
> when scheduling internally, no need to duplicate it.

Looks good too,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Question (while we're on the subject):
Do consumers have a way to restrict blk-mq to block on
lack of tags? I'm thinking in the context of nvme-target
that can do more useful things than waiting for a tag...
