Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388147AbeGWRgA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jul 2018 13:36:00 -0400
Date: Mon, 23 Jul 2018 12:33:57 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: data corruption with 'splt' workload to XFS on DM cache with its 3
 underlying devices being on same NVMe device
Message-ID: <20180723163357.GA29658@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

I've opened the following public BZ:
https://bugzilla.redhat.com/show_bug.cgi?id=1607527

Feel free to add comments to that BZ if you have a redhat bugzilla
account.

But otherwise, happy to get as much feedback and discussion going purely
on the relevant lists.  I've taken ~1.5 weeks to categorize and isolate
this issue.  But I've reached a point where I'm getting diminishing
returns and could _really_ use the collective eyeballs and expertise of
the community.  This is by far one of the most nasty cases of corruption
I've seen in a while.  Not sure where the ultimate cause of corruption
lies (that the money question) but it _feels_ rooted in NVMe and is
unique to this particular workload I've stumbled onto via customer
escalation and then trying to replicate an rbd device using a more
approachable one (request-based DM multipath in this case).

>From the BZ's comment#0:

The following occurs with latest v4.18-rc3 and v4.18-rc6 and also occurs
with v4.15.  When corruption occurs from this test it also destroys the
DOS partition table (created during step 0 below).. yeah, corruption is
_that_ bad.  Almost like the corruption is temporal (recently accessed
regions of the NVMe device)?

Anyway: I stumbled onto rampant corruption when using request-based DM
multipath ontop of an NVMe device (not exclusive to a particular drive
either, happens to NVMe devices from multiple vendors).  But the
corruption only occurs if the request-based multipath IO is issued to an
NVMe device in parallel to other IO issued to the _same_ underlying NVMe
by the DM cache target.  See topology detailed below (at the very end of
this comment).. basically all 3 devices that are used to create a DM
cache device need to be backed by the same NVMe device (via partitions
or linear volumes).

Again, using request-based DM multipath for dm-cache's "slow" device is
_required_ to reproduce.  Not 100% clear why really... other than
request-based DM multipath builds large IOs (due to merging).

--- Additional comment from Mike Snitzer on 2018-07-20 10:14:09 EDT ---

To reproduce this issue using device-mapper-test-suite:

0) Partition an NVMe device.  First primary partition with at least a
5GB, seconf primary partition with at least 48GB.
NOTE: larger partitions (e.g. 1: 50GB 2: >= 220GB) can be used to
reproduce XFS corruption much quicker.

1) create a request-based multipath device ontop of an NVMe device,
e.g.:

#!/bin/sh

modprobe dm-service-time

DEVICE=/dev/nvme1n1p2
SIZE=`blockdev --getsz $DEVICE`

echo "0 $SIZE multipath 2 queue_mode mq 0 1 1 service-time 0 1 2 $DEVICE
1000 1" | dmsetup create nvme_mpath

# Just a note for how to fail/reinstate path:
# dmsetup message nvme_mpath 0 "fail_path $DEVICE"
# dmsetup message nvme_mpath 0 "reinstate_path $DEVICE"

2) checkout device-mapper-test-suite from my github repo:

git clone git://github.com/snitm/device-mapper-test-suite.git
cd device-mapper-test-suite
git checkout -b devel origin/devel

3) follow device-mapper-test-suite's README.md to get it all setup

4) Configure /root/.dmtest/config with something like:

profile :nvme_shared do
   metadata_dev '/dev/nvme1n1p1'
   #data_dev '/dev/nvme1n1p2'
   data_dev '/dev/mapper/nvme_mpath'
end

default_profile :nvme_shared

------
NOTE: configured 'metadata_dev' gets carved up by
device-mapper-test-suite to provide both the dm-cache's metadata device
and the "fast" data device.  The configured 'data_dev' is used for
dm-cache's "slow" data device.

5) run the test:
# tail -f /var/log/messages &
# time dmtest run --suite cache -n /split_large_file/

6) If multipath device failed the lone NVMe path you'll need to
reinstate the path before the next iteration of your test, e.g. (from #1
above):
 dmsetup message nvme_mpath 0 "reinstate_path $DEVICE"

