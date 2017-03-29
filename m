Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Mar 2017 05:09:37 +0200
Message-ID: <CACRpkdbZrkAqEdP1-QqDww0ZuFcY47Jgj9dPqkG_whrx7pwC-w@mail.gmail.com>
Subject: Outstanding MQ questions from MMC
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi folks,

I earlier left some unanswered questions in my MMC to MQ conversion series
but I figured it is better if I collect them and ask the blk-mq
maintainers directly
how to deal with the following situations that occur in the MMC block layer:


1. The current MMC code locks the host when the first request comes in
from blk_fetch_request() and unlocks it when blk_fetch_request() returns
NULL twice in a row. Then the polling thread terminated and is not restarted
until we get called by the mmc_request_fn.

Host locking means that we will not send other commands to the MMC
card from i.e. userspace, which sometimes can send spurious stuff orthogonal
to the block layer. If the block layer has locked the host, userspace
has to wait
and vice versa. It is not a common contention point but it still happens.

In MQ, I have simply locked the host on the first request and then I never
release it. Clearly this does not work. I am uncertain on how to handle this
and whether MQ has a way to tell us that the queue is empty so we may release
the host. I toyed with the idea to just set up a timer, but a "queue
empty" callback
from the block layer is what would be ideal.


2. When MMC cards are ejected a serious error condition occurs. So for this
reason we spool out the queue with

req->rq_flags |= RQF_QUIET;
blk_end_request_all(req, -EIO);

This will shut up a huge amount of console errors for example.
I have no clue on how to manage this with MQ. I am currently using

blk_mq_complete_request(mq_rq->req, -EIO);

and nothing else, and it will hit all requests for the ejected card coming
in from this point. Is this the right solution? Or is there some medium
eject handling I'm not aware of inside the MQ layer? It seems like something
that can happen on pluggable harddrives and CDROMS and what not.


3. Sometimes a read or write gets partially completed. Say we read 12 out
of 15 sectors or somthing like that. I have no idea how often this occurs in
practice. With the old block layer we did this:

blk_end_request(req, 0, bytes_xfered);

It seems MQ cannot handle partially completed transfers. I currently do this:

blk_mq_requeue_request(req, false);

I do not feel that is the right thing to do either, and would like
recommendations
on how to proceed with this.


Yours,
Linus Walleij
