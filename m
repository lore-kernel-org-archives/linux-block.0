Return-Path: <BATV+13eae1ead3b510954992+5118+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 28 Aug 2017 08:59:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme update for Linux 4.14
Message-ID: <20170828155925.GA32254@infradead.org>
References: <20170828143343.evhchzfzam3whgwm@infradead.org>
 <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
 <20170828155336.GA5302@infradead.org>
 <3c45e618-6a96-6443-258a-dac8f93ccc7a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3c45e618-6a96-6443-258a-dac8f93ccc7a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 28, 2017 at 09:55:55AM -0600, Jens Axboe wrote:
> > It was based on the nvme-3.13 tree from about two weeks ago,
> > which was based on your for-linus at about that time.
> 
> Changes for 4.14 should be against the 4.14 branch. for-linus is
> for 4.13. In any case, there will be a conflict against master...

We would have otherwise had conflicts against changes in Linus'
tree for 4.13, so we were between a rock and a hard place here.
