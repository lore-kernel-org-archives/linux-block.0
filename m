Return-Path: <sergey.senozhatsky.work@gmail.com>
Return-Path: <sergey.senozhatsky.work@gmail.com>
Date: Thu, 18 Aug 2016 11:06:37 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-block@vger.kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	Paul Mackerras <paulus@samba.org>, linux-mtd@lists.infradead.org,
	"Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	virtualization@lists.linux-foundation.org,
	Nitin Gupta <ngupta@vflare.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 11/15] zram: Pass attribute group to device_add_disk
Message-ID: <20160818020637.GA500@swordfish>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
 <1471418115-3654-12-git-send-email-famz@redhat.com>
 <20160818015901.GA499@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818015901.GA499@swordfish>
List-ID: <linux-block@vger.kernel.org>

On (08/18/16 10:59), Sergey Senozhatsky wrote:
[..]
> I like the previous "Error creating sysfs group for device" string better,
> than "Error creating disk", because the latter one is much less informative.
> 
> do you want to do something like below?
> 
> int device_add_disk(struct device *parent, struct gendisk *disk,
> ...
>        if (attr_group) {
>                retval = sysfs_create_group(&disk_to_dev(disk)->kobj,
>                                            attr_group);
> 
> +		pr_err("Error creating sysfs group for device ...\n", ...);

d'oh... a typo. pr_err() is meant to be in `if (retval)' branch.

>                if (retval)
>                        goto fail;
>        }

	-ss
