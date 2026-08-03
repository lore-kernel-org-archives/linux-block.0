Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98F26982C
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786386; cv=none; b=Bfako1HVC4CRbdEWwmnZoqV0anfTpiU2hC0bKAvPnxI7Yi6IwxoJ2jQVstTp925eWh/R6ig1j2d+LuZi6ZkfPKSlSAU2+2WtBvZYpRnTr03XQGjIkzSw2aRp+3/dI/+02rSxDX1BL07jrIgmYzYSmWk+qfgujUmD9KNOV9KsBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786386; c=relaxed/simple;
	bh=QJUKYYZ+Ngu9vrXeW6sVXKrHqsfzwb4pP0yav050pYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsoZn74jL1xEIFnXi9JZtA6jJVhLlWfiQblbULbxRn7Q4W/9dQ0Sf+F8YOWwXCJnQ6kpJwE2O5kJipkq2+LU+mNCU4V+3m/2NwtLfl/J3XInQveA/RGtXwjW6o4NquqZrx0M5n2qBQw9GxsTjlYkAzi9xsjtMiSKeCjxW7f/xaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=n0LP0m2O; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="n0LP0m2O"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hDRxq5sMfzlfvq4;
	Mon,  3 Aug 2026 19:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785786374; x=1788378375; bh=+hlXBh64IxqDdDshtqGR4r+v
	KYC4xtrHPiY7HEc2nRI=; b=n0LP0m2OFQOknlZbbTDhZJG2UYIDfTzKF9yLpoKA
	OvXCuK4pi+dBBYEKTjiljcz+lh1uZr1uOhyEeLvzDcNHzV4rMaN3o5RX1i/22SIt
	79Mw4m7UK4ZP8W+ZYcaObbQgRT+kFbAPN5e/7gP/DjUieggfSn9K5vha/sToKRPD
	6nz6ushAXAQU2VnVDXc5jhuMyPg5KgN2Jsyd+Kifb30SOJhDEyngalpUFfbCUVng
	b5UzPCFhKi2KH/Iof0oYIppJeutHWjv+KehHNcbvpY1wZYGPuabyJOPVpdY0y6Xc
	NA/G6y//M9IQhRmIPokKUP8FQi9iPn9j5FMWii3yvy/u5w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jTFElilFC8UF; Mon,  3 Aug 2026 19:46:14 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hDRxc5qVxzlfvpH;
	Mon,  3 Aug 2026 19:46:12 +0000 (UTC)
Message-ID: <83968777-6f3a-4c21-ac89-fe9ebcbf254d@acm.org>
Date: Mon, 3 Aug 2026 12:46:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] rbd: Enable lock context analysis
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 Ilya Dryomov <idryomov@gmail.com>
References: <cover.1785440858.git.bvanassche@acm.org>
 <0b2988ca05e8a2733352a447e0810104b878376a.1785440858.git.bvanassche@acm.org>
 <487841d2-9d55-4873-ab6b-dbd94aa7bb71@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <487841d2-9d55-4873-ab6b-dbd94aa7bb71@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 8/3/26 7:03 AM, Nilay Shroff wrote:
> In addition to the above annotations, it looks like several variables=20
> and structure members
> are consistently protected by specific locks:
>=20
> 1. rbd_dev_list is guarded by rbd_dev_list_lock.
> 2. rbd_client_list is guarded by rbd_client_list_lock.
> 3. rbd_device::acquiring_list and rbd_device::running_list are guarded =
by
>  =C2=A0=C2=A0 rbd_device::lock_lists_lock.
> 4. rbd_device::object_map is guarded by rbd_device::object_map_lock.
> 5. rbd_device::watch_cookie, rbd_device::watch_state, and=20
> rbd_device::watch_handle
>  =C2=A0=C2=A0 are guarded by rbd_device::watch_mutex.
> 6. rbd_device::lock_state and rbd_device::lock_cookie are guarded by=20
> rbd_device::lock_rwsem.
>=20
> So I think we should add the corresponding `__guarded_by(...)`=20
> annotations for these
> fields as part of enabling lock context analysis for this driver.

Hi Nilay,

Thank you for having looked this up. I took a closer look at the rbd
driver and came up with the patch below. Some observations:
- Some code obtains pointers to acquiring_list, running_list and
   object_map before the corresponding synchronization objects are
   acquired. Hence, I have not tried to annotate these struct members
   with __guarded_by().
- The locking convention followed by rbd_img_object_requests() is not
   a good fit for what Clang supports.

Further feedback is welcome.

Thanks,

Bart.

