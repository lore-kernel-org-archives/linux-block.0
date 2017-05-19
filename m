Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:56157 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbdESQY0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2017 12:24:26 -0400
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [GIT PULL] libnvdimm fixes for 4.12-rc2
Date: Fri, 19 May 2017 16:24:24 +0000
Message-ID: <1495211062.15885.13.camel@intel.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-for-next

...to receive a couple compile fixes for 4.12-rc2.

With the removal of the -+AD4-direct+AF8-access() method from
block+AF8-device+AF8-operations in favor of a new dax+AF8-device +- dax+AF8-operations
we broke 2 configurations. The CONFIG+AF8-BLOCK+AD0-n case is fixed by
compiling out the block+-dax helpers in the dax core. Configurations
with FS+AF8-DAX+AD0-n EXT4+AD0-y / XFS+AD0-y and DAX+AD0-m fail due to the helpers the
builtin filesystem needs being in a module, so we stub out the helpers
in the FS+AF8-DAX+AD0-n case.

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-for-next

for you to fetch changes up to f5705aa8cfed142d980ecac12bee0d81b756479e:

  dax, xfs, ext4: compile out iomap-dax paths in the FS+AF8-DAX+AD0-n case (2017-05-13 17:52:16 -0700)

----------------------------------------------------------------
Dan Williams (2):
      dax: fix false CONFIG+AF8-BLOCK dependency
      dax, xfs, ext4: compile out iomap-dax paths in the FS+AF8-DAX+AD0-n case

 drivers/dax/super.c +AHw-  2 +-+-
 fs/ext2/inode.c     +AHw-  4 +-+---
 fs/ext4/inode.c     +AHw-  4 +-+---
 fs/xfs/xfs+AF8-iomap.c  +AHw-  4 +-+---
 include/linux/dax.h +AHw- 34 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--------
 5 files changed, 35 insertions(+-), 13 deletions(-)

commit 9d109081c261d87fc84e0cce245796796ae4c460
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:   Sat May 13 16:18:21 2017 -0700

    dax: fix false CONFIG+AF8-BLOCK dependency
    
    In the BLOCK+AD0-n case the dax core does not need to / must not emit the
    block-device-dax helpers. Otherwise it leads to compile errors.
    
    Cc: Arnd Bergmann +ADw-arnd+AEA-arndb.de+AD4-
    Reported-by: Fabian Frederick +ADw-fabf+AEA-skynet.be+AD4-
    Fixes: ef51042472f5 (+ACI-block, dax: move 'select DAX' from BLOCK to FS+AF8-DAX+ACI-)
    Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

commit f5705aa8cfed142d980ecac12bee0d81b756479e
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:   Sat May 13 16:31:05 2017 -0700

    dax, xfs, ext4: compile out iomap-dax paths in the FS+AF8-DAX+AD0-n case
    
    Tetsuo reports:
    
      fs/built-in.o: In function +AGA-xfs+AF8-file+AF8-iomap+AF8-end':
      xfs+AF8-iomap.c:(.text+-0xe0ef9): undefined reference to +AGA-put+AF8-dax'
      fs/built-in.o: In function +AGA-xfs+AF8-file+AF8-iomap+AF8-begin':
      xfs+AF8-iomap.c:(.text+-0xe1a7f): undefined reference to +AGA-dax+AF8-get+AF8-by+AF8-host'
      make: +ACoAKgAq- +AFs-vmlinux+AF0- Error 1
      +ACQ- grep DAX .config
      CONFIG+AF8-DAX+AD0-m
      +ACM- CONFIG+AF8-DEV+AF8-DAX is not set
      +ACM- CONFIG+AF8-FS+AF8-DAX is not set
    
    When FS+AF8-DAX+AD0-n we can/must throw away the dax code in filesystems.
    Implement 'fs+AF8-' versions of dax+AF8-get+AF8-by+AF8-host() and put+AF8-dax() that are
    nops in the FS+AF8-DAX+AD0-n case.
    
    Cc: +ADw-linux-xfs+AEA-vger.kernel.org+AD4-
    Cc: +ADw-linux-ext4+AEA-vger.kernel.org+AD4-
    Cc: Jan Kara +ADw-jack+AEA-suse.com+AD4-
    Cc: +ACI-Theodore Ts'o+ACI- +ADw-tytso+AEA-mit.edu+AD4-
    Cc: +ACI-Darrick J. Wong+ACI- +ADw-darrick.wong+AEA-oracle.com+AD4-
    Cc: Ross Zwisler +ADw-ross.zwisler+AEA-linux.intel.com+AD4-
    Tested-by: Tony Luck +ADw-tony.luck+AEA-intel.com+AD4-
    Fixes: ef51042472f5 (+ACI-block, dax: move 'select DAX' from BLOCK to FS+AF8-DAX+ACI-)
    Reported-by: Tetsuo Handa +ADw-penguin-kernel+AEA-i-love.sakura.ne.jp+AD4-
    Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index ebf43f531ada..6ed32aac8bbe 100644
