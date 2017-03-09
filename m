Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Mar 2017 11:39:39 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Omar Sandoval <osandov@osandov.com>,
	Arthur Marsh <arthur.marsh@internode.on.net>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/4] block: Allow bdi re-registration
Message-ID: <20170309163939.GA28982@htj.duckdns.org>
References: <20170309101624.25901-1-jack@suse.cz>
 <20170309101624.25901-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170309101624.25901-2-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 09, 2017 at 11:16:21AM +0100, Jan Kara wrote:
> SCSI can call device_add_disk() several times for one request queue when
> a device in unbound and bound, creating new gendisk each time. This will
> lead to bdi being repeatedly registered and unregistered. This was not a
> big problem until commit 165a5e22fafb "block: Move bdi_unregister() to
> del_gendisk()" since bdi was only registered repeatedly (bdi_register()
> handles repeated calls fine, only we ended up leaking reference to
> gendisk due to overwriting bdi->owner) but unregistered only in
> blk_cleanup_queue() which didn't get called repeatedly. After
> 165a5e22fafb we were doing correct bdi_register() - bdi_unregister()
> cycles however bdi_unregister() is not prepared for it. So make sure
> bdi_unregister() cleans up bdi in such a way that it is prepared for
> a possible following bdi_register() call.
> 
> An easy way to provoke this behavior is to enable
> CONFIG_DEBUG_TEST_DRIVER_REMOVE and use scsi_debug driver to create a
> scsi disk which immediately hangs without this fix.
> 
> Fixes: 165a5e22fafb127ecb5914e12e8c32a1f0d3f820
> Tested-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks!

-- 
tejun
