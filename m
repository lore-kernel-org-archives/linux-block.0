Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40546C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137F8217D8
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBIJs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:48:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:54510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726058AbfBIJs3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Feb 2019 04:48:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA847AFDC;
        Sat,  9 Feb 2019 09:48:27 +0000 (UTC)
Subject: Re: [PATCH 12/19] io_uring: add support for pre-mapped user IO
 buffers
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-13-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <263c8879-76c7-fd53-d37d-68b2e6993a9b@suse.de>
Date:   Sat, 9 Feb 2019 10:48:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190208173423.27014-13-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 6:34 PM, Jens Axboe wrote:
> If we have fixed user buffers, we can map them into the kernel when we
> setup the io_uring. That avoids the need to do get_user_pages() for
> each and every IO.
> 
> To utilize this feature, the application must call io_uring_register()
> after having setup an io_uring instance, passing in
> IORING_REGISTER_BUFFERS as the opcode. The argument must be a pointer to
> an iovec array, and the nr_args should contain how many iovecs the
> application wishes to map.
> 
> If successful, these buffers are now mapped into the kernel, eligible
> for IO. To use these fixed buffers, the application must use the
> IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
> set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
> must point to somewhere inside the indexed buffer.
> 
> The application may register buffers throughout the lifetime of the
> io_uring instance. It can call io_uring_register() with
> IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
> buffers, and then register a new set. The application need not
> unregister buffers explicitly before shutting down the io_uring
> instance.
> 
> It's perfectly valid to setup a larger buffer, and then sometimes only
> use parts of it for an IO. As long as the range is within the originally
> mapped region, it will work just fine.
> 
> For now, buffers must not be file backed. If file backed buffers are
> passed in, the registration will fail with -1/EOPNOTSUPP. This
> restriction may be relaxed in the future.
> 
> RLIMIT_MEMLOCK is used to check how much memory we can pin. A somewhat
> arbitrary 1G per buffer size is also imposed.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>   arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>   fs/io_uring.c                          | 356 ++++++++++++++++++++++++-
>   include/linux/sched/user.h             |   2 +-
>   include/linux/syscalls.h               |   2 +
>   include/uapi/asm-generic/unistd.h      |   4 +-
>   include/uapi/linux/io_uring.h          |  13 +-
>   kernel/sys_ni.c                        |   1 +
>   8 files changed, 363 insertions(+), 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes

