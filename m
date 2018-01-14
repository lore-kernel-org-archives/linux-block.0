Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <772a286e-48f9-37c5-3687-06ba17322ca3@oracle.com>
References: <20180109162953.1211451-1-tj@kernel.org> <1515790585.2396.50.camel@wdc.com>
 <3b2ad58c-837a-a084-fdb5-7e8913e5e285@kernel.dk> <1515791983.2396.65.camel@wdc.com>
 <772a286e-48f9-37c5-3687-06ba17322ca3@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 14 Jan 2018 23:45:04 +0800
Message-ID: <CACVXFVO_F5nRSC4o=N7cVM6DU+C9HxPqy2UxJwQKCxNfiME5SQ@mail.gmail.com>
Subject: Re: [PATCHSET v5] blk-mq: reimplement timeout handling
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, "jbacik@fb.com" <jbacik@fb.com>,
	"tj@kernel.org" <tj@kernel.org>, "jack@suse.cz" <jack@suse.cz>, "clm@fb.com" <clm@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sun, Jan 14, 2018 at 11:12 PM, jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
>
>
> On 01/13/2018 05:19 AM, Bart Van Assche wrote:
>> Sorry but I only retrieved the blk-mq debugfs several minutes after the hang
>> started so I'm not sure the state information is relevant. Anyway, I have attached
>> it to this e-mail. The most remarkable part is the following:
>>
>> ./000000009ddfa913/requeue_list:000000009646711c {.op=READ, .state=idle, gen=0x1
>> 18, abort_gen=0x0, .cmd_flags=, .rq_flags=SORTED|1|SOFTBARRIER|IO_STAT, complete
>> =0, .tag=-1, .internal_tag=217}
>>
>> The hexadecimal number at the start is the request_queue pointer (I modified the
>> blk-mq-debugfs code such that queues are registered with there address just after
>> creation and until a name is assigned). This is a dm-mpath queue.
>
> There seems to be something wrong in hctx->nr_active.

Then looks it is same with the issue I saw during starting multipathd, and the
following patch should fix that, if there isn't other issue.

        https://marc.info/?l=linux-block&m=151586577400558&w=2

-- 
Ming Lei
