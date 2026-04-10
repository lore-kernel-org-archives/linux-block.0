Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32D31691C
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783536; cv=none; b=QMZN4UKtsCgNXly48Xv+sUo7NEfA0cNsGZgZ32c5prqlhz+pjzQSxvex7a9fiYpZnHL/0ulXu3/4jE/WOMfDXvYoLgGF44/zBhEIPHG0Z+djR2nMrG8KIGK8nKzrqCVLfWtsv6fkh1YByL5odkJjVBFtz8wRJYt2l9XCy/aONw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783536; c=relaxed/simple;
	bh=R7elkKqzIEvnBn9bIM7EJPGEKhNDQxMkBGDun0sNrQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOp1Xbg8cfD9Z2PM2b6z/m3gL2vJEoXYM9N3IX21QXgnMxxUHbqEVDYPXr81+LoZkUMkIZtIzN8LgwBBRNVg3LdmvDUSYS3koAdSCTvg84oLXTALjw1vypBNw+QIeDQJDreLTg7WSz5SfhHbOq0mcQ/cmj1vyKCRq9WUIRnX2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vshAjb7h; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vshAjb7h"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so1281833eec.1
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 18:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775783534; x=1776388334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wicgY9NcgT/3UjIzdAZt3rganAsem03G6NL+TmYL0E=;
        b=vshAjb7hQ6wNFovj5gKMkF+ZvA9y35a/WyHJUBdEUyjJFx0QUaFjKbXheKdUUa03pl
         KNbg7RWg/CNnSjOjlg30BgPcrOCNv4SWN/qLFkgtugL2WiveUMJ2jmhzgIcxlNZro+qD
         VSnt64Ls5lrNqrqkz3NGfbyenf289HyqzyeURExiDgKM4JYvCSissTVSQ+pghC0qpztd
         ae59pnIzZIAl5rYgRdz6/9+hHnxfYE/i87JGAmCU+PqV8DuZoCYm43RlrhETsPal597a
         nQswCV2w0kidZy3LA/WsHhdPc3jJYhH/Wr6N4FcHze21JwiheTCV5YyRfGe6QXzP6PZi
         VB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783534; x=1776388334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wicgY9NcgT/3UjIzdAZt3rganAsem03G6NL+TmYL0E=;
        b=rbKB82U6fJ9OZLCz8+JpcCfjh+05lGgfT61qba4sAqKU2LD6QDslJdabm9/tAfJ6Gg
         fK2w977rLA8mtBvQpDD/UnWXzNtDDzzty4ZrrK6ZD4NheLtjLlbBrUPl3irFTQ3vaZBm
         iAAL+dfXsiGll1qAl48qVbZ/wNufPNdqPZASVrSU5FntlQwCK8WZJWdOBTXAPx/uJWqz
         Ph6vuItIwqrLHt1p2ZfQ8Et7xpAhIVGerKwJWwrk/yl/8xNd4b2Xsu9KrTd80qAwgyK7
         1J0hOkx4izpdcJKtlpmWxwcdHYFh29SXBa9znl0avTXgDXfFT1bPf3OT0ZyHywmbvZcs
         I1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4oBU7JTnLe/ZvQ4mdnoxEwyqlSiQWDhEpYVbjgiVVBOtTo29iuT4i8TwySQmRzQLZXFrZv6m4pEhcEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkV8C6qSVeKIMAD5p+JUzLySlvt6FEjirjEFs1bWsp3uV56f1
	SI3hZGATzX6U4uqX9tk6RoJjOnu1kH9Or3K/8m/f5lVrzo4pIzcfRJUQbVk7uYImm00=
X-Gm-Gg: AeBDietc/PxLD0w40JrSZjUi26JBJ7gKwZeH4dsLAyh9UI8Wi+dUqVeYTSFXg//0X6c
	ITlgLQlpmEd58bSbgu7PWB0JpMtb5iATxasntYAKAt+Irp+7CuhHTrfIVfisCciARUBnd1f39R4
	OXdPMq6zWdRcfnnHRG11q/rO5cCx3fUfcrFeWTZhRAi2A3EYFwomVuw0Ujef7UtLMwNm4pvaXjB
	dVSTay095sfEKQFQ3kHK1dM0TJ9mp/hjn3FXR48ri4eZ/GQPxXjzpxbGtaixYQQkb1xKLgRGVhr
	stDx76V7bC4wbsxvF6IrgzsX70lFYVMbiJHiPB0fi8t7sNr0MI/N2jOo1i6F6I+yzJX6b0+AAFz
	xVVQl+iSmEIEvcWF0feHhXridQblP4elB23ba/sqQ+SeJn/4Ip9z8Muy+JauAhRXjTvaJ22emYQ
	l6bqwnpvkVR6bkMW+jjszDOOUf4TkeKVzhEcSpoCMXKxZ4Z2iCNzWZ0xy4+8pE9lhML81UAZJZI
	sZp1bkDaHYICbdoUu2n+/BtWx7ImYavsHgBKBmFCXYg1XE9eCRFfkY=
X-Received: by 2002:a05:7300:a287:b0:2c1:3f85:747 with SMTP id 5a478bee46e88-2d5894628demr646992eec.21.1775783534159;
        Thu, 09 Apr 2026 18:12:14 -0700 (PDT)
Received: from ?IPV6:2600:380:873e:380f:e9e5:ea98:a905:9cbb? ([2600:380:873e:380f:e9e5:ea98:a905:9cbb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ce46a65sm2198745eec.0.2026.04.09.18.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 18:12:13 -0700 (PDT)
Message-ID: <24a86901-18c0-4ca9-89de-92f4fe131fe8@kernel.dk>
Date: Thu, 9 Apr 2026 19:12:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] ublk: followup fixes for SHMEM_ZC
To: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>
References: <20260409133020.3780098-1-tom.leiming@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260409133020.3780098-1-tom.leiming@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 7:30 AM, Ming Lei wrote:
> Hello Jens,
> 
> Followup fixes for the SHMEM_ZC (shared memory zero copy) patch series,
> addressing review feedback from Caleb Sander Mateos.
> 
> - Widen ublk_shmem_buf_reg.len to __u64 so 4GB buffers can be registered
>   (the __u32 field overflowed to 0 for exactly 4GB)
> - Verify all pages in multi-page bvecs fall within the registered maple
>   tree range, removing base_pfn from ublk_buf_range since mas.index
>   provides the range start PFN
> - Simplify the PFN range coalescing loop in __ublk_ctrl_reg_buf
> - Replace xarray with IDA for buffer index allocation, removing the
>   unnecessary struct ublk_buf
> - Allow buffer registration before device is started by taking ub->mutex
>   before freezing the queue (same ordering as ublk_stop_dev_unlocked)
> - Address documentation review comments
> - Update MAINTAINERS email

Applied, but I'm unsure what base you used, I'm guessing your old base
rather than my for-7.1/block which already had fixups for the issues I
mentioned? In any case, just ensure that future updates are against the
actual tree, not on top of your previous tree.

-- 
Jens Axboe
