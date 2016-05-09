Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Stephen Bates <stephen.bates@microsemi.com>
To: "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH 0/2] Block: Give option to force io polling
Date: Mon, 9 May 2016 14:53:30 +0000
Message-ID: <D87A37E7A4AA544D853031D9A919C70B16901010@avsrvexchmbx2.microsemi.net>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <D87A37E7A4AA544D853031D9A919C70B168FDA58@avsrvexchmbx2.microsemi.net>
 <20160508090257.GG15458@infradead.org>
In-Reply-To: <20160508090257.GG15458@infradead.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@fb.com" <axboe@fb.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jon Derrick <jonathan.derrick@intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

> On Thu, May 05, 2016 at 07:44:29PM +0000, Stephen Bates wrote:
> > I am very interested in seeing this added. There are use cases involving
> super-low latency (non-NAND based) NVMe devices and they want the
> fastest possible IO response times for ALL IO to that device. They also have
> no desire to wait for the new system calls and glibc updates needed to tie
> their applications into polling or to rewrite their applications to avail of those
> new calls. I have done some testing on Jon's "big hammer" and it seems to
> work well for this use case and applied cleanly against v4.6-rc6.
> 
> Let's get the driver for those devices merged first, and if you can provide
> numbers that it's worth it we can add a tweak to always enable polling from
> the driver for those devices.

Christoph, this is a DRAM based NVMe device, the code for polling in NVMe was merged in 4.5 right? We are using the inbox NVMe driver. Here is some performance data:

QD=1, single thread, random 4KB reads

Polling Off: 12us Avg / 40us 99.99% ;
Polling On: 9.5us Avg / 25us 99.99%

Both the average and 99.99% reduction are of interest.

Cheers

Stephen

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
