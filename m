Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5 v3] BDI lifetime fix
Date: Thu,  2 Feb 2017 15:56:48 +0100
Message-Id: <20170202145653.19614-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

this is the third version of the patch series that attempts to solve the
problems with the life time of a backing_dev_info structure. Currently it lives
inside request_queue structure and thus it gets destroyed as soon as request
queue goes away. However the block device inode still stays around and thus
inode_to_bdi() call on that inode (e.g. from flusher worker) may happen after
request queue has been destroyed resulting in oops.

This patch set tries to solve these problems by making backing_dev_info
independent structure referenced from block device inode. That makes sure
inode_to_bdi() cannot ever oops. I gave some basic testing to the patches in
KVM and on a real machine, Dan was running them with libnvdimm test suite which
was previously triggering the oops and things look good. So patches should be
reasonably healthy.

Changes since v2:
* Added Reviewed-by tags
* Removed slab cache for backing_dev_info
* Added patch to remove blkdev_get_backing_dev_info()

Changes since v1:
* Use kref instead of atomic_t for refcount
* Get rid of free_on_put flag

								Honza
