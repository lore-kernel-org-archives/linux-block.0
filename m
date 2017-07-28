Return-Path: <linux-block-owner@vger.kernel.org>
Received: from h19-45-4-185.rev.hosting.nbs-system.com ([185.4.45.19]:38684
        "EHLO owa.groupeot.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752320AbdG1Ous (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2017 10:50:48 -0400
Subject: Re: [Xen-users] File-based domU - Slow storage write since xen 4.8
To: Keith Busch <keith.busch@intel.com>
CC: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        <linux-block@vger.kernel.org>, <xen-users@lists.xen.org>,
        WebDawg <webdawg@gmail.com>
References: <5dd18982-cbcf-a675-1e07-5b4c4e4da50e@nbs-system.com>
 <20170717164658.drliebetcnil3wjb@dhcp-3-128.uk.xensource.com>
 <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
 <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
 <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
 <20170720173606.GD1202@localhost.localdomain>
 <3443d6ac-9011-85fb-3613-bacdee184fcc@nbs-system.com>
 <20170721155333.GG1202@localhost.localdomain>
 <20170721160712.74ee5f3xztbecanw@dhcp-3-128.uk.xensource.com>
 <6d76c489-1f1a-205f-434d-8fa1a486d2c4@nbs-system.com>
 <20170725222505.GH11979@localhost.localdomain>
From: Benoit Depail <benoit.depail@nbs-system.com>
Message-ID: <1642cf06-d9a3-1037-e3c9-6b6b3fc9db2d@nbs-system.com>
Date: Fri, 28 Jul 2017 16:50:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170725222505.GH11979@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/26/17 00:25, Keith Busch wrote:
> On Fri, Jul 21, 2017 at 07:07:06PM +0200, Benoit Depail wrote:
>> On 07/21/17 18:07, Roger Pau Monné wrote:
>>>
>>> Hm, I'm not sure I follow either. AFAIK this problem came from
>>> changing the Linux version in the Dom0 (where the backend, blkback is
>>> running), rather than in the DomU right?
>>>
>>> Regarding the queue/sectors stuff, blkfront uses several blk_queue
>>> functions to set those parameters, maybe there's something wrong
>>> there, but I cannot really spot what it is:
>>>
>>> http://elixir.free-electrons.com/linux/latest/source/drivers/block/xen-blkfront.c#L929
>>>
>>> In the past the number of pages that could fit in a single ring
>>> request was limited to 11, but some time ago indirect descriptors
>>> where introduced in order to lift this limit, and now requests can
>>> have a much bigger number of pages.
>>>
>>> Could you check the max_sectors_kb of the underlying storage you are
>>> using in Dom0?
>>>
>>> Roger.
>>>
>> I checked the value for the loop device as well
>>
>> With 4.4.77 (bad write performance)
>> $ cat /sys/block/sda/queue/max_sectors_kb
>> 1280
>> $ cat /sys/block/loop1/queue/max_sectors_kb
>> 127
>>
>>
>> With 4.1.42 (normal write performance)
>> $ cat /sys/block/sda/queue/max_sectors_kb
>> 4096
>> $ cat /sys/block/loop1/queue/max_sectors_kb
>> 127
> 
> Thank you for the confirmations so far. Could you confirm performance dom0
> running 4.4.77 with domU running 4.1.42, and the other way around? Would
> like to verify if this is just isolated to blkfront.
> 
Hi,

I've ran the tests, and I can tell that the domU kernel version have no
influence on the performance.

Dom0 with 4.4.77 always shows bad performance, wether the domU runs
4.1.42 or 4.4.77.

Dom0 with 4.1.42 always shows good performance, wether the domU runs
4.1.42 or 4.4.77.

Thanks,

-- 
Benoit Depail
Senior Infrastructures Architect
NBS System
