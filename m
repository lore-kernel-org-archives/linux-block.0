Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] two more nvme fixes for Linux 4.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180117183622.3nrboga4prjeck5i@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6b19008b-e8fe-d8c0-6794-88f6ff28a510@kernel.dk>
Date: Wed, 17 Jan 2018 13:30:44 -0700
MIME-Version: 1.0
In-Reply-To: <20180117183622.3nrboga4prjeck5i@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/17/18 11:36 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> two more last minute fixes for regressions due to the SGL support that
> is new in Linux 4.15.
> 
> The following changes since commit 32835a074171e7b83c1cefbbf9d681bb9518bbd5:
> 
>   Merge branch 'nvme-4.15' of git://git.infradead.org/nvme into for-linus (2018-01-12 10:42:36 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.15

Something appears to be funky at your end:

git pull --no-ff  git://git.infradead.org/nvme.git nvme-4.15
remote: Counting objects: 12, done.
remote: Compressing objects: 100% (11/11), done.
remote: fatal: unable to read 4276ebfff22ba00fd90e8c241cc7edd56deca353
remote: aborting due to possible repository corruption on the remote side.
fatal: protocol error: bad pack header

-- 
Jens Axboe
