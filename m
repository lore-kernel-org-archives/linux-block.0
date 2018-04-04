Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Sage Weil <sage@redhat.com>,
	Alex Elder <elder@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jason Dillaman <dillaman@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rbd: add missing return statements
Date: Wed,  4 Apr 2018 11:49:22 +0200
Message-Id: <20180404094931.2345742-1-arnd@arndb.de>
List-ID: <linux-block@vger.kernel.org>

A new set of warnings appeared in next-20180403 in some configurations
when gcc cannot see that rbd_assert(0) leads to an unreachable code
path:

drivers/block/rbd.c: In function 'rbd_img_is_write':
drivers/block/rbd.c:1397:1: error: control reaches end of non-void function [-Werror=return-type]
drivers/block/rbd.c: In function '__rbd_obj_handle_request':
drivers/block/rbd.c:2499:1: error: control reaches end of non-void function [-Werror=return-type]
drivers/block/rbd.c: In function 'rbd_obj_handle_write':
drivers/block/rbd.c:2471:1: error: control reaches end of non-void function [-Werror=return-type]

To work around this, we can add a return statement to each of these
cases. An alternative would be to remove the unlikely() annotation
in rbd_assert(), or to just use BUG()/BUG_ON() directly. This adds the
return statements, guessing what the most reasonable behavior
would be.

Fixes: 3da691bf4366 ("rbd: new request handling code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 07dc5419bd63..9445a71a9cd6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1394,6 +1394,7 @@ static bool rbd_img_is_write(struct rbd_img_request *img_req)
 	default:
 		rbd_assert(0);
 	}
+	return false;
 }
 
 static void rbd_obj_handle_request(struct rbd_obj_request *obj_req);
@@ -2468,6 +2469,7 @@ static bool rbd_obj_handle_write(struct rbd_obj_request *obj_req)
 	default:
 		rbd_assert(0);
 	}
+	return true;
 }
 
 /*
@@ -2496,6 +2498,7 @@ static bool __rbd_obj_handle_request(struct rbd_obj_request *obj_req)
 	default:
 		rbd_assert(0);
 	}
+	return true;
 }
 
 static void rbd_obj_end_request(struct rbd_obj_request *obj_req)
-- 
2.9.0
