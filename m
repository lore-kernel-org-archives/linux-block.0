Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178EF41D115
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765854; cv=none; b=K2kGA+k3qOhmTix8XVQleR31P8OmWs4vJQz5gDhe63Xet7yx+6BT2cbmKXowvmrzNBy0DwBQwB75+pv/HOTpIxNVGWvxxe8lp/xrjpQXSUeYNaC4R62J3weHXsmP+ZvtUDe5EWyvCI/U9ShxAeAx95nEc+T/jeUMel7c45VD8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765854; c=relaxed/simple;
	bh=nNYC5KM72YVEFE+lpHAVh4AFELq3+jSnilbdzDkfq88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uncG4+oFElvBDHVg/siUuoIkCjRcXbx3/VxT9JOC6vGf+v+1vmXNQkPP0w/pMj0bIcmrj7WM14pX1LZog6G6xlwlGJ1HtuO5gdQzo7sCaD63jx26ghinWdsSY4WPxDfr9r8SJgF6z8B2byYbtg+YZGw7gpQrX/zBtM9CRuV1HKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TlGgxUY+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TlGgxUY+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673DlXBv2194452;
	Mon, 3 Aug 2026 14:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aBAHCp
	Ij+61JX3tA+zyQltdXSddwKSA6ej+tkff6Td4=; b=TlGgxUY++t/cG+eGihxlkq
	kC3L9U12/aH66G1aRfcq/4H3hgQxsPbzaQkQ2VJmE6Wx2TBnlC3qFGX3pREp16lQ
	ze8m9pkvf4C/rrBcWQescunSB4wQmLw2vSg2a1V8lWwBdVrB7LQ+i4KwkotA5/Bn
	iz9fBJ18qZ6VmEMMKny4iJsOCb5szxMZeo6Ngf4gxgV5OeQCUd+fyWasUXpsQfQY
	ODPQmt/STfW2NiGIN5i58+Dxe7trvNEdRznpcdA8WmUYHEMKdUiTq4rjhr54YzYQ
	uLFGY4Cv9XT4XXJ/G40/QZqVzohTWsT/ynq08A3xib+vzeeK7rxASc71HsQIG7iQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3s5kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:04:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673DuQx5014588;
	Mon, 3 Aug 2026 14:04:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvwrwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:04:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673E40IV56951114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 14:04:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B8A458060;
	Mon,  3 Aug 2026 14:04:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30DED5805E;
	Mon,  3 Aug 2026 14:03:58 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 14:03:57 +0000 (GMT)
Message-ID: <487841d2-9d55-4873-ab6b-dbd94aa7bb71@linux.ibm.com>
Date: Mon, 3 Aug 2026 19:33:56 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <0b2988ca05e8a2733352a447e0810104b878376a.1785440858.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a709fd3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=N54-gffFAAAA:8
 a=xsKirhuivIg9WSYEcFQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: W-0o4yoBVAwpdjyt7XrQObMwZf5yx6FE
X-Proofpoint-GUID: Y2XyQdstdFRkE_OVW63kyhgX2man1hvI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEyNCBTYWx0ZWRfXxyVTypaqeuky
 rz3FnQqOWCMPjqxAUII2uIooQKfkm4UmamVuc8gXHnoo3U72QZN5eemCKmMUZr9rPzYJM/VSEZY
 oDljrXEQxuiiWT0Uw4nSkiFb5VVN8Qk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEyNCBTYWx0ZWRfX0tU9mB3ChHu8
 P8xR0tRVD+Q1A1DgKvjoz2UUADPZkr2JJVNe+9ux5lF/E3Be1XGux/ab9GjaeOSGY3nSvFtiuZh
 TMQ3YeWYGsvev1zblyfwlHN7W69k7HL1T2moA6dr7d3jrTVm9H4lZ1o1R6+P5Euqlzm6Su7zDY0
 IrfW98mmVOYoJKB+jslxSriuUASBp1YOZK7lLrDTJkJFpyShTuRnkz/O4ylyVyKa93ujJq/Af+2
 sJm+YloS58IcUtiaZOQjBKUMyNEH9PV7s1qsbkSbnseDKRZKB22G1021w5J1wyJQE1Kk4tpVs6r
 JvHsdejBliFOxevLzypM0yVs9n7qkFuA8T2zzDJLAWom3dRrROQa08Um5PjC5VQqGPVFzWI62cC
 svZIoB54fntalALLjVGA1r7UPCnCzdEr6NU5K/CH5Nom6MZlSHdTFP4nACUNiwL4uNM0U8UoUmG
 bwon3nqEta2FO5zqplA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030124

