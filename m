Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeAEUR0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 15:17:26 -0500
Subject: Re: [GIT PULL 18/25] lightnvm: set target over-provision on create
 ioctl
To: Javier Gonzalez <javier@cnexlabs.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Cc: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hans Holmberg (C)" <hans.holmberg@cnexlabs.com>
References: <20180105131621.20808-1-m@bjorling.me>
 <20180105131621.20808-19-m@bjorling.me>
 <fd47bd97-8ff7-1f6a-b07f-c86449ec1834@infradead.org>
 <D8E890A0-DBC8-4C0C-9AB9-62D9BB1CC9F2@cnexlabs.com>
 <05ea1992-8dae-f961-b2e0-a93727edc2b5@bjorling.me>
 <A85FDAC1-5A0C-4F09-AB6D-B08A388A918B@cnexlabs.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2d6747af-8287-e9e7-60a7-3047811ce45e@infradead.org>
Date: Fri, 5 Jan 2018 12:17:23 -0800
MIME-Version: 1.0
In-Reply-To: <A85FDAC1-5A0C-4F09-AB6D-B08A388A918B@cnexlabs.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/05/2018 11:56 AM, Javier Gonzalez wrote:
>> On 5 Jan 2018, at 20.53, Matias Bjørling <m@bjorling.me> wrote:
>>
>> On 01/05/2018 08:52 PM, Javier Gonzalez wrote:
>>>> On 5 Jan 2018, at 20.33, Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>
>>>> On 01/05/2018 05:16 AM, Matias Bjørling wrote:
>>>>> From: Javier González <javier@cnexlabs.com>
>>>>>
>>>>> Allow to set the over-provision percentage on target creation. In case
>>>>> that the value is not provided, fall back to the default value set by
>>>>> the target.
>>>>>
>>>>> In pblk, set the default OP to 11% of the total size of the device
>>>>
>>>>> +#define PBLK_DEFAULT_OP (11)
>>>>
>>>> Hi,
>>>> Just curious -- where does 11 come from?  Is it a spec value?
>>> 11 stands for 11% over-provisioning for the media to allow garbage
>>> collection. Different SSDs have different values based on the targeted
>>> workload - 11% is a common default value for standard drives.
>>> The spec. does not specify any default values of over-provisioning.
>>> Javier.
>>
>> I think what Randy means is, why is the value not 20% or 7%, which is the traditional over-provisioning on SSDs.
> 
> We decided 11% based on customer input, but 7% and 20% are also good
> default values. I'm ok with having any of those as default - anyone
> caring about OP will define the value on target creation, which is the
> primary objective of this patch.

Got it.  Thanks.

-- 
~Randy
