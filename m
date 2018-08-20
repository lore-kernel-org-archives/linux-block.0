Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534478043-7170-2-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVPZF7ohzUib4Nr1qdHLwjpEWP4+be6h6GmZh1y9-qsVqg@mail.gmail.com> <96657784-dd95-6ea9-3ffd-25737c534075@oracle.com>
In-Reply-To: <96657784-dd95-6ea9-3ffd-25737c534075@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 20 Aug 2018 10:24:14 +0800
Message-ID: <CACVXFVMqjiSmzL2JeLUV2Q4bXqy2WRNHahg-fusFYjHeCX3gng@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] blk-mq: init hctx sched after update ctx and hctx mapping
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@linux.intel.com>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 20, 2018 at 9:29 AM jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
>
> Hi Ming
>
> On 08/17/2018 05:33 PM, Ming Lei wrote:
> >> +               /*
> >> +                * elevator_release will put it.
> >> +                */
> >> +               __module_get(q->elv_type->elevator_owner);
> > I understand what elevator_release() frees is the 'ref-counter' got in
> > elevator_get(), but who will be the counter-pair of the above  __module_get()?
>
>
> Sorry for my bad description.
>
> The code path is:
>
> elevator_release
>   -> elevator_put(e->type)
>     -> module_put(e->elevator_owner)
>
> In normal elevator switch path, elevator_get will hold a reference counter of the
> elevator_owner.
> In this patch set, the elevator_type is saved directly. To prevent the io scheduler module
> is removed, we need to hold a reference of the module.

Yeah, I agree that the module reference need to be held, but it need to be
released too.

My concern is that this introduced getting module reference in your patch
isn't released. The module reference is a counter too, so the get and
put operation should be matched.


thanks,
Ming Lei
