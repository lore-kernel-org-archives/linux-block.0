Return-Path: <srivatsa@csail.mit.edu>
Subject: [PATCH 1/2] char_dev: Fix off-by-one bugs in find_dynamic_major()
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: gregkh@linuxfoundation.org, logang@deltatee.com
Cc: axboe@kernel.dk, jlayton@poochiereds.net, bfields@fieldses.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 srivatsa@csail.mit.edu
Date: Mon, 05 Feb 2018 18:25:09 -0800
Message-ID: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Srivatsa S. Bhat <srivatsa@csail.mit.edu>

CHRDEV_MAJOR_DYN_END and CHRDEV_MAJOR_DYN_EXT_END are valid major
numbers. So fix the loop iteration to include them in the search for
free major numbers.

While at it, also remove a redundant if condition ("cd->major != i"),
as it will never be true.

Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
---

 fs/char_dev.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index a65e4a5..33c9385 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -67,18 +67,18 @@ static int find_dynamic_major(void)
 	int i;
 	struct char_device_struct *cd;
 
-	for (i = ARRAY_SIZE(chrdevs)-1; i > CHRDEV_MAJOR_DYN_END; i--) {
+	for (i = ARRAY_SIZE(chrdevs)-1; i >= CHRDEV_MAJOR_DYN_END; i--) {
 		if (chrdevs[i] == NULL)
 			return i;
 	}
 
 	for (i = CHRDEV_MAJOR_DYN_EXT_START;
-	     i > CHRDEV_MAJOR_DYN_EXT_END; i--) {
+	     i >= CHRDEV_MAJOR_DYN_EXT_END; i--) {
 		for (cd = chrdevs[major_to_index(i)]; cd; cd = cd->next)
 			if (cd->major == i)
 				break;
 
-		if (cd == NULL || cd->major != i)
+		if (cd == NULL)
 			return i;
 	}
 
