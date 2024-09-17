Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D094C7C
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726532771; cv=none; b=ofEOqTkYj7lDMUWuHcEN0f2KaoGmFVD6/jplcPtaBxKdCFHIKMrK2YZcJlsYa8tDjDZ5ZAau0TpTacgSz4Sej0x3NhqgPLa53sGU0RgQmcKpwxGA8flV6UB/+H4l/ZRkpyZmCuCMi63E7xIcHfExLAEREGijTTmgtWU3ShlROGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726532771; c=relaxed/simple;
	bh=psoVpQzJrBPVY0fYQAyJ99TpO5Nskyt6xZz6CZaMDgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryOCYcdKTbZC4sHAnhSdcGVdJCeMXWxHAWdzroVoEpcBcREfHPoeNiwPX5mtl8GSYRPvIumVCQUKVuzeL7zFxXFbYI+s3F40vs6HhbYS8tTZ/AcKt3cQ6svKVYro4GLqXT3QCKzO9RphnLUIQzBs9udbIklHI06k+yZ46iZPbJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JsN0Q0Wl; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JsN0Q0Wl"
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-5365d3f9d34so4146986e87.3
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1726532766; x=1727137566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJkeqOmLIp2YwPfiW45sQOEAdHiKn0a7hMa2yMqu3lo=;
        b=JsN0Q0Wl+QHjAMT6e1KvPejMDD1SaHzx0q5jigiZflajkSWjqCzN98ZGpBztWrEHRj
         XFfKDIWDcNIwGBCz/2w8Q9L5Q8PR4xuzs0ky30lsgdEJimv8yurvzmeubEdyJs9W9Us2
         Y3eST3xKNPkg5dbIjfbrO9YrUOBTa4Wk6xd+Ro1/28bF6rhQ+Ln4sPZmUiLi9WfgThXs
         GqHqbZYRVaMFSGKvabkXVNULbW3gpzhlHUj8tBC/yxiDe+nhC/zleeb/tzr1Dn8XXbVy
         ak46eVqecRxIOxxU+Mm1tLLNY1TMhfyRvNk+rGQK4KL/hvzNlbHCmanxYSVEf8S981Wf
         csIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726532766; x=1727137566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJkeqOmLIp2YwPfiW45sQOEAdHiKn0a7hMa2yMqu3lo=;
        b=QZW7RF85Kn1ZPryYuJ6Vt9D8tn0QKOlY+l8ddGKb0iVfKvdl48k6PJx3Q9IDy5p39w
         xS754JWbIclmkjfPYnLVfiWu6q/6gwAaZ7S6ekLK/O9weDk1j++sAHEXZKXZ+NXog02r
         H5+xLPqDerEiNN9fJBVAVhaBlM3U9X/6ViMvJYDjjdtyzerS2aMNpL8qXvruhjA4hJ/S
         lhZomwOslpKgKC224SI4c9zzrx8WLnOxcG+MZgQk9gbsI1/TU08UzArjHSP17i6MSL2a
         VT+aLrrpKUh9349fnE8APiJsCLjaHnq5ro4D3aNTWfSbKID6zE2spTjpHtcaOqjfNzIp
         GjHw==
X-Forwarded-Encrypted: i=1; AJvYcCW1yr+lGu7jOtbCJyVyUipDuuW/jhNgOx5HNb5nUQqMxx7vLwmSsZR9lypDLfgJ//Wlrk04tkqqy2qi+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KV41BUIUXLIFR5SN5nRHWEp/DWk0LMHgMdRzoxevDIDuDL0q
	hVAQ39e/uXoKfoCL+Ma2ra+VEBnqOxjJ14IuuzIgu89Rn8w74X6pAY0hu6bCXvt7ak44y/gyLmC
	MiGJT3m/e+YRO1gquTPwrPv38a+t7cgkTCut4zliPAMy+su/N
X-Google-Smtp-Source: AGHT+IEtmGTWHzIPRpxTZlEB76CHGzg9/6jk++SzbRLNHFu46m/c80qjy7UkT8k28+sEMShRN5smc/bz4Xdh
X-Received: by 2002:a05:6512:114c:b0:533:4191:fa47 with SMTP id 2adb3069b0e04-5367ff24b46mr4929339e87.47.1726532765318;
        Mon, 16 Sep 2024 17:26:05 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5368704bf9esm83720e87.53.2024.09.16.17.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:26:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7872834028F;
	Mon, 16 Sep 2024 18:26:03 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 68727E40E56; Mon, 16 Sep 2024 18:26:03 -0600 (MDT)
Date: Mon, 16 Sep 2024 18:26:03 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] ublk: refactor recovery configuration flag helpers
Message-ID: <ZujMm9RkQyNmqkwD@dev-ushankar.dev.purestorage.com>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-3-ushankar@purestorage.com>
 <ZoPf5L4oihlZJ1rW@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoPf5L4oihlZJ1rW@fedora>

On Tue, Jul 02, 2024 at 07:09:24PM +0800, Ming Lei wrote:
> I feel the name of ublk_nosrv_should_queue_io() is a bit misleading.
> 
> The difference between ublk_queue_can_use_recovery() and
> ublk_queue_can_use_recovery_reissue() is clear, and
> both two need to queue ios actually in case of nosrv most times
> except for this one.

Well yeah, this refactoring is all to set up for the final patch in this
series. Taken in isolation, it might appear pointless.

I'm open to suggestions for better names if you have them.

> I'd rather to not fetch ublk_device in fast io path since ublk is MQ
> device, and only the queue structure should be touched in fast io path,
> but it is fine to check device in any slow path.

Added a helper which checks the queue-local copy of the device flags,
and used it in ublk_queue_rq in v2. Sorry for the delay; please take a
look.

