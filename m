Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50918 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075AbcFIQFS (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 12:05:18 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] cfq: priority boost on meta/prio marked IO
References: <20160608204347.GA30146@kernel.dk>
	<x49k2hyz78z.fsf@segfault.boston.devel.redhat.com>
	<20160609160046.GA30239@infradead.org>
Date: Thu, 09 Jun 2016 12:05:16 -0400
In-Reply-To: <20160609160046.GA30239@infradead.org> (Christoph Hellwig's
	message of "Thu, 9 Jun 2016 09:00:46 -0700")
Message-ID: <x49bn3az6tf.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Jun 09, 2016 at 11:55:56AM -0400, Jeff Moyer wrote:
>> I expect a higher prio process could be blocked on a lower prio process
>> reading the same metadata, too.  I had a hard time tracking down where
>> REQ_META WRITE I/O was issued outside of the journal or writeback paths
>> (and I hope you're not ionice-ing those!).  Eventually, with the help of
>> sandeen, I found some oddball cases that I doubt you're running into.
>> Can you enlighten me as to where this (REQ_META write I/O) is happening?
>> I don't disagree that it's a problem, I just would like to understand
>> your problem case better.
>
> XFS does lots of REQ_META writes from _xfs_buf_ioapply().  But none
> of those should be in the critical path as the all metadata is logged
> first and then written back later.
>
>> Anyway, it seems to me you could just set REQ_PRIO in the code paths you
>> care about instead of modifying CFQ to treat REQ_META and REQ_PRIO as
>> the same thing, which essentially undoes commit 65299a3b788bd ("block:
>> separate priority boosting from REQ_META") from Christoph.
>
> And I'm still waiting for someone to explain when exactly REQ_PRIO
> should be used..

I think Jens' bug report is exactly that explanation, no?  To avoid
priority inversion?

-Jeff
