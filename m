Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208744DB69
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840505; cv=none; b=BE1nsXNVJuz578UPB1e0DIHe8DXzTomDHF55qt5zYh4GfNiK104DNnYgohAe5cGsXCkOSFGOWn2tEgoJdgpUx/mhpN3ZMjW6jamhBwyyxOeDHY2TqnH/jg9ZZ4aDme5jd5epGt3aCLTtKpddTHTmIO4nhP/oZo11XxpbjH7c4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840505; c=relaxed/simple;
	bh=Ms5XvmYpu8xu4cCzus2T+LX3n6btAtaXEHKgn1q2ay4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZVybNCCujCuqzgmTZC0VHAjIBG7mnt2qVe80t4HmcrPAxtZJweEGGpCO1pX4fR1noUceVL2kYlIlQi8rLgZoq9txrE7A6WIgBYDCoCBw9hTzz+lnhLpOnJxmVMobLgtr32D+P8qvqUe040z/ifUvsBl2bo9purjhNS+emVIYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LQ3vjYRj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LQ3vjYRj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748IGGt235647;
	Tue, 4 Aug 2026 10:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BA27/A
	WrUyIZmebU1Yp8CRO9BXxobNSsZ1CQt1DE4l8=; b=LQ3vjYRj1Hre6C7DxOtSKo
	hxS5l+KKyqLOx8SzPwFRoPDRZQs++JZlPnRchyQkQ3FCuZc7riOrwzgE0yBpLGwf
	zDIrO44VKIG4NIcuyKXglUB90VpsQ1ecES1VB1b+GcpeSJStwKOG8vCaS47w0PIw
	iTfMv/sppsokkCJclat5HVayKpTYoPOFYexn3D5MM1MKL4dDk4wRrsHtFPVpiPP2
	WHzqIJDT6lyfBrtB1P3v6Witp01rLlEWqoldAAz8AhVq6u4B1+ElwR37VqP0DRHG
	udi0Gubri6lrO0KcKgO0C5G6d/o/615O5Xvx+/jejBr9XIa6i+18M0JPMt0+nBjg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hn9ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 10:48:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674AfJmt029979;
	Tue, 4 Aug 2026 10:48:12 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg9buf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 10:48:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674AmCNk24445482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 10:48:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3161A58062;
	Tue,  4 Aug 2026 10:48:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 784C558052;
	Tue,  4 Aug 2026 10:48:09 +0000 (GMT)
Received: from [9.43.105.125] (unknown [9.43.105.125])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 10:48:09 +0000 (GMT)
Message-ID: <4f4a40a4-082c-4b3a-9fec-5b7fa54c6a62@linux.ibm.com>
Date: Tue, 4 Aug 2026 16:18:07 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] rbd: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Ilya Dryomov <idryomov@gmail.com>
References: <cover.1785440858.git.bvanassche@acm.org>
 <0b2988ca05e8a2733352a447e0810104b878376a.1785440858.git.bvanassche@acm.org>
 <487841d2-9d55-4873-ab6b-dbd94aa7bb71@linux.ibm.com>
 <83968777-6f3a-4c21-ac89-fe9ebcbf254d@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <83968777-6f3a-4c21-ac89-fe9ebcbf254d@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfX2aI5vqbsCqwK
 T00Pk+0MS84B6apk6fgpzMH3HiZAEwFAJTPM21tWDqZ9bdzrfXqukH/l4Lz2dmZ6KgPhaJCTOIv
 ctoTqTAC4Gn1bUdwYTPrCljSBZvy5PI=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a71c36d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=-7OqevHddCzZRwe139EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfX3bxnlegspjtQ
 9SQtPuIcZ/qDSLcIxieYaZRACfe6ovx57RTqqGALBxbNgXxozm+4zwwqnO9/qCX9Vv6heXP+CZJ
 TwccUN6qC9ATe/QSuAiCcXuuuwS+5sq625/2kppBKqnSssu6utXD/xzbl4V/ZEzpv1UOac8skvb
 +AEWWFK9TZmfPtY+4RTH2d8J9HbEohonYjZPIBvcVaeHsxBwLqIme6cqBm883v/NRmhkhwwhzg+
 MXnXcNUB6GPVEUnL10KyBIvOwTid7iul4Bp3wjIT8KFPsNgnfgybgK9YlWUIRrrA/L57IaPR8Oo
 f6qFwN0W18pI77am1rLpWt8R38orxs02cFYsQXwS0N2/FlUuKxNXJH2hnBHXH4bmrXfW1Yz0Ekc
 ItIuBJYJH6uYgwuobOFOc5IqoBNhKKBBENEtXw3z3ZP1e0MvphWqVxmXz3CFwXBzvCLLoykjflc
 K1oT9ZLhGnhOL7D2WLQ==
