Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] another set of nvme fixes for 4.14-rc2
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20170922175537.z5gvxcbckoli6vn5@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ca4e3765-6d56-b963-3525-a1a67a0769fd@kernel.dk>
Date: Fri, 22 Sep 2017 12:33:18 -0600
MIME-Version: 1.0
In-Reply-To: <20170922175537.z5gvxcbckoli6vn5@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/22/2017 11:55 AM, Christoph Hellwig wrote:
> The fix for the target sqhdr fix is the critical one that we really want
> before -rc2.  But we've also accumulated a fair batch of small FC and
> RDMA fixes as well.
> 
> 
> The following changes since commit cd9e0a08e4f6173f9d7a469cabd09938fc4f0e25:
> 
>   block: fix a crash caused by wrong API (2017-09-21 13:20:40 -0600)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.14
> 
> for you to fetch changes up to 4384e7ae7686aa914ee4f163be1790d03e2e8f28:
> 
>   nvme-fcloop: fix port deletes and callbacks (2017-09-22 07:27:08 -0700)
> 
> ----------------------------------------------------------------
> James Smart (5):
>       nvme: fix sqhd reference when admin queue connect fails
>       nvmet-fc: on port remove call put outside lock
>       nvmet-fc: ensure target queue id within range.
>       nvmet-fc: sync header templates with comments
>       nvme-fcloop: fix port deletes and callbacks
> 
> Sagi Grimberg (3):
>       nvme-core: Use nvme_wq to queue async events and fw activation
>       nvme-rdma: give up reconnect if state change fails
>       nvme-rdma: don't fully stop the controller in error recovery

Pulled, thanks.

-- 
Jens Axboe
