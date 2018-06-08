Return-Path: <elviskitone@gmail.com>
Return-Path: <elviskitone@gmail.com>
Date: Fri, 8 Jun 2018 18:47:31 +0300
From: Kitone Elvis Peter <elviskitone@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: REMOVE DELETION ERROR
Message-ID: <20180608154731.GA1969@kitone-HP-ProBook-4530s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Corrected the modified variable in  previous commit
---
 block/partitions/acorn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/acorn.c b/block/partitions/acorn.c
index 3bfe39d..358b05e 100644
--- a/block/partitions/acorn.c
+++ b/block/partitions/acorn.c
@@ -152,7 +152,7 @@ static int linux_partition(struct parsed_partitions *state,
 		put_partition(state, slot++, first_sect +
 				 le32_to_cpu(linuxp->start_sect),
 				 le32_to_cpu(linuxp->nr_sects));
-		linux++;
+		linuxp++;
 	}
 	strlcat(state->pp_buf, " >", PAGE_SIZE);
 
-- 
2.7.4
