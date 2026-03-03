Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA7397693
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566648; cv=none; b=FFd6Az86wsxRoO7Afn0Os6KK5kGEmwvMBh/fwnCLPm8rtLdr6iFxPi+AldczrHPJ6En/xhkCfzQTjEbZp5bDawzvnG5P27GiwNRT/joB+hLVEcO8GtOzl8x1cxngFGPaeO+jvJgJD1UeFiALcPxipqQGOnKzVGoLS7aWPsHl+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566648; c=relaxed/simple;
	bh=sIHV7aoO6L4XZzMdh84TSY5dprLzfanCk/w7dZsPvEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGjYjbiN5qm4E0ktI65vkVZ/+irYbldAca9gSJBs2wzUniG8fzH0QNHFgNv4KpcdNpawqFRV0e4XtKsL6K43jGlO687XsVXOBGMDmZQOXkANrIuqXbf3bzmhhwnIvRnKba3qO7lelfAOQMBd7fea+pght2IdedZXR0pE3Aq1te8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qGPixjXY; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qGPixjXY"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89a133cdd4aso6881136d6.0
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 11:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772566646; x=1773171446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1T64qFnvXycVGrtrFxLUYBkPwWQdDHQpwifr7t+iMQI=;
        b=qGPixjXYy8s0wv9myTVTwlNLQYQAwC2INVRVog6y02LINA/QaUaMBas8Ltrwvjz3yj
         GFBcvc3tO/+ZlS3a2rm6JHesnqctAkvylwgjXd3UmfNF+Wv7rZCVPQ1QAKrLaMUNGjB6
         bO6AjpA9t4Kz2LkIdWgt9QjG79qLS7yH89lOiXnfqrPxJUs04XzeKinH+ZGzOeytQVqD
         LzhfDDYlDmnMDq1tZxnRIE2E47LbOaUdZxv5Wg3G2apOGEDr4bl/wPt32Pcaqi9DRAGR
         +AbabXhlf+Oji4JZyJoezI77HLP/61Ls1f4jH9TFb603iUG4rrih2yefkCgbHt5u5kYy
         kieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772566646; x=1773171446;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1T64qFnvXycVGrtrFxLUYBkPwWQdDHQpwifr7t+iMQI=;
        b=nl7de/lShIhxxUvJunBYmy1l1goa3UoLQ5jWqdXPLkCGZE0nBruMszmAAXSL/1/elB
         f/+2pW/QtVwFNIyKH1QAh6jGRNv0lnh8JihzHX8i3tbyjELMg7fADkdgvm92CaxdSYmf
         rC9LWzrLEQpnZoSRgjS6nViedsfgJkquDEen4/yFV0DZwSZcpzuqh/HHHCzWtpOc3JYY
         OPk6UEmj6lmGsG6FJ/KBCs5AYgR/B3t+rpLrqIxAaoN1aJiwMlvuvvbv+SMj61KAvrxs
         pfpCcz52YiAH2OhvwL0UUxey+pmkuKxgE+kJUOz3Hh5wwmY21lSLKdiFzRB5y+fDTZ5T
         b9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX4wj+mDYqc0s4VE4KUbTTQs2c5Ny8ma+3ZTyv7RFPKQMyPLbmmDIe+bp0G6FyUPMbqLygo3uHb4KFA5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRK9m8lXe0xXR9bPaXFa1te09AM6qHSFR/sMSylWvYU5e5ugNJ
	Lfgv5A5GA3ybA67GQm3VaIdSsmmVSV4EYR354fEAPXKgqTiZpw2+p0V+TEIKGfE9djQNz6LNzaF
	aVs0GgkQ=
X-Gm-Gg: ATEYQzzbWV+9Fla/rTVhV+KaZSUwKahUp55esY6DtORWuWmCjZz8LtDHmssoJ27YhNI
	BYe0uCiukSGEKQtDf+RV/+ig9Y8X/FJNYKDwRKWsTdftOCd5KKiDOzjP1lz5PytzlHdsCizykPk
	cmv6gs9ON9lelavP8Yy41XxuAic/xHT6rVxxcDkJVzLEiwZsU+MwiLnctxD7TYaM/8seaEnX1ki
	5T079jEiVVc0cfA+i/6B1UOKyk77LEbGFD+dZQK05f5Ew6Bgw/zcEVAQLAxqNKtznG1X+riMQlW
	WEYwZniGgVBQBLqb9GVUQth2726H4EYADo4dv2DbuoCMKKuyyb60TFxM8YqEz2uKtVWFkCExhmc
	T8SAfTpogGcAedvpJknEz13C+mjrYUvgbz0v6ShbJrjPxucA/3q3K8o+9/mDPkBruNw7wb1xRPj
	Xu61bHyiHDI15rKzdznMSP7FplnaFuIdPKlc2NQZVbcasHlPanpfbUM3TyIodE2ACRvS11iwyKI
	w9rdFkg
X-Received: by 2002:ad4:5d4b:0:b0:899:b42f:9de8 with SMTP id 6a1803df08f44-899d1dde739mr255048006d6.27.1772566645798;
        Tue, 03 Mar 2026 11:37:25 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0fbdbcb0sm17369666d6.45.2026.03.03.11.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 11:37:25 -0800 (PST)
Message-ID: <63dc40dd-3a52-4e72-af47-c59d12b4f379@kernel.dk>
Date: Tue, 3 Mar 2026 12:37:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] mm: Reduce direct reclaim stalls with RAM-backed
 swap
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Matt Fleming <matt@readmodwrite.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>,
 roman.gushchin@linux.dev
References: <20260303115358.1323188-1-matt@readmodwrite.com>
 <aab0AFAgAzBi4jO6@linux.dev>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aab0AFAgAzBi4jO6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 7:59 AM, Shakeel Butt wrote:
> Hi Matt,
> 
> Thanks for the report and one request I have is to avoid cover letter
> for a single patch to avoid partitioning the discussion.

No - cover letters are ALWAYS fine.

-- 
Jens Axboe
