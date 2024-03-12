Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E153A1
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206247; cv=none; b=o0duiLmawxAhfp08EX3jaGwHbzLPRaT8DHYgqyLThDqqvFwAolyCfxUVdGY7W/RJOk6aFUY/p81d2duBDE3SW7U5/7oU/iLViPAJqRJ1gD/Udeuvd8IHwrhaiQY0GXGvLK91y4qQVFC5FkEsv3lXJPCnDjH2sB1sAMTDF1fReD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206247; c=relaxed/simple;
	bh=u+Bn4WlVeHpPdJ4vYubmMVkm8KzxyZ/MpVfHzUdQxiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjR2kC1WckQjczZRImZZNCZsX7Nd+0RIVDF08xhidrhNN4utcDJcuboaRK/lEU4it9sBARksFS9DpUPcIPSiMiHE8m3NomcJPjyYecTEg2kdfl+b+xCbFTD4hk4Q9VyzlfbQqhIwZGQoK2tdrSMSa2HVyt7xlenjpuRU1NyvWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PUCWU4CU; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PUCWU4CU"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cfcf509fbdso1902482a12.1
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 18:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710206245; x=1710811045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unjfK9U6O1ghBRID04DhiaXDv6AjtwuYdgy1ONRzG2Y=;
        b=PUCWU4CUM9QYi+JJV4tqZAwEU2W5/Z8zYpvxbjBKd2Tc2ZpN/aQWpFXTV/96OsoO7u
         6/KMF+Xt2DDLs5/qgHpbxBErnKNBK5K54HeITAAOrvMSuHrPVOcBwtzwbnMWGcvE5veE
         H+GSt9TqM6P7KDTtVwlTMpmcezRi5h5Xm6ucOBdkXlWy+U+B2SQtJKqyl25la1ZoSrSn
         pZVGweKqWa7oGyAs8BtB+1RRiG2+u+aU/WHJYUA/Q83L5LB+V5K7BIZP+vN9xZluCPFn
         vluCiDPXa9oqFn1CteDvIelZRv0nWwvcaNMzYNg2appzsDD22JghoykAZIOushWcsgLk
         JVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710206245; x=1710811045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unjfK9U6O1ghBRID04DhiaXDv6AjtwuYdgy1ONRzG2Y=;
        b=nkkMUmj1F1AqggZuwiHG87u7K+p7zhPj300uC5/q3PaeMtSEY/rB8bgwXM5U9kWQ1z
         gqYrR+JeAFNINWIF9d7dhaT3R43TyDgEJLwk3EGJMc80J8Ev7T3vUpP4/xWnbpQc6wHt
         G+PJGvkPhnWY0qKmEt78TiMClf3We89LUrVuWqxnyIl3DGhSP+3qjb2sF1Ihhxkss6YL
         P82pZusoaVh8TZVx33i5CQxVMOkTuBhgglNf0DRHzhlKZna4yf7NKEWm8vLo+j1zdsR+
         MONN8OzeF9395m/hmTq3j+fspQDDYzhb5Rgz6brfRqCttwV1pTvimZX2G8kNszXtUlsJ
         71DQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3qHaXhPp2ak6S55r0Wt2qS+vJ8HtC4rEA81iMSlLLwang3YeYW/W4isWSVXSQRvb4zmdhz5z97USFJny9nZUmaAjmsW3sXlUvi0Y=
X-Gm-Message-State: AOJu0YyQcVk9OOmwK/KXOTj4AJRhnvCzo+B162abuU2qK+7TK6YF25UW
	RqoAxa0ax2o4t30IMXV8LpfNky5Tesw0BNeZtlxiaYToWBe09i59PKa9NZ6GIyM=
X-Google-Smtp-Source: AGHT+IG4bfMzNr3iVyXhsycnJAxpbAOeVbQHQjmlPXqhEnKJk7cD02xvrScMkVfqeZZNEyT3RhMRkA==
X-Received: by 2002:a05:6a20:438a:b0:1a1:49b4:75fe with SMTP id i10-20020a056a20438a00b001a149b475femr499904pzl.4.1710206244862;
        Mon, 11 Mar 2024 18:17:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001dcdf2576c6sm5379355plh.3.2024.03.11.18.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 18:17:24 -0700 (PDT)
Message-ID: <07ab62c9-06af-4a4f-bae8-297b3e254ef5@kernel.dk>
Date: Mon, 11 Mar 2024 19:17:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com> <Ze-rRvKpux44ueao@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Ze-rRvKpux44ueao@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 7:09 PM, Christoph Hellwig wrote:
> On Mon, Mar 11, 2024 at 08:28:50PM -0400, Mike Snitzer wrote:
>> All for Jens being made to suffer with dm-crypt but I think we need a
>> proper root cause of what is happening for you and Johannes ;)
> 
> I'm going to try to stay out of the cranking, but I think the reason is
> that the limits stacking inherits the max_segment_size, nvme has weird
> rules for them due their odd PRPs, and dm-crypt set it's own
> max_segment_size to split out each page.  The regression here is
> that we now actually verify that conflict.
> 
> So this happens only for dm-crypt on nvme.  The fix is probably
> to not inherit low-level limits like max_segment_size, but I need
> to think about it a bit more and come up with an automated test case
> using say nvme-loop.

That does seem like the most plausible explanation, I'm just puzzled why
nobody hit it before it landed in Linus's tree. I know linux-next isn't
THAT well runtime tested, but still. That aside, obviously the usual
test cases should've hit it. Unless that was all on non-nvme storage,
which is of course possible.

> So for now the revert is the right thing.

Yup

-- 
Jens Axboe

