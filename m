Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77295170
	for <linux-block@vger.kernel.org>; Sat, 20 Jan 2024 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705709116; cv=none; b=rGtC33Tkja38jcWe9oCaeZIDfmjx6TzfbSg6u2F11L3Tt6f9/c8vNUPTtol1z2+bWkl/nvpPyKMmQWHYZDhZNmPb6lNroQXu4rx+xOkj34MA9gquw65rbzdKjc4SOnnrGsQJpEErJ2jk0+1EQ+hVPxVuDUil6gMDOVDC/LbCHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705709116; c=relaxed/simple;
	bh=b5ZBtmo9d8+ijvHi7jKWW5WNBVG+L9mwbFfc5TbOHuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bDJFFcJw52K/b3hKN/LsRqMH0ImDlJMd9oxjzW8lVG364QgtLJmMcbiYJEDL33Kx5LqgKGl2/aXI5YpAj8kxJWiZm6htt4nKcMfeby12zTSN61MU4UUR+G2N9p9GMfgR7IdX4ZtOhPSinsAFeULOBGpx1n4QhJdo8NKf/08nuYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ifHw0TYj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ifHw0TYj"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce99e1d807so216260a12.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 16:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705709113; x=1706313913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJQCKEYagnP3BqjUkOgE65RJG8MYzo0s60jKbBbQWBE=;
        b=ifHw0TYjVFWviC+WIs/s0Xtv8Up6jJGTzXJ78lUHQbC/QDJgfW5SX0FYLwW/dXZnjH
         fNv6oAfyUky8Ho/UDc67wWWSrpiCEMQCVghVVQ4M9TJMT2kTxFVdHEQ/bHhVj2oGdtxp
         9XAHNG5z0HEI4IgDW0VwCrtvThdn3FbGrK51zbJi4Tc9iEcQpOL3eWCwbBiqgMmZItJk
         Em9mMxRlRrmWWpilololGPixciXAxmtJUx0hHoFmLI2YqbjlPwfRyQMt5XJ1G2FTO5yJ
         1emN3iU4A4yZm36j0HPnEn8djvdVvxkMPSwqxvS6kMaCsxIFi+ieTv4O8vXmjbmOhtnR
         A3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705709113; x=1706313913;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJQCKEYagnP3BqjUkOgE65RJG8MYzo0s60jKbBbQWBE=;
        b=f2/9ifNx3+azSl/x7Wxj5aSuE7ASDNcu7VU4O+mOHwLb5icH3mear7o7gElYJgQ5iu
         TslqEHuTMxOIwUYWEvikX8iArp2aJuwG+ABlSPfL8qgd7L0lhvWvD5JTRWx2XxWRJDxJ
         rO+w6vw8EBXkpPlIoVeYMC5OGD9mCcjRllc5tAjhPC2XN1P9yd7fHQ5JWpKQkJd+/t0k
         cS+X5WujCitBN/bOoZPSaLS5WQTHtdT2zpNQGsgQvLcMOtqNt2g3676BfWnbUZ/ADmPF
         3Bqwq48Xf4Pm2MhAGzrm1jYlCmkaFtDAQVCGYxQ6mgP4oqAV2bgwMAdQWtnwFZx5kGbB
         W/LQ==
X-Gm-Message-State: AOJu0Yyaa5fnby0hlJtWZ8IUHTtvU5g1fmk3gjnMgYn0R/fY2x6BBNPc
	r1+aNNIhjwGS7qE97Cmvjdsi4PXVOP+Hp/BOsEVH3WiaiXbzsmJthM1Z9F07/5nPDfchFbe23qU
	jLpw=
X-Google-Smtp-Source: AGHT+IGJ6YT2fl0wzM0J6ZBQ/ovh0YmNsYVdDuP6fdCKv1BrDgIb9tTuBXsU/JGyS+Y8ZiT/UF3ZFA==
X-Received: by 2002:a17:90b:882:b0:28d:c024:be86 with SMTP id bj2-20020a17090b088200b0028dc024be86mr1027233pjb.2.1705709112676;
        Fri, 19 Jan 2024 16:05:12 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090b004e00b0029020be4298sm4543979pjt.0.2024.01.19.16.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 16:05:12 -0800 (PST)
Message-ID: <af2f895c-ee57-41a1-ae14-1f531b5671e0@kernel.dk>
Date: Fri, 19 Jan 2024 17:05:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240119160338.1191281-1-axboe@kernel.dk>
 <20240119160338.1191281-4-axboe@kernel.dk>
 <9bf23380-b006-4e80-95a6-f5b95c35a475@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9bf23380-b006-4e80-95a6-f5b95c35a475@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 4:16 PM, Bart Van Assche wrote:
> On 1/19/24 08:02, Jens Axboe wrote:
>> If we attempt to insert a list of requests, but someone else is already
>> running an insertion, then fallback to queueing that list internally and
>> let the existing inserter finish the operation. The current inserter
>> will either see and flush this list, of if it ends before we're done
>> doing our bucket insert, then we'll flush it and insert ourselves.
>>
>> This reduces contention on the dd->lock, which protects any request
>> insertion or dispatch, by having a backup point to insert into which
>> will either be flushed immediately or by an existing inserter. As the
>> alternative is to just keep spinning on the dd->lock, it's very easy
>> to get into a situation where multiple processes are trying to do IO
>> and all sit and spin on this lock.
> 
> With this alternative patch I achieve 20% higher IOPS than with patch
> 3/4 of this series for 1..4 CPU cores (null_blk + fio in an x86 VM):

Performance aside, I think this is a much better approach rather than
mine. Haven't tested yet, but I think this instead of my patch 3 and the
other patches and this should further drastically cut down on the
overhead. Can you send a "proper" patch and I'll just replace the one
that I have?

-- 
Jens Axboe

