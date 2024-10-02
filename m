Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B81D1F44
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894315; cv=none; b=g9ccUTWVDm061I8TIo6k4kXJzypYSxwt5NSFe514RWI7VvMfwRdZBPrhgA50bx0GTkpOhqfHUVOdQTgFARWSIxeDkI0/2LpAwWd67f4NYApPFQ8SNEgc7Zk8H4l5Q7Bp7TzhOD8y1+79rclA3vYJ8DT0lgaHk8qaa1CBqg2n/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894315; c=relaxed/simple;
	bh=xtCqdu3o/WVR5bOanAxpuwKmndQfilnxrYpVpFPeD8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrgCb78hmTMPHkvYmDtECmNXy2B01J9o8eOFlP3ihnt9LyytQjdHKFK6n2E9M4wjwiingqe22lnxSc57LVR3CB3BTyJbGDGBoFJKyZ/J9y4J3u1bg65tlm83PMbnq9fwhJBtKr0s8/xkjO/X/6ymcWOmHSJKKF9wSQJD27p36dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OHZwnTqi; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OHZwnTqi"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82cd869453eso7155439f.0
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727894312; x=1728499112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJp0SLz4zhMPpN/9QdLXIlEOw6z2zlthBMJ+dYX71ZA=;
        b=OHZwnTqiOZX2pCYvohsJfzZbj+miMj8lxDg/jGGTDvONYw/rAq5rL5TFJ/WfQhHz1P
         SLbTRJgQuWMMEdvqexMNetzjeyGLQlg8U4IGgfeeovqHX5Z/cJ+pO1dbQoUuOs6lO1rO
         N3SEC5ECzdfBOg4m4ZUW5oLNPI39+GbYUVU1AIMqRJEQ/Wo3/hhhGYEEufSzgCUhiRi+
         5lBr8prbgDR9B4cbzPHyBOWETG4dUjgRnrsdk3fmhIeXt71vS22cVZ1Cedjg+213lMzm
         HFvJ2VadKLu0elO1csmGY8MSzAqKbcVocrcMZ3plV07vgHkjUedQ/3EqGZ2+upM3UM8O
         dmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894312; x=1728499112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJp0SLz4zhMPpN/9QdLXIlEOw6z2zlthBMJ+dYX71ZA=;
        b=tMvWM4DnWIDZyqDixWQxgnHNzzePphdAMyEOJbGmltwOWSAJZs2PWHKlijRxBc4UqR
         kJJJr5zPJ+XN6zRXP9SXRk0G2Hoq5ElWcCtw1qo88VWMFHuOodH4iixBa/Ss7D3g8KXU
         0UmoLyVG0lIWPIRV0AxxrFOEYcwEQUaiZq3KG+RLgc6RuQmQeM0vrPgCUgbpniVn8m4s
         8kk1QdDxyOS2hzf9ReK1O8xY6lZKZgYTaUYkmzogrjQRfU6R5ae5fOm0oj6Dny0izTJa
         kV+Qt8YLJKIfnt1bHSLFrfCVLkNXsCXV+4b1P9527x/ErEnEB/ycOnzslx/AtrPjBEPT
         sr6g==
X-Forwarded-Encrypted: i=1; AJvYcCVkyqhfiukfSwlZZciXUVt9RcLLGG7Hu/ccwmZawLhiiLozNzdLVCenrUEoyFI6JY/3mVZ6kvFchdgXxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6FrxUK7c0U/6QKBpqwkzJ9GzX+BdtFcd61OKgWUR3AMAOlq7R
	L2kDyMJuvVaSz0pUj/tPGUBNg4HmS7AZfbuc/dShZXhMjqfq8HaXLQ+D3tnLiNA=
X-Google-Smtp-Source: AGHT+IG/gozMX83QOgvNxZbi7a72D75ruQINKEcBndSq/tSeqLeSd64OqvSHja3mYl25NQFARSWvzQ==
X-Received: by 2002:a05:6602:2dc7:b0:82a:221d:51e8 with SMTP id ca18e2360f4ac-834d84f830dmr410358139f.13.1727894312385;
        Wed, 02 Oct 2024 11:38:32 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888497a6sm3232924173.37.2024.10.02.11.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 11:38:31 -0700 (PDT)
Message-ID: <e20707d4-53bc-400c-bb66-f1bd63e063e9@kernel.dk>
Date: Wed, 2 Oct 2024 12:38:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] aoe: add reference count in aoeif for tracking
 the using of net_device
To: Chun-Yi Lee <joeyli.kernel@gmail.com>, Justin Sanders <justin@coraid.com>
Cc: Pavel Emelianov <xemul@openvz.org>, Kirill Korotaev <dev@openvz.org>,
 "David S . Miller" <davem@davemloft.net>, Nicolai Stange <nstange@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>
References: <20241002040616.25193-1-jlee@suse.com>
 <20241002040616.25193-2-jlee@suse.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002040616.25193-2-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/24 10:06 PM, Chun-Yi Lee wrote:
> This is a patch for debugging. For tracking the reference count of using
> net_device in aoeif, this patch adds a nd_pcpu_refcnt field in aoeif
> structure. Two wrappers, nd_dev_hold() and nd_dev_put() are used to
> call dev_hold(nd)/dev_put(nd) and maintain ifp->nd_pcpu_refcnt at the
> same time.

There's no parallel universe in which using a percpu reference over just
a refcount_t for something like aoe is warranted.

-- 
Jens Axboe