--- Additional comment from Mike Snitzer on 2018-07-20 12:02:45 EDT ---

(In reply to Mike Snitzer from comment #6)

> SO seems pretty clear something is still wrong with request-based DM
> multipath ontop of NVMe... sadly we don't have any negative check in
> blk-core, NVMe or elsewhere to offer any clue :(

Building on this comment:

"Anyway, fact that I'm getting this corruption on multiple different
NVMe drives: I am definitely concerned that this BZ is due to a bug
somewhere in NVMe core (or block core code that is specific to NVMe)."

I'm left thinking that request-based DM multipath is somehow causing
NVMe's SG lists or other infrastructure to be "wrong" and it is
resulting in corruption.  I get corruption to the dm-cache's metadata
device (which while theoretically unrelated as its a separate device
from the "slow" dm-cache data device) if the dm-cache slow data device
is backed by request-based dm-multipath ontop of NVMe (which is a
partition from the _same_ NVMe device that is used by the dm-cache
metadata device).

Basically I'm back to thinking NVMe is corrupting the data due to the IO
pattern or nature of the cloned requests dm-multipath is issuing.  And
it is causing corruption to other NVMe partitions on the same parent
NVMe device.  Certainly that is a concerning hypothesis but I'm not
seeing much else that would explain this weird corruption.

If I don't use the same NVMe device (with multiple partitions) for _all_
3 sub-devices that dm-cache needs I don't see the corruption.  It is
almost like the mix of IO issued by DM cache's metadata (on nvme1n1p1
using dm-linear) and "fast" device (also on nvme1n1p1 via dm-linear
volume) in conjunction with IO issued by request-based DM multipath to
NVMe for "slow" device (on nvme1n1p2) is triggering NVMe to respond
negatively.  But this same observation can be made on completely
different hardware using 2 totally different NVMe devices:
testbed1: Intel Corporation Optane SSD 900P Series (2700)
testbed2: Samsung Electronics Co Ltd NVMe SSD Controller 171X (rev 03)

Which is why it feels like some bug in Linux (be it dm-rq.c, blk-core.c,
blk-merge.c or the common NVMe driver)

topology before starting the device-mapper-test-suite test:

# lsblk /dev/nvme1n1
NAME           MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
nvme1n1        259:1    0 745.2G  0 disk
├─nvme1n1p2    259:5    0 695.2G  0 part
│ └─nvme_mpath 253:2    0 695.2G  0 dm
└─nvme1n1p1    259:4    0    50G  0 part

topology during the device-mapper-test-suite test:

# lsblk /dev/nvme1n1
NAME                    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
nvme1n1                 259:1    0 745.2G  0 disk
├─nvme1n1p2             259:5    0 695.2G  0 part
│ └─nvme_mpath          253:2    0 695.2G  0 dm
│   └─test-dev-458572   253:5    0    48G  0 dm
│     └─test-dev-613083 253:6    0    48G  0 dm
/root/snitm/git/device-mapper-test-suite/kernel_builds
└─nvme1n1p1             259:4    0    50G  0 part
  ├─test-dev-126378     253:4    0     4G  0 dm
  │ └─test-dev-613083   253:6    0    48G  0 dm
  /root/snitm/git/device-mapper-test-suite/kernel_builds
  └─test-dev-652491     253:3    0    40M  0 dm
    └─test-dev-613083   253:6    0    48G  0 dm
    /root/snitm/git/device-mapper-test-suite/kernel_builds

pruning that tree a bit (removing the dm-cache device 253:6) for
clarity:

# lsblk /dev/nvme1n1
NAME                    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
nvme1n1                 259:1    0 745.2G  0 disk
├─nvme1n1p2             259:5    0 695.2G  0 part
│ └─nvme_mpath          253:2    0 695.2G  0 dm
│   └─test-dev-458572   253:5    0    48G  0 dm
└─nvme1n1p1             259:4    0    50G  0 part
  ├─test-dev-126378     253:4    0     4G  0 dm
  └─test-dev-652491     253:3    0    40M  0 dm

40M device is dm-cache "metadata" device
4G device is dm-cache "fast" data device
48G device is dm-cache "slow" data device
