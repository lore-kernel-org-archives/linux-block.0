Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4 RFC] BDI lifetime fix
Date: Thu, 26 Jan 2017 18:45:28 +0100
Message-Id: <20170126174532.15189-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

this patch series attempts to solve the problems with the life time of a
backing_dev_info structure. Currently it lives inside request_queue structure
and thus it gets destroyed as soon as request queue goes away. However
the block device inode still stays around and thus inode_to_bdi() call on
that inode (e.g. from flusher worker) may happen after request queue has been
destroyed resulting in oops.

This patch set tries to solve these problems by making backing_dev_info
independent structure referenced from block device inode. That makes sure
inode_to_bdi() cannot ever oops. The patches are lightly tested for now
(they boot, basic tests with adding & removing loop devices seem to do what
I'd expect them to do ;). If someone is able to reproduce crashes on bdi
when device goes away, please test these patches.

I'd also appreciate if people had a look whether the approach I took looks
sensible.

								Honza
