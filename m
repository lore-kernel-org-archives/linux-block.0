Return-Path: <linux-ide-owner@vger.kernel.org>
Date: Wed, 13 Jul 2016 13:03:08 -0400
From: Tejun Heo <tj@kernel.org>
To: tom.ty89@gmail.com
Cc: martin.petersen@oracle.com, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC 1/3] ata: bump ATA_MAX_SECTORS_LBA48 to 65536
Message-ID: <20160713170308.GF4065@mtj.duckdns.org>
References: <1c10437e3cd9be8556e77462b40ad53be542dfba.1468384890.git.tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1c10437e3cd9be8556e77462b40ad53be542dfba.1468384890.git.tom.ty89@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Jul 13, 2016 at 12:47:06PM +0800, tom.ty89@gmail.com wrote:
> From: Tom Yan <tom.ty89@gmail.com>
> 
> ATA_MAX_SECTORS_LBA48 is only used for setting the queue limit
> "max_hw_sectors", which only serves as the cap for "max_sectors",
> which is in turn the actual limit being used. Therefore, it should

It's used to device max_sectors.

> be alright for us to bump ATA_MAX_SECTORS_LBA48 to 65536. Also,
> lba_48_ok() has been accepting the number of blocks to be 65536.

This is way too gratuitous.  There's no rationale for it while it has
actual real-world risks.  max_sectors is staying at 65535.

Thanks.

-- 
tejun
