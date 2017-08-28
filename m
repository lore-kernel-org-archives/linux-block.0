Return-Path: <BATV+13eae1ead3b510954992+5118+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 28 Aug 2017 11:40:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme update for Linux 4.14
Message-ID: <20170828184035.GA11383@infradead.org>
References: <20170828143343.evhchzfzam3whgwm@infradead.org>
 <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
 <20170828155336.GA5302@infradead.org>
 <3c45e618-6a96-6443-258a-dac8f93ccc7a@kernel.dk>
 <20170828155925.GA32254@infradead.org>
 <44a35d51-48d5-7181-df7e-b75fcbc053d9@kernel.dk>
 <20170828175744.GA26713@infradead.org>
 <3c714d50-5b75-6a94-2fad-3ab491afc1cf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3c714d50-5b75-6a94-2fad-3ab491afc1cf@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Meh, I don't think that'll work out - the rdma refactoring from
Sagi deeply depends on the unіnit_ctrl split..
