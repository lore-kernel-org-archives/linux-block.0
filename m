Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4878F6E;
	Fri, 25 Jul 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467395; cv=none; b=XW0RRMvrkofB7ljT9dHktiSxLQpKP7xyFUmHXNLH1Nzcq2wMLO+U7yWGUqwWtx3zs9ReI1QeSlBv9BgM5UvjoRN636V/uk49NJloXDHBACVHKZHfcqEgxQgJFp5tf6SKBIX7YzdtAkMETIlCY6dr5RTJvTsB7w/T+/Z0aCi9QyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467395; c=relaxed/simple;
	bh=7nurUaPvO0z2E10IJI3RG/CoEtg+UcViKtixBrX2WWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xl7+sG1WHViBiwqAJA+qzAepWQGF4cWNOuj/jcAZvlmpOhkN1ZC18qWWbHvzlJJx0vZEgCskT9/ztnxDhmQ/S+izyq7+7G7b/FiKwrv8NRw8muKs0Tlbu1i6YAEIbNKpqqMp0y+l4syl6/lJ3RIsgv09enbNwk/5xjHunD2q//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0cTD0Xe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0cTD0Xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77E3C4CEE7;
	Fri, 25 Jul 2025 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753467393;
	bh=7nurUaPvO0z2E10IJI3RG/CoEtg+UcViKtixBrX2WWg=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V0cTD0XeUFB+hsn1eB7VGtgH8y8GOprsm5L+w5uGn1LDl0cO65Sq0mbGhr2bKd/vU
	 e1RmVJ8tU6sgLx6y6X35f9EPnZXAbA4S6tzRNYo0UN1J23Vq+8iExNN5hrzCc/+Ri4
	 7hu60qLRM08fOXjhCuaXmQzGpCy0C6VWsdzQzjx6BX8ltoBjSkjX0qrw7plnJhxMpT
	 bQZ5RDxCGuUcjzK9Fcl4Oz06nu0xWWugN98IJJqFi3os6IsrNXKlTibU3qdYl5Yw+u
	 EbuUE6ETjcrgshlTCvkzsu0k73UdD5oTflYdfU/7ZqjNTLPmF4/DqrTXGChaX6ivRm
	 bQR+TPis9WBXg==
Message-ID: <b4e52ec1-a385-429e-8768-5e0eae1dc170@kernel.org>
Date: Sat, 26 Jul 2025 02:16:28 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec
 interface
To: Jan Kara <jack@suse.cz>, Tang Yizhou <yizhou.tang@shopee.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, tangyeechou@gmail.com
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
 <20250724083001.362882-4-yizhou.tang@shopee.com>
 <nk2qqgxickxelo6a7ywxwan2fshjkfygzdb6sooe3v4cl5f3ob@kvejyp5t2cmf>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <nk2qqgxickxelo6a7ywxwan2fshjkfygzdb6sooe3v4cl5f3ob@kvejyp5t2cmf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/7/25 23:49, Jan Kara 写道:
> On Thu 24-07-25 16:30:01, Tang Yizhou wrote:
>> From: Tang Yizhou <yizhou.tang@shopee.com>
>>
>> The symbol wb_window_usec cannot be found. Update the doc to reflect the
>> latest implementation, in other words, the cur_win_nsec member of struct
>> rq_wb.
>>
>> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> I think the name should be actually 'curr_win_nsec' because that's the name
> of this value shown in debugfs.
Agreed, or you can mention both the field in rq_wb and debugfs name.

Thanks,
Kuai
>
> 								Honza
>
>> ---
>>   Documentation/ABI/stable/sysfs-block | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
>> index 4ba771b56b3b..7bb4dce73eca 100644
>> --- a/Documentation/ABI/stable/sysfs-block
>> +++ b/Documentation/ABI/stable/sysfs-block
>> @@ -731,11 +731,11 @@ Contact:	linux-block@vger.kernel.org
>>   Description:
>>   		[RW] If the device is registered for writeback throttling, then
>>   		this file shows the target minimum read latency. If this latency
>> -		is exceeded in a given window of time (see wb_window_usec), then
>> -		the writeback throttling will start scaling back writes. Writing
>> -		a value of '0' to this file disables the feature. Writing a
>> -		value of '-1' to this file resets the value to the default
>> -		setting.
>> +		is exceeded in a given window of time (see the cur_win_nsec
>> +		member of struct rq_wb), then the writeback throttling will
>> +		start scaling back writes. Writing a value of '0' to this file
>> +		disables the feature. Writing a value of '-1' to this file
>> +		resets the value to the default setting.
>>   
>>   
>>   What:		/sys/block/<disk>/queue/write_cache
>> -- 
>> 2.25.1
>>

