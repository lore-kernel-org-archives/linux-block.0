Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36616 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbcGaRy1 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Sun, 31 Jul 2016 13:54:27 -0400
Received: by mail-oi0-f54.google.com with SMTP id w18so166755771oiw.3
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2016 10:54:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d83eeac2-49dc-4c45-9aea-7d68da4fbf7d@redhat.com>
References: <622794958.9574724.1469674652262.JavaMail.zimbra@redhat.com>
 <1762637089.9575520.1469676013321.JavaMail.zimbra@redhat.com>
 <CAPcyv4g5PpShWfXSV+KPJYW7GFrejUNjk=C1-ak=88iX8XczGA@mail.gmail.com>
 <CAPcyv4gGLfLbCWmzb5Yt+oVp2pKuGwVv6iY__O_DPmaV__OZDQ@mail.gmail.com> <d83eeac2-49dc-4c45-9aea-7d68da4fbf7d@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 31 Jul 2016 10:54:25 -0700
Message-ID: <CAPcyv4hxP8aDyzsoeG9XH5ygtNWypU8fUj+qCNKh2wWa+PJh6w@mail.gmail.com>
Subject: Re: [BUG] kernel NULL pointer dereference observed during pmem btt
 switch test
To: yizhan <yizhan@redhat.com>
Cc: linux-nvdimm <linux-nvdimm@ml01.01.org>,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jul 31, 2016 at 10:19 AM, yizhan <yizhan@redhat.com> wrote:
> On 07/30/2016 11:52 PM, Dan Williams wrote:
>>
>> On Thu, Jul 28, 2016 at 8:50 AM, Dan Williams <dan.j.williams@intel.com>
>> wrote:
>>>
>>> [ adding linux-block ]
>>>
>>> On Wed, Jul 27, 2016 at 8:20 PM, Yi Zhang <yizhan@redhat.com> wrote:
>>>>
>>>> Hello everyone
>>>>
>>>> Could you help check this issue, thanks.
>>>>
>>>> Steps I used:
>>>> 1. Reserve 4*8G of memory for pmem by add kernel parameter "memmap=8G!4G
>>>> memmap=8G!12G memmap=8G!20G memmap=8G!28G"
>>>> 2. Execute below script
>>>> #!/bin/bash
>>>> pmem_btt_switch() {
>>>>          sector_size_list="512 520 528 4096 4104 4160 4224"
>>>>          for sector_size in $sector_size_list; do
>>>>                  ndctl create-namespace -f -e namespace${1}.0
>>>> --mode=sector -l $sector_size
>>>>                  ndctl create-namespace -f -e namespace${1}.0 --mode=raw
>>>>          done
>>>> }
>>>>
>>>> for i in 0 1 2 3; do
>>>>          pmem_btt_switch $i &
>>>> done
>>>
>>> Thanks for the report.  This looks like del_gendisk() frees the
>>> previous usage of the devt before the bdi is unregistered.  This
>>> appears to be a general problem with all block drivers, not just
>>> libnvdimm, since blk_cleanup_queue() is typically called after
>>> del_gendisk().  I.e. it will always be the case that the bdi
>>> registered with the devt allocated at add_disk() will still be alive
>>> when del_gendisk()->disk_release() frees the previous devt number.
>>>
>>> I *think* the path forward is to allow the bdi to hold a reference
>>> against the blk_alloc_devt() allocation until it is done with it.  Any
>>> other ideas on fixing this object lifetime problem?
>>
>> Does the attached patch solve this for you?
>
> Hi Dan
> This patch works and the issue cannot be reproduced after several times'
> test, thanks

Thank you!

> Another thing is during the bug verifying, I found below error message,
> could you check whether it is reasonable:
> [  150.464620] Dev pmem1: unable to read RDB block 0
> [  150.486897]  pmem1: unable to read partition table
> [  150.486901] pmem1: partition table beyond EOD, truncated
> [  151.133287] Buffer I/O error on dev pmem3, logical block 2, async page
> read
> [  151.164620] Buffer I/O error on dev pmem3, logical block 2, async page
> read
>

This test is racing block device registration versus teardown.  These
messages are expected and are likely coming from the block queue
percpu ref being marked dead while the partition scan runs.  When this
happens blk_queue_enter() in generic_make_request() returns errors for
every new I/O submission while blk_cleanup_queue() runs.