These are the changes I came up with (relative to the above patch):

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f0f7a94e3e3e..4c9f566b7a91 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -406,26 +406,26 @@ struct rbd_device {
  	struct mutex		watch_mutex;
  	enum rbd_watch_state	watch_state;
  	struct ceph_osd_linger_request *watch_handle;
-	u64			watch_cookie;
+	u64			watch_cookie __guarded_by(&watch_mutex);
  	struct delayed_work	watch_dwork;

  	struct rw_semaphore	lock_rwsem;
-	enum rbd_lock_state	lock_state;
-	char			lock_cookie[32];
+	enum rbd_lock_state	lock_state __guarded_by(&lock_rwsem);
+	char			lock_cookie[32] __guarded_by(&lock_rwsem);
  	struct rbd_client_id	owner_cid;
  	struct work_struct	acquired_lock_work;
  	struct work_struct	released_lock_work;
  	struct delayed_work	lock_dwork;
  	struct work_struct	unlock_work;
  	spinlock_t		lock_lists_lock;
-	struct list_head	acquiring_list;
-	struct list_head	running_list;
+	struct list_head	acquiring_list; /* __guarded_by(&lock) */
+	struct list_head	running_list; /* __guarded_by(&lock) */
  	struct completion	acquire_wait;
  	int			acquire_err;
  	struct completion	quiescing_wait;

  	spinlock_t		object_map_lock;
-	u8			*object_map;
+	u8			*object_map; /*__guarded_by(&object_map_lock)*/
  	u64			object_map_size;	/* in objects */
  	u64			object_map_flags;

@@ -464,11 +464,13 @@ enum rbd_dev_flags {

  static DEFINE_MUTEX(client_mutex);	/* Serialize client creation */

-static LIST_HEAD(rbd_dev_list);    /* devices */
+/* devices */
  static DEFINE_SPINLOCK(rbd_dev_list_lock);
+static __guarded_by(&rbd_dev_list_lock) LIST_HEAD(rbd_dev_list);

-static LIST_HEAD(rbd_client_list);		/* clients */
+/* clients */
  static DEFINE_SPINLOCK(rbd_client_list_lock);
+static __guarded_by(&rbd_client_list_lock) LIST_HEAD(rbd_client_list);

  /* Slab caches for frequently-allocated structures */

@@ -521,6 +523,7 @@ static bool rbd_is_snap(struct rbd_device *rbd_dev)
  }

  static bool __rbd_is_lock_owner(struct rbd_device *rbd_dev)
+	__must_hold_shared(&rbd_dev->lock_rwsem)
  {
  	lockdep_assert_held(&rbd_dev->lock_rwsem);

@@ -1645,6 +1648,7 @@ static void __rbd_object_map_index(struct=20
rbd_device *rbd_dev, u64 objno,
  }

  static u8 __rbd_object_map_get(struct rbd_device *rbd_dev, u64 objno)
+	__must_hold(&rbd_dev->object_map_lock)
  {
  	u64 index;
  	u8 shift;
@@ -1655,6 +1659,7 @@ static u8 __rbd_object_map_get(struct rbd_device=20
*rbd_dev, u64 objno)
  }

  static void __rbd_object_map_set(struct rbd_device *rbd_dev, u64=20
objno, u8 val)
+	__must_hold(&rbd_dev->object_map_lock)
  {
  	u64 index;
  	u8 shift;
@@ -3431,6 +3436,7 @@ static bool need_exclusive_lock(struct=20
rbd_img_request *img_req)
  }

  static bool rbd_lock_add_request(struct rbd_img_request *img_req)
+	__must_hold_shared(&img_req->rbd_dev->lock_rwsem)
  {
  	struct rbd_device *rbd_dev =3D img_req->rbd_dev;
  	bool locked;
@@ -3448,6 +3454,7 @@ static bool rbd_lock_add_request(struct=20
rbd_img_request *img_req)
  }

  static void rbd_lock_del_request(struct rbd_img_request *img_req)
+	__must_hold_shared(&img_req->rbd_dev->lock_rwsem)
  {
  	struct rbd_device *rbd_dev =3D img_req->rbd_dev;
  	bool need_wakeup =3D false;
@@ -3472,6 +3479,8 @@ static int rbd_img_exclusive_lock(struct=20
rbd_img_request *img_req)
  	if (!need_exclusive_lock(img_req))
  		return 1;

+	__assume_ctx_lock(&img_req->rbd_dev->lock_rwsem);
+
  	if (rbd_lock_add_request(img_req))
  		return 1;

@@ -3490,6 +3499,12 @@ static void rbd_img_object_requests(struct=20
rbd_img_request *img_req)
  	struct rbd_obj_request *obj_req;

  	rbd_assert(!img_req->pending.result && !img_req->pending.num_pending);
+	/*
+	 * The caller either obtains an exclusive lock or obtains
+	 * rbd_dev->lock_rwsem. Since this cannot be represented accurately
+	 * using lock context annotations, add an __assume_ctx_lock() statement=
.
+	 */
+	__assume_ctx_lock(&rbd_dev->lock_rwsem);
  	rbd_assert(!need_exclusive_lock(img_req) ||
  		   __rbd_is_lock_owner(rbd_dev));

@@ -3533,6 +3548,7 @@ static void rbd_img_object_requests(struct=20
rbd_img_request *img_req)
  }

  static bool rbd_img_advance(struct rbd_img_request *img_req, int *resul=
t)
+	__must_hold(&img_req->state_mutex)
  {
  	int ret;

@@ -3651,6 +3667,7 @@ static struct rbd_client_id rbd_get_cid(struct=20
rbd_device *rbd_dev)
   */
  static void rbd_set_owner_cid(struct rbd_device *rbd_dev,
  			      const struct rbd_client_id *cid)
+	__must_hold(&rbd_dev->lock_rwsem)
  {
  	dout("%s rbd_dev %p %llu-%llu -> %llu-%llu\n", __func__, rbd_dev,
  	     rbd_dev->owner_cid.gid, rbd_dev->owner_cid.handle,
@@ -3666,6 +3683,7 @@ static void format_lock_cookie(struct rbd_device=20
*rbd_dev, char *buf)
  }

  static void __rbd_lock(struct rbd_device *rbd_dev, const char *cookie)
+	__must_hold(&rbd_dev->lock_rwsem)
  {
  	struct rbd_client_id cid =3D rbd_get_cid(rbd_dev);

@@ -3679,6 +3697,7 @@ static void __rbd_lock(struct rbd_device *rbd_dev,=20
const char *cookie)
   * lock_rwsem must be held for write
   */
  static int rbd_lock(struct rbd_device *rbd_dev)
+	__must_hold(&rbd_dev->lock_rwsem)
  {
  	struct ceph_osd_client *osdc =3D &rbd_dev->rbd_client->client->osdc;
  	char cookie[32];
@@ -3702,6 +3721,7 @@ static int rbd_lock(struct rbd_device *rbd_dev)
   * lock_rwsem must be held for write
   */
  static void rbd_unlock(struct rbd_device *rbd_dev)
+	__must_hold(&rbd_dev->lock_rwsem)
  {
  	struct ceph_osd_client *osdc =3D &rbd_dev->rbd_client->client->osdc;
  	int ret;
@@ -3840,6 +3860,7 @@ static int rbd_request_lock(struct rbd_device=20
*rbd_dev)
   * (i.e. "rbd map").
   */
  static void wake_lock_waiters(struct rbd_device *rbd_dev, int result)
+	__must_hold(&rbd_dev->lock_rwsem)
  {
  	struct rbd_img_request *img_req;

@@ -3950,6 +3971,7 @@ static struct ceph_locker=20
*get_lock_owner_info(struct rbd_device *rbd_dev)

  static int find_watcher(struct rbd_device *rbd_dev,
  			const struct ceph_locker *locker)
+	__must_hold(&rbd_dev->lock_rwsem)
  {
  	struct ceph_osd_client *osdc =3D &rbd_dev->rbd_client->client->osdc;
  	struct ceph_watch_item *watchers;
@@ -3999,6 +4021,7 @@ static int find_watcher(struct rbd_device *rbd_dev,
   * lock_rwsem must be held for write
   */
  static int rbd_try_lock(struct rbd_device *rbd_dev)
+	__must_hold(&rbd_dev->lock_rwsem)
  {
  	struct ceph_client *client =3D rbd_dev->rbd_client->client;
  	struct ceph_locker *locker, *refreshed_locker;
@@ -4217,6 +4240,7 @@ static void rbd_pre_release_action(struct=20
rbd_device *rbd_dev)
  }

  static void __rbd_release_lock(struct rbd_device *rbd_dev)
+	__must_hold(&rbd_dev->lock_rwsem)
  {
  	rbd_assert(list_empty(&rbd_dev->running_list));

@@ -4256,6 +4280,7 @@ static void rbd_release_lock_work(struct=20
work_struct *work)
  }

  static void maybe_kick_acquire(struct rbd_device *rbd_dev)
+	__must_hold_shared(&rbd_dev->lock_rwsem)
  {
  	bool have_requests;

@@ -5302,6 +5327,7 @@ static void rbd_spec_free(struct kref *kref)
  }

  static void rbd_dev_free(struct rbd_device *rbd_dev)
+	__context_unsafe(cleanup function that does not need locking)
  {
  	WARN_ON(rbd_dev->watch_state !=3D RBD_WATCH_STATE_UNREGISTERED);
  	WARN_ON(rbd_dev->lock_state !=3D RBD_LOCK_STATE_UNLOCKED);
@@ -5338,6 +5364,7 @@ static void rbd_dev_release(struct device *dev)
  }

  static struct rbd_device *__rbd_dev_create(struct rbd_spec *spec)
+	__context_unsafe(initialization function that does not need locking)
  {
  	struct rbd_device *rbd_dev;


