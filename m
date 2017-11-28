Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:41333 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933932AbdK1K6s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Nov 2017 05:58:48 -0500
Received: by mail-it0-f44.google.com with SMTP id x28so489102ita.0
        for <linux-block@vger.kernel.org>; Tue, 28 Nov 2017 02:58:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4e7a58f7-39ef-9937-c54c-da6fe9edd1e3@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
 <1511271770-3444-14-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFrA5NVQ2Ei7rf7o7N0iHCHLHkntObnPP9hjToKrLr-TAg@mail.gmail.com>
 <1d7de4aa-f528-c3f8-bfc4-7d69301f8591@intel.com> <CAPDyKFr8tiJXSL-weQjGJ3DfRrfv8ZAFY8=ZECLNgSe_43S8Rw@mail.gmail.com>
 <4e7a58f7-39ef-9937-c54c-da6fe9edd1e3@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 28 Nov 2017 11:58:47 +0100
Message-ID: <CAPDyKFp--BBK-j3chmSHT2moVTuU7JHiu5BnL1NdHudDuvLkQQ@mail.gmail.com>
Subject: Re: [PATCH V14 13/24] mmc: block: Add blk-mq support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

[...]

>>>>> +
>>>>> +enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>>>>> +{
>>>>> +       struct mmc_blk_data *md = mq->blkdata;
>>>>> +       struct mmc_card *card = md->queue.card;
>>>>> +       struct mmc_host *host = card->host;
>>>>> +       int ret;
>>>>> +
>>>>> +       ret = mmc_blk_part_switch(card, md->part_type);
>>>>
>>>> What if there is an ongoing request, shouldn't you wait for that to
>>>> complete before switching partition?
>>>
>>> Two requests on the same queue cannot be on different partitions because we
>>> have a different queue (and block device) for each partition.
>>
>> That's not true for RPMB anymore I am afraid.
>>
>> RPMB shares the same queue as for the main eMMC partition, which is
>> because we strive towards fair I/O scheduling across the hole device.
>
> I hadn't thought of RPMB, but I think the logic is OK, which is good because
> it is the same as we presently have.  Here the md->part_type will be the
> main area even for RPMB.  So this switch won't do anything if we have a
> request in flight.  Then inside __mmc_blk_ioctl_cmd() the switch to RPMB is
> done, and afterwards mmc_blk_issue_drv_op() switches it back again.

Yes, you are right! No worries then!

[...]

>>>
>>> You are right, this logic does not support parallel dispatches.
>>>
>>
>> This do raises a question, don't you think it would be beneficial,
>> especially for CQE to allow parallel dispatches?
>>
>> I am not saying we should change this at this point, just that we may
>> consider changing this for future improvements.
>
> I think the benefit is limited because the time to dispatch a request is
> small compared with the time to complete a request. i.e. a number of
> requests can be queued before the first one has completed.  But yes, it is
> something to keep in mind.

Yeah, let's leave this for future considerations.

Kind regards
Uffe
