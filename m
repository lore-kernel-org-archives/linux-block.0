Return-Path: <famz@redhat.com>
Date: Thu, 30 Jun 2016 14:35:54 +0800
From: Fam Zheng <famz@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Jens Axboe <axboe@kernel.dk>,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jiri Kosina <jikos@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shaohua Li <shli@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Keith Busch <keith.busch@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        dan.j.williams@intel.com
Subject: Re: [PATCH v2 00/12] gendisk: Generate uevent after attribute
 available
Message-ID: <20160630063554.GE23296@ad.usersys.redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
 <20160630062442.GA19761@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160630062442.GA19761@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, 06/29 23:24, Christoph Hellwig wrote:
> On Thu, Jun 30, 2016 at 09:59:41AM +0800, Fam Zheng wrote:
> > Documentation/kobject.txt:
> > > Use the KOBJ_ADD action for when the kobject is first added to the kernel.
> > > This should be done only after any attributes or children of the kobject
> > > have been initialized properly, as userspace will instantly start to look
> > > for them when this call happens.
> > 
> > Unfortunately it seems impossible to fix this generally without touching the
> > offending callers.  The approach I'm proposing here is adding a flag to
> > suppress uevent in add_disk(), which is patch 1, then in later patches, convert
> > any caller to only trigger the uevent when attributes are added.
> 
> We (or rather Dan) is touching most add_disk callers anyway for the
> driverfs_dev removal.  Let's just pass the array of attributes to
> a disk_add variant and solve the issue for real.

I thought about that. Its usage is more compact compared to this series, but is
also more code and less flexible IMO.  For example, we need at least two
variants, for attribute_group and device_attribute separately, right?

Fam
