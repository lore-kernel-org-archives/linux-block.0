Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40710 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932116AbcFIPz6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 11:55:58 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] cfq: priority boost on meta/prio marked IO
References: <20160608204347.GA30146@kernel.dk>
Date: Thu, 09 Jun 2016 11:55:56 -0400
In-Reply-To: <20160608204347.GA30146@kernel.dk> (Jens Axboe's message of "Wed,
	8 Jun 2016 14:43:47 -0600")
Message-ID: <x49k2hyz78z.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi, Jens,

Jens Axboe <axboe@fb.com> writes:

> At Facebook, we have a number of cases where people use ionice to set a
> lower priority, then end up having tasks stuck for a long time because
> eg meta data updates from an idle priority tasks is blocking out higher
> priority processes. It's bad enough that it will trigger the softlockup
> warning.

I expect a higher prio process could be blocked on a lower prio process
reading the same metadata, too.  I had a hard time tracking down where
REQ_META WRITE I/O was issued outside of the journal or writeback paths
(and I hope you're not ionice-ing those!).  Eventually, with the help of
sandeen, I found some oddball cases that I doubt you're running into.
Can you enlighten me as to where this (REQ_META write I/O) is happening?
I don't disagree that it's a problem, I just would like to understand
your problem case better.

Anyway, it seems to me you could just set REQ_PRIO in the code paths you
care about instead of modifying CFQ to treat REQ_META and REQ_PRIO as
the same thing, which essentially undoes commit 65299a3b788bd ("block:
separate priority boosting from REQ_META") from Christoph.

Thanks!
Jeff
