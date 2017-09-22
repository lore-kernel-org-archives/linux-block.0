Return-Path: <yyt168@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170921145002.GA18634@lst.de>
References: <20170918231453.27128-1-hch@lst.de> <20170920110959.hwvujtis6ywnbb5p@linux-x5ow.site>
 <20170920145546.GB4709@lst.de> <20170921052345.pj5ymmqsfmckas2b@linux-x5ow.site>
 <20170921145002.GA18634@lst.de>
From: Tony Yang <yyt168@gmail.com>
Date: Fri, 22 Sep 2017 08:21:09 +0800
Message-ID: <CADL4p-qh=2KKc3FC_d8hBd7V5bnHeDF0fbXdQOpv2Xfy28wR9Q@mail.gmail.com>
Subject: Re: nvme multipath support V2
To: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Excuse me,
   ask an junior question, how can you complete the nvme mpath package
clone, I use git clone, after completion, found no nvme directory.


[root@scst1 soft]#  git clone
git://git.infradead.org/users/hch/block.git nvme-mpath
Cloning into 'nvme-mpath'...
remote: Counting objects: 5623436, done.
remote: Compressing objects: 100% (922468/922468), done.
remote: Total 5623436 (delta 4757577), reused 5524606 (delta 4658819)
Receiving objects: 100% (5623436/5623436), 1.12 GiB | 3.17 MiB/s, done.
Resolving deltas: 100% (4757577/4757577), done.
Checking out files: 100% (50795/50795), done.


[root@scst1 drivers]# pwd
/u01/soft/nvme-mpath/drivers

[root@scst1 drivers]# ls nvme
ls: cannot access nvme: No such file or directory

Thanks

2017-09-21 22:50 GMT+08:00 Christoph Hellwig <hch@lst.de>:
> On Thu, Sep 21, 2017 at 07:23:45AM +0200, Johannes Thumshirn wrote:
>> Ah OK, we maybe should update nvme-cli to recognize it as well then. I just
>> looked at the output of nvme list and obviously didn't find it.
>
> Overloading the new per-subsystem nodes into nvme list would be
> very confusing I think.  We could add a new command to list subsystems
> instead of controllers, if just doing a ls in /dev or sysfs is too hard.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
