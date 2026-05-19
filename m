Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E5F386C3B
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223912; cv=none; b=AVYxg60iK4UK80VDemM0Ro87FzlIMPi6lHmPjK7cyb6oV9zUN/6kZUwrsXxc3NAPdJTlV/V+lIT4DJsRGKjz/ROUhtC3D9tSv+IZde0DJmEbhOikkXRgZoyLYZZgjuJIRcSFCkQP20OcaXCK5QuEmPpKM2eRmp+xVBmdDa1IbC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223912; c=relaxed/simple;
	bh=whjXp8rWkJeXDbOFZ/V58cb/3zF2lbhUXZVSFzpVNWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS9+CH7IENCSYSJZhMFh6Umct50gcQBwfT/9+KbIqlvUYU7+0JfecyJaclNQtJnXvl+wvtg3XXAyCEgDqfOvFDjD5grHPuGCQpNtCnOM2h0RceaZGxNsUEJWEyt7zcGBG3QXgrcROBguZCA46+D5pue9qoIxhsbjxpX+QBPmvCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=Q/CGXIWW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="Q/CGXIWW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso22471865e9.3
        for <linux-block@vger.kernel.org>; Tue, 19 May 2026 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1779223909; x=1779828709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WCYsOu0Hdsv3nYRv+K8TQXlAkq1BjCEa9xNFJ1ynkw=;
        b=Q/CGXIWW+DubY1l7hhiT0gIFbFjX7FwfSZ90EBLr41dscttK4YbSEscFNRARf/mBmy
         wHBt4tCnnWiasoBJh5oXMOMJIdsVoQJOMgdQCCAc24M0o6BVWQjVwhDC33fOMUrNql8v
         /ipm8DaPZ+rBtAKIZJ7LZAkpm5yK0QC1kowgTewR0r1Mog3GPOcQYXD6mkYq3tvWjCK7
         LSDuOmu4mdVw/+mKk7S7VW+UzIFbJI1x0NBDjRJSB9B6/Eye1CIBASRux6qDZOOft/Py
         qxkbmMDoxsX4zeA6e88fr1xrw4S39II1cg5aFsUskaTTA+sdbA7Pw6HdcWsvM2W5vfLf
         qKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223909; x=1779828709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WCYsOu0Hdsv3nYRv+K8TQXlAkq1BjCEa9xNFJ1ynkw=;
        b=oAPThX1s+R505c0EmHcxSPHgjzBsjV3K1lmooQds5LFFZLxIsFVIODPPlGCNZcgMUd
         tVtUufMkEwut1TOSUzRQTKq4QXIO8DqUtH+nSzJhIc/pVauUvX+qtWgNUmuhmy2o/svn
         N9/48TWChBmmxZA/VoVVA21Vwd2uMyUQXBZxI5tPdDITXN86NyuO2Oo+BQmNO2VzM5HE
         1M6KZMaTx67smyvBDSKKF8zYMEojOqPAdS0Lav9SmIcfjbdsHdvRD1aal2XbmPuIgQw3
         8tDqV/d7+33GT5ldfTt621r8wLYiXUt4M6C3ErWlBi33xBdYlY2clpsPp+qK8K6wyZeY
         Fh7g==
X-Forwarded-Encrypted: i=1; AFNElJ9heK2NOsxu5h4RZQV17ZzYeka+9u6EtyrP6S47nZWKxPv785Kxi19FUabnxmSpQh66bZAbAACNS8G9gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7WAMdC5eYEsnVa2ZZnJM12FDrdcl97eqSr2/xppR39QxN5hhM
	b5sxCVFOc4HIi7aGBWKFqmwbUrcwOCZqlHfNiETWHCWeJYcVv1Bhr5WixUgC7WF4urg=
X-Gm-Gg: Acq92OEocSYvOGiHP0MaTuTwZqeXBEb618+mxsUO692hprVzjEzB5750cotc6Ae25s3
	jEhNnQamL0Sk7Ni+S7ycRnzd0xQSgm3nc8egSpNXTHVZ9QPokVDXLBV3cerPmxuh7k9H0sVDObq
	9DoULEfHTU3hxbbtJ1pAdZ76mHPXB47UB4eyaSTwZTwrjwlxUtNqavT5PMgxeouAsGoVMw5eF7C
	unrM5fczoYays9th4DNvWSh6Zk0FT0cw4HzfKoDA2JHulXqudDSNsgVO1mkSJA3YRXysuN3a9Hi
	s1EXoQNhx4Nv4z8fmX3dvwPrb+EKsMECquqtszohDCa6fyJypGwRXbK5PBT9Re1pFCkQz8MkER9
	AkEgV1OeRbKtsl08QwFpMcBIL0l/L2KXQi2rBjGa4DaNKyU2GavhfO12PBuF8YEjRkrEjth/c8n
	tiF4q8/GJObLq8nPMCrtxGSy9s9RC7yPGEhu0f4G8BiTVV4d5o43Ip+1kE/xOanOua/33zkWHJf
	jq/Wxsk/facQq5ujQmoNq4kWXD+OI1PJeE=
X-Received: by 2002:a05:600c:8901:b0:48e:526e:1040 with SMTP id 5b1f17b1804b1-48fe63021f9mr298522225e9.23.1779223909230;
        Tue, 19 May 2026 13:51:49 -0700 (PDT)
Received: from [10.61.154.145] (91.141.120.117.wireless.dyn.drei.com. [91.141.120.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767cb9sm46504270f8f.2.2026.05.19.13.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 13:51:48 -0700 (PDT)
Message-ID: <65088b94-a603-4e84-8601-0663f85303b9@linbit.com>
Date: Tue, 19 May 2026 22:51:44 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drbd: remove unused drbd_nl_mcgrps[] array
To: Arnd Bergmann <arnd@kernel.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev
References: <20260519203057.1340528-1-arnd@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260519203057.1340528-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/19/26 22:30, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After the rework, two files have a copy of drbd_nl_mcgrps[], but one
> of them has no references:
> 
> drivers/block/drbd/drbd_nl_gen.c:641:42: error: 'drbd_nl_mcgrps' defined but not used [-Werror=unused-const-variable=]
>    641 | static const struct genl_multicast_group drbd_nl_mcgrps[] = {
>        |                                          ^~~~~~~~~~~~~~
> 
> At the default warning level, -Wunused-const-variables is turned off,
> so this has gone unnoticed.
> 
> Remove the extra variable.
> 
> Fixes: 8098eeb693c4 ("drbd: replace genl_magic with explicit netlink serialization")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Oops, looks like a copy/paste error on my side.
Thanks for noticing and fixing.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
