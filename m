Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] fs meta data unmap
Message-ID: <db91490b-dcfb-983b-52be-265e842dcf0e@kernel.dk>
Date: Wed, 14 Dec 2016 15:54:19 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A series from Jan Kara, providing a more efficient way for unmapping
meta data from in the buffer cache than doing it block-by-block. Provide
a general helper that existing callers can use.

Please pull!


  git://git.kernel.dk/linux-block.git for-4.10/fs-unmap


----------------------------------------------------------------
Jan Kara (6):
      fs: Provide function to unmap metadata for a range of blocks
      direct-io: Use clean_bdev_aliases() instead of handmade iteration
      ext4: Use clean_bdev_aliases() instead of iteration
      ext2: Use clean_bdev_aliases() instead of iteration
      fs: Add helper to clean bdev aliases under a bh and use it
      fs: Remove unmap_underlying_metadata

 fs/buffer.c                 | 104 +++++++++++++++++++++++++++++++-------------
 fs/direct-io.c              |  28 +++---------
 fs/ext2/inode.c             |   9 ++--
 fs/ext4/extents.c           |  13 +-----
 fs/ext4/inode.c             |  18 +++-----
 fs/ext4/page-io.c           |   2 +-
 fs/mpage.c                  |   3 +-
 fs/ntfs/aops.c              |   2 +-
 fs/ntfs/file.c              |   5 +--
 fs/ocfs2/aops.c             |   2 +-
 fs/ufs/balloc.c             |   3 +-
 fs/ufs/inode.c              |   3 +-
 include/linux/buffer_head.h |   7 ++-
 13 files changed, 104 insertions(+), 95 deletions(-)

-- 
Jens Axboe
