Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme update for Linux 4.14
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20170828143343.evhchzfzam3whgwm@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
Date: Mon, 28 Aug 2017 09:51:38 -0600
MIME-Version: 1.0
In-Reply-To: <20170828143343.evhchzfzam3whgwm@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/28/2017 08:33 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below is the current set of NVMe updates for Linux 4.14.
> 
> The biggest bit comes from Sagi and refactors the RDMA driver to prepare
> for more code sharing in the setup and teardown path.  But we have various
> features and bug fixes from a lot of people as well.
> 
> The following changes since commit 16a5a480f067f945fd27bf91ffdce3f959b0d4b6:
> 
>   nvmet-fc: correct use after free on list teardown (2017-08-16 10:06:18 +0200)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.14
> 
> for you to fetch changes up to 16edd3d0272368eee5cac13356787c1f4d4eb255:
> 
>   nvme: honor RTD3 Entry Latency for shutdowns (2017-08-28 16:29:29 +0200)

What is this against, exactly? It doesn't merge cleanly with my 4.14 branch.
>From a quick look, looks like it's conflicting with:

commit d09f2b45f346f0a9e5e1b5fcea531b1b393671dc
Author: Sagi Grimberg <sagi@grimberg.me>
Date:   Sun Jul 2 10:56:43 2017 +0300

    nvme: split nvme_uninit_ctrl into stop and uninit

which went into master after for-4.14/block was forked off. I can fix it
up, but would be best if you did it.

-- 
Jens Axboe
