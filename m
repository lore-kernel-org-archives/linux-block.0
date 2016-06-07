Return-Path: <hch@lst.de>
Date: Tue, 7 Jun 2016 19:31:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, keith.busch@intel.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: NVMe over Fabrics target implementation
Message-ID: <20160607173105.GA13935@lst.de>
References: <1465248177-17970-1-git-send-email-hch@lst.de> <6abd6fd0-3a75-8569-95a4-174d856d0043@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6abd6fd0-3a75-8569-95a4-174d856d0043@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

Hi Bart,

> As you know with configfs it is not allowed to create directories in the 
> configfs hierarchy from inside the kernel.

Of course you can, and every user of configfs relies on being able
to create directories from the kernel using either the default_groups
list, or through the use of configfs_register_group().
