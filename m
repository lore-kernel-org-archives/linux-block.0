Return-Path: <htd+ml@fritha.org>
Date: Sun, 16 Apr 2017 10:14:12 +0200
From: Heinz Diehl <htd+ml@fritha.org>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH V3 00/16] Introduce the BFQ I/O scheduler
Message-ID: <20170416081412.GA1966@fritha.org>
References: <20170411134315.44135-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170411134315.44135-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On 11.04.2017, Paolo Valente wrote: 

> new patch series, addressing (both) issues raised by Bart [1].

I'm doing a lot of automatic video transcoding in order to get my
collection of homemade videos down to an acceptable size (mainly
landscapes and boats all over the Norwegian west coast, taken with an old
cam that only produces uncompressed files). This process
involves heavy permanent writing to disk, often over a period of 10
min and more. When this happens, the whole system is kind of
unresponsive. I'm running Fedora 25, but with a self-customised kernel
that is fully low-latency, and the machine is a quadcore Intel Xeon
which should have enough power (Intel(R) Xeon(R) CPU E3-1241 v3 @
3.50GHz).

Using plain blk-mq, the system is very sluggish when there is heavy
disk writing, and it can take up to several minutes (up to the point
where the disk writing actually finishes) to start programs like gimp
or Libreoffice. In fact, when I click on the "applications" button
within XFCE, it can take a long time before the window even opens.
I played with deadline-mq too, and the situation remains the same
unless I do some heavy tuning like this:

echo "mq-deadline" > /sys/block/nvme0n1/queue/scheduler
echo "1" > /sys/block/nvme0n1/queue/iosched/fifo_batch
echo "4" > /sys/block/nvme0n1/queue/iosched/writes_starved
echo "100" > /sys/block/nvme0n1/queue/iosched/read_expire
echo "2000" > /sys/block/nvme0n1/queue/iosched/write_expire

With deadline-mq tuned like this, overall responsiveness is a little bit
better, but not nearly as good as when using bfq. With plain bfq, no
tuning is needed. The system is no longer sluggish. Any program starts
within seconds, and all is very much responsive. Max throughput isn't
important to me, the nvme "harddisk" is fast enough that some MB/s
more or less do not really matter.

[root@chiara ~]# lspci -v | grep -i nvme
01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe
SSD Controller SM951/PM951 (rev 01) (prog-if 02 [NVM Express])
	Kernel driver in use: nvme
	Kernel modules: nvme

As an end-user with no relevant programming skills to be able to
contribute, I would wish that developers would combine their forces and
help Paolo to get bfq into the kernel and to make bfq even better.

Thanks,
 Heinz
 
