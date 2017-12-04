Return-Path: <ktkhai@virtuozzo.com>
Subject: [PATCH 2/5] aio: Export aio_nr_lock and aio_max_nr initial value to
 include/linux/aio.h
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: axboe@kernel.dk, bcrl@kvack.org, viro@zeniv.linux.org.uk, tj@kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org,
 oleg@redhat.com, ktkhai@virtuozzo.com
Date: Mon, 04 Dec 2017 19:13:09 +0300
Message-ID: <151240398921.10164.10950241945347389472.stgit@localhost.localdomain>
In-Reply-To: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-Path: ktkhai@virtuozzo.com
List-ID: <linux-block@vger.kernel.org>

Next patch will use the values in more files, so let's make them visible external.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/aio.c            |    4 ++--
 include/linux/aio.h |    4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 04209c0561b2..9dc98a29077c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -188,10 +188,10 @@ struct aio_kiocb {
 	struct eventfd_ctx	*ki_eventfd;
 };
 
+DEFINE_SPINLOCK(aio_nr_lock);
 /*------ sysctl variables----*/
-static DEFINE_SPINLOCK(aio_nr_lock);
 unsigned long aio_nr;		/* current system wide number of aio requests */
-unsigned long aio_max_nr = 0x10000; /* system wide maximum number of aio requests */
+unsigned long aio_max_nr = AIO_NR_DEF; /* system wide maximum number of aio requests */
 /*----end sysctl variables---*/
 
 static struct kmem_cache	*kiocb_cachep;
diff --git a/include/linux/aio.h b/include/linux/aio.h
index 9d8aabecfe2d..5dda2663802f 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -10,6 +10,10 @@ struct mm_struct;
 
 #define KIOCB_KEY		0
 
+#define AIO_NR_INF		(-1UL)
+#define AIO_NR_DEF		0x10000
+
+extern spinlock_t aio_nr_lock;
 typedef int (kiocb_cancel_fn)(struct kiocb *);
 
 /* prototypes */
