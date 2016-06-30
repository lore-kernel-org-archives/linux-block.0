Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Wed, 29 Jun 2016 23:24:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fam Zheng <famz@redhat.com>
Subject: Re: [PATCH v2 00/12] gendisk: Generate uevent after attribute
 available
Message-ID: <20160630062442.GA19761@infradead.org>
References: <20160630015953.6888-1-famz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Shaohua Li <shli@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>, Jiri Kosina <jikos@kernel.org>,
 linux-block@vger.kernel.org, dan.j.williams@intel.com,
 "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-raid@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, linux-mtd@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 30, 2016 at 09:59:41AM +0800, Fam Zheng wrote:
> Documentation/kobject.txt:
> > Use the KOBJ_ADD action for when the kobject is first added to the kernel.
> > This should be done only after any attributes or children of the kobject
> > have been initialized properly, as userspace will instantly start to look
> > for them when this call happens.
> 
> Unfortunately it seems impossible to fix this generally without touching the
> offending callers.  The approach I'm proposing here is adding a flag to
> suppress uevent in add_disk(), which is patch 1, then in later patches, convert
> any caller to only trigger the uevent when attributes are added.

We (or rather Dan) is touching most add_disk callers anyway for the
driverfs_dev removal.  Let's just pass the array of attributes to
a disk_add variant and solve the issue for real.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
