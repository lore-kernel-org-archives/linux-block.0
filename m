Return-Path: <jikos@kernel.org>
Date: Wed, 4 Jan 2017 15:15:21 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] minor floppy fix
Message-ID: <alpine.LSU.2.20.1701041315560.28985@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

Jens,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/linux-block.git for-jens

(based on your current for-next branch)

to get minor memory allocation fix for floppy driver, from Vlastimil 
Babka.

Thanks.

----------------------------------------------------------------
Vlastimil Babka (1):
      floppy: replace wrong kmalloc(GFP_USER) with GFP_KERNEL

 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jiri Kosina
SUSE Labs
