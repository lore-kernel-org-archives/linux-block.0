Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9282890
	for <linux-block@vger.kernel.org>; Sat,  2 Nov 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730558724; cv=none; b=QFaQqlSZyBlBfYFRmccjsu4mWkRX29cZ2b3sPYjFlmXIlh+qWyHOQIXyw5PLcLfISXMotdmzx3dhGgan8noR8ll5uOl0M3EEYftsDL5m4JvAoSRuU37GOV41/RmdZm5r3TOf40lOPt13k38ZDXvhVk3Do85FNmshuti9TSubGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730558724; c=relaxed/simple;
	bh=NR4/lJyYcVmDmEfs1LZZtR3UCu292JMRe6HTYN9c2cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOB2sHjUST6OtUikB0wyOSN5emhl0MxuQjxzVoC4WhBVaE/m26L81vEnLkIvRk8a/+TqV918cP2+RehudpNOec87j0ws+4DkRCHrOYagoO96uSyLkNt39V/V9QxMkq8QXcInE/HYCO2H3YZ3Qo6ZzJ+1ysqx4w5WXGCQ2DLbmlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rkGXyjn0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rkGXyjn0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720be2b27acso2215967b3a.0
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2024 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730558722; x=1731163522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lw5gpO69AvE6tiialPAqMUca5KLxdrCooMsgVemIQNY=;
        b=rkGXyjn0ysINAjToN9f7aBpS8FsE0L+nNjxEgaltqJxCGMVY7qMMQgIRCR8HFcTrKX
         K3476mBPSTKaEGlIbxTKie9a1p3gF71aeWfceE4WHmB7Woweu6Jtny+SRPju3fGUtP6q
         rXVharK9/8tGhGr2SHN2AO215E80m+YW9ROUQ6kzPexX81f0BX4T71WBOQoK9xrXQjCk
         GC0Ihs562n1J8pXGo5PZS8jIyarA4B6+mHYgf4tUoWh8XTrzY98T/AbRVOY0aoJlaO1U
         uTem3+T1M48wUKm9ig/aIYAEVcNBqo7NVGS4VkO3KnFm+2439g33O0DorCa15Ac6vfbb
         JYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730558722; x=1731163522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lw5gpO69AvE6tiialPAqMUca5KLxdrCooMsgVemIQNY=;
        b=xR85QwfANQvpU9IOrnTwSNO2Z8ywvBedXF2v6FDmm/v729ClmfFZP5bY5NKDdIV7B2
         3bKSjXj1jDxzTWhWKk5fEZrCoD7eH4toWAB+CiK5Xo7C6Nugor+PSDcbI3ecVaSP2swX
         rzlRZ7mO4B0GLHFIFf822ZBDRvmX+9joPFolcE3o4uha9rsO5uQ5xDOcc86utM3IBCtJ
         c5Rfj20XBfTVNTQ0u5caYFUZLBABABK2RsQt52G+nT4BxXKoYQh0Zlfick4LEqJtRKZm
         K2NMFy2PcGvTmjf6sQK6SXCrVVxYwXPwum1WNU/pqak7/mfgx67F4bYLrjlLUdO8/YBM
         E3hA==
X-Forwarded-Encrypted: i=1; AJvYcCVa7b8ZWxgxX1c2Eicl96+gis8XAdkcM7sGsOK5jYDH8GPi3/gMJ9hJBDxByJFagWOjDWUWjk8zpK9GCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWlyAr3vI7wa4uvppkAShRrBGG3YSneyDVGb9+p7GMhDyiez/X
	RwUT5ww2BjcJTQNKeM6GLD6NcuYJb0bmhtZoxpasD0y7oUMXCMl6BYv6+dr4r80=
X-Google-Smtp-Source: AGHT+IHNiDASTJSpVgC71p+4nUFyInfeTb1rctdvtTVempQa22fUIdNtOiI46RlOrj9alt2VHzotew==
X-Received: by 2002:a05:6a00:9aa:b0:71e:5b0e:a5e4 with SMTP id d2e1a72fcca58-720b9ddc8f1mr14464634b3a.27.1730558722101;
        Sat, 02 Nov 2024 07:45:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8d2fsm4227197b3a.9.2024.11.02.07.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 07:45:21 -0700 (PDT)
Message-ID: <801bf877-542e-46ed-a13c-bfc8bf133bd1@kernel.dk>
Date: Sat, 2 Nov 2024 08:45:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/iov_iter: fix bvec iterator setup
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
 syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
References: <20241102014211.348731-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241102014211.348731-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 7:42 PM, Ming Lei wrote:
> .bi_size of bvec iterator should be initialized as real max size for
> walking, and .bi_bvec_done just counts how many bytes need to be
> skipped in the 1st bvec, so .bi_size isn't related with .bi_bvec_done.
> 
> This patch fixes bvec iterator initialization, and the inner `size`
> check isn't needed any more, so revert Eric Dumazet's commit
> 7bc802acf193 ("iov-iter: do not return more bytes than requested in
> iov_iter_extract_bvec_pages()").
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Fixes: e4e535bff2bc ("iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages")
> Reported-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
> Tested-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> Hi Jens,
> 
> If possible, please merge this one with Eric's commit.

I can just swap them out.

-- 
Jens Axboe