--- a/drivers/dax/super.c
+-+-+- b/drivers/dax/super.c
+AEAAQA- -44,6 +-44,7 +AEAAQA- void dax+AF8-read+AF8-unlock(int id)
 +AH0-
 EXPORT+AF8-SYMBOL+AF8-GPL(dax+AF8-read+AF8-unlock)+ADs-
 
+-+ACM-ifdef CONFIG+AF8-BLOCK
 int bdev+AF8-dax+AF8-pgoff(struct block+AF8-device +ACo-bdev, sector+AF8-t sector, size+AF8-t size,
 		pgoff+AF8-t +ACo-pgoff)
 +AHs-
+AEAAQA- -112,6 +-113,7 +AEAAQA- int +AF8AXw-bdev+AF8-dax+AF8-supported(struct super+AF8-block +ACo-sb, int blocksize)
 	return 0+ADs-
 +AH0-
 EXPORT+AF8-SYMBOL+AF8-GPL(+AF8AXw-bdev+AF8-dax+AF8-supported)+ADs-
+-+ACM-endif
 
 /+ACoAKg-
  +ACo- struct dax+AF8-device - anchor object for dax services
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 26d77f9f8c12..2dcbd5698884 100644
--- a/fs/ext2/inode.c
+-+-+- b/fs/ext2/inode.c
+AEAAQA- -817,7 +-817,7 +AEAAQA- static int ext2+AF8-iomap+AF8-begin(struct inode +ACo-inode, loff+AF8-t offset, loff+AF8-t length,
 	iomap-+AD4-bdev +AD0- bdev+ADs-
 	iomap-+AD4-offset +AD0- (u64)first+AF8-block +ADwAPA- blkbits+ADs-
 	if (blk+AF8-queue+AF8-dax(bdev-+AD4-bd+AF8-queue))
-		iomap-+AD4-dax+AF8-dev +AD0- dax+AF8-get+AF8-by+AF8-host(bdev-+AD4-bd+AF8-disk-+AD4-disk+AF8-name)+ADs-
+-		iomap-+AD4-dax+AF8-dev +AD0- fs+AF8-dax+AF8-get+AF8-by+AF8-host(bdev-+AD4-bd+AF8-disk-+AD4-disk+AF8-name)+ADs-
 	else
 		iomap-+AD4-dax+AF8-dev +AD0- NULL+ADs-
 
+AEAAQA- -841,7 +-841,7 +AEAAQA- static int
 ext2+AF8-iomap+AF8-end(struct inode +ACo-inode, loff+AF8-t offset, loff+AF8-t length,
 		ssize+AF8-t written, unsigned flags, struct iomap +ACo-iomap)
 +AHs-
-	put+AF8-dax(iomap-+AD4-dax+AF8-dev)+ADs-
+-	fs+AF8-put+AF8-dax(iomap-+AD4-dax+AF8-dev)+ADs-
 	if (iomap-+AD4-type +AD0APQ- IOMAP+AF8-MAPPED +ACYAJg-
 	    written +ADw- length +ACYAJg-
 	    (flags +ACY- IOMAP+AF8-WRITE))
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5834c4d76be8..1bd0bfa547f6 100644
--- a/fs/ext4/inode.c
+-+-+- b/fs/ext4/inode.c
+AEAAQA- -3412,7 +-3412,7 +AEAAQA- static int ext4+AF8-iomap+AF8-begin(struct inode +ACo-inode, loff+AF8-t offset, loff+AF8-t length,
 	bdev +AD0- inode-+AD4-i+AF8-sb-+AD4-s+AF8-bdev+ADs-
 	iomap-+AD4-bdev +AD0- bdev+ADs-
 	if (blk+AF8-queue+AF8-dax(bdev-+AD4-bd+AF8-queue))
-		iomap-+AD4-dax+AF8-dev +AD0- dax+AF8-get+AF8-by+AF8-host(bdev-+AD4-bd+AF8-disk-+AD4-disk+AF8-name)+ADs-
+-		iomap-+AD4-dax+AF8-dev +AD0- fs+AF8-dax+AF8-get+AF8-by+AF8-host(bdev-+AD4-bd+AF8-disk-+AD4-disk+AF8-name)+ADs-
 	else
 		iomap-+AD4-dax+AF8-dev +AD0- NULL+ADs-
 	iomap-+AD4-offset +AD0- first+AF8-block +ADwAPA- blkbits+ADs-
+AEAAQA- -3447,7 +-3447,7 +AEAAQA- static int ext4+AF8-iomap+AF8-end(struct inode +ACo-inode, loff+AF8-t offset, loff+AF8-t length,
 	int blkbits +AD0- inode-+AD4-i+AF8-blkbits+ADs-
 	bool truncate +AD0- false+ADs-
 
-	put+AF8-dax(iomap-+AD4-dax+AF8-dev)+ADs-
+-	fs+AF8-put+AF8-dax(iomap-+AD4-dax+AF8-dev)+ADs-
 	if (+ACE-(flags +ACY- IOMAP+AF8-WRITE) +AHwAfA- (flags +ACY- IOMAP+AF8-FAULT))
 		return 0+ADs-
 
diff --git a/fs/xfs/xfs+AF8-iomap.c b/fs/xfs/xfs+AF8-iomap.c
index a63f61c256bd..94e5bdf7304c 100644
--- a/fs/xfs/xfs+AF8-iomap.c
+-+-+- b/fs/xfs/xfs+AF8-iomap.c
+AEAAQA- -1068,7 +-1068,7 +AEAAQA- xfs+AF8-file+AF8-iomap+AF8-begin(
 	/+ACo- optionally associate a dax device with the iomap bdev +ACo-/
 	bdev +AD0- iomap-+AD4-bdev+ADs-
 	if (blk+AF8-queue+AF8-dax(bdev-+AD4-bd+AF8-queue))
-		iomap-+AD4-dax+AF8-dev +AD0- dax+AF8-get+AF8-by+AF8-host(bdev-+AD4-bd+AF8-disk-+AD4-disk+AF8-name)+ADs-
+-		iomap-+AD4-dax+AF8-dev +AD0- fs+AF8-dax+AF8-get+AF8-by+AF8-host(bdev-+AD4-bd+AF8-disk-+AD4-disk+AF8-name)+ADs-
 	else
 		iomap-+AD4-dax+AF8-dev +AD0- NULL+ADs-
 
+AEAAQA- -1149,7 +-1149,7 +AEAAQA- xfs+AF8-file+AF8-iomap+AF8-end(
 	unsigned		flags,
 	struct iomap		+ACo-iomap)
 +AHs-
-	put+AF8-dax(iomap-+AD4-dax+AF8-dev)+ADs-
+-	fs+AF8-put+AF8-dax(iomap-+AD4-dax+AF8-dev)+ADs-
 	if ((flags +ACY- IOMAP+AF8-WRITE) +ACYAJg- iomap-+AD4-type +AD0APQ- IOMAP+AF8-DELALLOC)
 		return xfs+AF8-file+AF8-iomap+AF8-end+AF8-delalloc(XFS+AF8-I(inode), offset,
 				length, written, iomap)+ADs-
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 00ebac854bb7..5ec1f6c47716 100644
--- a/include/linux/dax.h
+-+-+- b/include/linux/dax.h
+AEAAQA- -18,6 +-18,20 +AEAAQA- struct dax+AF8-operations +AHs-
 			void +ACoAKg-, pfn+AF8-t +ACo-)+ADs-
 +AH0AOw-
 
+-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-DAX)
+-struct dax+AF8-device +ACo-dax+AF8-get+AF8-by+AF8-host(const char +ACo-host)+ADs-
+-void put+AF8-dax(struct dax+AF8-device +ACo-dax+AF8-dev)+ADs-
+-+ACM-else
+-static inline struct dax+AF8-device +ACo-dax+AF8-get+AF8-by+AF8-host(const char +ACo-host)
+-+AHs-
+-	return NULL+ADs-
+-+AH0-
+-
+-static inline void put+AF8-dax(struct dax+AF8-device +ACo-dax+AF8-dev)
+-+AHs-
+-+AH0-
+-+ACM-endif
+-
 int bdev+AF8-dax+AF8-pgoff(struct block+AF8-device +ACo-, sector+AF8-t, size+AF8-t, pgoff+AF8-t +ACo-pgoff)+ADs-
 +ACM-if IS+AF8-ENABLED(CONFIG+AF8-FS+AF8-DAX)
 int +AF8AXw-bdev+AF8-dax+AF8-supported(struct super+AF8-block +ACo-sb, int blocksize)+ADs-
+AEAAQA- -25,23 +-39,29 +AEAAQA- static inline int bdev+AF8-dax+AF8-supported(struct super+AF8-block +ACo-sb, int blocksize)
 +AHs-
 	return +AF8AXw-bdev+AF8-dax+AF8-supported(sb, blocksize)+ADs-
 +AH0-
+-
+-static inline struct dax+AF8-device +ACo-fs+AF8-dax+AF8-get+AF8-by+AF8-host(const char +ACo-host)
+-+AHs-
+-	return dax+AF8-get+AF8-by+AF8-host(host)+ADs-
+-+AH0-
+-
+-static inline void fs+AF8-put+AF8-dax(struct dax+AF8-device +ACo-dax+AF8-dev)
+-+AHs-
+-	put+AF8-dax(dax+AF8-dev)+ADs-
+-+AH0-
+-
 +ACM-else
 static inline int bdev+AF8-dax+AF8-supported(struct super+AF8-block +ACo-sb, int blocksize)
 +AHs-
 	return -EOPNOTSUPP+ADs-
 +AH0-
-+ACM-endif
 
-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-DAX)
-struct dax+AF8-device +ACo-dax+AF8-get+AF8-by+AF8-host(const char +ACo-host)+ADs-
-void put+AF8-dax(struct dax+AF8-device +ACo-dax+AF8-dev)+ADs-
-+ACM-else
-static inline struct dax+AF8-device +ACo-dax+AF8-get+AF8-by+AF8-host(const char +ACo-host)
+-static inline struct dax+AF8-device +ACo-fs+AF8-dax+AF8-get+AF8-by+AF8-host(const char +ACo-host)
 +AHs-
 	return NULL+ADs-
 +AH0-
 
-static inline void put+AF8-dax(struct dax+AF8-device +ACo-dax+AF8-dev)
+-static inline void fs+AF8-put+AF8-dax(struct dax+AF8-device +ACo-dax+AF8-dev)
 +AHs-
 +AH0-
 +ACM-endif
