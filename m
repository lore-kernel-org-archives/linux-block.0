Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A951EEE6
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323730; cv=none; b=F7xzKqySfScCBR3i4bluKRcMgeBJFWipm7FkB1AKN80MoM9rqnMrMV3xaXjQeGNpKYRhiIg+16DHTIsgg3yPnPF/vHIPGvU/nurGIEoIk9tM7Xh4Gvgb5bwaPot8gdWfF6UVvtq8HulR2Jd85yjzUbKJlj3igYGP9ftHmMq3KQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323730; c=relaxed/simple;
	bh=dvWq72TB7xhpi5Znsxf2mwzhz0pav+SXdKg55cSAmGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLKHkecTuxh21N4AwgzmFrv4X+XA5nff/ShgPnIaZJsFlvrDZ60xKD4zD1/31A3/XNtV3i1/Lsf+ASGyEMh80Ky64gTmPBDBnKM+14lb+RxnlZmBX6Uwdf+YFmPBjtXlufpcHIAQHT56ZbbLzAL+PJ1an+xjkF02U7UFFuB4hnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wV2uk9bd; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wV2uk9bd"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d4436ba324so40276575ab.2
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 11:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742323726; x=1742928526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij0v58qA+U174EXbPv213qJve27/DPyy709mQdnkfeI=;
        b=wV2uk9bdltsl1hFqNbuVCTQEjFkIueTzpgkXHc+Tf3sO4Gd0CapW8yTY/bEteByE4+
         3tj6ULv3rP9YZHf9+TN04O5Y7UrVBsVyKNzBuTxt6PpRvSZ/A9YESFUX0lKEyxXJHr3+
         Zs3lLKJih0jH7f1wtqrLbOMkPAMNbYjQ9Cw5BWA/WV5ftDidFvb+XgJsLRz90NEgcHsy
         Zlp0i6hgOvqqnV2pWXPURQmOPlL/PYl1KAzfPAyVhcFLSHStHz0iwUQKNYEQIYs5rki+
         +vFUUrLPLyNAnKmc3X/8Zl90lxwybdplYQwyfSJAkTYS+EESaN4DJIgfG5jNWYRIq18m
         ieqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742323726; x=1742928526;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij0v58qA+U174EXbPv213qJve27/DPyy709mQdnkfeI=;
        b=O0HQ3MXAJ/BGnnd0wtxI/BjN204FHk8LgE8nR6SR/S4/12LfpHv1bSLdocMOrflsap
         DBj9VHoGTgUhI1+8tzh2eW4imVBbsCTnPKZeo4v8pq5sG4jv7WGLigF016ADOXHmSgjn
         3osbq+9S4Yn5pf3/wWzcptaGXDci6KwPm17rnWtu9YH6sNePanhChBn8LJdQa/BozgLv
         +bpCYJUwMXMpgOJL0s3KNNlWSuqvCNbGD3EEMfU6N4t9dcHklN8EWRxPn9PgzL0JVBMD
         nM0zowS23yhskfiXrKnARA4jGIwlXrdiqlj/iCXnHvNIBQpiDLM7rAO1JFjZdxrtGazS
         xr2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmaz7fcWx9LtdWbwwGdPUJyI1se2LcSSGAgd3VKJsJszq22uW+XZJ4bYEi7xo4IuVn6lUeOL3Uxu0eaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJewePtKa/0Vi8LOItukTS5WC/y3L9OMsWxLdlb+fgWA2fzV4Y
	HoFmcWgYNP2DggDOtMBHREKt2rxwlL2LQPh2RHAQ//p0tw8oIvdXr8vzXYRzBD0=
X-Gm-Gg: ASbGncv9m8475iVgJgzWPda7D87K7LKdKCVpPWSFYYW3SLohzmjVHKKV4PyrwnqBIVi
	EnhnXRCmR4wIKXaEw2C1IG0tuOd7MCx4lV/ViSfADt+3bmRin/pYDwqkN2qUdjT9/LTPuUEd7RS
	M/TssIXdlw+XUkaUAUurkDa524RqvhCHMeNsWDIJ5NB680wEgvUS3xgyRoUDXDTukFhrz/UBCUv
	DuN84YW2p1k9Ws5a0svlzdhILKt/d6WaNO2sXMkNm8R89Zg00tBsyXuiD3blmvT1jXfpxuHEDyd
	8D7pYwuqsfkKHnMEUk/JOUx/oJrg0Qia8z+hyfNNKaup0PzywIxr
X-Google-Smtp-Source: AGHT+IHjkERD04qDZIPiGZfBQlC6H9qlw+BlXfZxv9tZ2fniXZhuWz+TUaHSWK0HApbdL36yhi/gzg==
X-Received: by 2002:a05:6e02:1d8e:b0:3cf:bb6e:3065 with SMTP id e9e14a558f8ab-3d48397f585mr169295645ab.0.1742323726320;
        Tue, 18 Mar 2025 11:48:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a83c3ecsm34100915ab.69.2025.03.18.11.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 11:48:45 -0700 (PDT)
Message-ID: <097f0495-b2e8-4938-9a0d-c321f618d49b@kernel.dk>
Date: Tue, 18 Mar 2025 12:48:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: remove io_cmds list in ublk_queue
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
 <c91dfaf8-d925-4f6d-8ced-06ecb395a360@kernel.dk>
 <Z9m+3qMBXgqDz399@dev-ushankar.dev.purestorage.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <Z9m+3qMBXgqDz399@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 12:43 PM, Uday Shankar wrote:
> On Tue, Mar 18, 2025 at 12:22:57PM -0600, Jens Axboe wrote:
>>>  struct ublk_rq_data {
>>> -	struct llist_node node;
>>> -
>>>  	struct kref ref;
>>>  };
>>
>> Can we get rid of ublk_rq_data then? If it's just a ref thing, I'm sure
>> we can find an atomic_t of space in struct request and avoid it. Not a
>> pressing thing, just tossing it out there...
> 
> Yeah probably - we do need a ref since one could complete a request
> concurrently with another code path which references it (user copy and
> zero copy). I see that struct request has a refcount in it already,

Right, at least with the current usage, we still do need that kref, or
something similar. I would've probably made it just use refcount_t
though, rather than rely on the indirect calls. kref doesn't really
bring us anything here in terms of API.

> though I don't see any examples of drivers using it. Would it be a bad
> idea to try and reuse that?

We can't reuse that one, and it's not for driver use - purely internal.
But I _think_ you could easily grab space in the union that has the hash
and ipi_list for it. And then you could dump needing this extra data per
request.

-- 
Jens Axboe
