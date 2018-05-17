Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180509074830.16196-5-hch@lst.de>
References: <20180509074830.16196-1-hch@lst.de> <20180509074830.16196-5-hch@lst.de>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Thu, 17 May 2018 13:33:17 +0200
Message-ID: <CAHpGcM+i1sAPGLxN9m5tcu973cx-Jr-DU2D7xWYScp7hfpcvnA@mail.gmail.com>
Subject: Re: [PATCH 04/33] fs: remove the buffer_unwritten check in page_seek_hole_data
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xfs@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

2018-05-09 9:48 GMT+02:00 Christoph Hellwig <hch@lst.de>:
> We only call into this function through the iomap iterators, so we already
> know the buffer is unwritten.  In addition to that we always require the
> uptodate flag that is ORed with the result anyway.

Please update the page_cache_seek_hole_data description as well:

--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -647,8 +647,8 @@
  * Seek for SEEK_DATA / SEEK_HOLE in the page cache.
  *
  * Within unwritten extents, the page cache determines which parts are holes
- * and which are data: unwritten and uptodate buffer heads count as data;
- * everything else counts as a hole.
+ * and which are data: uptodate buffer heads count as data; everything else
+ * counts as a hole.
  *
  * Returns the resulting offset on successs, and -ENOENT otherwise.
  */

Thanks,
Andreas
