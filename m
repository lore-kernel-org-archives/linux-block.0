Return-Path: <redfish@galactica.pw>
Date: Mon, 30 Oct 2017 21:50:53 -0400
From: redfish <redfish@galactica.pw>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	regressions@leemhuis.info
Subject: [Bug 197303] blk_partition_remap: fail for partition 3]
Message-ID: <20171031015053.GA15858@thinkpad.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

(This report on Bugzilla): https://bugzilla.kernel.org/show_bug.cgi?id=197303

On ARM board Odroid U3, with root fs on eMMC with 4.14rc4 got this:

blk_partition_remap: fail for partition 3
[52311.638650] EXT4-fs error (device mmcblk1p3): ext4_find_entry:1431: inode #20381: comm kworker/u8:0: reading directory lblock 0
[52311.650728] Core dump to |/usr/lib/systemd/systemd-coredump 2980 0 0 7 1507904006 4294967295 agetty pipe failed

Board fatally hung. Never observed happening in 4.13.6, 4.13.7 or any earlier kernel.

It looks like at least the error message was introduced in this commit present only in 4.14: 
74d46992e0d9dee7f1f376de0d56d31614c8a17a
block: replace bi_bdev with a gendisk pointer and partitions index

Thank you.


----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Sun, 29 Oct 2017 13:55:51 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: redfish@galactica.pw
Subject: [Bug 197303] blk_partition_remap: fail for partition 3

https://bugzilla.kernel.org/show_bug.cgi?id=197303

Thorsten Leemhuis (regressions@leemhuis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #1 from Thorsten Leemhuis (regressions@leemhuis.info) ---
I'll add this issue to the regression report. But you really should mail this
issue to linux-block@vger.kernel.org and CC the two developers mentioned in
74d46992e0d9dee7f1f376de0d56d31614c8a17a , as it will likely get ignored here
on bugzilla.

-- 
You are receiving this mail because:
You reported the bug.

----- End forwarded message -----
