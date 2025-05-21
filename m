Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331133DB
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859495; cv=none; b=TwF+lqrQAw2Cg1yKh35C7dNmctc3pYcz9dApfxBbMzvBdF+93iSgZ8z9bb2KRYfC2S4e5TCIt7nkGw1b6h90ynT5YsAO2S3w01uv1EAoAstPdro6XjT+TtX1+7c/UJGZmFpqq772f1C1T5OzNdR84QorHbRKX9+2dPAc68deM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859495; c=relaxed/simple;
	bh=c4TViiXmiaEuvoO6sVS9px+7WTtEMeag5GH3xGD3JJs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IJ/O7HsNkA8vF2LmdgdJz5YKsCOrj8bZMyBfgvf4eFsH1A2+7utROeY5tpbUWY9VNpjKjl818Y/cle1Mi8nuG5fXxVK2AO8yPUQz2djo4UdnYIEbP3CoxXQMdylstcUucw/xHtg5YtcQIWqiHhTbQ5GDQsomnvtoy0r+bUD+/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JnPFInoN; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JnPFInoN"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3dc83a8a4afso4298135ab.1
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747859489; x=1748464289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=og6cqm11YaoVV0qWb59/Lcgx1/XMSPY8hm+GvVFA2Yg=;
        b=JnPFInoNBJKBOuDy/9YM+vnh7gZt1IsxtjbQM4dTYDq+T64RCkHRIbaNKWtMtSRv1p
         zVCfGhvUYUgbrFpeqgTs3A6AsKZXuvd7ZnZpk8CGryjjZBJ6AFOrSTom2noWrguwTlmZ
         WakCOBD8DodZmcp6JnX1l0s10PR6Eiw5BzwmSl7cQV9/dSwI826HOhnDs3y0dEVI3HBe
         7FW+3GBMtO5kMizTdFdVi7isSlpuf9uFVHlUUK1NvEck8eUL3y4EDyLhPzVG0EJENcUD
         +5QwnQpgXBOb94blMXTjM8PKsDDt9vd42+UAwVuNeyo3AdjRiCql2ocQVAqY+tXfT/1r
         w8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747859489; x=1748464289;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=og6cqm11YaoVV0qWb59/Lcgx1/XMSPY8hm+GvVFA2Yg=;
        b=qxDWYtpoSR6j82zuRYzSXRvLAzxAgAkhNv6vz6USLHpDL5kJZhpV2dL7JyTXr+AmLY
         8mir6MOcRM/ql60JNpsa0qvCLvwD1b/oQsf2dNqkSX1cq3cbGgZOgMOiJgaeejdTa7bw
         RBOg8jVUUWGqyrmVKwHtj6+iJGBdJc2sQcZSalrefpEDaYRbBzxByVNQC+YHwDAeBCKL
         5pWpXHBqvUpqE+LXveZ1bF5isiWGKS8k+DrbrW87tDW9PLTt31nsOSXO0e4z82P1I1QX
         XmxHhetAyGQKhpo2U66Q0dtJhSO1SK8WFj5Gni4lH0Ikx5ujTM7LVwEImJ/SUHxTEiYm
         n9Vw==
X-Gm-Message-State: AOJu0YyRAZQh8O2njja/nrO1TZm6hYQiublpcFzPqWhOVFR0yG5iwWJ4
	cCgx9wzdx15rK5+BT9+sVRGw2Yq6NlGwKkT76gaNvupWYsn11uVEfhxp4KQrqjvSGwJtri8QGv8
	y3kc3
X-Gm-Gg: ASbGncu9EIUd0p+PanhWyE1ixbge2yr4OhwXVUpNmKcfol2KeWsQVP5kSXWYmNugwKu
	zYa9PawOmy6CuxULIEpAgguiH+dwJXREiE+/u5Iw5igWVChDGzH5gdAUDUbqpKUHyj5TSW7xxo4
	uSlOY69gOaxpcivhd0dzwkgw0qv+lq7puI6TF3ds0H5Y+OB+tYRgQgsKW3qVfXD4bM+rlnRClsD
	eAJA+iBkl/vfvj2WHO4unUdyopFMo0luXXR1H5yTvHndvsAhtHxjq35v0Nq+ak7XmHWUpHk+RkY
	4Wv3r/IDAb7sPZNBLaAFF4ucKlX8fsDvP1OXJsFbHChhvJlB
X-Google-Smtp-Source: AGHT+IH7ceuTl4hlxh+hVo77+Y+JjKAXxRmRB+IS6n52Ouy88Ukt1ky81kjqnGBGI7SGC03FygSTFg==
X-Received: by 2002:a05:6e02:b43:b0:3dc:7c44:cfae with SMTP id e9e14a558f8ab-3dc7c44d941mr69978635ab.3.1747859489143;
        Wed, 21 May 2025 13:31:29 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8693cf0asm4032645ab.19.2025.05.21.13.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 13:31:28 -0700 (PDT)
Message-ID: <b725e99c-d36f-484b-8281-284cde78334a@kernel.dk>
Date: Wed, 21 May 2025 14:31:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ublk: two fixes on UBLK_F_AUTO_BUF_REG
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
 Caleb Sander Mateos <csander@purestorage.com>
References: <20250521025502.71041-1-ming.lei@redhat.com>
 <174783310404.804195.9704387738908088189.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <174783310404.804195.9704387738908088189.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 7:11 AM, Jens Axboe wrote:
> 
> On Wed, 21 May 2025 10:54:58 +0800, Ming Lei wrote:
>> The 1st patches fix ublk_fetch() failure path for setting auto-buf-reg
>> data.
>>
>> The 2nd patch makes sure that the buffer unregister is done in same
>> 'io_ring_ctx' for issuing FETCH command.
>>
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] ublk: handle ublk_set_auto_buf_reg() failure correctly in ublk_fetch()
>       commit: 5b2a1c40684ba59570b302a56de31defc8d514ee
> [2/2] ublk: run auto buf unregisgering in same io_ring_ctx with register
>       commit: 349c41125d3945c53f2c3d48d7225dbdd2c99801

Dropped 2/2 for now.

-- 
Jens Axboe

