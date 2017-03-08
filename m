Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <20170308164834.14302-5-jack@suse.cz>
References: <20170308164834.14302-1-jack@suse.cz> <20170308164834.14302-5-jack@suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 8 Mar 2017 09:12:24 -0800
Message-ID: <CAPcyv4hbn77kDaDyzP0Nutfh_S-6Hv5bUphnndEgATb_-UsbAA@mail.gmail.com>
Subject: Re: [PATCH 4/4] Revert "scsi, block: fix duplicate bdi name
 registration crashes"
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>, Arthur Marsh <arthur.marsh@internode.on.net>,
	linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 8, 2017 at 8:48 AM, Jan Kara <jack@suse.cz> wrote:
> This reverts commit 0dba1314d4f81115dce711292ec7981d17231064. It causes
> leaking of device numbers for SCSI when SCSI registers multiple gendisks
> for one request_queue in succession. It can be easily reproduced using
> Omar's script [1] on kernel with CONFIG_DEBUG_TEST_DRIVER_REMOVE.
> Furthermore the protection provided by this commit is not needed anymore
> as the problem it was fixing got also fixed by commit 165a5e22fafb
> "block: Move bdi_unregister() to del_gendisk()".
>
> [1]: http://marc.info/?l=linux-block&m=148554717109098&w=2
>
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Dan Williams <dan.j.williams@intel.com>