X-Proofpoint-ORIG-GUID: uSt1xfCRDo10mZXU1i5kDKh9iDin1qqC
X-Proofpoint-GUID: Z4UJMcqSv3ISFidGJWImOQvK9t-wAgDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040085

On 8/4/26 1:16 AM, Bart Van Assche wrote:
> On 8/3/26 7:03 AM, Nilay Shroff wrote:
>> In addition to the above annotations, it looks like several variables and structure members
>> are consistently protected by specific locks:
>>
>> 1. rbd_dev_list is guarded by rbd_dev_list_lock.
>> 2. rbd_client_list is guarded by rbd_client_list_lock.
>> 3. rbd_device::acquiring_list and rbd_device::running_list are guarded by
>>     rbd_device::lock_lists_lock.
>> 4. rbd_device::object_map is guarded by rbd_device::object_map_lock.
>> 5. rbd_device::watch_cookie, rbd_device::watch_state, and rbd_device::watch_handle
>>     are guarded by rbd_device::watch_mutex.
>> 6. rbd_device::lock_state and rbd_device::lock_cookie are guarded by rbd_device::lock_rwsem.
>>
>> So I think we should add the corresponding `__guarded_by(...)` annotations for these
>> fields as part of enabling lock context analysis for this driver.
> 
> Hi Nilay,
> 
> Thank you for having looked this up. I took a closer look at the rbd
> driver and came up with the patch below. Some observations:
> - Some code obtains pointers to acquiring_list, running_list and
>    object_map before the corresponding synchronization objects are
>    acquired. Hence, I have not tried to annotate these struct members
>    with __guarded_by().
> - The locking convention followed by rbd_img_object_requests() is not
>    a good fit for what Clang supports.
> 
> Further feedback is welcome.
> 
> Thanks,
> 
> Bart.
> 
> These are the changes I came up with (relative to the above patch):
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f0f7a94e3e3e..4c9f566b7a91 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -406,26 +406,26 @@ struct rbd_device {
>       struct mutex        watch_mutex;
>       enum rbd_watch_state    watch_state;
>       struct ceph_osd_linger_request *watch_handle;
> -    u64            watch_cookie;
> +    u64            watch_cookie __guarded_by(&watch_mutex);
>       struct delayed_work    watch_dwork;
> 
>       struct rw_semaphore    lock_rwsem;
> -    enum rbd_lock_state    lock_state;
> -    char            lock_cookie[32];
> +    enum rbd_lock_state    lock_state __guarded_by(&lock_rwsem);
> +    char            lock_cookie[32] __guarded_by(&lock_rwsem);
>       struct rbd_client_id    owner_cid;
>       struct work_struct    acquired_lock_work;
>       struct work_struct    released_lock_work;
>       struct delayed_work    lock_dwork;
>       struct work_struct    unlock_work;
>       spinlock_t        lock_lists_lock;
> -    struct list_head    acquiring_list;
> -    struct list_head    running_list;
> +    struct list_head    acquiring_list; /* __guarded_by(&lock) */
> +    struct list_head    running_list; /* __guarded_by(&lock) */
>       struct completion    acquire_wait;
>       int            acquire_err;
>       struct completion    quiescing_wait;
> 
>       spinlock_t        object_map_lock;
> -    u8            *object_map;
> +    u8            *object_map; /*__guarded_by(&object_map_lock)*/
>       u64            object_map_size;    /* in objects */
>       u64            object_map_flags;
> 
> @@ -464,11 +464,13 @@ enum rbd_dev_flags {
> 
>   static DEFINE_MUTEX(client_mutex);    /* Serialize client creation */
> 
> -static LIST_HEAD(rbd_dev_list);    /* devices */
> +/* devices */
>   static DEFINE_SPINLOCK(rbd_dev_list_lock);
> +static __guarded_by(&rbd_dev_list_lock) LIST_HEAD(rbd_dev_list);
> 
> -static LIST_HEAD(rbd_client_list);        /* clients */
> +/* clients */
>   static DEFINE_SPINLOCK(rbd_client_list_lock);
> +static __guarded_by(&rbd_client_list_lock) LIST_HEAD(rbd_client_list);
> 
>   /* Slab caches for frequently-allocated structures */
> 
> @@ -521,6 +523,7 @@ static bool rbd_is_snap(struct rbd_device *rbd_dev)
>   }
> 
>   static bool __rbd_is_lock_owner(struct rbd_device *rbd_dev)
> +    __must_hold_shared(&rbd_dev->lock_rwsem)
>   {
>       lockdep_assert_held(&rbd_dev->lock_rwsem);
> 
> @@ -1645,6 +1648,7 @@ static void __rbd_object_map_index(struct rbd_device *rbd_dev, u64 objno,
>   }
> 
>   static u8 __rbd_object_map_get(struct rbd_device *rbd_dev, u64 objno)
> +    __must_hold(&rbd_dev->object_map_lock)
>   {
>       u64 index;
>       u8 shift;
> @@ -1655,6 +1659,7 @@ static u8 __rbd_object_map_get(struct rbd_device *rbd_dev, u64 objno)
>   }
> 
>   static void __rbd_object_map_set(struct rbd_device *rbd_dev, u64 objno, u8 val)
> +    __must_hold(&rbd_dev->object_map_lock)
>   {
>       u64 index;
>       u8 shift;
> @@ -3431,6 +3436,7 @@ static bool need_exclusive_lock(struct rbd_img_request *img_req)
>   }
> 
>   static bool rbd_lock_add_request(struct rbd_img_request *img_req)
> +    __must_hold_shared(&img_req->rbd_dev->lock_rwsem)
>   {
>       struct rbd_device *rbd_dev = img_req->rbd_dev;
>       bool locked;
> @@ -3448,6 +3454,7 @@ static bool rbd_lock_add_request(struct rbd_img_request *img_req)
>   }
> 
>   static void rbd_lock_del_request(struct rbd_img_request *img_req)
> +    __must_hold_shared(&img_req->rbd_dev->lock_rwsem)
>   {
>       struct rbd_device *rbd_dev = img_req->rbd_dev;
>       bool need_wakeup = false;
> @@ -3472,6 +3479,8 @@ static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
>       if (!need_exclusive_lock(img_req))
>           return 1;
> 
> +    __assume_ctx_lock(&img_req->rbd_dev->lock_rwsem);
> +
>       if (rbd_lock_add_request(img_req))
>           return 1;
> 
> @@ -3490,6 +3499,12 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
>       struct rbd_obj_request *obj_req;
> 
>       rbd_assert(!img_req->pending.result && !img_req->pending.num_pending);
> +    /*
> +     * The caller either obtains an exclusive lock or obtains
> +     * rbd_dev->lock_rwsem. Since this cannot be represented accurately
> +     * using lock context annotations, add an __assume_ctx_lock() statement.
> +     */
> +    __assume_ctx_lock(&rbd_dev->lock_rwsem);
>       rbd_assert(!need_exclusive_lock(img_req) ||
>              __rbd_is_lock_owner(rbd_dev));
> 
> @@ -3533,6 +3548,7 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
>   }
> 
>   static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
> +    __must_hold(&img_req->state_mutex)
>   {
>       int ret;
> 
> @@ -3651,6 +3667,7 @@ static struct rbd_client_id rbd_get_cid(struct rbd_device *rbd_dev)
>    */
>   static void rbd_set_owner_cid(struct rbd_device *rbd_dev,
>                     const struct rbd_client_id *cid)
> +    __must_hold(&rbd_dev->lock_rwsem)
>   {
>       dout("%s rbd_dev %p %llu-%llu -> %llu-%llu\n", __func__, rbd_dev,
>            rbd_dev->owner_cid.gid, rbd_dev->owner_cid.handle,
> @@ -3666,6 +3683,7 @@ static void format_lock_cookie(struct rbd_device *rbd_dev, char *buf)
>   }
> 
>   static void __rbd_lock(struct rbd_device *rbd_dev, const char *cookie)
> +    __must_hold(&rbd_dev->lock_rwsem)
>   {
>       struct rbd_client_id cid = rbd_get_cid(rbd_dev);
> 
> @@ -3679,6 +3697,7 @@ static void __rbd_lock(struct rbd_device *rbd_dev, const char *cookie)
>    * lock_rwsem must be held for write
>    */
>   static int rbd_lock(struct rbd_device *rbd_dev)
> +    __must_hold(&rbd_dev->lock_rwsem)
>   {
>       struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>       char cookie[32];
> @@ -3702,6 +3721,7 @@ static int rbd_lock(struct rbd_device *rbd_dev)
>    * lock_rwsem must be held for write
>    */
>   static void rbd_unlock(struct rbd_device *rbd_dev)
> +    __must_hold(&rbd_dev->lock_rwsem)
>   {
>       struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>       int ret;
> @@ -3840,6 +3860,7 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
>    * (i.e. "rbd map").
>    */
>   static void wake_lock_waiters(struct rbd_device *rbd_dev, int result)
> +    __must_hold(&rbd_dev->lock_rwsem)
>   {
>       struct rbd_img_request *img_req;
> 
> @@ -3950,6 +3971,7 @@ static struct ceph_locker *get_lock_owner_info(struct rbd_device *rbd_dev)
> 
>   static int find_watcher(struct rbd_device *rbd_dev,
>               const struct ceph_locker *locker)
> +    __must_hold(&rbd_dev->lock_rwsem)
>   {
>       struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>       struct ceph_watch_item *watchers;
> @@ -3999,6 +4021,7 @@ static int find_watcher(struct rbd_device *rbd_dev,
>    * lock_rwsem must be held for write
>    */
>   static int rbd_try_lock(struct rbd_device *rbd_dev)
> +    __must_hold(&rbd_dev->lock_rwsem)
>   {
>       struct ceph_client *client = rbd_dev->rbd_client->client;
>       struct ceph_locker *locker, *refreshed_locker;
> @@ -4217,6 +4240,7 @@ static void rbd_pre_release_action(struct rbd_device *rbd_dev)
>   }
> 
>   static void __rbd_release_lock(struct rbd_device *rbd_dev)
> +    __must_hold(&rbd_dev->lock_rwsem)
>   {
>       rbd_assert(list_empty(&rbd_dev->running_list));
> 
> @@ -4256,6 +4280,7 @@ static void rbd_release_lock_work(struct work_struct *work)
>   }
> 
>   static void maybe_kick_acquire(struct rbd_device *rbd_dev)
> +    __must_hold_shared(&rbd_dev->lock_rwsem)
>   {
>       bool have_requests;
> 
> @@ -5302,6 +5327,7 @@ static void rbd_spec_free(struct kref *kref)
>   }
> 
>   static void rbd_dev_free(struct rbd_device *rbd_dev)
> +    __context_unsafe(cleanup function that does not need locking)
>   {
>       WARN_ON(rbd_dev->watch_state != RBD_WATCH_STATE_UNREGISTERED);
>       WARN_ON(rbd_dev->lock_state != RBD_LOCK_STATE_UNLOCKED);
> @@ -5338,6 +5364,7 @@ static void rbd_dev_release(struct device *dev)
>   }
> 
>   static struct rbd_device *__rbd_dev_create(struct rbd_spec *spec)
> +    __context_unsafe(initialization function that does not need locking)
>   {
>       struct rbd_device *rbd_dev;
> 
> 
The above change look good.

However, I still think acquiring_list, running_list, and object_map should
ideally be guarded by their respective locks. The fact that some code obtains
pointers to these objects before acquiring the corresponding lock makes the
locking pattern worth looking at more closely rather than simply leaving
these fields unannotated.

Could you perhaps Cc the RBD maintainers and mailing list on the next revision
and ask for their feedback on these locking patterns? They may be able to clarify
whether obtaining these pointers outside the lock is intentional and safe, or
whether there are existing races that have gone unnoticed.

Thanks,
--Nilay

