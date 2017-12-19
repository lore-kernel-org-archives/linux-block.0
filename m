Return-Path: <vbatts@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8d1baf35-3f94-a6d7-7e05-0f90acbefde0@kernel.dk>
References: <20171218074044.1369-1-ming.lei@redhat.com> <8d1baf35-3f94-a6d7-7e05-0f90acbefde0@kernel.dk>
From: Vincent Batts <vbatts@redhat.com>
Date: Tue, 19 Dec 2017 11:25:10 -0500
Message-ID: <CANcsyS5uP5C-Qb0QhnyrQFKe9cVPkY-_cW8BdV4QtRC79YOKsA@mail.gmail.com>
Subject: Re: [PATCH 0/2] block: fix two regressiones on bounce
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, NeilBrown <neilb@suse.com>,
	Michele Ballabio <barra_cuda@katamail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Just got a confirmation that this patch set, when applied to the 4.14
branch, fixes the issue.

On Mon, Dec 18, 2017 at 3:22 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 12/18/2017 12:40 AM, Ming Lei wrote:
>> Hi Jens,
>>
>> The 1st patch makes sure that passthrough IO won't enter .make_request_fn.
>>
>> The 2nd one fixes blk_rq_append_bio(), which is from your post with
>> small change on failure handling.
>
> Thanks Ming, queued up.
>
> --
> Jens Axboe
>
