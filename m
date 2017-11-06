Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Mon, 6 Nov 2017 10:13:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 1/3] nvme: do not check for ns on rw path
Message-ID: <20171106091323.GA30382@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-2-git-send-email-javier@cnexlabs.com>
 <20171103125339.GA25186@lst.de>
 <20171103150203.GA11300@localhost.localdomain>
 <20171104081825.GA19180@lst.de>
 <20171104153844.GA12777@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20171104153844.GA12777@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Sat, Nov 04, 2017 at 09:38:45AM -0600, Keith Busch wrote:
> That's not quite right. For non-PI metadata formats, we use the
> 'nop_profile', which gets the metadata buffer allocated so we can safely
> use a metadata formatted namespace. There's no in-kernel user of the
> allocated payload, but we still need the metadata buffer in order to
> use the namespace at all.

You're right.  But that means we will indeed always have a matching
integrity payload here and the check should not be needed.

Are you fine with turning it into something like:

	if (WARN_ON_ONCE(ns->ms && !blk_integrity_rq(req)))
		return BLK_STS_IOERR;

?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
