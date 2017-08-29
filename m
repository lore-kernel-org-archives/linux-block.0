Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme update for Linux 4.14, take 2
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20170829150507.rjixn6uf3id6kltx@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9a27048d-1252-985f-c905-b738d709b204@kernel.dk>
Date: Tue, 29 Aug 2017 09:10:35 -0600
MIME-Version: 1.0
In-Reply-To: <20170829150507.rjixn6uf3id6kltx@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/29/2017 09:05 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below is the current set of NVMe updates for Linux 4.14, now against your
> postmerge branch, and with three more patches.
> 
> The biggest bit comes from Sagi and refactors the RDMA driver to prepare
> for more code sharing in the setup and teardown path.  But we have various
> features and bug fixes from a lot of people as well.

Pulled, thanks.

-- 
Jens Axboe
