Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org
Subject: [PATCHSET v8] Add support for write life time hints
Date: Mon, 19 Jun 2017 11:04:53 -0600
Message-Id: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

A new iteration of this patchset, previously known as write streams.
As before, this patchset aims at enabling applications split up
writes into separate streams, based on the perceived life time
of the data written. This is useful for a variety of reasons:

- For NVMe, this feature is ratified and released with the NVMe 1.3
  spec. Devices implementing Directives can expose multiple streams.
  Separating data written into streams based on life time can
  drastically reduce the write amplification. This helps device
  endurance, and increases performance. Testing just performed
  internally at Facebook with these patches showed up to a 25% reduction
  in NAND writes in a RocksDB setup.

- Software caching solutions can make more intelligent decisions
  on how and where to place data.

Contrary to previous patches, we're not exposing numeric stream values anymore.
I've previously advocated for just doing a set of hints that makes sense
instead. See the coverage from the LSFMM summit this year:

https://lwn.net/Articles/717755/

This patchset attempts to do that. We add an fcntl(2) interface to
get/set these types of hints. We define 4 hints that pertain to
data write life times:

RWH_WRITE_LIFE_SHORT	Data written with this flag is expected to have
			a high overwrite rate, or life time.

RWH_WRITE_LIFE_MEDIUM	Longer life time than SHORT

RWH_WRITE_LIFE_LONG	Longer life time than MEDIUM

RWH_WRITE_LIFE_EXTREME	Longer life time than LONG

The idea is that these are relative values, so an application can
use them as they see fit. The underlying device can then place
data appropriately, or be free to ignore the hint. It's just a hint.

A branch based on current master can be pulled
from here:

git://git.kernel.dk/linux-block write-stream.8

Changes since v7:

- NVMe: change 'streams' parameter to be a bool enable/disable. We
  hardwire the number of streams anyway and use the appropriate amount,
  so no point in exposing this value.
- NVMe: collapse stream values appropriately, instead of just doing
  a basic MOD.
- Get rid of pwritev2(2) flags. Just use the fcntl(2) interface.
- Collapse some patches
- Change fcntl(2) interface to get/set values from a user supplied
  64-bit pointer.
- Move inode-to-iocb mask setting to iocb_flags().

Changes since v6:

- Rewrite NVMe write stream assignment
- Change NVMe stream assignment to be per-controller, not per-ns. Then
  we can use the same IDs across name spaces, and we don't have to do
  lazy setup of streams.
- If streams are enabled on nvme, set io min/opt and discard
  granularity based on the stream params reported.
- Fixup F_SET_RW_HINT definition, it was 20, should have been 12.

Changes since v5:

- Change enum write_hint to enum rw_hint.
- Change fcntl() interface to be read/write generic
- Bring enum rw_hint all the way to bio/request
- Change references to streams in changelogs and debugfs interface
- Rebase to master to resolve blkdev.h conflict
- Reshuffle patches so the WRITE_LIFE_* hints and type come first. Allowed
  me to merge two block patches as well.

Changes since v4:

- Add enum write_hint and the WRITE_HINT_* values. This is what we
  use internally (until transformed to req/bio flags), and what is
  exposed to user space with the fcntl() interface. Maps directly
  to the RWF_WRITE_LIFE_* values.
- Add fcntl() interface for getting/setting hint values.
- Get rid of inode ->i_write_hint, encode the 3 bits of hint info
  in the inode flags intead.
- Allow a write with no hint to clear the old hint. Previously we
  only changed the hint if a new valid hint was given, not if no
  hint was passed in.
- Shrink flag space grabbed from 4 to 3 bits for RWF_* and the inode
  flags.

Changes since v3:

- Change any naming of stream ID to write hint.
- Various little API changes, suggested by Christoph
- Cleanup the NVMe bits, dump the debug info.
- Change NVMe to lazily allocate the streams.
- Various NVMe error handling improvements and command checking.

Changes since v2:

- Get rid of bio->bi_stream and replace with four request/bio flags.
  These map directly to the RWF_WRITE_* flags that the user passes in.
- Cleanup the NVMe stream setting.
- Drivers now responsible for updating the queue stream write counter,
  as they determine what stream to map a given flag to.

Changes since v1:

- Guard queue stream stats to ensure we don't mess up memory, if
  bio_stream() ever were to return a larger value than we support.
- NVMe: ensure we set the stream modulo the name space defined count.
- Cleanup the RWF_ and IOCB_ flags. Set aside 4 bits, and just store
  the stream value in there. This makes the passing of stream ID from
  RWF_ space to IOCB_ (and IOCB_ to bio) more efficient, and cleans it
  up in general.
- Kill the block internal definitions of the stream type, we don't need
  them anymore. See above.

-- 
Jens Axboe
