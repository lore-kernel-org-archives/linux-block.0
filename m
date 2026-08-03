Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E138D019
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762364; cv=none; b=BQ6E0cXPMI7zMusTw571iME7OdXbH8sRCcFKBO7pzZOVOdSNgR2cdqtXlLc6f98mtRMGWK0GXU8Phdi2Lqc+zETG6kgU/7Lf5gY+/tiCLvRJYLX1seEqvX6bSwyGrGWgt6rrHQik9cZT8RRX9tjPB0uNNL7DV32lmY3CxxABf/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762364; c=relaxed/simple;
	bh=JoMTjzqcXlwghnGT8ZDyQoNNQZBEpVmPMSbGmOph1IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpWCcHHDSINBGgpzjmTQ2JoAeCpZ7XuXbx9tVKCYPW1UKObNfV2DBN4cZBOB2kGiZgi98Gvt8EwwJ0b01Xl7UyAA77vqclTsJTd8tjMNPwL4Bo4kAmtjKsF7COBjpYeJZet3BoF54mCqW5j8yG3gojooi/tgGe/XzCiwwm+D2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VzHiemps; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VzHiemps"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHlft1943455;
	Mon, 3 Aug 2026 13:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HWyrvH
	QKZsWUjL1riW/7meoDSMofyyhRs/765GHcbT8=; b=VzHiempsf7DKwOacsAUs5l
	JELoFH93DyABfjyjhBOdSl+m4WI2wMImYGCdjyO/D0MrKWCj2CKRTvz1Q+YgVPVv
	3ZICUZZNOQGJLMndvFUno2dQF8xswWuu4/KEQT3aQ/oeRQ+f0jGSL4nQhnCb4qxu
	sNl5AJyFDnk3msnP6ZyuCDAg+tEvwvDpPQ3Mm96+4seSk689tnTnDC93SozoCduw
	kOTKfRjw7BTcA09JwPJrPRPQ2U3WLW5dtn9q3o6A/Ssjsn4UPtHyO6E1ng5CbAaw
	QfkT/g1chOxzWxHPYTClJpisgrm5239MlrNe+dpNm8apKKuLj8hKO1FD6Ni/UpBw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g0pt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:05:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CuF8w031366;
	Mon, 3 Aug 2026 13:05:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jwfb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:05:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673D5f2m23069344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 13:05:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CDDB58053;
	Mon,  3 Aug 2026 13:05:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE18058061;
	Mon,  3 Aug 2026 13:05:38 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 13:05:38 +0000 (GMT)
Message-ID: <f3d93315-c7cc-4200-b6c7-5b75ad02290d@linux.ibm.com>
Date: Mon, 3 Aug 2026 18:35:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] loop: Remove the "bool global" function argument
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Haris Iqbal <haris.iqbal@linux.dev>
References: <cover.1785440858.git.bvanassche@acm.org>
 <d5142cf35b04e88939c4aed2debf6f3716d540ae.1785440858.git.bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d5142cf35b04e88939c4aed2debf6f3716d540ae.1785440858.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfX9JgbtHDg5DVO
 OIxN9HIoDwgzhOBDJVl7SVCGrKa7Px3HehuqHp4g3PRhj8bwPdVgLGPqfQ87u7IMAebv4fFVFJi
 hzyb/rdk7+Vir41Csh4gs30MJbnC/Hw6p7TNFqgaUhN+qPlGYkD/G5QBTdHYuT/LTiaAEYfmabs
 nTeOpwHNGyl+xqIsY2M7MDTTUUHWl3KwehxH229Q+z53NAemRUohsFZ0Tc+5yuHye7LfRKizSGN
 trCH5i5ZOdJJjspPsychyYExLehAcrI6y/CxctqPPSZx9JTt5oq4tXWKTI6ucUKZZ1ENbctk9Pk
 24iusw7oP9z2DXjQk6rEmD+u7z1ei1d2WIt3mhyeyXPpWdr3rGP3ZqWmIJL0N/ejAZeMqSN3BZc
 uKkrzQ6NlhRrk/OpakMrssSiNNl9xe0IZOcIFECnH81u90RECgH3MvRSpJoYn3a6AabAVX/zb7g
 a1BiLT8S0SvfPeVLFCg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a709227 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=N54-gffFAAAA:8
 a=J_QzZ1Z6ujcpH6nbEHwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I8-Su-naEiLrzGQBnkgcLmNu4OUFIqTo
