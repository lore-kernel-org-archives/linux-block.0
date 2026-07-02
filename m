Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E4246781
	for <linux-block@vger.kernel.org>; Thu,  2 Jul 2026 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782954473; cv=none; b=BuXyWQSlrzbBk4GSVC3O9JakfkSvl0BqreDZrGK6bGPG6+uyYjb7+LPVLEQgUoI/ubYdsrhhiPAfd9iq7P2dbB1LA6LDq3SAK7P7rjoIRZBIIiCGFiCHO80GeT0J8jDHXnFKPMLCO45bH0TyVl5tljDj27imKZWZHXp6S39/vys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782954473; c=relaxed/simple;
	bh=v9Y+MRAzTZRAhDhvK2IbxvuPRET8FFXnOogEHx1gd/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pSkZ52Oe68dD/637b91zTnqU6EGsdt7/kZnrOrOKYy+dJDzSyA3h1tuHKfZHMeoRMOTPoG2FPtEOs6YsxPOMmjbV34bRDWs0+Lj2NVsikw23m1mv7urlKqVH5jV3tL9DFkM4gMlSs2IZRVWlIU5idRlzp4YzFfKeeFLb48RU0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=GEXMZf4Q; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="GEXMZf4Q"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9ecb1e13bso561762a34.2
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 18:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782954471; x=1783559271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9k3PRJQnpDO0neh6CEM6x4TZ6ua/bi9KKsm/tK+P+I=;
        b=GEXMZf4QfLeNEgLDzYFuTz3bQa27K8k0f2AqgUMp/Qkujo6axyKk3lxmtxXVOMDeLm
         XONAVktPFkQIntHFpBcQiV5w1mVx7fOiII9m/YQU9EzK9pBjWexiPwcYX3JN0Y7rQarx
         SngjXWj6cu4Pr/OCjrMt0wyvIoJpkWk2H8LiDDgatjnIajsx0llYzCBF71E12bbJo3CF
         Y2IkZFC1U2eDR/gxTbWO8KFMmgc7pT+KWAURxFR3QhFOiDYo83dyDSmO3fzdhxyXQOqR
         StljF+D7gz3+X5YmMvBynf16OFGnV4NTzqszIQldRzeSHhR5MKz6IF4m3TDuLQX988y1
         dHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782954471; x=1783559271;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U9k3PRJQnpDO0neh6CEM6x4TZ6ua/bi9KKsm/tK+P+I=;
        b=P8VgxJP6iOq8ZeDka0gcRYkl95IiSiBUMahb7TR2/U3bzXOGq5wfSuXh3AdMCcT0iE
         jP8JhfWIbMisCZH1pQDahwbmOTjIrlJzNq0iBmm5JCp+t2Z8yLDhSFTNBxREw8Kh0scc
         W31w1/v97JlIyF7vcBPX3GKR4MfbvnOW+uYrHjw0qmiQHSrSrA7gW54CnhtxSzdcqwIG
         UEs/C4TvTR0LHcQyPO1Z/IpnmGZ5DcZD14PvgjKW0T9wg2ZBBuj/DDIin2djmubWk3vV
         DMuwfuBTqBgatYoGTp4kvcHsop9mJZSRWK9oBjNfB9gUN59dWCgiv7tQq9dsHj2Ibpyc
         /MWw==
X-Gm-Message-State: AOJu0YxRv2m67ott/4HKDILXgAOEoTmxJSPVDdVCyUnpWHlOYMIZRs9R
	dKN1YpFTp8QF5eKItTur8PhUFYeO1ku5doTyezDft8t4kRFNDfTVDnx5NWZvgUqPPMCUl1KaFi9
	MXVsHsLE=
X-Gm-Gg: AfdE7ck0qWbc2vq1QlBw2d/RWuOjEK3Wxxwvdjuk+jJ7bmmElZiWCP+GzSt5dKv3yHN
	r6uXgMZ1auvVKCiRhbLDSw3BhrHmXQJuaiPijIe907K4m1vtLglcok/MhnADN8lipSv2x0oaclc
	JK9pdTsHD5BYhGsgm0bCyPRDAVJ9bicZtyL2QAwIfNk98YqGGJ8ndMhjcs8Ef7H+SxBSBJDK87D
	dD3n2mHXJygqPPB/s5Nq7YCEzk+X5OTwfhOy1zZuHvIBYk18omuQop8EyBVNSRu7QEBUn9mDBa5
	Oxms1hiWwnJrtUAf3XAmRy62TvNkyJ3jF6CdCt1AFpe8lUq4XdEe6rEqu6XgX4r7jC/sbCEYLyU
	sE4K0HGf0cxIunNe+nSzjkw+lbcWCkSVTtxiV8J+hBQZDBpD3gGuh0Fs74qmBSooMrmcSFPqglx
	jUKBx+Rxo9EyNpkdrcM44/XiqTchr3PgHoxAaX8i2j6EhazWGtfTsbfCrpKJtUNKSw9g==
X-Received: by 2002:a05:6830:3744:b0:7e6:ee1f:96f1 with SMTP id 46e09a7af769-7eb48aaebcfmr2445572a34.5.1782954470740;
        Wed, 01 Jul 2026 18:07:50 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542cadeasm1428514a34.7.2026.07.01.18.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 18:07:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: guzebing <guzebing1612@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260621014030.1625306-1-guzebing1612@gmail.com>
References: <20260621014030.1625306-1-guzebing1612@gmail.com>
Subject: Re: [PATCH] block: Make WBT latency writes honor enable state
Message-Id: <178295446925.50965.1910380292736043449.b4-ty@b4>
Date: Wed, 01 Jul 2026 19:07:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 21 Jun 2026 09:40:30 +0800, guzebing wrote:
> queue/wbt_lat_usec controls both the stored WBT latency target and the
> effective WBT enable state.
> 
> The old no-op check skipped updates whenever the converted latency
> matched the stored min_lat_nsec. That check ignored whether the current
> WBT state already matched the state requested by the write. For a queue
> disabled by default, attempting to enable WBT by writing the default
> value through sysfs could return success while the enable state was left
> unchanged.
> 
> [...]

Applied, thanks!

[1/1] block: Make WBT latency writes honor enable state
      commit: 1e56f30a73f304fe26a272742c398aedd88a1a6c

Best regards,
-- 
Jens Axboe



