Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39196 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbeIROIn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 10:08:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id h4-v6so1189742edi.6
        for <linux-block@vger.kernel.org>; Tue, 18 Sep 2018 01:37:08 -0700 (PDT)
Subject: Re: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
To: javier@cnexlabs.com
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
 <4ac29eb8-65bf-f733-d196-80c5bb41876c@lightnvm.io>
 <7493E737-A7F5-4F86-A91D-8BA01755714D@cnexlabs.com>
 <9C271B60-C421-4C9B-99B6-C30B65494095@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <52cca772-f7dc-9e7b-c9aa-92a390533382@lightnvm.io>
Date: Tue, 18 Sep 2018 10:37:04 +0200
MIME-Version: 1.0
In-Reply-To: <9C271B60-C421-4C9B-99B6-C30B65494095@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/11/2018 01:30 PM, Javier Gonzalez wrote:
>> On 11 Sep 2018, at 10.50, Javier Gonzalez <javier@cnexlabs.com> wrote:
>>
>>> On 7 Sep 2018, at 12.28, Matias Bjørling <mb@lightnvm.io> wrote:
>>>
>>> On 08/29/2018 12:09 PM, Javier González wrote:
>>>> In the OCSSD 2.0 spec., the sector and metadata sizes are reported though
>>>> the standard nvme identify command. Thus, the lightnvm subsystem needs
>>>> to update this information on the geometry structure on bootup.
>>>> Since 1.2 devices report these values on the OCSSD geometry identify,
>>>> avoid this update is it is unnecessary and can also corrupt the geometry
>>>> if the devices does not report the nvme sizes correctly (which is not
>>>> required by the OCSSD 1.2 spec either) >
>>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>>> ---
>>>> drivers/nvme/host/lightnvm.c | 3 +++
>>>> 1 file changed, 3 insertions(+)
>>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>>> index 5bfa354c5dd5..33ed09f8410e 100644
>>>> --- a/drivers/nvme/host/lightnvm.c
>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>> @@ -980,6 +980,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>>>> 	struct nvm_dev *ndev = ns->ndev;
>>>> 	struct nvm_geo *geo = &ndev->geo;
>>>> +	if (geo->version == NVM_OCSSD_SPEC_12)
>>>> +		return;
>>>
>>> The lba format sizes are not explicit in 2.0 either. For a conforming drive, it should implement the NVM Command Set and expose the LBA format correctly. Although, I do get your incentive, and if it is okay with you, I'll reword the commit message to this and apply it?:
>>>
>>> "1.2 devices exposes their data and metadata size through the separate
>>> identify command. Make sure that the NVMe LBA format does not override
>>> these values."
>>
>> Sounds good. I'll resend either way as I rebased on top of for-4.20/core
>> - you can change the commit as you think it suits.
> 
> Since Igor will send a patch for the OOB, can you pick this up
> separately? No changes needed after rebase.
> 
> Thanks,
> Javier
> 

Applied for 4.20.
