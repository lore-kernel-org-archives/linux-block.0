Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28E20D4E2
	for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069970; cv=none; b=RiIQ7eFjmrWiPgFI60Drj5JgXD7kSItMzswte8GTTKTWhSL/r8hR47Zl78wWfGhL9oEV/B/bWaNiGukG6MgyIFn8ydKZCQEXq2E5sHcTmD5lHgKbPqPJaG3kP9U1kyMy+4l+OacTpQjSqRFwD7rE85Ncf5ymU2BuixWdRRng/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069970; c=relaxed/simple;
	bh=Q96fH2ufnyrRSkdVqFWpIfJckWGdN24HBgnQJQFk4P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJAT/37s5MITxtNGa0dJ3XzIRbEwpCqOypgRWL1ySyFmkc/OgPibOnyVA0orADpsANuqCm4hG+ju4IFNoZk3b+Xk2F7oHndw/XfbiADAmzaucoAo0lNTytBqUjP0UJ807pF/cWFatZkoQAfcuQN7oQXrbXENfVrcEuisXzvO2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Jw2lEOeO; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Jw2lEOeO"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d19f5ce8a0so3526185ab.1
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 08:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740069966; x=1740674766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rh4eTXTu+c11RkR0T9DFkG9ZleZyfYRGduufAwusFKE=;
        b=Jw2lEOeOqtUCX24vu+Jh0LDfwu6zr2LDOafKLp9WXTaTnAbjtai/gChG7SmoUIkVMu
         ndEVVTLqlYRLW4sJu1syFSw1Sx8PcfyPaTTNdM6Wk32jwKxkEm+b4qriHBwKurV+1mAf
         jHCC5/OvIrnlnG0rF4VQE3SicENiTBdHK7cUPWh26garY/KyZTb2+SEnCGXuVmVMkc2V
         D6zJKwVKClWXK8xVGRvhMioWfiLnD/81xxF0wgfkItPRHeCC5ciFjf+NK4YyXXRruyNn
         zVR1Tp7b1CYjmcv+WfODQqO6SwxVDWEU5QU2hNRGHrJ/cMOG726zb+oWPVYfBa2mTrD/
         UBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069966; x=1740674766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh4eTXTu+c11RkR0T9DFkG9ZleZyfYRGduufAwusFKE=;
        b=QYNqCaJbJpoZsFlp4f8UDeRKFfuB66loGNjAqd1yj6lskhqB6rsi10zwQkNF9SiEoz
         mmLJzfnaErs0ySEtJqm6MQs9j3Q8YaILEWuWZmLZmPOyQfA3znq/rf6oNOtWanvpP5rp
         TB1RdqemBD88hPY1T2b7GXn7E152cpe3+43vON4jsA4nwnTII5ra8YnHbF26BddY0+cz
         yu0PIGpaRJUbPfcENEhkXKNbSEVzBYXTwUXwxeqXcBiwGGRpiiy2oibIVG6n/HfIOyUt
         sKqx1rg/d1mCkHx02QQMTPhcXGqsqEPUzX2K8fVe/5+ujjJhegoPwQmuxONeQFbQGdjj
         3g7g==
X-Forwarded-Encrypted: i=1; AJvYcCVmxzmBpJnoUTO2Pb2HDmRp7xL3LYzc5+Ev4qD6B8iAQ5iuG07lB2189aEmgCBXWzf2zLUA3uI2zINOYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQrTqJUDR7Pf7+nT7rN+4V58M9PUrZY7CNPqoHkArV0UruqGl1
	kVsuupNZGg72mr5tdD7RRqHxPLReK8sbHQbF+igsA789K/n7z9gwOk/CCAiwlAI=
X-Gm-Gg: ASbGnct5D1I50ra6TR87zJ9iCmh7+r40Me1ENXyTVJoupnRr/Ps4u2qngm53GRVHNzC
	NFKoEsVTk2bbZCyUL2OCZsKiUc5LGU8A4o/bIMUSwHXXfBLhozgPOrpa0EA6OYWB3ADTIkd4ihA
	S1AL5frO+dlBGCf/u/7WQ73RWqfj2uNIvNmCDQznoT8Q+c8EFwlNyOJDL5XYw5GwouLA0MUGoXs
	QmaeZerpmgJWxHz3KhRnlCp3hcr+PaWz7BVL4tYIAeGWUHvE5weUh9ahVcdo97Modpjjof6koSx
	fB/X87JmW5g=
X-Google-Smtp-Source: AGHT+IG+EYLLqM6THWYE8hAauMhRAcU2Nk6bktOc2WtjLtNwvqYq1DbYMyEayXYWgyo4XXN/dzNAHg==
X-Received: by 2002:a05:6e02:12e8:b0:3d0:26a5:b2c with SMTP id e9e14a558f8ab-3d2c01cbd32mr32793245ab.8.1740069966144;
        Thu, 20 Feb 2025 08:46:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee9f935135sm1841325173.42.2025.02.20.08.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:46:04 -0800 (PST)
Message-ID: <d178e65f-0168-4046-b516-1304db75820d@kernel.dk>
Date: Thu, 20 Feb 2025 09:46:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250218: arm64 LTP pids kernel panic loop_free_idle_workers
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 linux-block <linux-block@vger.kernel.org>, Cgroups
 <cgroups@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-mm <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Roman Gushchin <roman.gushchin@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYuVngeOP_t063LbiJ+8yf-f+5tRt-A3-Hj=_X9XmZ108w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+G9fYuVngeOP_t063LbiJ+8yf-f+5tRt-A3-Hj=_X9XmZ108w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 9:13 AM, Naresh Kamboju wrote:
> Regression on qemu-arm64 the kernel panic noticed while running the
> LTP controllers pids.sh test cases on Linux next 20250218 and started
> from the next-20250214
> 
> Test regression: arm64 LTP pids kernel panic loop_free_idle_workers
> 
> Started noticing from next-20250214.
> Good: next-20250213
> Bad: next-20250213..next-20250218
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Should already be fixed in the current tree.

-- 
Jens Axboe

