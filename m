Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
 <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
 <d528a730-8e44-225b-2a35-3544160761dc@oracle.com>
 <2c2003ff1baac05688495677f67239d52f6d9527.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <2a1dda06-5c7c-b75b-c1ae-75d1a2a49694@oracle.com>
Date: Thu, 21 Jun 2018 16:23:58 +0800
MIME-Version: 1.0
In-Reply-To: <2c2003ff1baac05688495677f67239d52f6d9527.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 06/21/2018 12:18 AM, Bart Van Assche wrote:
> On Wed, 2018-06-20 at 10:09 +0800, jianchao.wang wrote:
>> It is very easy to reproduce with following scripts.
>>
>> script 0
>> while true
>> do
>> 	modprobe null_blk queue_mode=2 shared_tags=1
>> 	sleep 0.1
>> 	rmmod null_blk
>> 	sleep 0.1
>> done
>>
>> script 1
>> file0="/sys/block/nullb0/mq/0/nr_tags"
>> file1="/sys/block/nullb0/mq/0/cpu0/rq_list"
>> while true;
>> do
>> 	if [ -e $file0 ];then
>> 		cat $file0
>> 	fi
>> 	if [ -e $file1 ];then
>> 		cat $file1
>> 	fi
>> done
> 
> Hello Jianchao,
> 
> Thanks for having shared a reproducer. However, the approach of the patch you
> posted doesn't seem like the right approach to me. I propose to proceed as
> follows:
> * Convert the reproducer into a blktests test and submit is as a patch to the
>   blktests project (https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_osandov_blktests&d=DwIGaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=_TjwODcX-0o-OZfrVTFMpvbS0QbYxoya17aHM9pZAXw&s=wdVpTkE6PJX3GXvjXNwEup3opdflyCGY324CAYXSixY&e=).
> * Remove the mutex_lock/unlock(&sysfs_lock) calls from blk_cleanup_queue().
>   These calls are useless.  Block drivers are required to call del_gendisk()
>   before calling blk_cleanup_queue(). That means that sysfs attributes are
>   removed synchronously before blk_cleanup_queue() is called. The following
>   statement in blk_cleanup_queue() verifies that:
>     WARN_ON_ONCE(q->kobj.state_in_sysfs);
>   BTW, this also means that the blk_queue_dying() checks in various show and
>   store methods are superfluous.
> * Introduce a new mutex to serialize blk_mq_register_dev() and
>   blk_mq_sysfs_register() and blk_mq_sysfs_unregister(). I think it is wrong
>   that these functions use sysfs_mutex.
> * Document the purpose of sysfs_mutex in include/linux/blkdev.h, namely to
>   serialize the sysfs .show() and .store() callback functions and also to
>   serialize elevator changes.
> 

Really appreciate your kindly and detailed directive.
I will post the V2 version based on your suggestions later.

Thanks
Jianchao
> 
> 
> 
