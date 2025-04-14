Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C58BA49
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664418; cv=none; b=U3CI1RCeIXvdY6sW5mce9KY2hHc+KdPeUxl0UDK/WB5XN68ZueBWUXvpkKmqmF2C8d8cQMP6B8tgX4I2AtQAl2ATwm4ZVhSacnOKNhgbg30a5uJBX5T3/Rk/9Xa2bSfh2zqodxXjf4bnk4LAVTYMhl+ZznELTXESotvph5Yk4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664418; c=relaxed/simple;
	bh=0nmDHSwT8tqHJdSfNsSyFhS1Fd3nMUxK71pFPQNEsGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYSo7ntcwXyseABG8OZ7NopitXEPNg168xbF3qOs8Z7hTfCgMVQi4H+WxP0p1x4bp12IQxuHnKygsAU3udqbDysL2SbdUkIHh6a02hCnpa+B/egOl1VlJirlH5rfHBtr0Ynk1CazZfcFCvv/F96o7eU7ZfCoNSDczR1xOgs+AFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iwlWWAcP; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iwlWWAcP"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86142446f3fso109216539f.2
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744664414; x=1745269214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgz27nrx0bMXCTAbU9u8chowTH1XDgbyzXXYmhdDJWA=;
        b=iwlWWAcP6QYk7aulG+Lu+i0PC9U4BioHJqY3uuUY4y6HKfELCGv9YIsd6zSslKu5P1
         oWCmISL5sOUNkRH0hZ43aEzPZWbN2LXFIY6urDeNBpbDTkNqqNWbhspnpfQafHrq2ep+
         zpBElKBSF81QOxnQHOmHmLeVjoco251zR0Ca4Gdb8rSGEDrrB9//h1C2Lu1s3q9RL9P+
         1AwDATfkbzDF0OLcyvbgxRHLesj8mqlZyoMHXfedfmDJhmUSidoVu2WePaEzZnsKvSkq
         WeMIPjmJUvMcbtcCnxbTyN1XhC3W4SzPsBa582pjD5xtsefKFMLnVR+jZ7lMJmSUoGxp
         Ko4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744664414; x=1745269214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgz27nrx0bMXCTAbU9u8chowTH1XDgbyzXXYmhdDJWA=;
        b=mi625VlVtiGaMYiYTcuRiYXKKcbrrCohZt0A76EtjTWuY2p8r+XgWe/xZ2gVM2ymoE
         CfI9gQvRaxAeo59xEX9IBzvxxPi8ahw1jFnIyXvhD1G+FMUPTGiOso+xGhxzrkOeG+t1
         1qV8SmpXXSYXMuKPojO2e9tuUsFwOnk8AisVLQD+I9CqcPJAjxA+t/yH8PT+Wgb2pIJi
         HWQ+e55R3uVi5wY7DPsOgM9FKjBPe/yDpEIjNBfsdAL+SIFJBGXuZF+3KICTS30YjwBG
         bnydb3RExdywrXVBVo+eE8dSFdc/OXGroelu2eG77yXA+5g0CZtZouFuvZSxZdpCPvIL
         wCmA==
X-Forwarded-Encrypted: i=1; AJvYcCWpAdS0PLTks46TvLmFIcFJOxafFvowqiYWEFkNw0lQvaVVEXdIFB+cR82YsVZ1TnjbzJShxL0ODQM2JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycjatFsJLcgqnmlatcd7pbcA3ZzXNvFfaWux3dAGN4oaMYZ0/u
	m0oAlSm5c7L9gjup6IamXSgZvU5G5tTeRe+JDr5t+GpHpombeH0/xwAlhjwQPQY=
