Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.12-rc2
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20170520131048.cjmpq2dnttritszb@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <660bcd31-3093-8bde-1d1c-b1dfe94cf57b@kernel.dk>
Date: Sat, 20 May 2017 10:13:15 -0600
MIME-Version: 1.0
In-Reply-To: <20170520131048.cjmpq2dnttritszb@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/20/2017 07:10 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> a few fixes for 4.12-rc2.  There are a few more that we need to get into
> 4.12, but I'd rather get the current queue to you ASAP.
> 
> 
> The following changes since commit 56868a460b83c0f93d339256a81064d89aadae8e:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide (2017-05-09 15:56:58 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.12
> 
> for you to fetch changes up to 3d5d1207d61b522b6aac24f896e53401e876b26e:
> 
>   nvmet: release the sq ref on rdma read errors (2017-05-11 12:52:46 +0200)
> 
> ----------------------------------------------------------------
> James Smart (4):
>       nvme-fc: correct port role bits
>       nvme-fc: require target or discovery role for fc-nvme targets
>       nvme-fc: stop queues on error detection
>       nvmet-fc: remove target cpu scheduling flag
> 
> Jon Derrick (1):
>       nvme: unmap CMB and remove sysfs file in reset path
> 
> Vijay Immanuel (1):
>       nvmet: release the sq ref on rdma read errors

Thanks - I hand applied these, your base is much further ahead than my
for-linus.

-- 
Jens Axboe
