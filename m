Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 08/28] scsi: kill off the legacy IO path
To: "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-9-axboe@kernel.dk> <1540503399.66186.60.camel@acm.org>
 <30e6eb38-dda5-f4c1-c715-379864268147@kernel.dk>
 <00277AC6-781A-40FB-B9CB-D1E0CB3D0EC6@cavium.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <780fec31-8e4b-9efb-2c3d-91d4e9dcb10e@kernel.dk>
Date: Thu, 25 Oct 2018 17:00:12 -0600
MIME-Version: 1.0
In-Reply-To: <00277AC6-781A-40FB-B9CB-D1E0CB3D0EC6@cavium.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 4:44 PM, Madhani, Himanshu wrote:
> Jens, 
> 
>> On Oct 25, 2018, at 3:18 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> External Email
>>
>> On 10/25/18 3:36 PM, Bart Van Assche wrote:
>>> On Thu, 2018-10-25 at 15:10 -0600, Jens Axboe wrote:
>>>> @@ -3265,25 +3261,17 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>         base_vha->mgmt_svr_loop_id, host->sg_tablesize);
>>>>
>>>>     if (ha->mqenable) {
>>>> -            bool mq = false;
>>>>             bool startit = false;
>>>>
>>>> -            if (QLA_TGT_MODE_ENABLED()) {
>>>> -                    mq = true;
>>>> +            if (QLA_TGT_MODE_ENABLED())
>>>>                     startit = false;
>>>> -            }
>>>>
>>>> -            if ((ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED) &&
>>>> -                shost_use_blk_mq(host)) {
>>>> -                    mq = true;
>>>> +            if (ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED)
>>>>                     startit = true;
>>>> -            }
>>>>
>>>> -            if (mq) {
>>>> -                    /* Create start of day qpairs for Block MQ */
>>>> -                    for (i = 0; i < ha->max_qpairs; i++)
>>>> -                            qla2xxx_create_qpair(base_vha, 5, 0, startit);
>>>> -            }
>>>> +            /* Create start of day qpairs for Block MQ */
>>>> +            for (i = 0; i < ha->max_qpairs; i++)
>>>> +                    qla2xxx_create_qpair(base_vha, 5, 0, startit);
>>>>     }
>>>>
>>>>     if (ha->flags.running_gold_fw)
>>>
>>> (+Himanshu)
>>>
>>> Since I'm not sure that "mq" in the above code refers to "scsi-mq" nor that it
>>> refers to "blk-mq", I'm not sure the above changes should be included in this
>>> patch. Himanshu, can you have a look?
>>
>> There's literally a comment there that says "for Block MQ" :-)
> 
> This change is Good.
> 
> We were using mq boolean to determine if we are in Target mode or Initiator with BLK-MQ on
> to create qpair in firmware.
> 
> Since this patch is removing shost_use_blk_mq)(), so the mq boolean becomes no-op. 

Thanks for checking. Can I add your acked-by or reviewed-by to the patch?

-- 
Jens Axboe
