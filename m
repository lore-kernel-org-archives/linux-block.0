Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8972 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdJWCNM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Oct 2017 22:13:12 -0400
Subject: Re: nvme multipath support V4
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        "Hannes Reinecke" <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Shenhong (C)" <shenhong09@huawei.com>,
        niuhaoxin <niuhaoxin@huawei.com>
References: <20171018165258.23212-1-hch@lst.de>
From: Guan Junxiong <guanjunxiong@huawei.com>
Message-ID: <fbccc0db-77cd-fabc-0225-4b515729f214@huawei.com>
Date: Mon, 23 Oct 2017 10:08:52 +0800
MIME-Version: 1.0
In-Reply-To: <20171018165258.23212-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Christoph,


On 2017/10/19 0:52, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds support for multipathing, that is accessing nvme
> namespaces through multiple controllers to the nvme core driver.
> 
> It is a very thin and efficient implementation that relies on
> close cooperation with other bits of the nvme driver, and few small
> and simple block helpers.
> 
> Compared to dm-multipath the important differences are how management
> of the paths is done, and how the I/O path works.
> 
> Management of the paths is fully integrated into the nvme driver,
> for each newly found nvme controller we check if there are other
> controllers that refer to the same subsystem, and if so we link them
> up in the nvme driver.  Then for each namespace found we check if
> the namespace id and identifiers match to check if we have multiple
> controllers that refer to the same namespaces.  For now path
> availability is based entirely on the controller status, which at
> least for fabrics will be continuously updated based on the mandatory
> keep alive timer.  Once the Asynchronous Namespace Access (ANA)
> proposal passes in NVMe we will also get per-namespace states in
> addition to that, but for now any details of that remain confidential
> to NVMe members.
> 
> The I/O path is very different from the existing multipath drivers,
> which is enabled by the fact that NVMe (unlike SCSI) does not support
> partial completions - a controller will either complete a whole
> command or not, but never only complete parts of it.  Because of that
> there is no need to clone bios or requests - the I/O path simply
> redirects the I/O to a suitable path.  For successful commands
> multipath is not in the completion stack at all.  For failed commands
> we decide if the error could be a path failure, and if yes remove
> the bios from the request structure and requeue them before completing
> the request.  All together this means there is no performance
> degradation compared to normal nvme operation when using the multipath
> device node (at least not until I find a dual ported DRAM backed
> device :))
> 
> A git tree is available at:
> 
>    git://git.infradead.org/users/hch/block.git nvme-mpath
> 
> gitweb:
> 
>    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-mpath
> 
> Changes since V3:
>   - new block layer support for hidden gendisks
>   - a couple new patches to refactor device handling before the
>     actual multipath support
>   - don't expose per-controller block device nodes
>   - use /dev/nvmeXnZ as the device nodes for the whole subsystem.

If per-controller block device nodes are hidden, how can the user-space tools
such as multipath-tools and nvme-cli (if it supports) know status of each path of
the multipath device?
In some cases, the admin wants to know which path is in down state , in degraded
state such as suffering intermittent IO error because of shaky link and he can fix
the link or isolate such link from the normal path.

Regards
Guan


>   - expose subsystems in sysfs (Hannes Reinecke)
>   - fix a subsystem leak when duplicate NQNs are found
>   - fix up some names
>   - don't clear current_path if freeing a different namespace
> 
> Changes since V2:
>   - don't create duplicate subsystems on reset (Keith Bush)
>   - free requests properly when failing over in I/O completion (Keith Bush)
>   - new devices names: /dev/nvm-sub%dn%d
>   - expose the namespace identification sysfs files for the mpath nodes
> 
> Changes since V1:
>   - introduce new nvme_ns_ids structure to clean up identifier handling
>   - generic_make_request_fast is now named direct_make_request and calls
>     generic_make_request_checks
>   - reset bi_disk on resubmission
>   - create sysfs links between the existing nvme namespace block devices and
>     the new share mpath device
>   - temporarily added the timeout patches from James, this should go into
>     nvme-4.14, though
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
> .
> 
