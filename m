Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99026AD7E
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335967; cv=none; b=HQQQpHnFWqmUkX8Wo+0DRUt2Oc7a+qgwARfR26htlZ4XupK2a8hGpzS4cJ0qBp0fcO+UEeQKl4U7v+QfyriptoQolotIJClCoUBf7advBQDHMSHK/fJ5u/h4zz8gdRPwrV7Hx8x/TkJ6OC2WzePKystj8FsXTm0LUVsf9gmVhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335967; c=relaxed/simple;
	bh=m0pLVWc50tF42FKUpj7r22FDMHA0roMZnY6ibDzMcZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaZ0NaGVaN4zGqXFuOCo2xW5OjOw9M1jwukr6DJ4b6gkTEnQCoaMvBeCJLOyzwvho5bxLGXjAPtkrTZiwwmcK9MIiGCY2cR1RfJ+9D3d+86NgSp3xclcJkruq3lApZeBXdpJcO+KlLb4yJAWtFSHsVWEuYxKHY266q9dAWqGnjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqAL/54m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqAL/54m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC052C433C7;
	Mon, 25 Mar 2024 03:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711335966;
	bh=m0pLVWc50tF42FKUpj7r22FDMHA0roMZnY6ibDzMcZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LqAL/54mco4tPpXgGDR4Wrkr9H/RnX6Z5Ghmcek0H1CdYgLTyTXE+o9kKmwRecPXd
	 Q2xmm9MRy4ny7PfZ8e1a7qQcRvsHDOZ4mjfY5Xx0xqVRjyeXT4/1lWe/HbcMg5B1tF
	 8L11rdjJyfZilO9Xk5Nn3vTjSdcwcgzR4EuKdaRi9ttuRI1Htu/GdH/bftgpzo8lCt
	 d3ENb/kk0psbZlTbXXtlSLr81aPTVT8ILghmHQRrHzU0cyQqgat1095Fgye7pZUYgj
	 9iY0IFLyhewTbjhKo7XVUgcBLtb9YT7vyh7oUD6toTgDkE5LYoNddW6CNiNrlejhKs
	 6vzsh/DAozhyg==
Message-ID: <bd72565c-052e-457a-ac08-7bf40077992c@kernel.org>
Date: Mon, 25 Mar 2024 11:06:02 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [bug report]WARNING: CPU: 22 PID: 44011 at
 fs/iomap/iter.c:51 iomap_iter+0x32b observed with blktests zbd/010
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block
 <linux-block@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
References: <esesb6dg5omj7e5sdnltnapuuzgmbdfmezcz6owsx2waqayc5q@36yhz4dmrxh6>
 <CAHj4cs874FivTdmw=VMJwTzzLFZWb4OKqvNGRN0R0O+Oiv4aYA@mail.gmail.com>
 <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
 <msec3wnqtvlsnfsw34uyrircyco3j3y7yb4gj75ofz5gnn57mg@qzcq5eumjwy5>
 <CAHj4cs-DC7QQH1W3KSzXS8ERMPW-6XQ9-w_Mzr1zEGF7ZZ=K3w@mail.gmail.com>
 <d6vi6aq44c4a7ekhck6zxxy4woa5q7v5bnvn5qmad7nqk7egms@ptc72tum4bks>
 <gngdj77k4picagsfdtiaa7gpgnup6fsgwzsltx6milmhegmjff@iax2n4wvrqye>
 <f4f1cfac-8520-47a1-ad18-b9922aa0545d@kernel.org>
 <jpgro32y5r3mpyh24hoqnwkbcg67twbmcxeicoa5qt723u7ehk@4imddarhtt74>
 <cd11bff9-46cc-4148-9dcf-4087e1621985@kernel.org>
 <l7n5vbvpfmeutotnznxubhdr3migk5kpxgm6j5n265dnfgdtzo@iod4gcsfy5om>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <l7n5vbvpfmeutotnznxubhdr3migk5kpxgm6j5n265dnfgdtzo@iod4gcsfy5om>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/25 10:14, Shinichiro Kawasaki wrote:
> On Mar 24, 2024 / 20:13, Chao Yu wrote:
> ...
>> Hi Shinichiro,
>>
>> Can you please check below diff? IIUC, for the case: f2fs_map_blocks()
>> returns zero blkaddr in non-primary device, which is a verified valid
>> block address, we'd better to check m_flags & F2FS_MAP_MAPPED instead
>> of map.m_pblk != NULL_ADDR to decide whether tagging IOMAP_MAPPED flag
>> or not.
>>
>> ---
>>   fs/f2fs/data.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 6f66e3e4221a..41a56d4298c8 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -4203,7 +4203,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>   	if (WARN_ON_ONCE(map.m_pblk == COMPRESS_ADDR))
>>   		return -EINVAL;
>>
>> -	if (map.m_pblk != NULL_ADDR) {
>> +	if (map.m_flags & F2FS_MAP_MAPPED) {
>>   		iomap->length = blks_to_bytes(inode, map.m_len);
>>   		iomap->type = IOMAP_MAPPED;
>>   		iomap->flags |= IOMAP_F_MERGED;
>>
> 
> Thanks Chao, I confirmed that the diff above avoids the WARN and zbd/010
> failure. From that point of view, it looks good.

Thank you for the confirmation. :)

> 
> One thing I noticed is that the commit message of 8d3c1fa3fa5ea ("f2fs:
> don't rely on F2FS_MAP_* in f2fs_iomap_begin") says that f2fs_map_blocks()
> might be setting F2FS_MAP_* flag on a hole, and that's why the commit
> avoided the F2FS_MAP_MAPPED flag check. So I was not sure if it is the
> right thing to reintroduce the flag check.

I didn't see such logic in previous f2fs_map_blocks(, F2FS_GET_BLOCK_DIO) codebase,
I doubt it hits the same case: map.m_pblk is valid zero blkaddr which locates in
the head of secondary device? What do you think?

Quoted commit message from 8d3c1fa3fa5ea:

When testing with a mixed zoned / convention device combination, there
are regular but not 100% reproducible failures in xfstests generic/113
where the __is_valid_data_blkaddr assert hits due to finding a hole.

Previous code:

-	if (map.m_flags & (F2FS_MAP_MAPPED | F2FS_MAP_UNWRITTEN)) {
-		iomap->length = blks_to_bytes(inode, map.m_len);
-		if (map.m_flags & F2FS_MAP_MAPPED) {
-			iomap->type = IOMAP_MAPPED;
-			iomap->flags |= IOMAP_F_MERGED;
-		} else {
-			iomap->type = IOMAP_UNWRITTEN;
-		}
-		if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
-			return -EINVAL;

Thanks,
