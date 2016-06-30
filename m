Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38638 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbcF3UBM (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 30 Jun 2016 16:01:12 -0400
Message-ID: <1467316875.21253.24.camel@linux.intel.com>
Subject: Re: [PATCH 5/6] lightnvm: expose device geometry through sysfs
From: J Freyensee <james_p_freyensee@linux.intel.com>
To: Matias =?ISO-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com, keith.busch@intel.com,
	linux-nvme@lists.infradead.org, dm-devel@redhat.com
Cc: "Simon A. F. Lund" <slund@cnexlabs.com>
Date: Thu, 30 Jun 2016 13:01:15 -0700
In-Reply-To: <1467211901-26707-6-git-send-email-m@bjorling.me>
References: <1467211901-26707-1-git-send-email-m@bjorling.me>
	 <1467211901-26707-6-git-send-email-m@bjorling.me>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2016-06-29 at 16:51 +0200, Matias Bjørling wrote:
> From: "Simon A. F. Lund" <slund@cnexlabs.com>
> 
> For a host to access an Open-Channel SSD, it has to know its
> geometry,
> so that it writes and reads at the appropriate device bounds.
> 
> Currently, the geometry information is kept within the kernel, and
> not
> exported to user-space for consumption. This patch exposes the
> configuration through sysfs and enables user-space libraries, such as
> liblightnvm, to use the sysfs implementation to get the geometry of
> an
> Open-Channel SSD.
> 
> The sysfs entries are stored within the device hierarchy, and can be
> found using the "lightnvm" device type.
> 
> An example configuration looks like this:
> 
> /sys/class/nvme/
> └── nvme0n1
>    ├── capabilities: 3
>    ├── device_mode: 1
>    ├── channel_parallelism: 0
>    ├── erase_max: 1000000
>    ├── erase_typ: 1000000
>    ├── flash_media_type: 0
>    ├── media_capabilities: 0x00000001
>    ├── media_type: 0
>    ├── multiplane: 0x00010101
>    ├── num_blocks: 1022
>    ├── num_channels: 1
>    ├── num_luns: 4
>    ├── num_pages: 64
>    ├── num_planes: 1
>    ├── page_size: 4096
>    ├── prog_max: 100000
>    ├── prog_typ: 100000
>    ├── read_max: 10000
>    ├── read_typ: 10000
>    ├── sector_oob_size: 0
>    ├── sector_size: 4096
>    ├── media_manager: gennvm
>    ├── ppa_format: 0x380830082808001010102008
>    ├── vendor_opcode: 0
>    └── version: 1
> 

That is an awful lot of new things to add under nvme0n1-type sysfs
entries when there is already a decent amount of stuff under it.

Any chance these new things could be stuck under a separate sysfs
directory under each nvmeXnY device?  If these things are mainly
beneficial to LightNVM, it will be easier for a LightNVM newbie to
find, recognize, and consider all the important things in an Open
Channel SSD solution if it's under a separate directory.  And for
current SSD solutions that don't seem to need these things exposed in
sysfs for operation, it will make what is directly under nvmeXnY
directories less cluttered.

Thanks,
Jay

