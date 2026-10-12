Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC104E80CF
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836509; cv=none; b=piB2bzwPxcu0IB4v4rH0/7+jJT5CbpqSjaUr+zqMXXy2iDqi08Htr+tAJivplamHiGdSeGmmTMQe0QM8HN2OAaA1cffVgUKLZJI5wWb+5ieAT8t9g6G0uc9MANhCNZiINszTKYwBdD0RWqOR7miPtZa9XyBW4wSQaXolf7bDi0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836509; c=relaxed/simple;
	bh=lli5ii/H/rCG9APVq9ZvpYJJiJuxiuQfHiO8zLh8fqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRGo8sYY9PyZ/SZKuql2RVxK6uvEQy7zGV2YOz1HJGX5H+/z8hEZo3M59wu1b6Hu0ggUhVBM0fsV9E65Mf9HqXSEaERGF2fd/sjibKY+2lBJKwefuRZ635bO1AwYtBDswZLBk8EdLcIkEXiQJEZxL5YuTcCFFe6QGHsNa3kzZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=gD/J06PY; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="gD/J06PY"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-823e4047037so1893486a34.2
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791836507; x=1792441307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6hOwSLR8cfh8cDplIOaHfJc8wiTVy6P5jX2Jl3fTgI=;
        b=gD/J06PYlcBk+mVRnraTNFIXOIJVOIGTOcTB1oa30DcyYN2svFooHy20btUglxMoyH
         AEOEeaajtTdi16bz5YWVjnfOIhGw8pVwnpsgsnTmLwBCp6fdLqzotYGAPbVvezyD9W+V
         xG5wVMa//0oST81G134fFyrpHC8Gj/W5sjwx121/kXfuHOXI8q9lU8Ml08zM+CI93n0h
         9wT1MNs+CaI4/JUokTfBkMQRgSBMQPPgE2uLjHbdYK9i+QbIcFR1s4m5uUZrh2kKzDR0
         GK5CNrF8M2H7zwCjmjdqP6theBogcsc4ctAS9pEtv1tFd6RJ4wv2meY2w4x4esC3M2tG
         hEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791836507; x=1792441307;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z6hOwSLR8cfh8cDplIOaHfJc8wiTVy6P5jX2Jl3fTgI=;
        b=w053IeOFewCmBnVUpXAW63Q0NGTrPvYsRWkqwBDnAGcDW3PFO5KaOBJPAhD5gely6w
         1pg5eTdPzWDpafJTU1i/FhbWTWU3H4UxkhuQwoNmfD7smO1qQxSgdUOezsbtK35ppCbs
         W0v9Ry8ePz+q2RXylLoAcpg0CVCaVHbGEO2Bj5lLBPVRMEXjVtBBIZ8O+2l/48GibsUD
         mcMlQ4FtGT2Z5Jdu3bF4C+8fzCxOOU4C24up2m1h1OuZkDOv4jpI6ks4hiR1+NQ5ZUSG
         B/HO5BviOELlpIUYbVqHh6C2veeQrtWrmLAW8J8+aiaALGnKl10pX8Va8Qrv/MkNUQnR
         GxSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIPlQCFc1cR0dr5I16hwgyZZ8Y5YbxXUTWhb+lk6N7d+WqKV5FCRt7KIvJunphGa1nHkargcQQnnOmEA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJKGhNGiHoTOq28Wp+tjJjPrjnJFlLCP0eu2Lf7iYSIgfH3GqDi
	zLvRC4Bh8RTZou/srtZCyKssWKEcpQ+DPlKhFMShdlGNPXYOM3wMjHcqQTmUdT/DsmY=
X-Gm-Gg: AYBFou0fyPBRM+udPUyS13H3vm7mESVLGiZvXBfo/6xfP2AJuMIxSPiwo203fv465VB
	9vWviw8bFp7SeUgEqAZ/zjH7R6TFsRz5cRld1uJ3X5J+heGkjriel9fVyXmyJ/fB54sKCej9eFb
	oRFFJo1X7OirVOuEY0EdMBGM0/Z7eT2V8p3z001z8PtyVCPF4EN9GZZVz+DlFcsnm4SEquql5jX
	HAGAuOcDt2o185OxBqWzSzhqlcWeNqY5szPBuYninZ6POLR4+3CGTaqRSQZdmYM5wr7+WDLn5G6
	hCRNJXdlcnBi4WX/cTtS6DTN/ggFt+MabWaQls/Q4UG7wr/8+pzuHcK3EgytaebcAznzA+nC8KK
	S8nNFJD6MzLJl+vzlEhv+m6AtX3Lh30NP7nMNV+KsiWyB25zYuTr2MP6Zv7dqwpddqpiytJp07b
	Frb4n3e9hqhzv3Z++KZ1mulmwhsJIU2/A0se/1PsopbDig9QlE4mWIytoJY02fQgH1Yqd8M2tIB
	i1DqdiWv+CRs9idfpPpLGEhPhJalcQCTaLOuRKDl6PnH2PdwkQ+ze66lQ==
X-Received: by 2002:a05:6808:f88:b0:4d7:17d5:6c9b with SMTP id 5614622812f47-50c40a3e034mr9500602b6e.9.1791836506735;
        Mon, 12 Oct 2026 13:21:46 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c167544b5sm12396143b6e.3.2026.10.12.13.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 13:21:45 -0700 (PDT)
Message-ID: <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
Date: Mon, 12 Oct 2026 14:21:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/26 7:42 PM, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a number of changes. Later it was brough back up
> to life by Tushar and Vishal.
> 
> It's an opt-in feature for files, and they need to implement a new
> file operation to use it. Only NVMe block devices are supported in this
> series. The user API is built on top of io_uring's "registered buffers",
> where a dmabuf is registered in a special way, but after it can be used
> as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
> requests. It's created via a new file operation and the resulted map is
> then passed through the I/O stack in a new iterator type. There is some
> additional infrastructure to glue it together, count requests, manage
> lifetime and implement invalidation.

I've queued this series up for some testing, in a separate branch. JFYI.

-- 
Jens Axboe
