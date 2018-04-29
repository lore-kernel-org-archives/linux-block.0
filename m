Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme
 <linux-nvme@lists.infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
 <b8dd2c24-a011-7e66-feca-502b0a6b10c0@oracle.com>
 <20180426155722.GA3597@ming.t460p>
 <325688af-3ae2-49db-3a59-ef3903adcdf6@oracle.com>
 <20180427145708.GA2767@ming.t460p>
 <18b7ab23-f0d6-6765-021a-28c225f8a990@oracle.com>
 <CACVXFVPwV7cAChndWXxg8A2onJu5Ngr9fpKVvLjNwMqDPM9yJg@mail.gmail.com>
 <CACVXFVPZV2+3XcWUD0fkxf=oRx7bBhU=J=hnhaEURgZvBUC4xA@mail.gmail.com>
 <CACVXFVO5anknwHUdPpHVBMvirh93UDS__qVrJvw7R_ThY+yjGA@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <22dfe86b-8981-cc66-4a5b-216aa26dd003@oracle.com>
Date: Sun, 29 Apr 2018 10:21:21 +0800
MIME-Version: 1.0
In-Reply-To: <CACVXFVO5anknwHUdPpHVBMvirh93UDS__qVrJvw7R_ThY+yjGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi ming

On 04/29/2018 09:36 AM, Ming Lei wrote:
> On Sun, Apr 29, 2018 at 6:27 AM, Ming Lei <tom.leiming@gmail.com> wrote:
>> On Sun, Apr 29, 2018 at 5:57 AM, Ming Lei <tom.leiming@gmail.com> wrote:
>>> On Sat, Apr 28, 2018 at 10:00 PM, jianchao.wang
>>> <jianchao.w.wang@oracle.com> wrote:
>>>> Hi ming
>>>>
>>>> On 04/27/2018 10:57 PM, Ming Lei wrote:
>>>>> I may not understand your point, once blk_sync_queue() returns, the
>>>>> timer itself is deactivated, meantime the synced .nvme_timeout() only
>>>>> returns EH_NOT_HANDLED before the deactivation.
>>>>>
>>>>> That means this timer won't be expired any more, so could you explain
>>>>> a bit why timeout can come again after blk_sync_queue() returns
>>>>
>>>> Please consider the following case:
>>>>
>>>> blk_sync_queue
>>>>   -> del_timer_sync
>>>>                           blk_mq_timeout_work
>>>>                             -> blk_mq_check_expired // return the timeout value
>>>>                             -> blk_mq_terninate_expired
>>>>                               -> .timeout //return EH_NOT_HANDLED
>>>>                             -> mod_timer // setup the timer again based on the result of blk_mq_check_expired
>>>>   -> cancel_work_sync
>>>> So after the blk_sync_queue, the timer may come back again, then the timeout work.
>>>
>>> OK, I was trying to avoid to use blk_abort_request(), but looks we
>>> may have to depend on it or similar way.
>>>
>>> BTW, that means blk_sync_queue() has been broken, even though the uses
>>> in blk_cleanup_queue().
>>>
>>> Another approach is to introduce one perpcu_ref of
>>> 'q->timeout_usage_counter' for
>>> syncing timeout, seems a bit over-kill too, but simpler in both theory
>>> and implement.
>>
>> Or one timout_mutex is enough.
> 
> Turns out it is SRCU.
> 
after split the timeout path into timer and workqueue two parts, if we don't drain the in-flight requests, the request_queue->timeout and the timeout work look like an issue of 'chicken and egg'.
how about introduce a flag to disable triggering of timeout work ?


Thanks
Jianchao
