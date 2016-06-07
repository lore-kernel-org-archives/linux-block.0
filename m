Return-Path: <nab@linux-iscsi.org>
Message-ID: <1465280632.5365.58.camel@haakon3.risingtidesystems.com>
Subject: Re: NVMe over Fabrics target implementation
From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, keith.busch@intel.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, target-devel
	 <target-devel@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>
Date: Mon, 06 Jun 2016 23:23:52 -0700
In-Reply-To: <1465248177-17970-1-git-send-email-hch@lst.de>
References: <1465248177-17970-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi HCH & Co,

On Mon, 2016-06-06 at 23:22 +0200, Christoph Hellwig wrote:
> This patch set adds a generic NVMe over Fabrics target. The
> implementation conforms to the NVMe 1.2b specification (which
> includes Fabrics) and provides the NVMe over Fabrics access
> to Linux block devices.
> 

Thanks for all of the development work by the fabric_linux_driver team
(HCH, Sagi, Ming, James F., James S., and Dave M.) over the last year. 

Very excited to see this code get a public release now that NVMf
specification is out.  Now that it's in the wild, it's a good
opportunity to discuss some of the more interesting implementation
details, beyond the new NVMf wire-protocol itself.

(Adding target-devel + linux-scsi CC')

> The target implementation consists of several elements:
> 
> - NVMe target core: defines and manages the NVMe entities (subsystems,
>   controllers, namespaces, ...) and their allocation, responsible
>   for initial commands processing and correct orchestration of
>   the stack setup and tear down.
> 
> - NVMe admin command implementation: responsible for parsing and
>   servicing admin commands such as controller identify, set features,
>   keep-alive, log page, ...).
> 
> - NVMe I/O command implementation: responsible for performing the actual
>   I/O (Read, Write, Flush, Deallocate (aka Discard).  It is a very thin
>   layer on top of the block layer and implements no logic of it's own.
>   To support exporting file systems please use the loopback block driver
>   in direct I/O mode, which gives very good performance.
> 
> - NVMe over Fabrics support: responsible for servicing Fabrics commands
>   (connect, property get/set).
> 
> - NVMe over Fabrics discovery service: responsible to serve the Discovery
>   log page through a special cut down Discovery controller.
> 
> The target is configured using configfs, and configurable entities are:
> 
>  - NVMe subsystems and namespaces
>  - NVMe over Fabrics ports and referrals
>  - Host ACLs for primitive access control - NVMe over Fabrics access
>    control is still work in progress at the specification level and
>    will be implemented once that work has finished.
> 
> To configure the target use the nvmetcli tool from
> http://git.infradead.org/users/hch/nvmetcli.git, which includes detailed
> setup documentation.
> 
> In addition to the Fabrics target implementation we provide a loopback
> driver which also conforms the NVMe over Fabrics specification and allows
> evaluation of the target stack with local access without requiring a real
> fabric.
> 

So as-is, I have two main objections that been discussed off-list for
some time, that won't be a big surprise to anyone following
fabrics_linux_driver list.  ;P

First topic, I think nvme-target name-spaces should be utilizing
existing configfs logic, and sharing /sys/kernel/config/target/core/
backend driver symlinks as individual nvme-target subsystem namespaces.

That is, we've already got a configfs ABI in place for target mode
back-ends that today is able to operate independently from SCSI
architecture model dependencies.

To that end, the prerequisite series to allow target-core backends to
operate independent of se_cmd, and allow se_device backends to be
configfs symlinked directly into /sys/kernel/config/nvmet/, outside
of /sys/kernel/config/target/$FABRIC/ has been posted earlier here:

http://marc.info/?l=linux-scsi&m=146527281416606&w=2

Note the -v2 series has absorbed the nvmet/io-cmd execute_rw()
improvements from Sagi + Ming (inline bio/bvec and blk_poll) into
target_core_iblock.c driver code.

Second topic, and more important from a kernel ABI perspective are the
current scale limitations around the first pass of nvmet configfs.c
layout code in /sys/kernel/config/nvmet/.

Namely, the design of having three top level configfs groups in
/sys/kernel/config/nvmet/[subsystems,ports,hosts] that are configfs
symlinked between each other, with a single rw_mutex (nvmet_config_sem)
used for global list lookup and enforcing a globally synchronized
nvmet_fabrics_ops->add_port() creation across all subsystem NQN ports.

>From the shared experience in target_core_fabric_configfs.c over the
last 8 years, perhaps the greatest strength of configfs has been it's
ability to allow config_item_type parent/child relationships to exist
and operate independently of one another.

Specifically in the context of storage tenants, this means creation +
deletion of one backend + target fabric endpoint tenant, should not
block creation + deletion of another backend + target fabric endpoint
tenant.

As-is, a nvmet configfs layout holding a global mutex across
subsystem/port/host creation + deletion, and doing internal list lookup
within configfs ->allow_link + ->drop_link callbacks ends up being
severely limiting when scaling up the total number of nvmet subsystem
NQNs and ports.

Specifically, modern deployments of /sys/kernel/config/target/iscsi/
expect backends + fabric endpoints to be configured in parallel at
< 100ms from user-space, in order to actively migrate and fail-over
100s of storage instances (eg: iscsi IQNs -> NVMf NQN) across physical
cluster nodes and L3 networks.

So in order to reach this level of scale with nvmet/configfs, the layout
I think is necessary to match iscsi-target in a multi-tenant environment
will, in it's most basic form look like:

/sys/kernel/config/nvmet/subsystems/
└── nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep
    ├── hosts
    ├── namespaces
    │   └── ns_1
    │       └── 1 -> ../../../../../../target/core/rd_mcp_1/ramdisk0
    └── ports
        ├── pcie:$SUPER_TURBO_FABRIC_EAST
        ├── pcie:$SUPER_TURBO_FABRIC_WEST
        ├── rdma:[$IPV6_ADDR]:$PORT
        ├── rdma:10.10.1.75:$PORT
        └── loop

That is, both NQN ports groups and host ACL groups exist below the
nvmet_subsys->group, and NQN namespaces are configfs symlinked directly
from /sys/kernel/config/target/core/ backends as mentioned in point #1.

To that end, I'll be posting a nvmet series shortly that implements a
multi-tenant configfs layout WIP using nvme/loop, using existing
target-core backends as configfs symlinked nvme namespaces.

Comments..?
