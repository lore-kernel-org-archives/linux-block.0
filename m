Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB914A0A4
	for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732896322; cv=none; b=jJy3xHHOMwxM7mxpC5kizWwkeUbZqyYxdmbSPJS8Gg+bVQNiXmLx2RoosSkSYOzNnuiHkLKsNjlBSM09jobP8X+Xw4p8oRoK2hvH4//lUZ3HxkTMC+IbBl09K4xTfpyU3/6veXNrHeMB5M6qhGIewDSA2hQnGly7vCQ9MFgUfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732896322; c=relaxed/simple;
	bh=nEsxp/18XlojV7xxv+z1qsPSDIU2AJO74A3oRe6MsUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VDlFT03qMqExNKYNRI4uxTdgEky+rSyXYxe4OafVNCDe3uydlnrV4JQUjZ4vEN170K9jtoslGlCdVRPoZzIPBEEvVqUxbJjrMVkHpzOLbA/hNa5c652NwlAIpJx9yaJk47DhS5n3nN+VaYOnWRZtCIDSBCoCIIkvEqEuB88qF0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BPRXx32N; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BPRXx32N"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2127d4140bbso19283345ad.1
        for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732896319; x=1733501119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDMgssOalwyZWOZXl7hrTVuU6/CuCfdxnlEES8/8jVI=;
        b=BPRXx32NZB7EsTLftBVcz1z91+lwamHOtiV4cQayk7BNVwoWlidJ28xzE+gjQZiXig
         VkFt5lffnB+zOBEoZSVH8kwt62ElN2OFJHlF0YN8cDprBLMtsynIltPk0Y+KzBgklNzw
         k4ppTRIefonjG6RtIS78c0pMu2RCV07YU6XxpUu4bYi0EL+udwDObEvC+5Gqgm4S5Tw3
         evtZc3q6GA7C+CT0h9a29Kj/71gvpI+3AHvQlk6Gy2PBJ7DnFLq3XT90vSFb7SKSuiIG
         tcU1Eg89EvVfBl1riSwKQEh6e5MxOWpWKhk1jwlZylO/NF1S5gZvfikH6WnxWbI+8XmP
         G0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732896319; x=1733501119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDMgssOalwyZWOZXl7hrTVuU6/CuCfdxnlEES8/8jVI=;
        b=Hm736/t5YBCTWC0pYuvkR5JvXD45B7JuU8oC4qKuTwxr0Og07Mx8j2e+YBw5ruUI0u
         AQ8A0Zdin0Nf/5BW6PadvPDA7+CtcWDzWOKx9zRz5UnCAXhPY6J7QFzZtzSsvnCU/TUz
         cMZSBzHu0nriMhYbjL3EcMxQ1sWp2Sd4FhLHL5FyxYjleGIHUQfBojb/2DGD+UYcPevb
         0+fO7+YliBN2UotCmE2a9sQKeMl8aZfgOiWasPohdg1JhoRXBuE+xAq/Lig64eQsNudv
         eWxe3px0lwglxAuHAn4Dy5aFtcHoPGAe50+vbPb3VXTJyH9q5ZK2KQcD331qAf4ixX2U
         Sn0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVthYuN3phJbMa+pEIabO+jc1VwMrgHf3ORV/tcKnsRwDe2sa29qzusBYXgs+lMXb6271rFq19l8/7/pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZwXrcanZjxoKLT2RFWO12l/5zrOt1ssytzrD58fyAst1zxhX
	Rip75ai77H8YSO1RCRovv8/nIk8US5+ycOiIWupXNJJfIfp/sHD+imgGs33stBtyzAjMXdOqUkD
	e
X-Gm-Gg: ASbGncsvIU4Y8iu892Jj7Agd7js4GHuAOsJ7eSuYUMF3o5ZwCSi+95rK8OYjo0JRL+q
	MvvqBBJLjarH2nJ3gsco1lS1iE5eHIxawQlm1pCQtPymExyxSGbL72aTojiI/hBuiHjNpzKcLdl
	nRTga/KD2mCsbITRQPQ+bSf/R0bM4qARN8Q4tb8Tlv4FGVU9DKYBqce9fHY0KlSwlWtSDDo++YE
	34wHPU2GQaL5W63VtNPwG9VHit2VVb9Ts1Ua23SRvffzzY=
X-Google-Smtp-Source: AGHT+IGNqcVs7d31J2KaXvv0IGjDKQlEyKSxrxtya9KXHzxxbHn0zSXA1zK6vVIg2zESlxcP0m5MWg==
X-Received: by 2002:a17:902:d2cc:b0:215:9dc:856b with SMTP id d9443c01a7336-21509dc873fmr137481005ad.35.1732896317638;
        Fri, 29 Nov 2024 08:05:17 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2154c2b9bdcsm8349665ad.258.2024.11.29.08.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 08:05:17 -0800 (PST)
Message-ID: <ae59fa1b-b0a1-4818-bb81-4de09f3855bb@kernel.dk>
Date: Fri, 29 Nov 2024 09:05:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] blktrace: fix one kind of lockdep warning
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20241128125029.4152292-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241128125029.4152292-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 5:50 AM, Ming Lei wrote:
> Hello,
> 
> This patchset kills one big kind of lockdep warning by cutting
> dependency between q->debugfs_lock and mm->mmap_lock around copy_to_user()
> and copy_from_user(().

This is almost identical to one I did a month or two ago, but didn't
get to finish. Thanks for getting this done!

-- 
Jens Axboe

