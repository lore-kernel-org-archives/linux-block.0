Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F324A13D884
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715602; cv=none; b=alyf6C0/QlDUgDl+qF5gh5OKURz6he+m3naMgh3urMLmHVPRC1TqmTtkss51mJtWFvf1znO5NTBUT5+UfM/1ur0hHKbys0zhhTQG74XRPZSGKhgR96Mj5G4cGJaaXJlvefZUKEaeEg96qFsm5MeRStrtgYWdDo4IzSInL/57i4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715602; c=relaxed/simple;
	bh=EOtoTvWvly0gj88wYnE4Shufh5oDMSqXi4juL59GtTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mua04pptJG68O2CcsUY+8xhUUKefUgPstXn+ZSbUXIfg4avRGnQ7HmkpR1R/4QZff78prwctbIp/b4JAbgUESLakREhsob/v/vAxnO6m6d0fSueIxN3Uo/hbCI7tFCzPB41v32pTQ6Jn7loAJMTQeJuCAJ2KUMaxwB/htF2kOU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWpGOZG7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWpGOZG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBC1C2BD10;
	Thu,  6 Jun 2024 23:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717715601;
	bh=EOtoTvWvly0gj88wYnE4Shufh5oDMSqXi4juL59GtTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NWpGOZG7yfs/pok/be0L9v2NGnhakEkWUrBxDnNodQ52fDbxbLe9pjAdtwhT0yM6+
	 pOFNqpU96gII5CbXnLw+aPJUUfFDIsHNJWxGJNdmwtrCM+hh4gIGKsWlS40/iqUBjd
	 I06lVyxz8iBnIwDQq2iwt6s7zD5tx+ACcWv1fo3pxp5h7hd3KPyXSMXQ0bldP4UrPd
	 uTG/FPcc4LjxP17yWGTdKRVGzdltDPkTbObMDA/Af+Ub00vMO+h3wfSl0Mn3IVQdFl
	 76PZNrN/7b0oa0v77od37zDFScEEC0kwBcNT6KfCMXRXub3gqATkKdKfvK2StX+NKc
	 KDjhGgxyvLSWg==
Message-ID: <57ad537d-de62-435f-82db-469e98c056f5@kernel.org>
Date: Fri, 7 Jun 2024 08:13:18 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: disk removal slowdown due to rcu_barrier
To: Mikulas Patocka <mpatocka@redhat.com>,
 Zdenek Kabelac <zkabelac@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Hans Holmberg <hans.holmberg@wdc.com>,
 Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <b3c96411-dea-16ed-85fc-a33f842594@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <b3c96411-dea-16ed-85fc-a33f842594@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/24 21:49, Mikulas Patocka wrote:
> Hi
> 
> The patch dd291d77cc90eb6a86e9860ba8e6e38eebd57d12 (block: Introduce zone 
> write plugging) causes a performance regression when removing block 
> devices.
> 
> The kernel 6.9 removes a DM block device in 73ms. The kernel 6.10-rc in 
> 103ms.
> 
> That patch adds a rcu_barrier() call to the disk-removal code path and it 
> causes the slowdown. We get this stacktrace when we attempt to remove 
> large amount of DM devices. Note that the removed devices aren't zoned at 
> all.

OK. Let me send a fix patch to avoid the barrier for non-zoned devices. For
zoned devices, it can only be avoided if the device does not need zone write
plugging, which is the case for most zoned DM setup.

> 
> [<0>] rcu_barrier+0x208/0x320
> [<0>] disk_free_zone_resources+0x102/0x160
> [<0>] disk_release+0x72/0xe0
> [<0>] device_release+0x34/0x90
> [<0>] kobject_put+0x8b/0x1d0
> [<0>] cleanup_mapped_device+0xd8/0x160
> [<0>] __dm_destroy+0x12a/0x1d0
> [<0>] dm_hash_remove_all+0x77/0x1a0
> [<0>] remove_all+0x23/0x40
> [<0>] ctl_ioctl+0x1dc/0x530
> [<0>] dm_ctl_ioctl+0xe/0x20
> [<0>] __x64_sys_ioctl+0x94/0xd0
> [<0>] do_syscall_64+0x82/0x160
> [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Mikulas
> 

-- 
Damien Le Moal
Western Digital Research

