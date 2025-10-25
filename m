Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C929BDB8
	for <linux-block@vger.kernel.org>; Sat, 25 Oct 2025 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761370010; cv=none; b=cdfrRXHiMvTIHbLfLWTIm94+TemGroSCwfWS/8ZL/4Pm4UumJqfHLgVQhgFXws4W76FcU6emP79djyaO/KPrggphQeMtxWzfawVXueVqI7KwxLc/KRuiblsQQzA4/jCQwKmPVGyPyqGPGRjm3KWEVr10umIBp92sld9X5LQ7/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761370010; c=relaxed/simple;
	bh=/zQwfhMEJhTOa5/FV1euV1Dku1nFTDlTsbnBQjlqjDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tqr83PowGCiY8SsUWpWXh6tsXBiZdB5wRwl/SZjHQg4AAZw7m6+HfIQkYAri+T3vsQ/2oCGdZzLQNibbmPCKOwAfda+/3gfgVdZiRK+skkBhR8kBAdX6eXmZ1jUnBoqXPvzAal+KQXw/DLUa5lEi0TXIjXmbVArM+39tbVze2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjvfa8SE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjvfa8SE"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so4945461a12.1
        for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 22:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761370005; x=1761974805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV8buuSZQP0rHOq5S4b8K+cOmbjRvDVQwA71gPDHBAE=;
        b=Pjvfa8SEZbxsM/zJR4PQ+NRDcthojbCwES9h0rerasc6DuX+QlbPq3ReB7mSmCwZzk
         G+RaYizITPByzjqWgNZCCdnHaJaARqKNOXhortmhpG6uojE+a0urH8nCO97GrZMm6zuO
         DdvtNpTMeHn5rWMFFQ7Ju4peQwzCN+8hsCog0MMBRSxOQ39Bv9ts+qL7kuXrPafx2mDp
         gsIImPcmgn6dRmfYObiegOz3nu/ZxylQPh2GOg8+npFQgjOqF89CdQqJEmYiltz2lDST
         DmfDH2jHtwgINimt1F9lgcm6fSLUUT2WEstjXw4+XuAN4I8VbQ5sjQS+kAyiVJ8caOWb
         zu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761370005; x=1761974805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mV8buuSZQP0rHOq5S4b8K+cOmbjRvDVQwA71gPDHBAE=;
        b=Mc81npCATWzSgd9MUjEBP/iIJEtRvtkU0pecmoemb3IdXOqgRWDt1Tq4OI7CkxOYO4
         dJVISRmS4v/sPbolDg+Z8uHy+lmj6f2UG/TCeSzrVYR/mIzZi6oFcdp1dSvWt3xw3mru
         ZT1sgpGfcjDShVyZGL/2CBtfRWX8JXUlttZrhZoPHMOTIe9LN4kbwRqRUmUPzuDZCidq
         nE2SrVr4NS69pZTyClc/xscPYfrPxJSLBU+0IFKbDMxKK22AQXP/WqU1r1E4YyReccLq
         Or0eAaHJS40/+6CMH5N4zrS7jp07lVB39ZBRzEQOFH1Hqxom9Zlx2t2QudA1hBFFUAds
         NpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfz4eatj2bW2ngJKE5MssR8AFLSU8mzoillZssVpMz0E5qyI6mZwWykWyEYRS8IPYPwlWQkyr51O/ALA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrGVzpEptE5TzJEiKLtOFb7SwMPXFPJDWGI4n23u3CkbHP4rd/
	kKMNmYnM9jckErVyMi2KMUXUMQD0e3stP1+KJyLNi8Aches6qBcphi8h
X-Gm-Gg: ASbGncsV0UQYvtFYMCqIOJ6BgC5hankuQqneakMEuashx5kJk7lRy1GG+H8wqFyZ6k7
	hiWULIXZfB7WUDlC651Ko3RYC5ApZPRtrc1t1sa5avTdr1szfvpE0Ixw1vawkZQqhJ/XkE+X/u6
	PxTHHoCFEJ9KDzwoqwercnhOzEheWdnQb2SKDhtG8OiCuu4GCqp61QaVt97kJZZRuynnOiDBLPP
	WsUDQnKGIuSVtFHS7yY1Fnoe8rU2l6trr8Z6X86+XrFCuDFt7CSOXlLSC98NtnMAqXGbW5s6gML
	I0QNdOmJCUpXDIyVpX9GJH3Qn8PnPwpucLaDGBj6WxN0e4ash+2pc1qRZo9aBA1mQucliV3+y+J
	BZT26Wv6ey4yu2ubLLQe2EA2F6lXT5LlDQxGPMNMkUzWdf/iOAcc7CZNInGo2WkC5nZAR0xyk05
	zOM4LSWTyjfHI=
X-Google-Smtp-Source: AGHT+IHk4JGeekekahtUg2k/EhAC9kyrxVTGjCsIExfHrDtgIcN62P8FCtHZWZXypDamfyJkpyvf/Q==
X-Received: by 2002:a05:6402:40d5:b0:628:5b8c:64b7 with SMTP id 4fb4d7f45d1cf-63c1f64ec00mr33191598a12.6.1761370005212;
        Fri, 24 Oct 2025 22:26:45 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e7ef96105sm880960a12.19.2025.10.24.22.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 22:26:44 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	brauner@kernel.org,
	dm-devel@lists.linux.dev,
	ebiggers@kernel.org,
	gmazyland@gmail.com,
	kix@kix.es,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: dm bug: hibernate to swap located on dm-integrity doesn't work (how to get data redundancy for swap?)
Date: Sat, 25 Oct 2025 08:26:37 +0300
Message-ID: <20251025052637.422902-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024163142.376903-1-safinaskar@gmail.com>
References: <20251024163142.376903-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Askar Safin <safinaskar@gmail.com>:
> Here is output of this script on master:
> https://zerobin.net/?68ef6601ab203a11#7zBZ44AaVKmvRq161MJaOXIXY/5Hiv+hRUxWoqyZ7uE=
[...]
> Also, you will find backtrace in logs above. Disregard it. I think this
> is just some master bug, which is unrelated to our dm-integrity bug.

That WARNING in logs is unrelated bug, which happens always when I hibernate.
I reported it here: https://lore.kernel.org/regressions/20251025050812.421905-1-safinaskar@gmail.com/

-- 
Askar Safin
