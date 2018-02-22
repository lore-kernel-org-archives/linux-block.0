Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36064 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeBVJpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 04:45:33 -0500
Received: by mail-lf0-f66.google.com with SMTP id t79so6509240lfe.3
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2018 01:45:32 -0800 (PST)
Subject: Re: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
To: Javier Gonzalez <javier@cnexlabs.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
 <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
 <F70FB36A-967C-4B37-8037-C550249A0C3B@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <ec5d6c53-c3a1-7d66-9db7-407a519f0feb@lightnvm.io>
Date: Thu, 22 Feb 2018 10:45:30 +0100
MIME-Version: 1.0
In-Reply-To: <F70FB36A-967C-4B37-8037-C550249A0C3B@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/22/2018 08:55 AM, Javier Gonzalez wrote:
>> On 22 Feb 2018, at 08.45, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 02/21/2018 10:26 AM, Javier González wrote:
>>> Complete the generic geometry structure with the maxoc and maxocpu
>>> felds, present in the 2.0 spec.
>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>> ---
>>>   drivers/nvme/host/lightnvm.c | 4 ++++
>>>   include/linux/lightnvm.h     | 2 ++
>>>   2 files changed, 6 insertions(+)
>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>> index cca32da05316..9c1f8225c4e1 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -318,6 +318,8 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
>>>   	dev_geo->c.ws_min = sec_per_pg;
>>>   	dev_geo->c.ws_opt = sec_per_pg;
>>>   	dev_geo->c.mw_cunits = 8;		/* default to MLC safe values */
>>> +	dev_geo->c.maxoc = dev_geo->all_luns;	/* default to 1 chunk per LUN */
>>> +	dev_geo->c.maxocpu = 1;			/* default to 1 chunk per LUN */
>>
>> One can't assume that it is 1 open chunk per lun. If you need this for specific hardware, make a quirk for it.
>>
> 
> Which default you want for 1.2 if not specified then? I use 1 because it
> has been the implicit default until now.

INT_MAX, since it then allows the maximum of open chunks. It cannot be 
assumed that other 1.2 devices is limited to a single open chunk.

> 
> Javier
> 
