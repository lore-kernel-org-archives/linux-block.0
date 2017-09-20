Return-Path: <longman@redhat.com>
Subject: Re: [PATCH v7] blktrace: Fix potentail deadlock between delete &
 sysfs ops
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
 Bart Van Assche <Bart.VanAssche@wdc.com>
References: <1505928371-27829-1-git-send-email-longman@redhat.com>
 <20170920173552.GA14611@infradead.org>
From: Waiman Long <longman@redhat.com>
Message-ID: <76cc6fea-fd1a-04fb-b18b-04ea5d69dde9@redhat.com>
Date: Wed, 20 Sep 2017 15:05:36 -0400
MIME-Version: 1.0
In-Reply-To: <20170920173552.GA14611@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/20/2017 01:35 PM, Christoph Hellwig wrote:
>> +/*
>> + * When reading or writing the blktrace sysfs files, the references t=
o the
>> + * opened sysfs or device files should prevent the underlying block d=
evice
>> + * from being removed. So no further delete protection is really need=
ed.
>> + *
>> + * Protection from multiple readers and writers accessing blktrace da=
ta
>> + * concurrently is still required. The bd_mutex was used for this pur=
pose.
>> + * That could lead to deadlock with concurrent block device deletion =
and
>> + * sysfs access. As a result, a new blk_trace_mutex is now added to b=
e
>> + * used solely by the blktrace code.
>> + */
> Comments about previous locking schemes really don't have a business
> in the code - those are remarks for the commit logs.  And in general
> please explain the locking scheme near the data that they proctect
> it, as locks should always protected data, not code and the comments
> should follow that.

It seems to be a general practice that we don't put detailed comments in
the header files. The comment was put above the function with the first
instance of the blk_trace_mutex. Yes, I agree that talking about the
past history may not be applicable here. I will keep that in mind in the
future.

Thanks,
Longman
