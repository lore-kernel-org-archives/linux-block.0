Return-Path: <longman@redhat.com>
Subject: Re: [PATCH v3] blktrace: Fix potentail deadlock between delete &
 sysfs ops
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1503078848-15779-1-git-send-email-longman@redhat.com>
 <1503079624.2622.10.camel@wdc.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <e7767695-e0b3-17d5-f54e-88b9cf170e60@redhat.com>
Date: Fri, 18 Aug 2017 15:55:13 -0400
MIME-Version: 1.0
In-Reply-To: <1503079624.2622.10.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 02:07 PM, Bart Van Assche wrote:
> On Fri, 2017-08-18 at 13:54 -0400, Waiman Long wrote:
>> Instead, a global blktrace
>> mutex will be used to serialize the read/write of the blktrace sysfs
>> attributes.
> Hello Waiman,
>
> Using a mutex to serialize code is wrong. What is needed is exact
> documentation of what data structures and/or member variables are
> protected by bdev->bd_mutex and by blktrace_mutex.

Yes, I missed the blk_trace_ioctl(). I should have modified it to use
blktrace_mutex as well.

> Also, please spell "potential" correctly in the subject of this patch.

Will do.

Thanks,
Longman
