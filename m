Return-Path: <linux-block-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45481 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbcGAG5r (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2016 02:57:47 -0400
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhEzr=yaFPO4ZVzndct84VC6c57W5DNEtqUHUcBjdTjQg@mail.gmail.com>
References: <CAOQ4uxhEzr=yaFPO4ZVzndct84VC6c57W5DNEtqUHUcBjdTjQg@mail.gmail.com>
From: Ming Lei <ming.lei@canonical.com>
Date: Fri, 1 Jul 2016 14:57:44 +0800
Message-ID: <CACVXFVOFpJqPLjw2z8jKEg_2XD2AEc8_wyQTEv2M9rz2xTqt2g@mail.gmail.com>
Subject: Re: Question about loop device DIO/AIO and FLUSH
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 1, 2016 at 4:54 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> Hi Ming,
>
> I was reading through the code of loop DIO/AIO
> and I was wondering whether lo_req_flush() really
> honors REQ_FLUSH by calling  vfs_fsync() on a backing file
> that is open with O_DIRECT?

>From view of device, REQ_FLUSH just flushs the cache inside
drive to medium.

>
> Shouldn't lo_req_flush() actually wait for completion of
> all the in-flight loop AIO requests to complete?

I think it isn't needed, just like the flush handling in blk-flush.c, and
it just works for completed I/O.

> Am I missing something?
>
> Thanks,
> Amir.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
