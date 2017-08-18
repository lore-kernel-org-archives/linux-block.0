Return-Path: <BATV+5995e8b4f66cfb16e0fe+5108+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 18 Aug 2017 00:14:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH] nvme: always return IRQ_HANDLED
Message-ID: <20170818071428.GA5460@infradead.org>
References: <06b85884-efb4-e419-4b31-3aa4751bb338@kernel.dk>
 <20170817201526.GA21397@localhost.localdomain>
 <60b6e2b7-86d1-d5c7-66af-e771d17384b8@kernel.dk>
 <20170817202945.GB21397@localhost.localdomain>
 <28c04e46-043f-2864-f9c6-d4a76e5e2248@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <28c04e46-043f-2864-f9c6-d4a76e5e2248@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 17, 2017 at 02:25:27PM -0600, Jens Axboe wrote:
> Yes, that will work. We need to get this into 4.13.

I'll pick it up for the pull request I'm going to send you today.
