Return-Path: <linux-block-owner@vger.kernel.org>
Received: from h19-45-4-185.rev.hosting.nbs-system.com ([185.4.45.19]:38895
        "EHLO owa.groupeot.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932134AbdHWPyf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 11:54:35 -0400
From: Benoit Depail <benoit.depail@nbs-system.com>
Subject: Re: [Xen-users] File-based domU - Slow storage write since xen 4.8
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
CC: Keith Busch <keith.busch@intel.com>, <linux-block@vger.kernel.org>,
        <xen-users@lists.xen.org>, WebDawg <webdawg@gmail.com>
References: <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
 <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
 <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
 <20170720173606.GD1202@localhost.localdomain>
 <3443d6ac-9011-85fb-3613-bacdee184fcc@nbs-system.com>
 <20170721155333.GG1202@localhost.localdomain>
 <20170721160712.74ee5f3xztbecanw@dhcp-3-128.uk.xensource.com>
 <6d76c489-1f1a-205f-434d-8fa1a486d2c4@nbs-system.com>
 <20170725222505.GH11979@localhost.localdomain>
 <1642cf06-d9a3-1037-e3c9-6b6b3fc9db2d@nbs-system.com>
 <20170801094831.cr2brqudqubcinxt@dhcp-3-128.uk.xensource.com>
 <46b4bdb3-25c4-076e-3401-0506688e2d83@nbs-system.com>
Message-ID: <f647e1d9-7527-96c5-7f65-774dbf6cef66@nbs-system.com>
Date: Wed, 23 Aug 2017 17:54:20 +0200
MIME-Version: 1.0
In-Reply-To: <46b4bdb3-25c4-076e-3401-0506688e2d83@nbs-system.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/02/17 18:29, Benoit Depail wrote:
> On 08/01/2017 11:48 AM, Roger Pau Monné wrote:
>> On Fri, Jul 28, 2017 at 04:50:27PM +0200, Benoit Depail wrote:
>>> On 07/26/17 00:25, Keith Busch wrote:
>>>> On Fri, Jul 21, 2017 at 07:07:06PM +0200, Benoit Depail wrote:
>>>>> On 07/21/17 18:07, Roger Pau Monné wrote:
>>>>>>
>>>>>> Hm, I'm not sure I follow either. AFAIK this problem came from
>>>>>> changing the Linux version in the Dom0 (where the backend, blkback is
>>>>>> running), rather than in the DomU right?
>>>>>>
>>>>>> Regarding the queue/sectors stuff, blkfront uses several blk_queue
>>>>>> functions to set those parameters, maybe there's something wrong
>>>>>> there, but I cannot really spot what it is:
>>>>>>
>>>>>> http://elixir.free-electrons.com/linux/latest/source/drivers/block/xen-blkfront.c#L929
>>>>>>
>>>>>> In the past the number of pages that could fit in a single ring
>>>>>> request was limited to 11, but some time ago indirect descriptors
>>>>>> where introduced in order to lift this limit, and now requests can
>>>>>> have a much bigger number of pages.
>>>>>>
>>>>>> Could you check the max_sectors_kb of the underlying storage you are
>>>>>> using in Dom0?
>>>>>>
>>>>>> Roger.
>>>>>>
>>>>> I checked the value for the loop device as well
>>>>>
>>>>> With 4.4.77 (bad write performance)
>>>>> $ cat /sys/block/sda/queue/max_sectors_kb
>>>>> 1280
>>>>> $ cat /sys/block/loop1/queue/max_sectors_kb
>>>>> 127
>>>>>
>>>>>
>>>>> With 4.1.42 (normal write performance)
>>>>> $ cat /sys/block/sda/queue/max_sectors_kb
>>>>> 4096
>>>>> $ cat /sys/block/loop1/queue/max_sectors_kb
>>>>> 127
>>>>
>>>> Thank you for the confirmations so far. Could you confirm performance dom0
>>>> running 4.4.77 with domU running 4.1.42, and the other way around? Would
>>>> like to verify if this is just isolated to blkfront.
>>>>
>>> Hi,
>>>
>>> I've ran the tests, and I can tell that the domU kernel version have no
>>> influence on the performance.
>>>
>>> Dom0 with 4.4.77 always shows bad performance, wether the domU runs
>>> 4.1.42 or 4.4.77.
>>>
>>> Dom0 with 4.1.42 always shows good performance, wether the domU runs
>>> 4.1.42 or 4.4.77.
>>
>> Hello,
>>
>> I haven't yet got time to look into this sadly. Can you please try to
>> use fio [0] in order to run the tests against the loop device in Dom0?
>>
>> If possible, could you test several combinations of block sizes, I/O
>> sizes and I/O depths?
>>
>> Thanks, Roger.
>>
>> [0] http://git.kernel.dk/?p=fio.git;a=summary
>>
> 
> Ok I'll give a try later when I have more time. Probably next week.
> 
> Thanks,
> 

Hi,

I had some time to play around with fio. I am not really sure what I was
supposed to do with it so I made a wild guess.

Using the setup showing bad write performances (dom0 with v4.4.77), I
ran a fio job with the following parameters :

[global]
size=5g
filename=<device>
direct=1
readwrite=write

[job1]
runtime=1m


I then used a loop to change the blocksize from 512 to 8192, steps 512,
and the io depth from 1 to 32, steps 4.

On the loop device (from the dom0), write speed was about 34MB/s most of
the time, reaching 110MB/s with a blocksize multiple of 4096 (4096 and
8192).

On the domU, write speed was the same, but reaching only 52MB/s when the
blocksize is a multiple of 4096.

Io depth did not show any significant change.

Feel free to suggest any improvment on my bench suit.

Thansk,

-- 
Benoit Depail
Senior Infrastructures Architect
NBS System