X-Proofpoint-ORIG-GUID: 1GoQ0EA-wkk1J5uP351InuGvKPRrDuhq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfX2VqRk45FLRSu
 gSC6AHm5rR9jJ6Chef73xZvfKwT/YXdpKBNpczpBGQCfz6mfqhl8q1EpyvIRaIhSbxjn65ht1sZ
 Fcu/kZS4Yz4xY+kNov5DeDXTcU81p5I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030115

On 7/31/26 1:28 AM, Bart Van Assche wrote:
> Move the code that is protected by a mutex from loop_change_fd() into
> __loop_change_fd(). Move the code that is protected by a mutex from
> loop_configure() into __loop_configure(). Keep the behavior in
> loop_global_lock_killable() for the global == true case. Expand
> loop_global_lock_killable(lo, false) calls into a mutex_lock_killable()
> and a mutex_unlock() call. This patch prepares for adding lock context
> annotations.
> 
> Cc: Haris Iqbal <haris.iqbal@linux.dev>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/block/loop.c | 249 ++++++++++++++++++++++++-------------------
>   1 file changed, 138 insertions(+), 111 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1faecef33009..a71fe763c933 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -98,25 +98,22 @@ static DEFINE_MUTEX(loop_validate_mutex);
>    * loop_global_lock_killable() - take locks for safe loop_validate_file() test
>    *
>    * @lo: struct loop_device
> - * @global: true if @lo is about to bind another "struct loop_device", false otherwise
>    *
>    * Returns 0 on success, -EINTR otherwise.
>    *
> - * Since loop_validate_file() traverses on other "struct loop_device" if
> - * is_loop_device() is true, we need a global lock for serializing concurrent
> + * Since loop_validate_file() traverses on other "struct loop_device", we need a
> + * global lock for serializing concurrent
>    * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
>    */
> -static int loop_global_lock_killable(struct loop_device *lo, bool global)
> +static int loop_global_lock_killable(struct loop_device *lo)
>   {
>   	int err;
>   
> -	if (global) {
> -		err = mutex_lock_killable(&loop_validate_mutex);
> -		if (err)
> -			return err;
> -	}
> +	err = mutex_lock_killable(&loop_validate_mutex);
> +	if (err)
> +		return err;
>   	err = mutex_lock_killable(&lo->lo_mutex);
> -	if (err && global)
> +	if (err)
>   		mutex_unlock(&loop_validate_mutex);
>   	return err;
>   }
> @@ -125,13 +122,11 @@ static int loop_global_lock_killable(struct loop_device *lo, bool global)
>    * loop_global_unlock() - release locks taken by loop_global_lock_killable()
>    *
>    * @lo: struct loop_device
> - * @global: true if @lo was about to bind another "struct loop_device", false otherwise
>    */
> -static void loop_global_unlock(struct loop_device *lo, bool global)
> +static void loop_global_unlock(struct loop_device *lo)
>   {
>   	mutex_unlock(&lo->lo_mutex);
> -	if (global)
> -		mutex_unlock(&loop_validate_mutex);
> +	mutex_unlock(&loop_validate_mutex);
>   }
>   
>   static int max_part;
> @@ -523,6 +518,50 @@ static int loop_check_backing_file(struct file *file)
>   	return 0;
>   }
>   
> +static int __loop_change_fd(struct loop_device *lo, struct block_device *bdev,
> +			    struct file *file, struct file **old_file,
> +			    bool *partscan)
> +	__must_hold(&lo->lo_mutex)
> +{
> +	unsigned int memflags;
> +	int error;
> +
> +	if (lo->lo_state != Lo_bound)
> +		return -ENXIO;
> +
> +	/* the loop device has to be read-only */
> +	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
> +		return -EINVAL;
> +
> +	error = loop_validate_file(file, bdev);
> +	if (error)
> +		return error;
> +
> +	*old_file = lo->lo_backing_file;
> +
> +	/* size of the new backing store needs to be the same */
> +	if (lo_calculate_size(lo, file) != lo_calculate_size(lo, *old_file))
> +		return -EINVAL;
> +
> +	/*
> +	 * We might switch to direct I/O mode for the loop device, write back
> +	 * all dirty data the page cache now that so that the individual I/O
> +	 * operations don't have to do that.
> +	 */
> +	vfs_fsync(file, 0);
> +
> +	/* and ... switch */
> +	disk_force_media_change(lo->lo_disk);
> +	memflags = blk_mq_freeze_queue(lo->lo_queue);
> +	mapping_set_gfp_mask((*old_file)->f_mapping, lo->old_gfp_mask);
> +	loop_assign_backing_file(lo, file);
> +	loop_update_dio(lo);
> +	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
> +	*partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> +
> +	return 0;
> +}
> +
>   /*
>    * loop_change_fd switched the backing store of a loopback device to
>    * a new file. This is useful for operating system installers to free up
> @@ -536,7 +575,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>   {
>   	struct file *file = fget(arg);
>   	struct file *old_file;
> -	unsigned int memflags;
>   	int error;
>   	bool partscan;
>   	bool is_loop;
> @@ -554,46 +592,21 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>   	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
>   
>   	is_loop = is_loop_device(file);
> -	error = loop_global_lock_killable(lo, is_loop);
> +	if (is_loop) {
> +		error = loop_global_lock_killable(lo);
> +		if (error)
> +			goto out_putf;
> +		error = __loop_change_fd(lo, bdev, file, &old_file, &partscan);
> +		loop_global_unlock(lo);
> +	} else {
> +		error = mutex_lock_killable(&lo->lo_mutex);
> +		if (error)
> +			goto out_putf;
> +		error = __loop_change_fd(lo, bdev, file, &old_file, &partscan);
> +		mutex_unlock(&lo->lo_mutex);
> +	}
>   	if (error)
>   		goto out_putf;
> -	error = -ENXIO;
> -	if (lo->lo_state != Lo_bound)
> -		goto out_err;
> -
> -	/* the loop device has to be read-only */
> -	error = -EINVAL;
> -	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
> -		goto out_err;
> -
> -	error = loop_validate_file(file, bdev);
> -	if (error)
> -		goto out_err;
> -
> -	old_file = lo->lo_backing_file;
> -
> -	error = -EINVAL;
> -
> -	/* size of the new backing store needs to be the same */
> -	if (lo_calculate_size(lo, file) != lo_calculate_size(lo, old_file))
> -		goto out_err;
> -
> -	/*
> -	 * We might switch to direct I/O mode for the loop device, write back
> -	 * all dirty data the page cache now that so that the individual I/O
> -	 * operations don't have to do that.
> -	 */
> -	vfs_fsync(file, 0);
> -
> -	/* and ... switch */
> -	disk_force_media_change(lo->lo_disk);
> -	memflags = blk_mq_freeze_queue(lo->lo_queue);
> -	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
> -	loop_assign_backing_file(lo, file);
> -	loop_update_dio(lo);
> -	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
> -	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> -	loop_global_unlock(lo, is_loop);
>   
>   	/*
>   	 * Flush loop_validate_file() before fput(), for l->lo_backing_file
> @@ -618,8 +631,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>   	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>   	return error;
>   
> -out_err:
> -	loop_global_unlock(lo, is_loop);
>   out_putf:
>   	fput(file);
>   	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> @@ -974,61 +985,29 @@ static void loop_update_limits(struct loop_device *lo, struct queue_limits *lim,
>   		lim->discard_granularity = 0;
>   }
>   
> -static int loop_configure(struct loop_device *lo, blk_mode_t mode,
> -			  struct block_device *bdev,
> -			  const struct loop_config *config)
> +static int __loop_configure(struct loop_device *lo, blk_mode_t mode,
> +			    struct block_device *bdev,
> +			    const struct loop_config *config, struct file *file,
> +			    bool *partscan)
> +	__must_hold(&lo->lo_mutex)
>   {
> -	struct file *file = fget(config->fd);
>   	struct queue_limits lim;
> -	int error;
>   	loff_t size;
> -	bool partscan;
> -	bool is_loop;
> -
> -	if (!file)
> -		return -EBADF;
> -
> -	error = loop_check_backing_file(file);
> -	if (error) {
> -		fput(file);
> -		return error;
> -	}
> -
> -	is_loop = is_loop_device(file);
> -
> -	/* This is safe, since we have a reference from open(). */
> -	__module_get(THIS_MODULE);
> -
> -	/*
> -	 * If we don't hold exclusive handle for the device, upgrade to it
> -	 * here to avoid changing device under exclusive owner.
> -	 */
> -	if (!(mode & BLK_OPEN_EXCL)) {
> -		error = bd_prepare_to_claim(bdev, loop_configure, NULL);
> -		if (error)
> -			goto out_putf;
> -	}
> -
> -	error = loop_global_lock_killable(lo, is_loop);
> -	if (error)
> -		goto out_bdev;
> +	int error;
>   
> -	error = -EBUSY;
>   	if (lo->lo_state != Lo_unbound)
> -		goto out_unlock;
> +		return -EBUSY;
>   
>   	error = loop_validate_file(file, bdev);
>   	if (error)
> -		goto out_unlock;
> +		return error;
>   
> -	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0) {
> -		error = -EINVAL;
> -		goto out_unlock;
> -	}
> +	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0)
> +		return -EINVAL;
>   
>   	error = loop_set_status_from_info(lo, &config->info);
>   	if (error)
> -		goto out_unlock;
> +		return error;
>   	lo->lo_flags = config->info.lo_flags;
>   
>   	if (!(file->f_mode & FMODE_WRITE) || !(mode & BLK_OPEN_WRITE) ||
> @@ -1039,10 +1018,8 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   		lo->workqueue = alloc_workqueue("loop%d",
>   						WQ_UNBOUND | WQ_FREEZABLE,
>   						0, lo->lo_number);
> -		if (!lo->workqueue) {
> -			error = -ENOMEM;
> -			goto out_unlock;
> -		}
> +		if (!lo->workqueue)
> +			return -ENOMEM;
>   	}
>   
>   	/* suppress uevents while reconfiguring the device */
> @@ -1059,7 +1036,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   	/* No need to freeze the queue as the device isn't bound yet. */
>   	error = queue_limits_commit_update(lo->lo_queue, &lim);
>   	if (error)
> -		goto out_unlock;
> +		return error;
>   
>   	/*
>   	 * We might switch to direct I/O mode for the loop device, write back
> @@ -1080,14 +1057,66 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   	WRITE_ONCE(lo->lo_state, Lo_bound);
>   	if (part_shift)
>   		lo->lo_flags |= LO_FLAGS_PARTSCAN;
> -	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> -	if (partscan)
> +	*partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> +	if (*partscan)
>   		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
>   
>   	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
>   	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>   
> -	loop_global_unlock(lo, is_loop);
> +	return 0;
> +}
> +
> +static int loop_configure(struct loop_device *lo, blk_mode_t mode,
> +			  struct block_device *bdev,
> +			  const struct loop_config *config)
> +{
> +	struct file *file = fget(config->fd);
> +	int error;
> +	bool partscan;
> +	bool is_loop;
> +
> +	if (!file)
> +		return -EBADF;
> +
> +	error = loop_check_backing_file(file);
> +	if (error) {
> +		fput(file);
> +		return error;
> +	}
> +
> +	is_loop = is_loop_device(file);
> +
> +	/* This is safe, since we have a reference from open(). */
> +	__module_get(THIS_MODULE);
> +
> +	/*
> +	 * If we don't hold exclusive handle for the device, upgrade to it
> +	 * here to avoid changing device under exclusive owner.
> +	 */
> +	if (!(mode & BLK_OPEN_EXCL)) {
> +		error = bd_prepare_to_claim(bdev, loop_configure, NULL);
> +		if (error)
> +			goto out_putf;
> +	}
> +
> +	if (is_loop) {
> +		error = loop_global_lock_killable(lo);
> +		if (error)
> +			goto out_bdev;
> +		error = __loop_configure(lo, mode, bdev, config, file,
> +					 &partscan);
> +		loop_global_unlock(lo);
> +	} else {
> +		error = mutex_lock_killable(&lo->lo_mutex);
> +		if (error)
> +			goto out_bdev;
> +		error = __loop_configure(lo, mode, bdev, config, file,
> +					 &partscan);
> +		mutex_unlock(&lo->lo_mutex);
> +	}
> +	if (error)
> +		goto out_bdev;
>   	if (partscan)
>   		loop_reread_partitions(lo);
>   
> @@ -1096,8 +1125,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   
>   	return 0;
>   
> -out_unlock:
> -	loop_global_unlock(lo, is_loop);
>   out_bdev:
>   	if (!(mode & BLK_OPEN_EXCL))
>   		bd_abort_claiming(bdev, loop_configure);
> @@ -1194,11 +1221,11 @@ static int loop_clr_fd(struct loop_device *lo)
>   	 * which loop_configure()/loop_change_fd() found via fget() was this
>   	 * loop device.
>   	 */
> -	err = loop_global_lock_killable(lo, true);
> +	err = loop_global_lock_killable(lo);
>   	if (err)
>   		return err;
>   	if (lo->lo_state != Lo_bound) {
> -		loop_global_unlock(lo, true);
> +		loop_global_unlock(lo);
>   		return -ENXIO;
>   	}
>   	/*
> @@ -1210,7 +1237,7 @@ static int loop_clr_fd(struct loop_device *lo)
>   	lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
>   	if (disk_openers(lo->lo_disk) == 1)
>   		WRITE_ONCE(lo->lo_state, Lo_rundown);
> -	loop_global_unlock(lo, true);
> +	loop_global_unlock(lo);
>   
>   	return 0;
>   }

Overall this change looks good to me. But I see, lo->lo_lock
is used to protect lo->lo_backing_file. so shall we annotate
the lo->lo_backing_file using __guarded_by(&lo_lock)?

Thanks,
--Nilay


