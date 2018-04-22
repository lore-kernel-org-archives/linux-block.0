Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: testing io.low limit for blk-throttle
To: Paolo Valente <paolo.valente@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <180654d2-17ef-0d25-bef6-f526e9ec4ea3@oracle.com>
Date: Sun, 22 Apr 2018 21:29:56 +0800
MIME-Version: 1.0
In-Reply-To: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Paolo

I used to meet similar issue on io.low.
Can you try the following patch to see whether the issue could be fixed.
https://marc.info/?l=linux-block&m=152325456307423&w=2
https://marc.info/?l=linux-block&m=152325457607425&w=2

Thanks
Jianchao

On 04/22/2018 05:23 PM, Paolo Valente wrote:
> Hi Shaohua, all,
> at last, I started testing your io.low limit for blk-throttle.  One of
> the things I'm interested in is how good throttling is in achieving a
> high throughput in the presence of realistic, variable workloads.
> 
> However, I seem to have bumped into a totally different problem.  The
> io.low parameter doesn't seem to guarantee what I understand it is meant
> to guarantee: minimum per-group bandwidths.  For example, with
> - one group, the interfered, containing one process that does sequential
>   reads with fio
> - io.low set to 100MB/s for the interfered
> - six other groups, the interferers, with each interferer containing one
>   process doing sequential read with fio
> - io.low set to 10MB/s for each interferer
> - the workload executed on an SSD, with a 500MB/s of overall throughput
> the interfered gets only 75MB/s.
> 
> In particular, the throughput of the interfered becomes lower and
> lower as the number of interferers is increased.  So you can make it
> become even much lower than the 75MB/s in the example above.  There
> seems to be no control on bandwidth.
> 
> Am I doing something wrong?  Or did I simply misunderstand the goal of
> io.low, and the only parameter for guaranteeing the desired bandwidth to
> a group is io.max (to be used indirectly, by limiting the bandwidth of
> the interferers)?
> 
> If useful for you, you can reproduce the above test very quickly, by
> using the S suite [1] and typing:
> 
> cd thr-lat-with-interference
> sudo ./thr-lat-with-interference.sh -b t -w 100000000 -W "10000000 10000000 10000000 10000000 10000000 10000000" -n 6 -T "read read read read read read" -R "0 0 0 0 0 0"
> 
> Looking forward to your feedback,
> Paolo
> 
> [1] 
> 
