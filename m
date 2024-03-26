Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF56128381
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 03:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423844; cv=none; b=cmLkcYJ+TTC4bwLyjkFLUEcKfnQMQjkJyZPLvOfktMnAxB9gdCASDrdTFjetwDUGBNbOCn/eLCMnUafpeppI49xuxgptyu0jb/B/RjL/T7yvpWbylrSStpmm+0KyC5znaqruRBxRKmmiwyj+22OBMjY5GUefIrKZlItAy7BExPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423844; c=relaxed/simple;
	bh=vk4WsrhZtbWmybVFcGpn0hZuRw7hyds0oN4TXI3xe68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWa15P/4d/9YqSpw8e8XgVTTlOXSLGoOmBl+RKGHPkoYVkXDNauRWur/0GFuEw8OibOd3dm4JIaEUOtC4TsgdIvaDtA1+VzQF1KEcUrdj1njlHj0di1Gayvxp00XPqi+/uRp85Yz9QLwhAoHQI+j6y5s3V23egYXrtp76Bt9Y9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITK7kCoM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITK7kCoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C197DC433F1;
	Tue, 26 Mar 2024 03:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711423843;
	bh=vk4WsrhZtbWmybVFcGpn0hZuRw7hyds0oN4TXI3xe68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ITK7kCoMJEInQriTUxHlpSNaf6Ni/MjB/I6QA6NhZx34DnEKcGpM/wq/wFxZrL1TG
	 j3vkHkKZunY4qB22bmA3v4ErXvcxyzNZ5MwLPD5Y3prBBI1/cjc1XE6nrVPdi1LwZG
	 LlRLLddE8aaWsJtcyKQZCuiQKUqYiwGXE6roNdKq0d/SY4//JW4T6Y+38ZTMGjggnI
	 yMfhAEQ45o4ONwUgN8kzcuKQ1GIHkdhECVN3HEmcCiaMtUrEJQuu8vof8mAJFexq7R
	 1J+qIiEcSm2KsnuDGppkkAdV03FeTCa6MZJuj48kRoD4/gbUxhLEErZM1aF7i7h5ZN
	 v+7cN/0fG1s3w==
Message-ID: <bb294f79-cb2f-4035-bb65-307bc2e5dd5b@kernel.org>
Date: Tue, 26 Mar 2024 11:30:37 +0800
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
References: <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
 <msec3wnqtvlsnfsw34uyrircyco3j3y7yb4gj75ofz5gnn57mg@qzcq5eumjwy5>
 <CAHj4cs-DC7QQH1W3KSzXS8ERMPW-6XQ9-w_Mzr1zEGF7ZZ=K3w@mail.gmail.com>
 <d6vi6aq44c4a7ekhck6zxxy4woa5q7v5bnvn5qmad7nqk7egms@ptc72tum4bks>
 <gngdj77k4picagsfdtiaa7gpgnup6fsgwzsltx6milmhegmjff@iax2n4wvrqye>
 <f4f1cfac-8520-47a1-ad18-b9922aa0545d@kernel.org>
 <jpgro32y5r3mpyh24hoqnwkbcg67twbmcxeicoa5qt723u7ehk@4imddarhtt74>
 <cd11bff9-46cc-4148-9dcf-4087e1621985@kernel.org>
 <l7n5vbvpfmeutotnznxubhdr3migk5kpxgm6j5n265dnfgdtzo@iod4gcsfy5om>
 <bd72565c-052e-457a-ac08-7bf40077992c@kernel.org>
 <z2akreemu5xu5s4xj5lagbxzhsropp7ga7b2gvl3eook4hjshs@thrz3jcmk6um>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <z2akreemu5xu5s4xj5lagbxzhsropp7ga7b2gvl3eook4hjshs@thrz3jcmk6um>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/25 14:56, Shinichiro Kawasaki wrote:
