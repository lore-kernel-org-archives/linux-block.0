Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Damien.LeMoal@wdc.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: bgurney@redhat.com
Subject: [PATCH 0/2][RFC] block: default to deadline for SMR devices
Date: Fri, 25 May 2018 17:14:30 -0400
Message-Id: <20180525211432.20359-1-jmoyer@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Bryan Gurney reported I/O errors when using dm-zoned with a host-managed
SMR device.  It turns out he was using CFQ, which is the default.
Unfortunately, as of v4.16, only the deadline schedulers work well with
host-managed SMR devices.  This series aatempts to switch the elevator
to deadline for those devices.

NOTE: I'm not super happy with setting up one iosched and then
immediately tearing it down.  I'm open to suggestions on better ways
to accomplish this goal.

[PATCH 1/2] block: __elevator_change: add try_loading parameter
[PATCH 2/2] block: default to deadline for host-managed SMR devices
