Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7495 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdJEN3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2017 09:29:01 -0400
From: John Garry <john.garry@huawei.com>
Subject: [Question] on blk_mq_map_queues()
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <maxg@mellanox.com>
CC: Linuxarm <linuxarm@huawei.com>
Message-ID: <f5280c3c-ffd9-bc3a-7e0b-226c4a1232c9@huawei.com>
Date: Thu, 5 Oct 2017 14:28:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi All,

I have a question on the core-to-hw queue mapping in 
blk_mq_map_queues(). In looking at the latest version, we map the first 
$nr_queues cores to separate queues, and then map sibling threaded-cores 
to the same queue. First off, I am just curious why we always map the 
first batch of cores to separate queues.

As I understand for blk mq, we try to map cores which are physically 
close to the same hw queue (in the case of more cores than hw queues). 
So, by this rationale, we would not map the first $nr_queues cores to 
each separate queue, but would rather map core [0, $nr_cores/$nr_queues) 
to q0, [$nr_cores/$nr_queues, 2*$nr_cores/$nr_queues) to q1, and so on 
(assuming $nr_queues is evenly divisible into $nr_cores, for simplicity).

So what is the full desired mapping behaviour?

The specific problem I see is that for my 64-core system (no 
hyperthreading) and 16 hw queues, I see cores per 4-core cluster being 
mapped to different queues, when I would expect them to be mapped to 
same queue.

I know that we can add our own per-driver mapping function to solve, but 
I would expect that that generic mapper would cover a generic platform.

Thanks in advance,
John
