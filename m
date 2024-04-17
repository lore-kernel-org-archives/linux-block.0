Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35613F42E
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363614; cv=none; b=clQuOSzf/XX9h5SU39pkWKyPIkmvv21Y6+lnjpd5yaESARVKVdwgWsIt/bKa+jeifzRBxHvfbxO3KckMlSdBKRlTUuTHANdCPGoiGVqhylLlbTEvgionlVJeCsEnHuXKbW7oemN9zwwpuLzAUZ6Hlx+yNioMX8sipd8KIOS6l+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363614; c=relaxed/simple;
	bh=qV+sZe9J6QOdFH+HyvdCk29XqhUU/5ZAe3YBep7WUpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWV2fYxNilnSyH/yNxDMBIMAwZZB6Ot2LAw9S/Lo6AhxEE3N79a3RLiwOczDOD0pSSc0yo9YN2T0IJdQ9leXmnjxPHDl7ABOXsknPcWybOESqYPKaDIScdFn/FfLjWQo4xwnboo/O7ihLCfNy3qEDyxa5AAoVe7ZuXOOLIaZ3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GorSckcS; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GorSckcS"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d9c78d7f97so15143139f.3
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713363611; x=1713968411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmJ5eZJGxB1Hun1ep3UDJQ3ZjsSAsChxE6ejtia75oo=;
        b=GorSckcSSwPcNwDyn50PCvnf8e5H4+6jC6Iubis+ZMQbzdCt+umRgHPRehKVnSOmY2
         yxy4LBzJHfwF4SUCBsoc1edku5CgFkJLipMvMWcbWQT+ucbkdkySva8cbfceuF6Hxic4
         IJUxXms6SVufrgFcA4yuvRfaDtEnTqtNo3fkWkla9cX5uwcq//3H41sdkPtgeD1M1gIQ
         PgS8gGo21rZhOsIDrjzVuMW0+7eJUxt3Lkwb8ME2Mt6ZcTDpL0WC2YuHZFpsO+nzjlMh
         H09P0Pa/rdkTKVkSwYEAkLhrgbVcnOcixQbaScB7dTWCAo9vMTCvdQN97DG+2rLvLU8N
         AAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713363611; x=1713968411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmJ5eZJGxB1Hun1ep3UDJQ3ZjsSAsChxE6ejtia75oo=;
        b=hG7WWhgLaLzri1bx0uy3G04Z+Jhc2to9ZRCiRv5OUm/hxhO5RGu5T0Vhauqc9vaWVW
         2r//1LQy1xzCYK5jHJOSIelEyPl9tdu4QYPyXDZV7cRX87CQrkNw2FBDbUA2HgOJhQdK
         MslO7PXPO2XzwG91DwBkAKy57hxgKY9Iq41dsSFo6pkctf8SadZQilRxwx1KzxfIHr7H
         S68LfZGq/7VuJEBgYX8sUQzVXzSX/lm07A4aWliV6Dp7X4UTcjqISKs5tbhNMyDba4f/
         4ZHxXRgrEURYjiuyJ3yaJxptte56zxMeElQKrUjkOjld00n8TnmAvkThgZSPkAjbP/z2
         +Tfg==
X-Forwarded-Encrypted: i=1; AJvYcCV0U1HLf2fe+L7eBq2J6um/kAmesGxLYRLYYykbZyjDOLxS/at2cGi9DuOueiPzCB6ujN89Zxb5E0qsO1GXqs5oVZwLw75S0pf5RZk=
X-Gm-Message-State: AOJu0Ywkmg9aqrHvKywz8aEjfIrCbuemV8yp7w4cBhbGTy9MJ0igCPox
	vceMitc9QK+IGQ4m2qoT+chvzKXUfjpMRNTmcAzOGGZjGWmh3z9/Wd5MDxAT5hY=
X-Google-Smtp-Source: AGHT+IHtsCXR9G3n7aDlaLxkxPqb+SGPG4DBga0J3T70QmsEh45We5icSAo7F0CzW0bUzldcD1V8pw==
X-Received: by 2002:a5e:8d03:0:b0:7d9:4bfe:5ed1 with SMTP id m3-20020a5e8d03000000b007d94bfe5ed1mr10824580ioj.2.1713363611590;
        Wed, 17 Apr 2024 07:20:11 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dv2-20020a056638608200b00482f1e0662asm3245449jab.9.2024.04.17.07.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 07:20:11 -0700 (PDT)
Message-ID: <e86c972f-4acc-4b89-9872-b5f92606cfd9@kernel.dk>
Date: Wed, 17 Apr 2024 08:20:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dm-io: don't warn if flush takes too long time
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer
 <msnitzer@redhat.com>, Damien Le Moal <dlemoal@kernel.org>
Cc: Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
 linux-block@vger.kernel.org
References: <754d1973-31cb-d3ca-1f6f-2d35b96364db@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <754d1973-31cb-d3ca-1f6f-2d35b96364db@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/24 3:05 AM, Mikulas Patocka wrote:
> There was reported hang warning when using dm-integrity on the top of loop
> device on XFS on a rotational disk. The warning was triggered because
> flush on the loop device was too slow.
> 
> There's no easy way to reduce the latency, so I made a patch that shuts
> the warning up.
> 
> There's already a function blk_wait_io that avoids the hung task warning.
> This commit moves this function from block/blk.h to
> include/linux/completion.h, renames it to wait_for_completion_long_io
> (because it is not dependent on the block layer at all) and uses it in
> dm-io instead of wait_for_completion_io.

Change looks fine to me, but while at it, let's just move it into
blk-core.c and make it public, no need for this function to be a static
inline.

-- 
Jens Axboe

