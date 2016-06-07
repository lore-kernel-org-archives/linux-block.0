Return-Path: <hch@lst.de>
Date: Tue, 7 Jun 2016 22:27:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Steve Wise <swise@opengridcomputing.com>
Cc: "Woodruff, Robert J" <robert.j.woodruff@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"Busch, Keith" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: NVMe over Fabrics RDMA transport drivers
Message-ID: <20160607202727.GA16366@lst.de>
References: <1465248215-18186-1-git-send-email-hch@lst.de> <5756B695.5020305@grimberg.me> <9C6B67F36DCAFC479B1CF6A967258A8C7DDCB23D@ORSMSX115.amr.corp.intel.com> <6ed161c3-d7d2-909f-6f17-7d75c36ed5b2@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6ed161c3-d7d2-909f-6f17-7d75c36ed5b2@opengridcomputing.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 07, 2016 at 03:14:22PM -0500, Steve Wise wrote:
> It would be great to make sure and CC linux-rdma on v2 of all 4 series, so 
> interested folks can review and/or test out the whole enchilada.

Just go for the git tree at

	git://git.infradead.org/nvme-fabrics.git nvmf-all

to make your life easier for that..  I'll include the list on the next
repost, although I hope the first series with it's mostly protocol header
changes can go in before needing to repost the rest, they are all pretty
trivial.