> On Mar 25, 2024 / 11:06, Chao Yu wrote:
>> On 2024/3/25 10:14, Shinichiro Kawasaki wrote:
>>> On Mar 24, 2024 / 20:13, Chao Yu wrote:
>>> ...
>>>> Hi Shinichiro,
>>>>
>>>> Can you please check below diff? IIUC, for the case: f2fs_map_blocks()
>>>> returns zero blkaddr in non-primary device, which is a verified valid
>>>> block address, we'd better to check m_flags & F2FS_MAP_MAPPED instead
>>>> of map.m_pblk != NULL_ADDR to decide whether tagging IOMAP_MAPPED flag
>>>> or not.
>>>>
>>>> ---
>>>>    fs/f2fs/data.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index 6f66e3e4221a..41a56d4298c8 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -4203,7 +4203,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>>>    	if (WARN_ON_ONCE(map.m_pblk == COMPRESS_ADDR))
>>>>    		return -EINVAL;
>>>>
>>>> -	if (map.m_pblk != NULL_ADDR) {
>>>> +	if (map.m_flags & F2FS_MAP_MAPPED) {
>>>>    		iomap->length = blks_to_bytes(inode, map.m_len);
>>>>    		iomap->type = IOMAP_MAPPED;
>>>>    		iomap->flags |= IOMAP_F_MERGED;
>>>>
>>>
>>> Thanks Chao, I confirmed that the diff above avoids the WARN and zbd/010
>>> failure. From that point of view, it looks good.
>>
>> Thank you for the confirmation. :)
>>
>>>
>>> One thing I noticed is that the commit message of 8d3c1fa3fa5ea ("f2fs:
>>> don't rely on F2FS_MAP_* in f2fs_iomap_begin") says that f2fs_map_blocks()
>>> might be setting F2FS_MAP_* flag on a hole, and that's why the commit
>>> avoided the F2FS_MAP_MAPPED flag check. So I was not sure if it is the
>>> right thing to reintroduce the flag check.
>>
>> I didn't see such logic in previous f2fs_map_blocks(, F2FS_GET_BLOCK_DIO) codebase,
>> I doubt it hits the same case: map.m_pblk is valid zero blkaddr which locates in
>> the head of secondary device? What do you think?
>>
>> Quoted commit message from 8d3c1fa3fa5ea:
>>
>> When testing with a mixed zoned / convention device combination, there
>> are regular but not 100% reproducible failures in xfstests generic/113
>> where the __is_valid_data_blkaddr assert hits due to finding a hole.
>>
>> Previous code:
>>
>> -	if (map.m_flags & (F2FS_MAP_MAPPED | F2FS_MAP_UNWRITTEN)) {
>> -		iomap->length = blks_to_bytes(inode, map.m_len);
>> -		if (map.m_flags & F2FS_MAP_MAPPED) {
>> -			iomap->type = IOMAP_MAPPED;
>> -			iomap->flags |= IOMAP_F_MERGED;
>> -		} else {
>> -			iomap->type = IOMAP_UNWRITTEN;
>> -		}
>> -		if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
>> -			return -EINVAL;
> 
> Hmm, I can agree with your guess. Let me add two more points:
> 
> 1) The commit message says that the generic/113 failure was not 100% recreated.
>     So it was difficult to confirm that the commit avoided the failure, probably.
> 
> 2) I ran zbd/010 using the kernel just before the commit 8d3c1fa3fa5ea, and
>     observed the WARN in the hunk you quoted above.
> 
>       WARNING: CPU: 1 PID: 1035 at fs/f2fs/data.c:4164 f2fs_iomap_begin+0x19e/0x1b0 [f2fs]
> 
>     So, it implies that the WARN observed xfstests generic/113 has same failure
>     scenario as blktests zbd/010, probably.

Yup,

> 
> 
> Based on these guesses, I think your fix diff is reasonable. If you post it as a
> formal patch, feel free to add my:
> 
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thank you for the test!

I've submitted a formal patch, let me know, if you have any comments on it, or want
to update it.

https://lore.kernel.org/linux-f2fs-devel/20240325152623.797099-1-chao@kernel.org/

Thanks,
