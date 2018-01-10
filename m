Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/4] block: convert REQ_ATOM_COMPLETE to stealing
 rq->__deadline bit
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "osandov@fb.com" <osandov@fb.com>
References: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
 <1515544167-10751-4-git-send-email-axboe@kernel.dk>
 <1515608975.2745.14.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1ce2cc85-1217-c0a8-2ca3-afe3e1c3845c@kernel.dk>
Date: Wed, 10 Jan 2018 11:32:14 -0700
MIME-Version: 1.0
In-Reply-To: <1515608975.2745.14.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/10/18 11:29 AM, Bart Van Assche wrote:
> On Tue, 2018-01-09 at 17:29 -0700, Jens Axboe wrote:
>> @@ -313,8 +307,6 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
>>  	seq_puts(m, ", .rq_flags=");
>>  	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
>>  		       ARRAY_SIZE(rqf_name));
>> -	seq_puts(m, ", .atomic_flags=");
>> -	blk_flags_show(m, rq->atomic_flags, rqaf_name, ARRAY_SIZE(rqaf_name));
>>  	seq_printf(m, ", .tag=%d, .internal_tag=%d", rq->tag,
>>  		   rq->internal_tag);
>>  	if (mq_ops->show_rq)
> 
> Whether or not a request has been marked complete is very useful to know. Have you
> considered to show the return value of blk_rq_is_complete() in the debugfs output?

Yeah, that's a good point. Let me add that in lieu of the atomic flags that
are being killed. Are you fine with the patch then?

-- 
Jens Axboe
