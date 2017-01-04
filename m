Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [patch] block: fix up io_poll documentation
References: <x49zij74v0q.fsf@segfault.boston.devel.redhat.com>
	<87783960-96e2-fd51-6d70-5e8a74a0d25b@kernel.dk>
Date: Wed, 04 Jan 2017 09:49:44 -0500
In-Reply-To: <87783960-96e2-fd51-6d70-5e8a74a0d25b@kernel.dk> (Jens Axboe's
	message of "Tue, 3 Jan 2017 16:46:53 -0700")
Message-ID: <x49r34iyj5j.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:

> On 01/03/2017 03:51 PM, Jeff Moyer wrote:
>> 
>> /sys/block/<dev>/queue/io_poll is a boolean.  Fix the docs.
>> 
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>> 
>> diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
>> index 5164215..c0a3bb5 100644
>> --- a/Documentation/block/queue-sysfs.txt
>> +++ b/Documentation/block/queue-sysfs.txt
>> @@ -54,9 +54,9 @@ This is the hardware sector size of the device, in bytes.
>>  
>>  io_poll (RW)
>>  ------------
>> -When read, this file shows the total number of block IO polls and how
>> -many returned success.  Writing '0' to this file will disable polling
>> -for this device.  Writing any non-zero value will enable this feature.
>> +When read, this file shows whether polling is enabled (1) or disabled
>> +(0).  Writing '0' to this file will disable polling for this device.
>> +Writing any non-zero value will enable this feature.
>
> It seems to be describing the mq hw queue io_poll file description when
> read, for the queue/ one it's different. I'll apply the patch, thanks.

Right.  It's probably time to create an mq-sysfs.txt file.

-Jeff
