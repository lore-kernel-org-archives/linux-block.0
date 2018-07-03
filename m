Return-Path: <axboe@kernel.dk>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V3 3/3] blk-mq: dequeue request one by one from sw queue iff hctx is busy
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20180703012346.GA24254@ming.t460p>
Date: Mon, 2 Jul 2018 19:52:27 -0600
Cc: linux-block@vger.kernel.org,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Laurence Oberman <loberman@redhat.com>, Omar Sandoval <osandov@fb.com>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Message-Id: <8EB84C90-DD18-41D7-BFA9-882D79D13BC3@kernel.dk>
References: <20180702093600.10315-1-ming.lei@redhat.com> <20180702093600.10315-4-ming.lei@redhat.com> <f120df41-a378-23e5-3dab-28398cd49d4e@kernel.dk> <20180703012346.GA24254@ming.t460p>
To: Ming Lei <ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Jul 2, 2018, at 7:23 PM, Ming Lei <ming.lei@redhat.com> wrote:
>=20
>> On Mon, Jul 02, 2018 at 11:30:17AM -0600, Jens Axboe wrote:
>>> On 7/2/18 3:36 AM, Ming Lei wrote:
>>> It won't be efficient to dequeue request one by one from sw queue,
>>> but we have to do that when queue is busy for better merge performance.
>>>=20
>>> This patch takes EWMA to figure out if queue is busy, then only dequeue
>>> request one by one from sw queue when queue is busy.
>>=20
>> Just one minor comment, since you're going to be updating this one
>> anyway:
>>=20
>>> @@ -1209,8 +1234,11 @@ bool blk_mq_dispatch_rq_list(struct request_queue=
 *q, struct list_head *list,
>>>        else if (needs_restart && (ret =3D=3D BLK_STS_RESOURCE))
>>>            blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
>>>=20
>>> +        blk_mq_update_hctx_busy(hctx, true);
>>> +
>>>        return false;
>>=20
>> Kill that newline between update and return.
>>=20
>> Rest looks fine to me now, though I do agree with Christophs comments on
>> making the weight and factor in caps.
>>=20
>> Applying 1-2/3 so far.
>=20
> Hi Jens,
>=20
> Not sure if 3 is applied now given your for-4.19/block isn't public yet.
> So please let me know if you need me to re-send 3.

Please send a new 3/3, didn=E2=80=99t apply it yet. I haven=E2=80=99t pushed=
 out my 4.19 branch yet, since I may have to rebase it. It=E2=80=99ll come o=
ut soon.=20
