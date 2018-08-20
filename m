Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2 1/2] blk-mq: init hctx sched after update ctx and hctx
 mapping
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534478043-7170-2-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVPZF7ohzUib4Nr1qdHLwjpEWP4+be6h6GmZh1y9-qsVqg@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <96657784-dd95-6ea9-3ffd-25737c534075@oracle.com>
Date: Mon, 20 Aug 2018 09:29:36 +0800
MIME-Version: 1.0
In-Reply-To: <CACVXFVPZF7ohzUib4Nr1qdHLwjpEWP4+be6h6GmZh1y9-qsVqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 08/17/2018 05:33 PM, Ming Lei wrote:
>> +               /*
>> +                * elevator_release will put it.
>> +                */
>> +               __module_get(q->elv_type->elevator_owner);
> I understand what elevator_release() frees is the 'ref-counter' got in
> elevator_get(), but who will be the counter-pair of the above  __module_get()?


Sorry for my bad description.

The code path is:

elevator_release
  -> elevator_put(e->type)
    -> module_put(e->elevator_owner)

In normal elevator switch path, elevator_get will hold a reference counter of the
elevator_owner.
In this patch set, the elevator_type is saved directly. To prevent the io scheduler module
is removed, we need to hold a reference of the module.

Thanks
Jianchao
