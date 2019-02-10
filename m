Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92851C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 09:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BC82084D
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 09:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfBJJb7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:31:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:37534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfBJJb7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 04:31:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22289AEE1;
        Sun, 10 Feb 2019 09:31:58 +0000 (UTC)
Subject: Re: [PATCH 18/19] io_uring: allow workqueue item to handle multiple
 buffered requests
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190209211346.26060-1-axboe@kernel.dk>
 <20190209211346.26060-19-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <476b621e-85e2-35df-c1e3-50395ca4ebeb@suse.de>
Date:   Sun, 10 Feb 2019 10:31:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190209211346.26060-19-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/9/19 10:13 PM, Jens Axboe wrote:
> Right now we punt any buffered request that ends up triggering an
> -EAGAIN to an async workqueue. This works fine in terms of providing
> async execution of them, but it also can create quite a lot of work
> queue items. For sequentially buffered IO, it's advantageous to
> serialize the issue of them. For reads, the first one will trigger a
> read-ahead, and subsequent request merely end up waiting on later pages
> to complete. For writes, devices usually respond better to streamed
> sequential writes.
> 
> Add state to track the last buffered request we punted to a work queue,
> and if the next one is sequential to the previous, attempt to get the
> previous work item to handle it. We limit the number of sequential
> add-ons to the a multiple (8) of the max read-ahead size of the file.
> This should be a good number for both reads and wries, as it defines the
> max IO size the device can do directly.
> 
> This drastically cuts down on the number of context switches we need to
> handle buffered sequential IO, and a basic test case of copying a big
> file with io_uring sees a 5x speedup.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   fs/io_uring.c | 269 ++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 218 insertions(+), 51 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes

