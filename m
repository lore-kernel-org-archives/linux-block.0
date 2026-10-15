Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1112F39B5
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792034655; cv=none; b=lnyP1MEFocdRmgIazGnHPH3ac2s3i/XhaiXiL0HydVPkEBcsGJVV3I8KSgV92dQRqH2Z8S4/+p1vR/AZSYKJ1bQYdFcchkLETe1/Ni69BummI6kGmK/Y8nvFvN1r0s37HzPcUBIp7XjbQ7gFJ30NzovtaRVI3ijXZMvBH6HZ5HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792034655; c=relaxed/simple;
	bh=JOwG0J0Pxa0giw+pSldljXOspqL7h3Tsw0YcmIbRJks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtJMih+U4pxswwX56Hctjl17zwCQUqCQI0uWPBTbzsWfmX/o0VeOgekNJcp4JUoUExZF0gGynkZr3talUTEXKQrXjC7zNS/FlvaLTAkJ3sP26ecM0taT8YJT4z+dH+rIT6HYQ4ewdiA52R8WZlSUhwb+I9CGv08uH0MjrSOSd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ker6DsRq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ker6DsRq"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-88b7d853b11so583540b3a.1
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 20:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792034653; x=1792639453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8RAKj7MN73RI8tJkT02x1VHOxQPPjvpRldJHyl+Kj5I=;
        b=Ker6DsRq3keBNNEPQ15CFaO6HMxH4UenwAouDnKTUFWlzlxNtx2nnTDYYDy/uVrz/h
         eFRsDLv9OXDOoysEi8zFjlUgkQ0er6UrW2/yW66WtCl0OuZvXLbgz3xU5wGznjJCbzP2
         EqdHAQr8hQQqXQX+prG5D/DXx5Bc2v9PtilNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792034653; x=1792639453;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RAKj7MN73RI8tJkT02x1VHOxQPPjvpRldJHyl+Kj5I=;
        b=MMneEtP6OVzfi5eKAjG7mFyLYraDMwrwSHN27nyCrSy3nXKfEOESHp0Zp0eXtZwGra
         pinzIF6wHj6r/WTweCa7+xjaUQham6Kx/QmfeWDuj0KUjqOmfVikNk3qFfodvirijnCL
         Fg7G6zT7wa22DpDxS+6pXlo9um1EKLN9QfP/sLLCJ8wLPotSQvZDoMAufYSeuOtUPF+p
         awv2syi/HQGu0CUwSOHuxBfv8MmvWGtwxv5xV9Tb8Z8s7zhHO6J+zrCNYUWVmi+LfSiX
         OO4f+Qump8qx3x1sYPdqFvt/VcPOzxYSQqVSemdQREhSZuk6EZaalzm9CsUwksbQdiLV
         m6sw==
X-Forwarded-Encrypted: i=1; AKwUvBzSy/R8xsMYLu79F50cpe0SByxsbada5FKol4zf+y0ZHaha94ED6nvu+PAr2/dzWuwhuTdJWTwjCpu/7w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJx9lICqr0Qi+ASkOyfrfHNq7CGwFGQbMPQk1kRWAPkhY8p0/Lh
	IGMcZNrXj4FHM3Vz9w7n3OLPtrGkyKuHUYayfHzCjKZ2BAOCpdzv7xAUjIVrFObkDQ==
X-Gm-Gg: AYBFou1Y5jDuYs00F5xG61+iTKoRIePuREyZZ5bL1awXQbUhl3T5lvOEhGxhArUdPF9
	GwoFgDePcqPGNkpSgC2TpjK3xQTunbPkRIWp4K511TZheqiP8VadCAtQLnIlikWBQioi+0eEe4G
	37/9RXzXgV2y3OWsBxiQdSbTNAvZK1TZRTO54ZlKTuwIre8EtHxYqdl2CFsgCo7rSr3LOWtMeCB
	SUuD0tiSjz7Lc0HZ/oFqarv6WWIzVamiSQG9aLseRbdBH9pSTWQwi0TTGQrrefgKpyyXgMi1wr1
	Xf7/HLV2Z61oVWnkaXVKug+v8EQrRkkTAljcFXNkN7TK9Vk0HEL62gLQoUB1hAYl/KQnsVO2tv0
	wPBr8XebdwTcq/rL9vkpbJN6XqWmaFGqdi8HshjDQ2ON9CC1VAjWtBB69e7mhgVQKNQZQRkDsKr
	+5gBr6vPuHmNxtYLmSSvxv6CGe0nW9aZfr0zFelD/7sEswQaFk53tQj8HeV+s4zfVy/aGBc4hNu
	NDCpFdDawwUja34Li7PTSE0TdSP1Rc3svHjtoIA
X-Received: by 2002:a05:6a00:7615:b0:897:dda6:ad35 with SMTP id d2e1a72fcca58-897dda6b684mr11707767b3a.41.1792034653406;
        Wed, 14 Oct 2026 20:24:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8455:7899:5a2e:26f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d7f51ff63sm1700395b3a.5.2026.10.14.20.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 20:24:12 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:24:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bo Zhang <zhangbo0325@gmail.com>
Cc: baohua@kernel.org, senozhatsky@chromium.org, akpm@linux-foundation.org, 
	bgeffon@google.com, minchan@kernel.org, richardycc@google.com, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Message-ID: <atBHDEBCVL6Ae0hT@google.com>
References: <CAGsJ_4wuPCPR0DnbrLp7ebdO=Oih6K_yP4XxwETKQ+3U+THVjg@mail.gmail.com>
 <20261015031940.1410875-1-zhangbo56@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015031940.1410875-1-zhangbo56@xiaomi.com>

On (26/10/15 11:19), Bo Zhang wrote:
> I'll also apply Sergey's vm_map_ram() patch (with the memalloc_noio
> fixup) and re-run on-device. Note this only helps the cross-page part
> of our exclusive reads on a stateless backend like lzo-rle; it won't
> change zstd/deflate, which stay exclusive regardless because of
> create_dctx. Will report the numbers separately.

Thanks.  I just sent another patch.  vm_map_ram() is a little of a
hard sell, I guess, because of TLBs.  kmalloc() patch doesn't seem
to be much worse (if worse at all).
