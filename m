Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38229 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbcGCI0G (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Sun, 3 Jul 2016 04:26:06 -0400
MIME-Version: 1.0
In-Reply-To: <CACVXFVOFpJqPLjw2z8jKEg_2XD2AEc8_wyQTEv2M9rz2xTqt2g@mail.gmail.com>
References: <CAOQ4uxhEzr=yaFPO4ZVzndct84VC6c57W5DNEtqUHUcBjdTjQg@mail.gmail.com>
 <CACVXFVOFpJqPLjw2z8jKEg_2XD2AEc8_wyQTEv2M9rz2xTqt2g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 3 Jul 2016 11:26:03 +0300
Message-ID: <CAOQ4uxjsWJkgr1sJ3_PaZiCswzuwSDPfcHA6z3yWk6EdcO9quQ@mail.gmail.com>
Subject: Re: Question about loop device DIO/AIO and FLUSH
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 1, 2016 at 9:57 AM, Ming Lei <ming.lei@canonical.com> wrote:
> On Fri, Jul 1, 2016 at 4:54 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>> Hi Ming,
>>
>> I was reading through the code of loop DIO/AIO
>> and I was wondering whether lo_req_flush() really
>> honors REQ_FLUSH by calling  vfs_fsync() on a backing file
>> that is open with O_DIRECT?
>
> From view of device, REQ_FLUSH just flushs the cache inside
> drive to medium.
>
>>
>> Shouldn't lo_req_flush() actually wait for completion of
>> all the in-flight loop AIO requests to complete?
>
> I think it isn't needed, just like the flush handling in blk-flush.c, and
> it just works for completed I/O.

Thanks Ming and Christoph.
I see what I was missing.

>
>> Am I missing something?
>>
>> Thanks,
>> Amir.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-block" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
