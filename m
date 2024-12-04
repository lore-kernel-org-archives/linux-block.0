Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92B217335C
	for <linux-block@vger.kernel.org>; Wed,  4 Dec 2024 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733345375; cv=none; b=Eizuq3Yqygr1iYZue5oiI67k/jMfm0sj/pujFtCrVIan6J1OV52jFgsPrBXeXGkkUYU6WXsVf75v4NB0lMiGYWAVIzkvPM/hU3M/Mm1PkSPjr8zvtl40dH16MuhHzdchM4lUeffz8mvbFBGqGIf9xNWMUmd6gnGMOs+hslOft3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733345375; c=relaxed/simple;
	bh=7RgwpnjtZfjN6CCvXlv8wtHGBwExeTD4IIoLBag0vh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGVjBgITGBTyX2055IC10AIOHgMI2u5gTOQyOP8n2sCB4wM2u+D/2Gd6uJU4KY6PcsAhKXnyLgewvNcpMSm0imEywkoo5Jh3nw55DEGgy42WSx5vos9ZhQ72+MId/yc2B3bfoepThkD4V0CMDzELGM5QOmXJSYznIyYMiRswGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=qZKHz80U; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="qZKHz80U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1733344809; bh=7RgwpnjtZfjN6CCvXlv8wtHGBwExeTD4IIoLBag0vh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qZKHz80UendupyMRI53cKLWiKmoIQ/+N/D8H+7B3tftsG50ahV9N00nrhXsx460OM
	 9jz+DJurfFE4yT6GZXI8f1m2czoc3WyW8811QmQ0lsqT4fhEvLyF319CKbCivRuyGa
	 MBREMIimjoL+cS9SO2NwzxI11cwh3o+yPeJjyDkc/F+zraLLky/ZL/xqeGoXWo40dF
	 XM1jPdCjO2c3ECBZ54K3pTEv68zLREn7d3PFAkDjo68CXyRCKYBx5J975IZtLkyVFe
	 9BFvhkfO/RymaZB1iZUZl+W/3XSbH6feGppVBAhoCogT4HZG54BJtwYqcBYltqDE9V
	 rsYyPCeVAk21JHdGNuEa/YsLn3GT/ehtsEbfY1rO+jqibq5Q0Q3KBuDbgsnwCCJOjK
	 6UxO57XFLYDmZ67wPOod01+pDZ0IMsT+dJuYfJQYfupkYv+VOPP81y7PWc5Lde2pYN
	 bOI89bGC0mVXx0+4CjT3sw7kETtaeZWF0A8uZZKelRAK10KUxIA4hhypQP4Kiu0hj9
	 yrOSWrMtAImAei6+Ep13S4kTpaK6WosZV52BtFZMT2Um9Ms9tbUaQYvDmDR0RUUQIf
	 IDHPIDHi0BWtox6T5MOklJh+Vkg+Lr3ZPk9ARNuzXvRszwDBjZEzJ8hlYvSTEQEsQF
	 5QxtY2nlNl7grvoHw7x5S8rg=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 6661116827E;
	Wed,  4 Dec 2024 21:40:09 +0100 (CET)
Message-ID: <d35c5de3-ad63-45f6-91ce-c3aa67bf4965@ijzerbout.nl>
Date: Wed, 4 Dec 2024 21:40:06 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blktrace: move copy_[to|from]_user() out of
 ->debugfs_lock
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: syzbot+91585b36b538053343e4@syzkaller.appspotmail.com
References: <20241128125029.4152292-1-ming.lei@redhat.com>
 <20241128125029.4152292-3-ming.lei@redhat.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241128125029.4152292-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 28-11-2024 om 13:50 schreef Ming Lei:
> Move copy_[to|from]_user() out of ->debugfs_lock and cut the dependency
> between mm->mmap_lock and q->debugfs_lock, then we avoids lots of
> lockdep false positive warning. Obviously ->debug_lock isn't needed
> for copy_[to|from]_user().
>
> The only behavior change is to call blk_trace_remove() in case of setup
> failure handling by re-grabbing ->debugfs_lock, and this way is just
> fine since we do cover concurrent setup() & remove().
>
> Reported-by: syzbot+91585b36b538053343e4@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-block/67450fd4.050a0220.1286eb.0007.GAE@google.com/
> Closes: https://lore.kernel.org/linux-block/6742e584.050a0220.1cc393.0038.GAE@google.com/
> Closes: https://lore.kernel.org/linux-block/6742a600.050a0220.1cc393.002e.GAE@google.com/
> Closes: https://lore.kernel.org/linux-block/67420102.050a0220.1cc393.0019.GAE@google.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   kernel/trace/blktrace.c | 26 +++++++++-----------------
>   1 file changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index f01aae3a2f7b..18c81e6aa496 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -617,8 +617,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>   	return ret;
>   }
>   
> -static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> -			     struct block_device *bdev, char __user *arg)
> +int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> +		    struct block_device *bdev,
> +		    char __user *arg)
>   {
>   	struct blk_user_trace_setup buts;
>   	int ret;
> @@ -627,26 +628,17 @@ static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>   	if (ret)
>   		return -EFAULT;
>   
> +	mutex_lock(&q->debugfs_mutex);
>   	ret = do_blk_trace_setup(q, name, dev, bdev, &buts);
> +	mutex_unlock(&q->debugfs_mutex);
>   	if (ret)
>   		return ret;
>   
>   	if (copy_to_user(arg, &buts, sizeof(buts))) {
> -		__blk_trace_remove(q);
> +		blk_trace_remove(q);
>   		return -EFAULT;
>   	}
>   	return 0;
> -}
> -
> -int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> -		    struct block_device *bdev,
> -		    char __user *arg)
> -{
> -	int ret;
> -
> -	mutex_lock(&q->debugfs_mutex);
> -	ret = __blk_trace_setup(q, name, dev, bdev, arg);
> -	mutex_unlock(&q->debugfs_mutex);
>   
>   	return ret;
You forgot to delete "return ret;" from function blk_trace_setup()
>   }
> [...]