X-Gm-Gg: ASbGncviF5NDzr+8Jg8qtgA/GKFtL+dy1cRteGpV+zkms5MiH0cumKyjzYIG7FOZJ+t
	icyWDqXat4hzGsB2HGYu0k6s0/skdKGgZMVYkKfU7BVhIb8t718Uwbq2EVXvEKnIGvy8XJVQPkL
	F/ebdtyCL5XyGbGBW54xcDIGesWjoLicqW2Tfyhu5yoFURGzm7gZABTFw4rNLW81UKEgBzxVBkx
	XVmi8ypgwwXdehq5BIy0BcOv+ZUMq4b/cNH9Ae/q934vXYOSYIKDGVU1+UlKQK8q82cXMm21XY+
	lJZMdaoMxwhXS1FPGx5grwy7qHDlMcjcfaeD1w==
X-Google-Smtp-Source: AGHT+IHX+Mgrm5WgIvRN3pfgrPx4hi7+Tf1M2Vwyyv557DKdAFq22PD3RhU65n2/wnKkuJviqNDwvA==
X-Received: by 2002:a05:6602:3713:b0:855:5e3a:e56b with SMTP id ca18e2360f4ac-8617cc3d525mr1432717839f.12.1744664413706;
        Mon, 14 Apr 2025 14:00:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861656e18e3sm233843939f.43.2025.04.14.14.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 14:00:12 -0700 (PDT)
Message-ID: <0a8fd62e-2715-45cc-a1ed-8779c179464d@kernel.dk>
Date: Mon, 14 Apr 2025 15:00:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ublk: properly serialize all FETCH_REQs
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Caleb Sander Mateos <csander@purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-3-ming.lei@redhat.com>
 <Z/1o946/z43QETPr@dev-ushankar.dev.purestorage.com>
 <dc912318-f649-46bd-8d7b-e5d18b3c45b5@kernel.dk>
 <Z/11q+J0rW6rAJI9@dev-ushankar.dev.purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z/11q+J0rW6rAJI9@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 2:52 PM, Uday Shankar wrote:
> On Mon, Apr 14, 2025 at 02:39:33PM -0600, Jens Axboe wrote:
>> On 4/14/25 1:58 PM, Uday Shankar wrote:
>>> +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
>>> +		      struct ublk_queue *ubq, struct ublk_io *io,
>>> +		      const struct ublksrv_io_cmd *ub_cmd,
>>> +		      unsigned int issue_flags)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	if (issue_flags & IO_URING_F_NONBLOCK)
>>> +		return -EAGAIN;
>>> +
>>> +	mutex_lock(&ub->mutex);
>>
>> This looks like overkill, if we can trylock the mutex that should surely
>> be fine? And I would imagine succeed most of the time, hence making the
>> inline/fastpath fine with F_NONBLOCK?
> 
> Yeah, makes sense. How about this?
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index cdb1543fa4a9..bf4a88cb1413 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1832,8 +1832,8 @@ static void ublk_nosrv_work(struct work_struct *work)
>  
>  /* device can only be started after all IOs are ready */
>  static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
> +	__must_hold(&ub->mutex)
>  {
> -	mutex_lock(&ub->mutex);
>  	ubq->nr_io_ready++;
>  	if (ublk_queue_ready(ubq)) {
>  		ubq->ubq_daemon = current;
> @@ -1845,7 +1845,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  	}
>  	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
>  		complete_all(&ub->completion);
> -	mutex_unlock(&ub->mutex);
>  }
>  
>  static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
> @@ -1929,6 +1928,55 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
>  	return io_buffer_unregister_bvec(cmd, index, issue_flags);
>  }
>  
> +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> +		      struct ublk_queue *ubq, struct ublk_io *io,
> +		      const struct ublksrv_io_cmd *ub_cmd,
> +		      unsigned int issue_flags)
> +{
> +	int ret = 0;
> +
> +	if (!mutex_trylock(&ub->mutex)) {
> +		if (issue_flags & IO_URING_F_NONBLOCK)
> +			return -EAGAIN;
> +		else
> +			mutex_lock(&ub->mutex);
> +	}

That looks better, though I'd just do:

	if (!mutex_trylock(&ub->mutex)) {
		if (issue_flags & IO_URING_F_NONBLOCK)
			return -EAGAIN;
		mutex_lock(&ub->mutex);
	}

which gets rid of a redundant else and reads simpler to me.

-- 
Jens Axboe
