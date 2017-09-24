Return-Path: <hch@lst.de>
Date: Sun, 24 Sep 2017 16:41:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tony Yang <yyt168@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Johannes Thumshirn <jthumshirn@suse.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@intel.com>
Subject: Re: nvme multipath support V2
Message-ID: <20170924144132.GA13681@lst.de>
References: <20170918231453.27128-1-hch@lst.de> <20170920110959.hwvujtis6ywnbb5p@linux-x5ow.site> <20170920145546.GB4709@lst.de> <20170921052345.pj5ymmqsfmckas2b@linux-x5ow.site> <20170921145002.GA18634@lst.de> <CADL4p-qh=2KKc3FC_d8hBd7V5bnHeDF0fbXdQOpv2Xfy28wR9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADL4p-qh=2KKc3FC_d8hBd7V5bnHeDF0fbXdQOpv2Xfy28wR9Q@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 22, 2017 at 08:21:09AM +0800, Tony Yang wrote:
> Excuse me,
>    ask an junior question, how can you complete the nvme mpath package
> clone, I use git clone, after completion, found no nvme directory.
> 
> 
> [root@scst1 soft]#  git clone
> git://git.infradead.org/users/hch/block.git nvme-mpath
> Cloning into 'nvme-mpath'...
> remote: Counting objects: 5623436, done.
> remote: Compressing objects: 100% (922468/922468), done.
> remote: Total 5623436 (delta 4757577), reused 5524606 (delta 4658819)
> Receiving objects: 100% (5623436/5623436), 1.12 GiB | 3.17 MiB/s, done.
> Resolving deltas: 100% (4757577/4757577), done.
> Checking out files: 100% (50795/50795), done.

git checkout nvme-mpath
make oldconfig
<answer question>
<make sure all options with NVME in the name are enabled in .config>
make
