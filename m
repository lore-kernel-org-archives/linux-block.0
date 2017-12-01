Return-Path: <ivan@ludios.org>
MIME-Version: 1.0
In-Reply-To: <20171201133546.GA11483@ming.t460p>
References: <87fu8v7xe2.fsf@ksca2.i-did-not-set--mail-host-address--so-tickle-me>
 <20171201085051.GA1308@ming.t460p> <CAKynti+h_-MuR7YXsiYHqTv7xCiy1QhRUyu=zCcb9brwR2ByxQ@mail.gmail.com>
 <20171201133546.GA11483@ming.t460p>
From: Ivan Kozik <ivan@ludios.org>
Date: Fri, 1 Dec 2017 14:46:39 +0000
Message-ID: <CAKyntiKzyPK7MVg-WqOhzLsVx5o2zw+OMp1Bw_wTCWa8-T5kdQ@mail.gmail.com>
Subject: Re: blk-mq + bfq IO hangs after writing partition table
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, paolo.valente@linaro.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, oleksandr@natalenko.name
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 1, 2017 at 1:35 PM, Ming Lei <ming.lei@redhat.com> wrote:
> Basically all IO hang happen inside get_request(), and seems this issue
> isn't related with recent change in V4.15, could you run V4.14 to see if
> there is such issue?

I tried several times and I could not reproduce the problem on linus's v4.14.

Also, while testing, I noticed that udev rules can switch out the IO
scheduler after gdisk writes partitions, but this appears to be
unrelated to the problem, just something to remember when testing.

Thanks,

Ivan
