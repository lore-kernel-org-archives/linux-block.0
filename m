Return-Path: <ktkhai@virtuozzo.com>
Subject: [PATCH 1/5] aio: Move aio_nr increment to separate function
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: axboe@kernel.dk, bcrl@kvack.org, viro@zeniv.linux.org.uk, tj@kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org,
 oleg@redhat.com, ktkhai@virtuozzo.com
Date: Mon, 04 Dec 2017 19:12:59 +0300
Message-ID: <151240397905.10164.6467631934054020994.stgit@localhost.localdomain>
In-Reply-To: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-Path: ktkhai@virtuozzo.com
List-ID: <linux-block@vger.kernel.org>

There is no functional changes, only a preparation
for next patches.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/aio.c |   44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index e6de7715228c..04209c0561b2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -694,13 +694,39 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 	}
 }
 
-static void aio_nr_sub(unsigned nr)
+static bool __try_to_charge_aio_nr(unsigned nr)
+{
+	if (aio_nr + nr > aio_max_nr ||
+	    aio_nr + nr < aio_nr)
+		return false;
+
+	aio_nr += nr;
+	return true;
+}
+
+static void __uncharge_aio_nr(unsigned nr)
 {
-	spin_lock(&aio_nr_lock);
 	if (WARN_ON(aio_nr - nr > aio_nr))
 		aio_nr = 0;
 	else
 		aio_nr -= nr;
+}
+
+static bool try_to_charge_aio_nr(unsigned nr)
+{
+	bool ret;
+
+	spin_lock(&aio_nr_lock);
+	ret = __try_to_charge_aio_nr(nr);
+	spin_unlock(&aio_nr_lock);
+
+	return ret;
+}
+
+static void uncharge_aio_nr(unsigned nr)
+{
+	spin_lock(&aio_nr_lock);
+	__uncharge_aio_nr(nr);
 	spin_unlock(&aio_nr_lock);
 }
 
@@ -776,15 +802,9 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 		ctx->req_batch = 1;
 
 	/* limit the number of system wide aios */
-	spin_lock(&aio_nr_lock);
-	if (aio_nr + ctx->max_reqs > aio_max_nr ||
-	    aio_nr + ctx->max_reqs < aio_nr) {
-		spin_unlock(&aio_nr_lock);
-		err = -EAGAIN;
+	err = -EAGAIN;
+	if (!try_to_charge_aio_nr(ctx->max_reqs))
 		goto err_ctx;
-	}
-	aio_nr += ctx->max_reqs;
-	spin_unlock(&aio_nr_lock);
 
 	percpu_ref_get(&ctx->users);	/* io_setup() will drop this ref */
 	percpu_ref_get(&ctx->reqs);	/* free_ioctx_users() will drop this */
@@ -801,7 +821,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	return ctx;
 
 err_cleanup:
-	aio_nr_sub(ctx->max_reqs);
+	uncharge_aio_nr(ctx->max_reqs);
 err_ctx:
 	atomic_set(&ctx->dead, 1);
 	if (ctx->mmap_size)
@@ -848,7 +868,7 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
 	 * -EAGAIN with no ioctxs actually in use (as far as userspace
 	 *  could tell).
 	 */
-	aio_nr_sub(ctx->max_reqs);
+	uncharge_aio_nr(ctx->max_reqs);
 
 	if (ctx->mmap_size)
 		vm_munmap(ctx->mmap_base, ctx->mmap_size);
