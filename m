Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA481B86D5;
	Tue, 14 Jan 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871724; cv=none; b=PnQ6n9gVRlkY8j/5OChHp40XQxGuktbcYfoaiJiJoZH5Yt7BgmFU0HDB3X594nGaVPhvwtpgKT2l/kXbGU2OAiRyDiJAY/s34ynOg9x1bo6z7ez/ztb2KacjMDwcWy0YYjQ6GrUIqGQjZwWWiZSo6be550DaIl+D9abaBb62zAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871724; c=relaxed/simple;
	bh=e91kkEsCfmD9u2P8yNl+aEZpdWkMWWGuPvt5LUw+rYQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gJd1YeUMf0fN4qqYCpUm3zeogB85wloaTd4yWxbWBbG5z7t+kK0/OANhSYydYeGbFoiP9VKYYuwBrC7dZ32uxX55BoWPBND9Gt53BIL95vOeUq6NU5kYAW/6CfhvQiywBZnlXOAk5Gufc6g/TbqxJM1wQstDyc8ekgNjkEb10+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=knhKKdSY; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="knhKKdSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736871717; bh=U5IVvXsTRNrBweuVm0gvYG0dVIHQyKG/FVlvjTIYgWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=knhKKdSYiyh7RSSuiJ4iO8KDYl+V/rSl4R4pNiLNQVljzyB6FYJhUlUc2E9+mOH2q
	 WCB64Y2CmtRKzxtXck8gLSZKJYTwvzMPimIoeDoutiCwEkaIvOVXy6eoDCLU64QMzD
	 6XoywPaASPzaJMCCrUJehy74COVbbf/sFBwcjHno=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 576A3EB0; Wed, 15 Jan 2025 00:21:54 +0800
X-QQ-mid: xmsmtpt1736871714tbeyior5q
Message-ID: <tencent_67C442B763577226C3F37EE367896923AA05@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1XnQNvfFBCm0zC/oDq5Aoc2XwTZNZ3OdjOlikO3IKmoMPryOCXoYD
	 AWu8thpyzmVRPjHXV0u9UdEKIN87X8S9d9tZ/jiYD5KnLYhBB7YKbNukdC2cdGEo3ai+t7phwzTN
	 A151AwlGx9O0FCKwPmMLRP63YzzvX4zn2rc6K/K4A/N5wzmMhWzMW2UDNQ15qwhjo6q+RH9OEaFN
	 tuVmvCEXwF2y5B2WawAZNcnHmuaVmVLoOTOK3phmRne+IhpWXfY9c1hi6QUAa7wCWkZbcmxL4gfB
	 gGxX4l/YApkSnwOVubJQ2xk4ruePIrdh2Mu8fyTy7KweA3YRYh+wXxS1Ys4hbXp52VOifK4Cf+M8
	 usqHO5+q4mdnzyTV13JKEisGFXHW37qqTv7L2VoIDdNVCHymz8gv2M/a0nCa4lT88DFOPOMRRgKw
	 Awp6+bJMpcZE9ENzKUe3Nq/Cm5mbVVys2swIJce6B/SKrWf+GrQJPyOpBXBWCZQKWr8bHUe+zJqD
	 HEjXFW8LWLYyt7SdOf/TC/rLX7xMV/mvBaQxbiglQSINEMTWjmS/OS8NJY6YSnAsQL6KEbcL8sms
	 /PCq2punjhjDDHmC/a4h4J1wifLr8mEku9T4B0U5wXLRDWXvt3vXh0HHIF3mm6fe4LAr8Z7vb+l8
	 leKLRvdn7uD1iohhbmwKsLfhYq+EIqI+x4qhyx1icatpC+HZkPiyXQx71f8F0e+WZT8HeH9qeZ66
	 iCraq/EDiRrUhYSfO1/RDVhxXBCFgjL2keJO0bG4e2gkgsaej+2JquXlkmnn3in4Ud41HOkRx6If
	 tAlaTXEOeFqT32CpsVTkSc34oKrEm+RwWGQNmK8e2L0vQh1Z/5i8qaj9pbP3aseptvIFuVXbg6e7
	 bEc7BSryuVGeLd7HVyvgzVAn84cjI92HfCQEVaMsT+uHk7Mer9TjqNUxIXuk5K+d7NDOpA64+FpQ
	 9j0/qtJZXkvtCnkj3Mdoun1Dar1jOH
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: axboe@kernel.dk
Cc: eadavis@qq.com,
	hare@suse.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] block: no show partitions if partno corrupted
Date: Wed, 15 Jan 2025 00:21:55 +0800
X-OQ-MSGID: <20250114162154.3027662-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2df5c0d7-cf9e-49ce-a39a-4e3d50c6df0c@kernel.dk>
References: <2df5c0d7-cf9e-49ce-a39a-4e3d50c6df0c@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Jan 2025 08:25:13 -0700, Jens Axboe wrote:
>> On Tue, 14 Jan 2025 08:02:15 -0700, Jens Axboe wrote:
>>>> diff --git a/block/genhd.c b/block/genhd.c
>>>> index 9130e163e191..3a9c36ad6bbd 100644
>>>> --- a/block/genhd.c
>>>> +++ b/block/genhd.c
>>>> @@ -890,6 +890,9 @@ static int show_partition(struct seq_file *seqf, void *v)
>>>>
>>>>  	rcu_read_lock();
>>>>  	xa_for_each(&sgp->part_tbl, idx, part) {
>>>> +		int partno = bdev_partno(part);
>>>> +
>>>> +		WARN_ON_ONCE(partno >= DISK_MAX_PARTS);
>>>>  		if (!bdev_nr_sectors(part))
>>>>  			continue;
>>>>  		seq_printf(seqf, "%4d  %7d %10llu %pg\n",
>>>
>>> Surely you still want to continue for that condition?
>> No.
>
>No?
>
>> But like following, ok?
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 9130e163e191..142b13620f0c 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -890,7 +890,10 @@ static int show_partition(struct seq_file *seqf, void *v)
>>
>>         rcu_read_lock();
>>         xa_for_each(&sgp->part_tbl, idx, part) {
>> -               if (!bdev_nr_sectors(part))
>> +               int partno = bdev_partno(part);
>> +
>> +               WARN_ON_ONCE(partno >= DISK_MAX_PARTS);
>> +               if (!bdev_nr_sectors(part) || partno >= DISK_MAX_PARTS)
>>                         continue;
>>                 seq_printf(seqf, "%4d  %7d %10llu %pg\n",
>>                            MAJOR(part->bd_dev), MINOR(part->bd_dev),
>
>That's just silly...
I checked WARN_ON_ONCE(), and when the condition is met, the subsequent
WARN_ON_ONCE() will still return true, so adding it will not affect the
judgment of the condition.
It just issues a warning the first time the condition is met, and it will
still return true if the condition is true.
>
>	xa_for_each(&sgp->part_tbl, idx, part) {
>		int partno = bdev_partno(part);
>
>		if (!bdev_nr_sectors(part))
>			continue;
>		if (WARN_ON_ONCE(partno >= DISK_MAX_PARTS))
>			continue;
>
>		...
>	}

Edward

