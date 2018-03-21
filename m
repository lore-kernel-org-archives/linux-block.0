Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34017 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753344AbeCUT15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Mar 2018 15:27:57 -0400
Received: by mail-lf0-f66.google.com with SMTP id c78-v6so4890686lfh.1
        for <linux-block@vger.kernel.org>; Wed, 21 Mar 2018 12:27:56 -0700 (PDT)
Subject: Re: [PATCH 08/12] lightnvm: implement get log report chunk helpers
To: Keith Busch <keith.busch@intel.com>
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
References: <1520004080-27760-1-git-send-email-javier@cnexlabs.com>
 <1520004080-27760-9-git-send-email-javier@cnexlabs.com>
 <8a0a3bad-26a4-ca2f-4bd8-5c71858f6d00@lightnvm.io>
 <20180321143617.GD12909@localhost.localdomain>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <67b77f5d-fa35-1199-10c5-12fb8a324a64@lightnvm.io>
Date: Wed, 21 Mar 2018 20:27:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180321143617.GD12909@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/21/2018 03:36 PM, Keith Busch wrote:
> On Wed, Mar 21, 2018 at 03:06:05AM -0700, Matias Bjørling wrote:
>>> outside of nvme core so that we can use it form lightnvm.
>>>
>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>> ---
>>>    drivers/lightnvm/core.c      | 11 +++++++
>>>    drivers/nvme/host/core.c     |  6 ++--
>>>    drivers/nvme/host/lightnvm.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
>>>    drivers/nvme/host/nvme.h     |  3 ++
>>>    include/linux/lightnvm.h     | 24 ++++++++++++++
>>>    5 files changed, 115 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 2e9e9f973a75..af642ce6ba69 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -2127,9 +2127,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>>    	return ret;
>>>    }
>>>    
>>> -static int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>> -			    u8 log_page, void *log,
>>> -			    size_t size, size_t offset)
>>> +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>> +		     u8 log_page, void *log,
>>> +		     size_t size, size_t offset)
>>>    {
>>>    	struct nvme_command c = { };
>>>    	unsigned long dwlen = size / 4 - 1;
>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>> index 08f0f6b5bc06..ffd64a83c8c3 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -35,6 +35,10 @@ enum nvme_nvm_admin_opcode {
>>>    	nvme_nvm_admin_set_bb_tbl	= 0xf1,
>>>    };
>>>    
>>
>> <snip>
>>
>>>    
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index 1ca08f4993ba..505f797f8c6c 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -396,6 +396,9 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
>>>    int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
>>>    int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
>>>    
>>> +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>> +		     u8 log_page, void *log, size_t size, size_t offset);
>>> +
>>>    extern const struct attribute_group nvme_ns_id_attr_group;
>>>    extern const struct block_device_operations nvme_ns_head_ops;
>>>    
>>
>>
>> Keith, Christoph, Sagi, Is it okay that these two changes that exposes
>> the nvme_get_log_ext fn are carried through Jens' tree after the nvme
>> tree for 4.17 has been pulled?
> 
> That's okay with me. Alteratively, if you want to split the generic nvme
> part out, I can apply that immediately and the API will be in the first
> nvme-4.17 pull request.
> 

Will do. I've sent the patch in another mail. Thanks! :)
