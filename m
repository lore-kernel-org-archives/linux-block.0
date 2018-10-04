Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1538692972.8223.7.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Bart Van Assche <bvanassche@acm.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Linus Walleij <linus.walleij@linaro.org>, linux-block
 <linux-block@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Ulf Hansson
 <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, Artem
 Bityutskiy <dedekind1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>, Mel Gorman
 <mgorman@suse.com>, Chunyan Zhang <zhang.chunyan@linaro.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Date: Thu, 04 Oct 2018 15:42:52 -0700
In-Reply-To: <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
	 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
	 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
	 <1538582091.205649.20.camel@acm.org>
	 <20181004202553.71c2599c@alans-desktop> <1538683746.230807.9.camel@acm.org>
	 <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-10-04 at 22:39 +-0200, Paolo Valente wrote:
+AD4 No, kernel build is, for evident reasons, one of the workloads I cared
+AD4 most about.  Actually, I tried to focus on all my main
+AD4 kernel-development tasks, such as also git checkout, git merge, git
+AD4 grep, ...
+AD4 
+AD4 According to my test results, with BFQ these tasks are at least as
+AD4 fast as, or, in most system configurations, much faster than with the
+AD4 other schedulers.  Of course, at the same time the system also remains
+AD4 responsive with BFQ.
+AD4 
+AD4 You can repeat these tests using one of my first scripts in the S
+AD4 suite: kern+AF8-dev+AF8-tasks+AF8-vs+AF8-rw.sh (usually, the older the tests, the more
+AD4 hypertrophied the names I gave :) ).
+AD4 
+AD4 I stopped sharing also my kernel-build results years ago, because I
+AD4 went on obtaining the same, identical good results for years, and I'm
+AD4 aware that I tend to show and say too much stuff.

On my test setup building the kernel is slightly slower when using the BFQ
scheduler compared to using scheduler +ACI-none+ACI (kernel 4.18.12, NVMe SSD,
single CPU with 6 cores, hyperthreading disabled). I am aware that the
proposal at the start of this thread was to make BFQ the default for devices
with a single hardware queue and not for devices like NVMe SSDs that support
multiple hardware queues.

What I think is missing is measurement results for BFQ on a system with
multiple CPU sockets and against a fast storage medium. Eliminating
the host lock from the SCSI core yielded a significant performance
improvement for such storage devices. Since the BFQ scheduler locks and
unlocks bfqd-+AD4-lock for every dispatch operation it is very likely that BFQ
will slow down I/O for fast storage devices, even if their driver only
creates a single hardware queue.

Bart.
