Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91D38AC92
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261745; cv=none; b=pvjYxiMp4zYJdkHBO9aJS+acQP+u8UffwvB26MfhM9jOre3rJYoLS7xwmZZu1hUNIFhi8hD9h0UlYR3mdl4sZXV+YbKmZPqI8GHXBm9R9LlarUMH799XOubM8JEgPBuX+NkcKIw72Oi0eyPVKMk5Oqo9jXHJSxyASposkj9VhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261745; c=relaxed/simple;
	bh=OqYSohQ9wmjFzgFFtXqFhnT+y32D7vCWHF/R8qdhoss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnhbz/kU8vyPIyXlw1Y1OHIlI8A37K81+A/j0ENqWC8S3LGBzC9kimAoYTtk9lohtIR2hbweXaOk+9Joal+omFh2TXIBt2fjmvbE0ORyBTuD0NNQUaF+B4o/EtUbik1nqzXYfpjoa12AxYQ/Fn1ojtjctAcW+SU3SdKh1Dx6wp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=ie9jDDiP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="ie9jDDiP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso176579f8f.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1773261738; x=1773866538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pu0NIFLN/ECFVaOtKO0yfpos5sjB3G2gTzkdHYJNxIY=;
        b=ie9jDDiPJQeIFwCFtbfGcDKNyb4+Jj7u8G03eFPdPnBupImDTNZLxkYyw/coJBBzJt
         t8zytfVfDg9rmtM1DumDYcHx8CQtV/MIIc3KOkRFPNgK0jkOMsUsdsQ75EqKhVSEPnZx
         U7N1yj4EOSrR+UYDAX2ztpQ1p+dKbAuaM6mdE575WUlcGw1ucpdj/Fh0XQArbpN5Exdl
         QbjzBjWyfiF8KkODC7bMCmjr5XzPe2BSwmgR4WdyfzjhBFLjYnvzWCiLvEVnBwFrtlMR
         FrsCt1nIvQRRVBvVFxe7INTRDo9cTJSeS8xFuf6wQLbjLZwqD/H//J5sKthNFxE5ZB4X
         KzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773261738; x=1773866538;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pu0NIFLN/ECFVaOtKO0yfpos5sjB3G2gTzkdHYJNxIY=;
        b=LeODgrFmkcOPic0FEQWs8GGC91N6ou9IXxBKrlOI/8yik24L321IMScZlBVqbZtBYM
         pWC3/hnfqUY3CPLnyR0D+p8x1B7TCv/z99+4apt/ZtK5gYpg5PeCn3P3Di16yF1LG77Q
         U4tt99h0t1AH6yppgVLCUxIk6dw67IAF8nJpH37q508C7Qu8nDZmwj7+OHoTY4gZWVI7
         Xg11Gj6rOZWOB7lHhZfXFbH5yKOUJNL4i5g/8LPjcMlfEpKTHAfvI/qGmkLks8dWcPTX
         ZdW7qPmE1fikvKNww6svo0LIhxFJTWtpsjiSj5t7oGJi7sq7aGuMFXtrXuUYAOyxnsas
         c48w==
X-Forwarded-Encrypted: i=1; AJvYcCV2+MpeK/3WQrHz4qEpvbZ0IqXG9FKbWbAXAUM6vhOeBzznyHzNM/z+evLQVPWy+Zduo5gMi4iu1tn2+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yydl40CK+qy+eE/BMedfwmr195vuA5VNKqCdM6MY2pRmgRRGM6z
	aZGkugbUAfolEYA4bCXlCewXcJ+Ha2Praq/R0wUFjSBBcrlSZpSKByzodt1uBscIc+U=
X-Gm-Gg: ATEYQzy3E9UolbwQ7HtGqcCqX5WXSAK1L0kHO6qTuvrrC412Kz9qH65EjnRAESKHtXc
	I7A5Buoa7KHn6i/3G6SIzASUnuXz6Ek+WV0lFOyALk7hvGNtHzBS0o2nUJI+0GK1bGJLGtDvGHT
	sc3IXZwJTTCRQUY0ozq5uzdeuXqdFbvrkBTADGlA+VuZwSZyPtkJFmpwUa5j4HBRgPkDC+dDmv8
	ANwt19fzhOtnIdvAGcrah2kJm+/rN0AaY+i+rVT7X66uJ5gwNZ6inA3oyop87SGW3zpYvB7Yz8S
	UmWKTNTCeBncqXFUlj7iaNs+Lq1P94fvD8+PrKmROrXqvTTKPxo3vZZQMu8GbQFqxnjfnlN20zc
	U/ZNhIwmBU9U+EDGTvnbyFnKEQJKt244n9hdBk0oeqVRGJuLLfB6fauU7C+YfQvhW/Mp128FzpJ
	TYILoZ9PdEZBPHB6JYFXwskmL9uCUW+yf1qWFiShTOatcDfeqR7OkVW+bHGVFhq/GCXzm6peteZ
	8CHVLI8UQrYyCk=
X-Received: by 2002:a5d:5f53:0:b0:439:8a13:2c65 with SMTP id ffacd0b85a97d-439f821bb8bmr7863321f8f.37.1773261737629;
        Wed, 11 Mar 2026 13:42:17 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a737csm1717190f8f.10.2026.03.11.13.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 13:42:16 -0700 (PDT)
Message-ID: <e8431e46-95ff-4daa-959d-024be1ed2fee@linbit.com>
Date: Wed, 11 Mar 2026 21:42:14 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drbd: Make the lock context annotations compatible
 with Clang
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 Marco Elver <elver@google.com>, linux-block@vger.kernel.org,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-6-bvanassche@acm.org>
 <cbcfb229-9a5d-4552-9ced-788de1e69842@linbit.com>
 <19592fdb-3bd1-4406-939e-3e7afc6f6919@acm.org>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <19592fdb-3bd1-4406-939e-3e7afc6f6919@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Am 10.03.26 um 00:15 schrieb Bart Van Assche:
> On 3/9/26 3:08 AM, Christoph Böhmwalder wrote:
>> These are marked as acquiring connection->data.mutex, but actually use
>> connection->meta later. So the annotation should reference meta.mutex.
>>
>> Also, I think the annotations on drbd_send_* are wrong. These functions
>> have no path where they return without releasing the mutex, but these
>> annotations would tell clang that they hold the mutex on non-zero return.
> 
> Thanks for the feedback. Does the patch below look better? Compared to
> the previous version, all lock context annotations (except for static
> functions) have been moved from .c into .h files. Lock context aliases
> have been introduced if the synchronization object is not visible in the
> .h file. Two function declarations have been moved from before to after
> the struct drbd_device definition.
> 
> Thanks,
> 
> Bart.
> 

Yes, looks better now, and I can confirm that no warnings remain (after
the other DRBD patch in this series).

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

