Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbeB1EyQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 23:54:16 -0500
Subject: Re: [PATCH v7 9/9] bcache: stop bcache device when backing device is
 offline
To: Michael Lyle <mlyle@lyle.org>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Junhui Tang <tang.junhui@zte.com.cn>
References: <20180227165557.20442-1-colyli@suse.de>
 <20180227165557.20442-10-colyli@suse.de>
 <f4eb2061-67d7-28a3-6187-6390ff974836@lyle.org>
From: Coly Li <colyli@suse.de>
Message-ID: <3cbe4681-e9a8-0b1a-15f2-b75d7a0cdcf5@suse.de>
Date: Wed, 28 Feb 2018 12:54:06 +0800
MIME-Version: 1.0
In-Reply-To: <f4eb2061-67d7-28a3-6187-6390ff974836@lyle.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 28/02/2018 2:20 AM, Michael Lyle wrote:
> Hi Coly Li--
> 
> Just a couple of questions.
> 
> On 02/27/2018 08:55 AM, Coly Li wrote:
>> +#define BACKING_DEV_OFFLINE_TIMEOUT 5
> 

Hi Mike,

> I think you wanted this to be 30 (per commit message)-- was this turned
> down for testing or deliberate?
> 

Currently the correct timeout is 5 seconds. The 30 seconds was for the
condition when the offline backing device came back within 30 seconds,
which is not implemented yet. In general after 5 seconds, the offline
device will be deleted from system, if it comes back again the device
name might be changed (e.g. from /dev/sdc to /dev/sdd) with different
bdev index. I need to recognize the new coming drive is previous offline
one, and modify bcache internal data structures to link to the new
device name. This requires more details and effort, and I decided to
work on it later as a separate topic. Obviously I didn't update patch
commit log properly. Thanks for point out this :-)

>> +static int cached_dev_status_update(void *arg)
>> +{
>> +	struct cached_dev *dc = arg;
>> +	struct request_queue *q;
>> +	char buf[BDEVNAME_SIZE];
>> +
>> +	/*
>> +	 * If this delayed worker is stopping outside, directly quit here.
>> +	 * dc->io_disable might be set via sysfs interface, so check it
>> +	 * here too.
>> +	 */
>> +	while (!kthread_should_stop() && !dc->io_disable) {
>> +		q = bdev_get_queue(dc->bdev);
>> +		if (blk_queue_dying(q))
> 
> I am not sure-- is this the correct test to know if the bdev is offline?
>  It's very sparsely used outside of the core block system.  (Is there
> any scenario where the queue comes back?  Can the device be "offline"
> and still have a live queue?  Another approach might be to set
> io_disable when there's an extended period without a successful IO, and
> it might be possible to do this with atomics without a thread).
> 

I asked blocker layer developers Ming Lei, this is the methods suggested
 for now. And in my test, it works as expected.

Anyway, using a kernel thread to monitor device status is ugly, the
reason I have to do it this way is because there is no general notifier
for block layer device offline or failure. There is a bus notifier, but
for devices have no bus, it does not work well. So I am also thinking of
the possibility for a generic notifier for block device offline or
failure, if it can be done someday, we can just register a callback
routine, and not need an extra kernel thread.

> This approach can work if you're certain that blk_queue_dying is an
> appropriate test for all failure scenarios (I just don't know).

So far it works well, and I am collaborating with our partners to test
the patch set, no negative report so far.

Thanks.

Coly Li
