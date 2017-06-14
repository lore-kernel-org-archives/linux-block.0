Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca
Subject: [PATCHSET v2] Add support for write life time hints
Date: Tue, 13 Jun 2017 22:01:49 -0600
Message-Id: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

A new iteration of this patchset, previously known as write streams.
As before, this patchset aims at enabling applications split up
writes into separate streams, based on the perceived life time
of the data written. This is useful for a variety of reasons:

- With NVMe 1.3 compliant devices, the device can expose multiple
  streams. Separating data written into streams based on life time
  can drastically reduce the write amplification. This helps device
  endurance, and increases performance. Testing just performed
  internally at Facebook with these patches showed up to a 25%
  reduction in NAND writes in a RocksDB setup.

- Software caching solutions can make more intelligent decisions
  on how and where to place data.

Contrary to previous patches, we're not exposing numeric stream values anymore.
I've previously advocated for just doing a set of hints that makes sense
instead. See the coverage from the LSFMM summit this year:

https://lwn.net/Articles/717755/

This patchset attempts to do that. We define 4 flags for the pwritev2
system call:

RWF_WRITE_LIFE_SHORT	Data written with this flag is expected to have
			a high overwrite rate, or life time.

RWF_WRITE_LIFE_MEDIUM	Longer life time than SHORT

RWF_WRITE_LIFE_LONG	Longer life time than MEDIUM

RWF_WRITE_LIFE_EXTREME	Longer life time than LONG

The idea is that these are relative values, so an application can
use them as they see fit. The underlying device can then place
data appropriately, or be free to ignore the hint. It's just a hint.

A branch based on current master can be pulled
from here:

git://git.kernel.dk/linux-block write-stream.1

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