On 7/31/26 1:28 AM, Bart Van Assche wrote:
> Add lock context annotations.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/block/rbd.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 1f1c2810f6ee..f0f7a94e3e3e 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4183,6 +4183,7 @@ static void rbd_acquire_lock(struct work_struct *work)
>   }
>   
>   static bool rbd_quiesce_lock(struct rbd_device *rbd_dev)
> +	__must_hold(&rbd_dev->lock_rwsem)
>   {
>   	dout("%s rbd_dev %p\n", __func__, rbd_dev);
>   	lockdep_assert_held_write(&rbd_dev->lock_rwsem);
> @@ -4227,6 +4228,7 @@ static void __rbd_release_lock(struct rbd_device *rbd_dev)
>    * lock_rwsem must be held for write
>    */
>   static void rbd_release_lock(struct rbd_device *rbd_dev)
> +	__must_hold(&rbd_dev->lock_rwsem)
>   {
>   	if (!rbd_quiesce_lock(rbd_dev))
>   		return;
> @@ -4583,6 +4585,7 @@ static void rbd_unregister_watch(struct rbd_device *rbd_dev)
>    * lock_rwsem must be held for write
>    */
>   static void rbd_reacquire_lock(struct rbd_device *rbd_dev)
> +	__must_hold(&rbd_dev->lock_rwsem)
>   {
>   	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>   	char cookie[32];
> @@ -6780,6 +6783,7 @@ static void rbd_dev_device_release(struct rbd_device *rbd_dev)
>    * upon return.
>    */
>   static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
> +	__releases(&rbd_dev->header_rwsem)
>   {
>   	int ret;
>   
> @@ -6881,6 +6885,7 @@ static void rbd_dev_image_release(struct rbd_device *rbd_dev)
>    * with @depth == 0.
>    */
>   static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
> +	__context_unsafe(conditional locking on @depth)
>   {
>   	bool need_watch = !rbd_is_ro(rbd_dev);
>   	int ret;
> @@ -7134,6 +7139,9 @@ static ssize_t do_rbd_add(const char *buf, size_t count)
>   	if (rc < 0)
>   		goto err_out_rbd_dev;
>   
> +	/* Acquired by rbd_dev_image_probe(rbd_dev, 0) */
> +	__acquire(&rbd_dev->header_rwsem);
> +
>   	if (rbd_dev->opts->alloc_size > rbd_dev->layout.object_size) {
>   		rbd_warn(rbd_dev, "alloc_size adjusted to %u",
>   			 rbd_dev->layout.object_size);


In addition to the above annotations, it looks like several variables and structure members
are consistently protected by specific locks:

1. rbd_dev_list is guarded by rbd_dev_list_lock.
2. rbd_client_list is guarded by rbd_client_list_lock.
3. rbd_device::acquiring_list and rbd_device::running_list are guarded by
    rbd_device::lock_lists_lock.
4. rbd_device::object_map is guarded by rbd_device::object_map_lock.
5. rbd_device::watch_cookie, rbd_device::watch_state, and rbd_device::watch_handle
    are guarded by rbd_device::watch_mutex.
6. rbd_device::lock_state and rbd_device::lock_cookie are guarded by rbd_device::lock_rwsem.

So I think we should add the corresponding `__guarded_by(...)` annotations for these
fields as part of enabling lock context analysis for this driver.

Thanks,
--Nilay

