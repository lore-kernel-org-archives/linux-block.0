Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: NVMe over Fabrics target implementation
To: Christoph Hellwig <hch@lst.de>, <axboe@kernel.dk>, <keith.busch@intel.com>
References: <1465248177-17970-1-git-send-email-hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <6abd6fd0-3a75-8569-95a4-174d856d0043@sandisk.com>
Date: Tue, 7 Jun 2016 10:01:01 -0700
MIME-Version: 1.0
In-Reply-To: <1465248177-17970-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 06/06/2016 02:22 PM, Christoph Hellwig wrote:
> The target is configured using configfs, and configurable entities are:
>  - NVMe subsystems and namespaces
>  - NVMe over Fabrics ports and referrals
>  - Host ACLs for primitive access control - NVMe over Fabrics access
>    control is still work in progress at the specification level and
>    will be implemented once that work has finished.

Hello Christoph,

As you know with configfs it is not allowed to create directories in the 
configfs hierarchy from inside the kernel. This means that users will 
have to create one directory per fabric port before configuring a target 
port. Other virtual filesystems, e.g. sysfs, allow directory creation by 
kernel drivers. This means that with sysfs the fabric port directory 
could be created by the nvmet driver. Is this how you want the nvmet 
driver to work?

Thanks,

Bart.
