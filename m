Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297F3C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04D121916
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfBIJxV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:53:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:55006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfBIJxV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Feb 2019 04:53:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7D13B025;
        Sat,  9 Feb 2019 09:53:19 +0000 (UTC)
Subject: Re: [PATCH 15/19] io_uring: add submission polling
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-16-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c2aecf8b-a203-9c66-7e77-4e9d7cec7216@suse.de>
Date:   Sat, 9 Feb 2019 10:53:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190208173423.27014-16-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 6:34 PM, Jens Axboe wrote:
> This enables an application to do IO, without ever entering the kernel.
> By using the SQ ring to fill in new sqes and watching for completions
> on the CQ ring, we can submit and reap IOs without doing a single system
> call. The kernel side thread will poll for new submissions, and in case
> of HIPRI/polled IO, it'll also poll for completions.
> 
> By default, we allow 1 second of active spinning. This can by changed
> by passing in a different grace period at io_uring_register(2) time.
> If the thread exceeds this idle time without having any work to do, it
> will set:
> 
> sq_ring->flags |= IORING_SQ_NEED_WAKEUP.
> 
> The application will have to call io_uring_enter() to start things back
> up again. If IO is kept busy, that will never be needed. Basically an
> application that has this feature enabled will guard it's
> io_uring_enter(2) call with:
> 
> read_barrier();
> if (*sq_ring->flags & IORING_SQ_NEED_WAKEUP)
> 	io_uring_enter(fd, 0, 0, IORING_ENTER_SQ_WAKEUP);
> 
> instead of calling it unconditionally.
> 
> It's mandatory to use fixed files with this feature. Failure to do so
> will result in the application getting an -EBADF CQ entry when
> submitting IO.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   fs/io_uring.c                 | 249 +++++++++++++++++++++++++++++++++-
>   include/uapi/linux/io_uring.h |  12 +-
>   2 files changed, 253 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
