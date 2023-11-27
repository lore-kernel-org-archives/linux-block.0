Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F2B13D;
	Sun, 26 Nov 2023 22:59:31 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 968A268AFE; Mon, 27 Nov 2023 07:59:28 +0100 (CET)
Date: Mon, 27 Nov 2023 07:59:28 +0100
From: "hch@lst.de" <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: Merging raw block device writes
Message-ID: <20231127065928.GA27811@lst.de>
References: <SN6PR02MB41575884C4898B59615B496AD4BFA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41575884C4898B59615B496AD4BFA@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 25, 2023 at 05:38:28PM +0000, Michael Kelley wrote:
> Hyper-V guests and the Azure cloud have a particular interest here
> because Hyper-V guests uses SCSI as the standard interface to virtual
> disks.  Azure cloud disks can be throttled to a limited number of IOPS,
> so the number of in-flights I/Os can be relatively high, and
> merging can be beneficial to staying within the throttle
> limits.  Of the flip side, this problem hasn't generated complaints
> over the last 18 months that I'm aware of, though that may be more
> because commercial distros haven't been running 5.16 or later kernels
> until relatively recently.

I think the more important thing is that if you care about reducing
the number of I/Os you probably should use an I/O scheduler.  Reducing
the number of I/Os without an I/O scheduler isn't (and I'll argue
shouldn't) be a concern for the non I/O scheduler.

