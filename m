Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A11F03EF
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980749; cv=none; b=RyiwsarBb79L1ZBJy9iou6bk9i3lHxk2kg4g9Uo5cPkiXjHbzHMiMNLSEzfko1ILx38+F6KpwgyT91AFH9iEVLm3LELG6uqdbiAKq0Sxhyp/dm8cw5urYO4FcL7nAm4wLMYd3MfdCPMJM4IbjmGWDyiK24QN8OQ5iYw5FuEVm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980749; c=relaxed/simple;
	bh=jkkcB6ll+qcxHW2AYIBSAKgfMB1n7DIqZsmsZPxBk58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5cV/tqd9mmNgu5vFiUdMot2+rvTVbbObUVV55DWC/Dp57Bf8Ul7vnhC7XPbwNVw1CmpK8i/G9txF2M0XoizDvcvA69l01NYm9asheuqQKpygw1ReC+xFFHDFm+z2I9xuI2dKE0zSq5NbOADOa5JAo8emslIZTEXMA3QDGroexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=TpjLFztq; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="TpjLFztq"
X-Virus-Scanned: Yes
Message-ID: <efe851c6-cb40-4e6f-a382-047b33753ee1@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1770980742; bh=jkkcB6ll+qcxHW2AYIBSAKgfMB1n7DIqZsmsZPxBk58=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=TpjLFztqlAtJ73QvMC1Z2xj7uD4rIEDAmKjAl3dwz4kIk3Y3guuqnsyZ3WGc1jqYS
	 JtzFceQ3tD87gexeLrdIE10nrBSveak8Kr/cVfoi4SJxCHcKN6ATBaLqZzVz4EfkK4
	 EKQDDhcoM0h6z2VaKcl97jsjIOHmKKNV5xhOeEhpXmwsHJcoGZkCqTK4ffa4U8Iis3
	 6/k0mCBLMbliH8o99Cj1UHmlOB/U3jVKT2E0JPEJe20fS/rO5qqXJDZj31CniA1CS+
	 Qv2w11UAw016cTdzQgBsfk68rJ0faNae/npotyYdxbHUfbaKG9Nhopfwo/F/ylAZvt
	 wVw2UkPte32Br+jdyv1cEsHaRtnS9IXU4F4Lg+KuEOc5msIC/H7oO3SUtgZ427TUqA
	 Kc7683tnGblmDA/+YgjLYNMugWGjwBpxFeUYjfkY1zYGaqC591qfQ8sVTqb0vfLjdA
	 /V/idK4J6ouYmA25Y3iL9iNtBE1aA7tBBM0KkzsJnBpmPaE4tOPF8k/akM0FmtrV/v
	 E0Puqagbv/thTHyaW48N/8OXHwUMYm+k1EfZXxO10THD6gg44vNA5EqpsQZ8wJ7HpP
	 YKkCATb9O48UlYBVcHjhMZF38nOYuKeEBPGJ/VPg/ozUwMGlqGU1O5ExtJa7NFhch1
	 zt1pBEqx81FVp3aWQlOXOGsM=
Date: Fri, 13 Feb 2026 13:05:40 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ublk: cleanup flag handling and fix
 UBLK_F_NO_AUTO_PART_SCAN
Content-Language: en-GB
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Yoav Cohen <yoav@nvidia.com>
References: <20260212152553.1737373-1-alex@zazolabs.com>
 <aY6fAlXmzQZCKwmM@fedora>
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <aY6fAlXmzQZCKwmM@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.02.26 5:48, Ming Lei wrote:
> On Thu, Feb 12, 2026 at 03:25:52PM +0000, Alexander Atanasov wrote:
>> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
>> as it tries to use it as a switch for the auto partition scan.
>> When UBLK_F_NO_AUTO_PART_SCAN is not passed a proper
>> auto partition scanning is not done because the first
>> call to ublk_partition_scan_work will clear the bit
>> GD_SUPPRESS_PART_SCAN but not actually load the partitions.
>>
>> How it should work:
>> Unprivileged daemons - never scan partitions, they have
>> GD_SUPPRESS_PART_SCAN always set - they are marked as devices
>> without partitions. While ioctl(BLKRRPART) does require
>> CAP_SYS_ADMIN, block layer have its own a check in
>> disk_has_partscan(...) if partitions are supported.
>>
>> Trusted daemons - auto scan partitions by default
>> and they do not have the bit set, so they do have partitions.
>>
>> For trusted daemons auto partitions scan is performed but it can
>> be skipped if user have set UBLK_F_NO_AUTO_PART_SCAN flag.
>>
>> Rework the code to work as described above:
>> - remove checks in ublk_partition_scan_work and rely on
>> the caller to schedule the work only if it has to be done.
>> - keep GD_SUPPRESS_PART_SCAN always set on unprivileged
>> - keep GD_SUPPRESS_PART_SCAN always clear on trusted
>> - Properly handle user request to skip auto partitioning scanning
>>
>> Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
>> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
>> ---
>>   drivers/block/ublk_drv.c | 14 ++++----------
>>   1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> Cc: Yoav Cohen <yoav@nvidia.com>
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 3c918db4905c..e662c6e8e722 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -2361,14 +2361,9 @@ static void ublk_partition_scan_work(struct work_struct *work)
>>   	if (!disk)
>>   		return;
>>   
>> -	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
>> -					     &disk->state)))
>> -		goto out;
>> -
> 
> It is wrong to remove clearing GD_SUPPRESS_PART_SCAN, otherwise ioctl(BLKRRPART)
> can't succeed.

