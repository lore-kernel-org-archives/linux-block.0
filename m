Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6093EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 30 Jun 2023 15:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjF3P01 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 11:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjF3P00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 11:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5882703
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mthXo3mgP7U+daoZuZFZnhRN3B6pNdnA/TCl+mKtp+A=;
        b=NDe2oPkJ6HlSGfTcaxsh5MxfgHUH8z7Z6fdMKINWprImdTbvGL5oJGb0wmfoQvdDrgDazz
        sJmnupmq7gTt/hB7pArM1U4LWRLPYiVExBOaMXHH7X+i40gDvY9ugMd3SHoEaZ+wgJWITt
        QtlLaj2tijhTanW068X+NqkViFzu4NI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-U7PU7gZfOQ2IVzmMF0LTDg-1; Fri, 30 Jun 2023 11:25:29 -0400
X-MC-Unique: U7PU7gZfOQ2IVzmMF0LTDg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FE6F8631DB;
        Fri, 30 Jun 2023 15:25:28 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D6DD492B02;
        Fri, 30 Jun 2023 15:25:26 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH 00/11] iov_iter: Use I/O direction from kiocb, iomap & request rather than iov_iter
Date:   Fri, 30 Jun 2023 16:25:13 +0100
Message-ID: <20230630152524.661208-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, Christoph,

Here are some patches to switch from using the I/O direction indication in the
iov_iter struct to using the I/O direction flags to be found in the kiocb
struct, the iomap_iter struct and the request struct.  The iterator's I/O
direction is then only used in some internal checks.

The patches also add direction flags into iov_iter_extract_pages() so that it
can perform some checks.  New constants are defined rather than using READ and
WRITE so that a check can be made that one of them is specified.  The problem
with the READ constant is that it is zero and is thus the same as no direction
being specified - but if we're modifying the buffer contents (ie. reading into
it), we need to know to set FOLL_WRITE.  Granted this would be the default if
unspecified, but it seems better that this case should be explicit.

There are also patches to make 9P and SCSI use iov_iter_extract_pages().

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract

David

David Howells (11):
  iov_iter: Fix comment refs to iov_iter_get_pages/pages_alloc()
  vfs: Set IOCB_WRITE in iocbs that we're going to write from
  vfs: Use init_kiocb() to initialise new IOCBs
  iov_iter: Use IOCB_WRITE rather than iterator direction
  iov_iter: Use IOMAP_WRITE rather than iterator direction
  iov_iter: Use op_is_write() rather than iterator direction
  cifs: Drop the check using iov_iter_rw()
  iov_iter: Drop iov_iter_rw() and fold in last user
  iov_iter: Use I/O dir flags with iov_iter_extract_pages()
  9p: Pin pages rather than ref'ing if appropriate
  scsi: Use extract_iter_to_sg()

 block/bio.c                       |  6 ++
 block/blk-map.c                   |  5 +-
 block/fops.c                      |  8 +--
 crypto/af_alg.c                   |  5 +-
 crypto/algif_hash.c               |  3 +-
 drivers/block/loop.c              | 11 ++--
 drivers/nvme/target/io-cmd-file.c |  5 +-
 drivers/target/target_core_file.c |  2 +-
 drivers/vhost/scsi.c              | 79 ++++++++------------------
 fs/9p/vfs_addr.c                  |  2 +-
 fs/affs/file.c                    |  4 +-
 fs/aio.c                          |  9 ++-
 fs/btrfs/ioctl.c                  |  4 +-
 fs/cachefiles/io.c                | 10 ++--
 fs/ceph/file.c                    |  6 +-
 fs/dax.c                          |  6 +-
 fs/direct-io.c                    | 28 ++++++----
 fs/exfat/inode.c                  |  6 +-
 fs/ext2/inode.c                   |  2 +-
 fs/f2fs/file.c                    | 10 ++--
 fs/fat/inode.c                    |  4 +-
 fs/fuse/dax.c                     |  2 +-
 fs/fuse/file.c                    |  8 +--
 fs/hfs/inode.c                    |  2 +-
 fs/hfsplus/inode.c                |  2 +-
 fs/iomap/direct-io.c              |  4 +-
 fs/jfs/inode.c                    |  2 +-
 fs/nfs/direct.c                   |  2 +-
 fs/nilfs2/inode.c                 |  2 +-
 fs/ntfs3/inode.c                  |  2 +-
 fs/ocfs2/aops.c                   |  2 +-
 fs/orangefs/inode.c               |  2 +-
 fs/read_write.c                   | 10 ++--
 fs/reiserfs/inode.c               |  2 +-
 fs/seq_file.c                     |  2 +-
 fs/smb/client/smbdirect.c         |  9 ---
 fs/splice.c                       |  2 +-
 fs/udf/inode.c                    |  2 +-
 include/linux/bio.h               | 18 +++++-
 include/linux/fs.h                | 16 +++++-
 include/linux/mm_types.h          |  2 +-
 include/linux/uio.h               | 10 ++--
 io_uring/rw.c                     | 10 ++--
 lib/iov_iter.c                    | 14 ++++-
 lib/scatterlist.c                 | 12 +++-
 mm/filemap.c                      |  2 +-
 mm/page_io.c                      |  4 +-
 net/9p/trans_common.c             |  8 +--
 net/9p/trans_common.h             |  2 +-
 net/9p/trans_virtio.c             | 92 ++++++++++---------------------
 50 files changed, 221 insertions(+), 241 deletions(-)

