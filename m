Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9F42086C;
	Tue,  7 Jul 2026 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783397236; cv=none; b=XwGWT5Jaoq8mvXSW60RI8Td7/F1oTFv6U+Q4OiUVMo7vgpzI2g0IfSITvqJ04nJY9KS1ORO9YCVqv90QkiNcnA+aFWFfncWzqJBeeuFtUZJ9iy5A1TmCzK5IEn+D5tTWFbIlbvw52v43Kf9Im+cMfgenZltwPWzCMawO/MSPYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783397236; c=relaxed/simple;
	bh=nDV/QOf+jUMZ+Xh8dWILgp9bNpzAoRTss4rgh9/EUt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2BqnjZrVazbcln9XuGqRADd+SCwXZguUVnr1xN9pJey5xGvaprykoQns8IUgYV63CL7U4dbyLGWP+VehyCKxX/noIsCtIyiAnAcSSBClGfIcVmkGOz1GLTvOVcLyya+92KwzZFZJY/3+YvGJ1kq1jVeY2ZT8taya7OrK/HU1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmWhBLFy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmWhBLFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912911F000E9;
	Tue,  7 Jul 2026 04:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783397235;
	bh=45zsZgjr6TPI2Bu1I+9PVJD2os2EhYfvhzKyRZi3oxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UmWhBLFyOfx6P8Wc8Nb79p+rrIImSPdOVyXkblYl2c6HX59uByHiyIY822w5HWHTq
	 GL3CDdBaYEwJccN+QChbMwocU5gNCXG8irzEqz5qkAtUkpdbL6vozLE6GtnfMMRa+h
	 w6cHt+ghd19EHIFokxGqC2JRbbhNgpHsjeofOCKTOG2byIb661awYHQ5daq9CpCCfO
	 AcaB6FHVElPjYKIF4Ro4v65FR6/oUAoHT09EGihgcsvY1dh3s3UrhRs5121pPjQNEA
	 Apn5dFDJVbGZAl9AfWZOxonqsTGUlRff67AtLNbEC6QTfznWBfOqrKxcXdQ1sKM9Q7
	 Tn3yPJGlvlzVw==
Message-ID: <f448bfcf-207d-4550-b268-efa5a51a6603@kernel.org>
Date: Tue, 7 Jul 2026 13:07:11 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/6] null_blk: use DEFINE_MUTEX for the file-scope
 mutex
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 linux-block@vger.kernel.org, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-2-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260707025542.1299859-2-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 11:55, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> In null_init(), mutex_init(&lock) currently happens after
> configfs_register_subsystem(), which exposes the nullb subsystem to
> userspace. A racing mkdir() into /sys/kernel/config/nullb/ can reach
> null_find_dev_by_name() -> mutex_lock(&lock) before the mutex is
> initialized, trigger warning:
> 
> [  123.137788] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> [  123.137796] WARNING: kernel/locking/mutex.c:159 at mutex_lock+0x171/0x1c0, CPU#13: mkdir/1301
> [  123.140090] Modules linked in: null_blk(+) nft_fib_inet nft_fib_ipv4
> ......
> [  123.154926] Call Trace:
> [  123.155172]  <TASK>
> [  123.155419]  ? __pfx_mutex_lock+0x10/0x10
> [  123.156181]  ? __pfx__raw_spin_lock+0x10/0x10
> [  123.156571]  nullb_group_make_group+0x20/0x100 [null_blk]
> [  123.157011]  configfs_mkdir+0x47b/0xc70
> [  123.157337]  ? __pfx_configfs_mkdir+0x10/0x10
> [  123.157719]  ? may_create_dentry+0x242/0x2e0
> [  123.158061]  vfs_mkdir+0x2a9/0x6c0
> [  123.158352]  filename_mkdirat+0x3dc/0x500
> [  123.158710]  ? __pfx_filename_mkdirat+0x10/0x10
> [  123.159070]  ? strncpy_from_user+0x3a/0x1d0
> [  123.159413]  __x64_sys_mkdir+0x6b/0x90
> [  123.159760]  do_syscall_64+0xea/0x600
> 
> Replace the runtime mutex_init(&lock) with a static DEFINE_MUTEX(lock)
> declaration to fix this issue.
> 
> Fixes: 49c3b9266a71 ("block: null_blk: Improve device creation with configfs")
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
