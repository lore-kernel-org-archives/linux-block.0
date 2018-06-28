Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
To: Bart Van Assche <bart.vanassche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
 <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
 <d528a730-8e44-225b-2a35-3544160761dc@oracle.com>
 <2c2003ff1baac05688495677f67239d52f6d9527.camel@wdc.com>
 <2a1dda06-5c7c-b75b-c1ae-75d1a2a49694@oracle.com>
 <a0350d07-3c11-c04c-d9ba-94a5868e7d8f@oracle.com>
 <1d4d1dc3-7014-4e2a-1ea5-e1446381b404@wdc.com>
 <07e9e71a-723c-93a8-becb-df5d2f43b690@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <9ee9aee0-9361-b2ef-3124-aa6cab678faf@oracle.com>
Date: Thu, 28 Jun 2018 09:15:32 +0800
MIME-Version: 1.0
In-Reply-To: <07e9e71a-723c-93a8-becb-df5d2f43b690@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 06/28/2018 09:11 AM, jianchao.wang wrote:
> Hi Bart
> 
> On 06/26/2018 11:36 PM, Bart Van Assche wrote:
>> On 06/25/18 20:47, jianchao.wang wrote:
>>> V2 patch has been posted, would you please take a look at on them ?
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dblock-26m-3D152965143412927-26w-3D2&d=DwICaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=FPLHVLVF0V8ZCvwZJx7vHy9v01iAQogJ_IbvseGhElo&s=tQ0ZiK7VrV4j-6K_WEfiWAyxogOrC8hOm6coS9nAmYI&e=
>>
>> Hello Jianchao,
>>
>> Patches 1/3 and 2/3 of that series look fine to me but I don't like the approach of patch 3/3 so please do not expect a review from me for that patch.
>>
> 
> Would you please explain the defects of the patch 3/3 ?

We still need some way to serialize the blk_register/unregister_queue, blk_mq_sysfs_register/unregister and sysfs queue, mq, hctx entries' show and store method. So I didn't introduce another mutex as your suggestions.

> 
> Thanks
> Jianchao
> 
