Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbeJ2Q1m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Oct 2018 12:27:42 -0400
Subject: Re: [PATCH 08/14] blk-mq: separate number of hardware queues from
 nr_cpu_ids
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-9-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <bc29ae04-f218-c702-b2b6-bc05567d752d@suse.de>
Date: Mon, 29 Oct 2018 08:40:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211626.12692-9-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/25/18 11:16 PM, Jens Axboe wrote:
> With multiple maps, nr_cpu_ids is no longer the maximum number of
> hardware queues we support on a given devices. The initializer of
> the tag_set can have set ->nr_hw_queues larger than the available
> number of CPUs, since we can exceed that with multiple queue maps.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
