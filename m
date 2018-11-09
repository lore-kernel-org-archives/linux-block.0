Return-Path: <manjunath.b.patil@oracle.com>
Subject: Re: [Xen-devel] [PATCH v2] xen-blkfront: fix kernel panic with
 blkfront_remove()
To: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc: axboe@kernel.dk, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <1541725843-2019-1-git-send-email-manjunath.b.patil@oracle.com>
 <9414b993-15f6-941a-fc2b-e96147e4fb26@suse.com>
From: Manjunath Patil <manjunath.b.patil@oracle.com>
Message-ID: <28e89b14-add7-348d-f054-975af74bdf52@oracle.com>
Date: Fri, 9 Nov 2018 11:08:56 -0800
MIME-Version: 1.0
In-Reply-To: <9414b993-15f6-941a-fc2b-e96147e4fb26@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

oops! sorry for not noticing this.

-Manjunath

On 11/8/2018 10:16 PM, Juergen Gross wrote:
> On 09/11/2018 02:10, Manjunath Patil wrote:
>> When we try to detach the device, blkfront_remove() tries to access
>> blkfront_info leading to kernel panic.
>>
>> Typical call stack involving panic -
>>   #10 page_fault at ffffffff816f25df
>>       [exception RIP: blkif_free+46]
>>   #11 blkfront_remove at ffffffffa004de47 [xen_blkfront]
>>   #12 xenbus_dev_remove at ffffffff813faa4c
>>   #13 __device_release_driver at ffffffff814769aa
>>   #14 device_release_driver at ffffffff81476a63
>>   #15 bus_remove_device at ffffffff814762eb
>>   #16 device_del at ffffffff81472684
>>   #17 device_unregister at ffffffff814727e2
>>   #18 xenbus_dev_changed at ffffffff813fa89f
>>   #19 frontend_changed at ffffffff813fca19
>>   #20 xenwatch_thread at ffffffff813f88f9
>>   #21 kthread at ffffffff810a486b
>>   #22 ret_from_fork at ffffffff816ed2a8
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> Commit f92898e7f32e3 already added that.
>
>
> Juergen
