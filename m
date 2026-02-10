Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74430F7E9
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770696634; cv=none; b=MtZp7jtAeUc45mywEiRuPP5MNiXZzPQEzUMs500Qckv8iBDmvQNwDr+w7cSYcgxYeGfEzFCYURSVRbntbdj9gej0U8tUVJUYMXlbmQ7wGxzO1jx9yMkEpzqprlRvS8vwNg3z/6XAxfCXRf2zAfhQgNLXKbFii/RZTRYg3YnWqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770696634; c=relaxed/simple;
	bh=v95coYCBEj9D7alqrTv7xxW8TNrcUtrwwm7osjxxiG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK9OrNi17DJHMTscmh287qvqKVaOj8ysMX4eNoD/+IB/sUmd1C7lc4/7mK3U2q6dG1tAzUGuTDnwiUnFcdeTo0y6zwdiovyPmSH8+As1ZIE6tDNydGhIgt5w3pcg7W2cRhj0VkW84Pt94J0Y5C5ByodGpt7zxFMm8I9trxFk6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B1N5TNRy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B1N5TNRy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a95bfdb31eso14281955ad.3
        for <linux-block@vger.kernel.org>; Mon, 09 Feb 2026 20:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770696633; x=1771301433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mScTVjrr5hgqDSceepZk2KFe97cs6wupSJIij6NU0Os=;
        b=B1N5TNRyZ5Kt3U8/BrHAaC1nRXPhJTjWq78jmOnJ5ZRUf/fSIfwu5lpUlZ9AfV4yOw
         WSvWGe4UUGtnhoHN3TJgpsTO+8o4pfQDDCt7pzTCQHqbEkNdBDZIhpkZQgUKKzlrVCsN
         838anfPCMu9oD8C4skV09DbUsy+8D+7UnFqLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770696633; x=1771301433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mScTVjrr5hgqDSceepZk2KFe97cs6wupSJIij6NU0Os=;
        b=H4B2w4R2UfNiv+CEj9eVrMNfmw2bFHWLVurVfHRH9mifrpl3/4mA3IRRz/HfaZWdik
         rGdXmXlAspmX12yYgxDMz9On+ePmwIKhZBlLvvYb84gBZT8tqpCHw8SZSQcTIUKRwGrB
         /m5MVOI1Nkv8fFh+R+HKU+leoHOa0VDVSpuJS4V0Tal88aukLDIlagDUiUk8x7zhjz2R
         MTabg5OLVCRV5+oPdjkgtn6s7ybjW62yHz9f0XPVX/m8gosEMIOoQMcAodvCbFFLoSgX
         YOAfclmf0WNygJoI4ek4fV6K8lut/YzA2i3bCKGn0/5BypGVrlpByTgoxCXHhdXaXZJw
         9Zlw==
X-Forwarded-Encrypted: i=1; AJvYcCV/TAAz5IEhS/hqVUs1fqBecLuY1sjLgxnoWPWdLpadlKulY9XRF3Mn93VIYs7+ulWOVnz1Tz6T4HGmFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRLJftONp7RbKOw9v3IQE6oOR+WeI7TwaEZ01rnzNMlj0K+wz
	CQg3TDseN5F88TyCaUoRPlCk6+mI3cD//ml7BPGSpxHH8CS6HdumkVrFXdB6HNV/Vw==
X-Gm-Gg: AZuq6aK+kyBsRFXgA+LDTBeDy/gXc1RHbSJjYFenZoIHdBiLMTD7ro1NewU/t1iEG2M
	0N+nYq+/9DUMTxW6VIoNYg6JuMOLj04ReJY4pgxEXVIx2DkQ9UqhxE0eNlcqxSfdi0jSVEY1Kcn
	qCHGmVhS0S+gpu5aaDb+mzRSqaL1UDHdEwEbKUMIS611tBjvTJ874eAbx0GSHCmOzUAQCYjbCb3
	HfFbac3o6oQ1Xg2rhuPzDq8S8Jlv3SheiaghacoXTH4lu7ktgLj9eyq9RuH/kJQvp3lZA4f/YrX
	xBlGKwn2Wc20SBmTGOSJS+c29h7xBQs5mfYR2kObml8r0cF3/0i5OWWE8ZkftQppjrYTlg0L8ZJ
	IE9Zgw2rs6tyvg9b2f48KmCIKAyyAGu4apwVAvvBGIlaaGJunqi0NxVqfSJQQnezeYvfNyPMJZ2
	Nrudwn/Vc9eqKd083pjjioftT7N3UwEttfQACFlfY0V722jpSJuMoNGDLPsh5V
X-Received: by 2002:a17:902:c945:b0:29e:9c82:a918 with SMTP id d9443c01a7336-2a95214a72amr125016215ad.22.1770696633129;
        Mon, 09 Feb 2026 20:10:33 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:3f6:92b2:887b:120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a638c0sm132083815ad.15.2026.02.09.20.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 20:10:32 -0800 (PST)
Date: Tue, 10 Feb 2026 13:10:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, Richard Chang <richardycc@google.com>, 
	David Stevens <stevensd@google.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: drop slot trylock and miss_free
Message-ID: <fkx7xu4nl7olte26x6ra4p4nokc6frnpguc3wkmk45hmqfw3z2@ewyryw3mx54y>
References: <20260210035045.3817297-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210035045.3817297-1-senozhatsky@chromium.org>

On (26/02/10 12:50), Sergey Senozhatsky wrote:
> Commit e914d8f00391 ("mm: fix unexpected zeroed page
> mapping with zram swap") removed swap_slot_free_notify()
> calls from end_io callbacks.  This means that there is
> no more slot_free_notify() from IRQ context and hence
> slot-free cannot deadlock on slot lock any more.  Drop
> slot trylock.

Oh, please ignore this patch.  I realized it doesn't make sense,
we can drop miss_free, but trylock has to stay.
