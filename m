Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC43C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 09:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613DD21773
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 09:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfBJJ2E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:28:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:37342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfBJJ2E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 04:28:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1438ADFB;
        Sun, 10 Feb 2019 09:28:02 +0000 (UTC)
Subject: Re: [PATCH 17/19] io_uring: add support for IORING_OP_POLL
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190209211346.26060-1-axboe@kernel.dk>
 <20190209211346.26060-18-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3f422430-4e91-316b-9f8a-8b7ff99aad56@suse.de>
Date:   Sun, 10 Feb 2019 10:28:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190209211346.26060-18-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/9/19 10:13 PM, Jens Axboe wrote:
> This is basically a direct port of bfe4037e722e, which implements a
> one-shot poll command through aio. Description below is based on that
> commit as well. However, instead of adding a POLL command and relying
> on io_cancel(2) to remove it, we mimic the epoll(2) interface of
> having a command to add a poll notification, IORING_OP_POLL_ADD,
> and one to remove it again, IORING_OP_POLL_REMOVE.
> 
> To poll for a file descriptor the application should submit an sqe of
> type IORING_OP_POLL. It will poll the fd for the events specified in the
> poll_events field.
> 
> Unlike poll or epoll without EPOLLONESHOT this interface always works in
> one shot mode, that is once the sqe is completed, it will have to be
> resubmitted.
> 
> Based-on-code-from: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   fs/io_uring.c                 | 261 +++++++++++++++++++++++++++++++++-
>   include/uapi/linux/io_uring.h |   3 +
>   2 files changed, 263 insertions(+), 1 deletion(-)
> 
I still would like to be able to properly terminate the I/O on 
aio_cancel. But this can probably be done in a later patch.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
