Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2 1/2] blk-mq: init hctx sched after update ctx and hctx
 mapping
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534478043-7170-2-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVPZF7ohzUib4Nr1qdHLwjpEWP4+be6h6GmZh1y9-qsVqg@mail.gmail.com>
 <96657784-dd95-6ea9-3ffd-25737c534075@oracle.com>
 <CACVXFVMqjiSmzL2JeLUV2Q4bXqy2WRNHahg-fusFYjHeCX3gng@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3ce9f249-4c2f-89a6-727f-9bc449a4fdf4@oracle.com>
Date: Mon, 20 Aug 2018 11:57:52 +0800
MIME-Version: 1.0
In-Reply-To: <CACVXFVMqjiSmzL2JeLUV2Q4bXqy2WRNHahg-fusFYjHeCX3gng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 08/20/2018 10:24 AM, Ming Lei wrote:
>> The code path is:
>>
>> elevator_release
>>   -> elevator_put(e->type)
>>     -> module_put(e->elevator_owner)
>>
>> In normal elevator switch path, elevator_get will hold a reference counter of the
>> elevator_owner.
>> In this patch set, the elevator_type is saved directly. To prevent the io scheduler module
>> is removed, we need to hold a reference of the module.
> Yeah, I agree that the module reference need to be held, but it need to be
> released too.
> 
> My concern is that this introduced getting module reference in your patch
> isn't released. The module reference is a counter too, so the get and
> put operation should be matched.

elevator_switch_mq
  -> elevator_exit
it will put a reference count of the elevator_queue associated with the request_queue.
and the elevator_release will be invoked when the reference count of elevator_queue->kobj reaches zero.
elevator_release will put the reference count of the io scheduler module.

the elevator_queue structure will be allocated and freed every time when we switch io scheduler.
so the elevator_release will always be invoked.

This is the put ref corresponding to the get one in this patch.

Thanks
Jianchao
