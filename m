Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33868 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbdACTLK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2017 14:11:10 -0500
Received: by mail-lf0-f65.google.com with SMTP id d16so30888891lfb.1
        for <linux-block@vger.kernel.org>; Tue, 03 Jan 2017 11:10:41 -0800 (PST)
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        lsf-pc@lists.linux-foundation.org
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Vyacheslav.Dubeyko@wdc.com
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
Date: Tue, 3 Jan 2017 20:10:38 +0100
MIME-Version: 1.0
In-Reply-To: <1483464921.2440.19.camel@dubeyko.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/03/2017 06:35 PM, Viacheslav Dubeyko wrote:
> Hi Matias,
>
> On Tue, 2017-01-03 at 09:56 +0100, Matias Bjørling wrote:
>> On 01/03/2017 12:12 AM, Viacheslav Dubeyko wrote:
>>>
>>> On Mon, 2017-01-02 at 22:06 +0100, Matias Bjørling wrote:
>>>>
>>>> Hi,
>>>>
>>>> The open-channel SSD subsystem is maturing, and drives are
>>>> beginning
>>>> to
>>>> become available on the market.
>>> What do you mean? We still have nothing on the market. I haven't
>>> opportunity to access to any of such device. Could you share your
>>> knowledge where and what device can be bought on the market?
>>>
>> Hi Vyacheslav,
>>
>> You are right that they are not available off the shelf at a
>> convenient
>> store. You may contact one of these vendors for availability: CNEX
>> Labs
>> (Westlake LightNVM SDK), Radian Memory Systems (RMS-325), and/or EMC
>> (OX
>> Controller + Dragon Fire card).
>
> We, Western Digital, contacted with CNEX Labs about a half year ago.
> Our request was refused. Also we contacted with Radian Memory Systems
> about a year ago. Our negotiations finished with no sucess at all. And
> I doubt that EMC will share with us something. So, such situation looks
> really weird, especially for the case of open-source community. We
> cannot access or test any Open-channel SSD nor for money nor under NDA.
> Usually, open-source means that everybody has access to hardware and we
> can discuss implementation, architecture or approach without any
> restrictions. But we haven't access to hardware right now. I understand
> the business model and blah, blah, blah. But it looks like that,
> finally, we have nothing like Open-channel SSD on the market, from my
> personal point of view. And I suppose that it's really tricky way to
> discuss software interface or any other details about something that
> doesn't exist at all. Because if I cannot take and test some hardware
> then I cannot build my own opinion about this technology.
>

I understand your frustration. It is annoying not having easy access to 
hardware. As you properly are aware, similarly with host-managed SMR 
drives, there are customers that use your drives, while not being 
available off-the-shelf.

All of the open-channel SSD work is done in the open. Patches, new 
targets, and so forth are being developed for everyone to see. 
Similarly, the NVMe host interface is developed in the open as well. The 
interface allows one to implements supporting firmware. The "front-end" 
of the FTL on the SSD, is removed, and the "back-end" engine is exposed. 
It is not much work and given HGST already have an SSD firmware 
implementation. I bet you guys can whip up an internal implementation in 
a matter of weeks. If you choose to do so, I will bend over backwards to 
help you sort out any quirks that might be.

Another option is to use the qemu extension. We are improving it 
continuously to make sure it follows the implementation of a real 
hardware OCSSDs. Today we do 90% of our FTL work using qemu, and most of 
the time it just works when we run the FTL code on real hardware.

Similarly to vendors that provide new CPUs, NVDIMMs, and graphic 
drivers. Some code and refactoring go in years in advance. What I am 
proposing here is to discuss how OCSSDs fits into the storage stack, and 
what we can do to improve it. Optimally, most of the lightnvm subsystem 
can be removed by exposing vectored I/Os. Which then enables 
implementation of a target to be a traditional device mapper module. 
That would be great!
