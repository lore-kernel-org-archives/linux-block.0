Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170918230803.GB4671@localhost.localdomain>
References: <1505772186-4601-1-git-send-email-keith.busch@intel.com>
 <1505772477.12701.6.camel@wdc.com> <20170918223900.GA4671@localhost.localdomain>
 <1505775191.12701.20.camel@wdc.com> <20170918230803.GB4671@localhost.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 19 Sep 2017 12:16:31 +0800
Message-ID: <CACVXFVO4joG1zzipABWK4bc5Rwo9bDa4by4_mFOTx10nQPAUpQ@mail.gmail.com>
Subject: Re: [RFC PATCH] blk-mq: Fix lost request during timeout
To: Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 19, 2017 at 7:08 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, Sep 18, 2017 at 10:53:12PM +0000, Bart Van Assche wrote:
>> On Mon, 2017-09-18 at 18:39 -0400, Keith Busch wrote:
>> > The nvme driver's use of blk_mq_reinit_tagset only happens during
>> > controller initialisation, but I'm seeing lost commands well after that
>> > during normal and stable running.
>> >
>> > The timing is pretty narrow to hit, but I'm pretty sure this is what's
>> > happening. For nvme, this occurs when nvme_timeout() runs concurrently
>> > with nvme_handle_cqe() for the same struct request. For scsi-mq,
>> > the same situation may arise if scsi_mq_done() runs concurrently with
>> > scsi_times_out().
>>
>> Hello Keith,
>>
>> Are you sure that scenario can happen? The blk-mq core calls test_and_set_bit()
>> for the REQ_ATOM_COMPLETE flag before any completion or timeout handler is
>> called. See also blk_mark_rq_complete(). This avoids that the .complete() and
>> .timeout() functions run concurrently.
>
> Indeed that prevents .complete from running concurrently with the
> timeout handler, but scsi_mq_done and nvme_handle_cqe are not .complete
> callbacks. These are the LLD functions that call blk_mq_complete_request
> well before .complete. If the driver calls blk_mq_complete_request on
> a request that blk-mq is timing out, the request is lost because blk-mq
> already called blk_mark_rq_complete. Nothing prevents these LLD functions

That shouldn't happen because only one blk_mark_rq_complete() can win
and it is the winner's responsibility to complete the request, so
there shouldn't
be request lost. Especially in your case, it is the responsibility of timeout
to complete the rq really.

Also your patch removes test_and_clear_bit(REQ_ATOM_STARTED) from
__blk_mq_requeue_request(), which will make timeout to easy to happen
since the period between starting requeue and starting req may be long
enough, and timeout can be triggered because STARTED isn't cleared.

-- 
Ming Lei
