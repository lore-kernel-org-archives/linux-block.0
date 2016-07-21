Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH linux-4.7-rc7] blk_stack_limits() setting
 discard_granularity
To: =?UTF-8?Q?Florian-Ewald_M=c3=bcller?=
 <florian-ewald.mueller@profitbricks.com>, linux-block@vger.kernel.org
References: <CAHJVUej82MtyPdVXdU82Hj=HgdXRuqng5nQxgrznUBq8rB0Rng@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3e8dcc7f-8502-b0b2-3c0a-43db0c3d7433@kernel.dk>
Date: Thu, 21 Jul 2016 12:56:04 -0600
MIME-Version: 1.0
In-Reply-To: <CAHJVUej82MtyPdVXdU82Hj=HgdXRuqng5nQxgrznUBq8rB0Rng@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/21/2016 12:09 PM, Florian-Ewald M�ller wrote:
> blk_stack_limits() can set discard_granularity bigger than
> max_discard_sectors (in bytes).
> This makes blk_bio_discard_split() non-functional and can lead to data
> corruption.

Let's get rid of the unlikely(), this isn't a hot path.

-- 
Jens Axboe
