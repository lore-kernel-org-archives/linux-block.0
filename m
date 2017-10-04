Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	shli@kernel.org
Subject: [PATCH v2 0/9] Nowait support for stacked block devices
Date: Wed,  4 Oct 2017 08:55:02 -0500
Message-Id: <20171004135511.26110-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

This is a continuation of the nowait support which was incorporated
a while back. We introduced REQ_NOWAIT which would return immediately
if the call would block at the block layer. Request based-devices
do not wait. However, bio based devices (the ones which exclusively
call make_request_fn) need to be trained to handle REQ_NOWAIT.

This effort covers the devices under MD and DM which would block
for any reason. If there should be more devices or situations
which need to be covered, please let me know.

The problem with partial writes discussed during v1 turned out
to be a bug in partial writes during direct I/O and is fixed
by the submitted patch[1].

Changes since v1:
 - mddev to return early in case the device is suspended, within the md code as opposed to ->make_request()
 - Check for nowait support with all the lower devices. Same with if adding a device which does not support nowait.
 - Nowait under each raid is checked before the final I/O submission for the entire I/O.

[1] https://patchwork.kernel.org/patch/9979887/

-- 
Goldwyn
