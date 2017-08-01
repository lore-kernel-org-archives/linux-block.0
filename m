Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46315 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdHAXtK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Aug 2017 19:49:10 -0400
Subject: Re: [PATCH] sysfs: replace WARN() with pr_debug in
 sysfs_remove_group()
To: Greg KH <gregkh@linuxfoundation.org>
References: <1501574545-15691-1-git-send-email-ethan.zhao@oracle.com>
 <20170801180635.GA31628@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ethan.kernel@gmail.com
From: Ethan Zhao <ethan.zhao@oracle.com>
Message-ID: <a5701c95-304a-e727-48eb-55ffeec04013@oracle.com>
Date: Wed, 2 Aug 2017 07:49:37 +0800
MIME-Version: 1.0
In-Reply-To: <20170801180635.GA31628@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Grep,


On 2017/8/2 2:06, Greg KH wrote:
> On Tue, Aug 01, 2017 at 05:02:25PM +0900, Ethan Zhao wrote:
>> There is no enough error handling in block device adding/registration
>> path, for example,
>>
>> device_add_disk()
>>    blk_register_queue()
>>
>> When kernel returns from device_add_disk(), no return value to tell
>> us it was successful or not --- that suggests it would always succeed,
>> and according to this assumption, then during block device removal/
>> unregistration steps,
>>
>> sd_remove()
>>    del_gendisk()
>>      blk_unregister_queue()
>>
>> dpm_sysfs_remove(), blk_trace_remove_sysfs() will be called blindly,
>> though there is likely no 'trace' 'power' sysfs groups there because
>> actually blk_register_queue()/device_add() failed somewhere. thus
>> causes WARN flood emitted from sysfs_remove_group() as following triggered
>> by unloading fnic driver:
> Then fix the real issue here, don't paper over the issue by changing the
> sysfs core please.  No other subsystem seems to be having this issue.
   Yep, I agree it is kind of cover up block layer issue.

  Thanks,
  Ethan
> thanks,
>
> greg k-h
>
