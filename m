Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.18
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180615131301.2teay6o7c2jrqxtw@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8ac40265-01a6-780c-f0a2-baa773a94187@kernel.dk>
Date: Fri, 15 Jun 2018 08:16:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180615131301.2teay6o7c2jrqxtw@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/15/18 7:13 AM, Christoph Hellwig wrote:
> Fix various little regressions introduced in this merge window, plus
> a rework of the fibre channel connect and reconnect path to share the
> code instead of having separate sets of bugs.  Last but not least a
> trivial trace point addition from Hannes.

Pulled, thanks.

-- 
Jens Axboe