If you agree with how should it work in the message then it is not a 
problems. GD_SUPPRESS_PART_SCAN is set only on unprivileged - no
partitions on them. Trusted have it always clear - they
schedule the scan and get their partitions automatically.
If user passes the UBLK_F_NO_AUTO_PART_SCAN, then the scan is not 
scheduled and it is up to the user to reread partitions.
This ublk_partition_scan_work is used inside ublk_drv only,
ioctl uses different code path. Double checked and the only
way to reach it is thru ublk_ctrl_add_dev and from ublk_ctrl_uring_cmd.


> 
>>   	mutex_lock(&disk->open_mutex);
>>   	bdev_disk_changed(disk, false);
>>   	mutex_unlock(&disk->open_mutex);
>> -out:
>>   	ublk_put_disk(disk);
>>   }
>>   
>> @@ -4429,12 +4424,11 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>>   
>>   	set_bit(UB_STATE_USED, &ub->state);
>>   
>> -	/* Skip partition scan if disabled by user */
>> -	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
>> +	if (!ub->unprivileged_daemons) {
>> +		/* Enable partition scanning for trusted daemons */
>>   		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>> -	} else {
>> -		/* Schedule async partition scan for trusted daemons */
>> -		if (!ub->unprivileged_daemons)
>> +		/* Skip auto partition scan if requested by user */
>> +		if (!(ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
>>   			schedule_work(&ub->partition_scan_work);
> 
> We may switch to disallow partition scan permanently for UBLK_F_NO_AUTO_PART_SCAN
> per discussion in the following thread:
> 
> https://lore.kernel.org/linux-block/0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk/
> 
> So the change may can be simplified as below, meantime
> selftests/ublk/test_part_01.sh need to be updated.

Ok, tests and docs are next as Jens requested.

> 
> Alexander, please let us know if you'd like work this way?

https://lore.kernel.org/linux-block/c95b3de4-f4f8-4b35-a3e4-a83da98ced0b@zazolabs.com/T/#mbb410ceb3f4c6f23e6c566911dfc833365ce9cdc

in short - having partitions and auto scan are two different features, 
why merge them?

If we want to cover all cases i thing we should go like this:

/* Enable partitions support on device */
#define UBLK_F_PARTITIONS (1ULL << 18)

/* Do not perform automatic partition scanning when device is added */
#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 19)

Added value is to have partitions enabled/disabled explicitly for 
trusted devices. Where by default they will be disabled.

Also may be change from UBLK_F_NO_AUTO_PART_SCAN to 
UBLK_F_AUTO_PART_SCAN - to make it explicit instead and be like
the rest of the flags - all are enable flags

Then these variants become possible:
- unprivileged without partitions (can we add security checks to allow 
partitions for them too?)
- trusted with or without partitions (UBLK_F_PARTITIONS bound to 
GD_SUPPRESS_PART_SCAN)
- If it is a device with partitions then UBLK_F_NO_AUTO_PART_SCAN 
controls if initial auto scan is performed or not.

Having them separate can allow emulation of removable media where data 
is not available at device creation time but is known when available by 
external event so you can load partitions. Two step device bring up, 
i.e. partition scan at device creation time will block you, but you know 
when data is available from an external event, and then you can load 
partitions.

What do you think?

I'be added CC Yoav since i think he requested that feature in first 
place. I beleive Hannes may have a different use case, so let's get some 
more input on this.

> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index a88876756805..d6f479fff75b 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -367,8 +367,8 @@
>    */
>   #define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
> 
> -/* Disable automatic partition scanning when device is started */
> -#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> +/* Disable partition scanning */
> +#define UBLK_F_NO_PART_SCAN    (1ULL << 18)
> 
>   /* device state */
>   #define UBLK_S_DEV_DEAD        0
> [root@ktest-40 linux]# git diff
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c13cda58a7c6..f1a104222fb1 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -81,7 +81,7 @@
>                  | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
>                  | UBLK_F_SAFE_STOP_DEV \
>                  | UBLK_F_BATCH_IO \
> -               | UBLK_F_NO_AUTO_PART_SCAN)
> +               | UBLK_F_NO_PART_SCAN)
> 
>   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                  | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -4438,14 +4438,13 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
> 
>          set_bit(UB_STATE_USED, &ub->state);
> 
> -       /* Skip partition scan if disabled by user */
> -       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> -               clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> -       } else {
> -               /* Schedule async partition scan for trusted daemons */
> -               if (!ub->unprivileged_daemons)
> -                       schedule_work(&ub->partition_scan_work);
> -       }
> +       /*
> +        * Only schedule async partition scan in case of
> +        * !UBLK_F_NO_PART_SCAN and trusted daemons
> +        */
> +       if (!(ub->dev_info.flags & UBLK_F_NO_PART_SCAN) &&
> +                       !ub->unprivileged_daemons)
> +               schedule_work(&ub->partition_scan_work);

a few lines above
set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
is done uncoditionally.

schedule_work(&ub->partition_scan_work); without clearing
the bit first won't load the partitions just clear the bit and return.
This is a bug in the original commit, not a result of any of the 
proposed changes.

-- 
have fun,
alex
