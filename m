Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@redhat.com>, y2038@lists.linaro.org,
        Hannes Reinecke <hare@suse.com>, Mike Christie <mchristi@redhat.com>,
        Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: avoid using timespec
References: <20160617145849.3771756-1-arnd@arndb.de>
	<20160617113648.69448c9f@gandalf.local.home>
	<57646E09.9080408@kernel.dk>
Date: Fri, 17 Jun 2016 17:54:16 -0400
In-Reply-To: <57646E09.9080408@kernel.dk> (Jens Axboe's message of "Fri, 17
	Jun 2016 23:39:21 +0200")
Message-ID: <x494m8r5vnb.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:

> On 06/17/2016 05:36 PM, Steven Rostedt wrote:
>>
>> Jens,
>>
>> You want to take this, or do you want me to?
>
> I'll add it to my 4.8 tree, thanks Arnd.

+	/* need to check user space to see if this breaks in y2038 or y2106 */

Userspace just uses it to print the timestamp, right?  So do we need the
comment?

-Jeff
