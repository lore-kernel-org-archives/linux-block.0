Return-Path: <federico.willer@gmail.com>
Return-Path: <federico.willer@gmail.com>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
To: Bart Van Assche <bvanassche@acm.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Paolo Valente <paolo.valente@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>,
 Adrian Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
 Artem Bityutskiy <dedekind1@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Mark Brown <broonie@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jonathan Corbet <corbet@lwn.net>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <1539615735.129692.3.camel@acm.org>
From: Federico Motta <federico@willer.it>
Message-ID: <39c65b8e-c13c-5a84-cc28-5b06345dd568@willer.it>
Date: Tue, 16 Oct 2018 18:14:26 +0200
MIME-Version: 1.0
In-Reply-To: <1539615735.129692.3.camel@acm.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/15/18 5:02 PM, Bart Van Assche wrote:
> On Mon, 2018-10-15 at 16:10 +0200, Linus Walleij wrote:
>> + * For blk-mq devices, we default to using:
>> + * - "none" for multiqueue devices (nr_hw_queues != 1)
>> + * - "bfq", if available, for single queue devices
>> + * - "mq-deadline" if "bfq" is not available for single queue devices
>> + * - "none" for single queue devices as well as last resort
> 
> For SATA SSDs nr_hw_queues == 1 so this patch will also affect these SSDs.
> Since this patch is an attempt to improve performance, I'd like to see
> measurement data for one or more recent SATA SSDs before a decision is
> taken about what to do with this patch. 
> 
> Thanks,
> 
> Bart.
> 

Hi,
although these tests should be run for single-queue devices, I tried to
run them on an NVMe high-performance device. Imho if results are good
in such a "difficult to deal with" multi-queue device, they should be
good enough also in a "simpler" single-queue storage device..

Testbed specs:
kernel = 4.18.0 (from bfq dev branch [1], where bfq already contains
                 also the commits that will be available from 4.20)
fs     = ext4
drive  = ssd samsung 960 pro NVMe m.2 512gb

Device data sheet specs state that under random IO:
* QD  1 thread 1
  * read  = 14 kIOPS
  * write = 50 kIOPS
* QD 32 thread 4
  * read = write = 330 kIOPS

What follows is a results summary; under requests I can give all
results. The workload notation (e.g. 5r5w-seq) means:
- num_readers                  (5r)
- num_writers                  (5w)
- sequential_io or random_io   (-seq)


# replayed gnome-terminal startup time (lower is better)
workload  bfq-mq [s]  none [s]  % gain
--------  ----------  --------  ------
 10r-seq    0.3725      2.79     86.65
5r5w-seq    0.9725      5.53     82.41

# throughput (higher is better)
workload   bfq-mq [mb/s]  none [mb/s]   % gain
---------  -------------  -----------  -------
 10r-rand       394.806      429.735    -8.128
 10r-seq       1387.63      1431.81     -3.086
  1r-seq        838.13       798.872     4.914
5r5w-rand      1118.12      1297.46    -13.822
5r5w-seq       1187         1313.8      -9.651

Thanks,
Federico

[1] https://github.com/Algodev-github/bfq-mq/commits/bfq-mq
