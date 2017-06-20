Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: axboe@kernel.dk
Cc: viro@ZenIV.linux.org.uk,
	hch@lst.de,
	jack@suse.cz,
	akpm@linux-foundation.org,
	linux-block@vger.kernel.org
Subject: [PATCH 0/10 v14] merge request: No wait AIO
Date: Tue, 20 Jun 2017 07:05:39 -0500
Message-Id: <20170620120549.23147-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

Jens,

As discussed, here are the patches against the block
tree for merge since the block layer changes had the most conflicts.
My tree is at https://github.com/goldwynr/linux/tree/nowait-block

 Changes since v13:
 + nowait support for dax files in ext4 and xfs

-- 
Goldwyn
