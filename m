Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:45122
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757618AbdAKQIp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 11:08:45 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
CC: "Linux-scsi@vger.kernel.org" <Linux-scsi@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
Date: Wed, 11 Jan 2017 16:08:31 +0000
Message-ID: <1484150893.2619.1.camel@sandisk.com>
References: <20170111134312.GH6286@linux-x5ow.site>
In-Reply-To: <20170111134312.GH6286@linux-x5ow.site>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-11 at 14:43 +0100, Johannes Thumshirn wrote:
> I'd like to attend LSF/MM and would like to discuss polling for block
> drivers.
>=20
> Currently there is blk-iopoll but it is neither as widely used as NAPI in
> the networking field and accoring to Sagi's findings in [1] performance
> with polling is not on par with IRQ usage.
>=20
> On LSF/MM I'd like to whether it is desirable to have NAPI like polling i=
n
> more block drivers and how to overcome the currently seen performance
> issues.
>=20
> [1] http://lists.infradead.org/pipermail/linux-nvme/2016-October/006975.h=
t
> ml

A typical Ethernet network adapter delays the generation of an interrupt
after it has received a packet. A typical block device or HBA does not dela=
y
the generation of an interrupt that reports an I/O completion. I think that
is why polling is more effective for network adapters than for block
devices. I'm not sure whether it is possible to achieve benefits similar to
NAPI for block devices without implementing interrupt coalescing in the
block device firmware. Note: for block device implementations that use the
RDMA API, the RDMA API supports interrupt coalescing (see also
ib_modify_cq()).

An example of the interrupt coalescing parameters for a network adapter:

# ethtool -c em1 | grep -E 'rx-usecs:|tx-usecs:'
rx-usecs: 3
tx-usecs: 0

Bart.=
