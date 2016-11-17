Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Thu, 17 Nov 2016 05:12:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCH v1 0/7] SED OPAL Library
Message-ID: <20161117131251.GA15852@infradead.org>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
In-Reply-To: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, sagi@grimberg.me, axboe@fb.com,
 linux-nvme@lists.infradead.org, keith.busch@intel.com,
 Rafael.Antognolli@intel.com, linux-block@vger.kernel.org,
 jonathan.derrick@intel.com, j.naumann@fu-berlin.de
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Hi Scott,

I took a look at the code and here are some very high level comments:

 - we only call into block_device_operations.sec_ops from the ioctl
   handlers.  So instead of adding it to the block layer I'd rather
   structure the code so that the driver itself calls a new common
   blkdev_sed_ioctl handler implemented in lib/sed.c, which then gets
   callbacks passed directly from the calling, similar to how
   opal_unlock_from_suspend works.  And the callbacks might actually
   be condensed to one I think, given that all potential
   implementations would basically just dispatch to two
   different opcode but otherwise use the same implementation.
 - talking about lib/sed*.c - I'd move it to block/
 - there are a lot of levels of indirection in the code, I think
   we can condense them down a bit to basically just having the
   main blkdev_sed_ioctl entry point, which should check
   bdev_sec_capable first, and then dispatch to the security
   types, probably through a little method table.
 - what's so special about request_user_key that it can't be inline
   into the only caller but needs a separate file?
 - please don't use pointer indirections in your userspace ABI,
   struct sed_key will be a pain to handle for 32-bit userspace
   on 64-bit kernels.  I don't fully understand what the key_type
   is for anyway - it seems like exactly one type is supported
   per call anyway.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
