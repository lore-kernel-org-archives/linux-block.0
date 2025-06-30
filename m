Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091A1EB5B
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751321313; cv=none; b=gpGLIsMpcZEGMIhA6fS/kQ1xjhzJQJF7lWIICwA6PmXYBjKwIVZuBeHWGWq0b5Xuooeu8H7oRnX4hxqQ/ZAXBytivbXtA+GU/jBkccOoflWRI59//+NJ9WJNU7aGbvFKUkYpRCdPNQt6UChZuBw6Qmjau/BxUgcWcaXIc72pw2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751321313; c=relaxed/simple;
	bh=HHRMsV3fm1fevwn85+HuwnpXeUOPp5iuP+uGVQ/z5j4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WwzzGBqM43WunDONcmwlVnrL+mWD1qTQMBLxuXK2mNGvdjTsXNikxf3Hs4abyqwqZen8MccRGN9PFFzM2xiLILL2yWPzPuzFvy78WZkSbjrAOBg4cmkxfmMTPq3XuJD5zCOvv2qEuDcdW4t7WK1qhOmVkqpdlky44LyEkGuR0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iHO731Bm; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iHO731Bm"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-87640a9e237so221685139f.2
        for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751321310; x=1751926110; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNCS0Ap1EdukI7cJB2MNgTuHFBTVL7bHj+FO4XgRIVI=;
        b=iHO731Bm50qZqKGKraBR2aN4aHCYPJCXV4dvq8Z8/o7h0zih95woZDQn1eI+uNJUV7
         UMylc9x551rwZ8iJ5uhlGW7KiOHlbpbKOLDLzG0BXLMMymFHxj+39hWvT2YVXuAyk2QB
         6wM5tQobAvgH+N6cPwae3igYoUCSrAoyOJCLaAYl8IoJKc+xe4xTWWMXt5yhYAIYFVFB
         57jZj4dTN9E/toyJc6sP/gogDdW9J1ijXJSb26gSUzFQ5/KF+D7cUtZuKzkKVg/nE3hj
         pJ2Z8uH9ixFmUsNCd5qS4+d6A2OinEC0CMg1xxROlYO0Wt+z/AQusWkQxuAIe+tNlx9g
         RN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751321310; x=1751926110;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NNCS0Ap1EdukI7cJB2MNgTuHFBTVL7bHj+FO4XgRIVI=;
        b=F2BFBKglgux0QHYjFfTEJBr3+Nl9QS/+x5mm53TO8JvnYND88eXmWRMGC7NAbv06Nv
         tXi4uXKbCNT3f77mc0oCdZ6r+af1ZJhgV+weJAJQDROczWej7KHB0ArTLrLNfXyqbjhO
         jDvKmGlESy35NXr7gVZGpALBUU2mosGTIzo/3K+283MGUT6KWWcY+n/Hc8yqq6HrYbAK
         5oeZMR2nD+aIYn9/HZprFgwQ7Qte2jYI3uLDtHz0JNu6H4cOMHzjFt9GHXUDyVZHqU6g
         BVmc7EURTC9n/JioXo0+q5zKza80HNamICdTzydWXmqAhmGOttNUCPXOeCOaoItEIJUn
         6iNA==
X-Forwarded-Encrypted: i=1; AJvYcCWuau3R1hZWIzSr32ef4DODDHc5R+2y14NMemHKY3jJdaiFSJ4lznnyncHwO0Bz5Gdj0kmt0p9csmkdqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMB46nlHU0fQAPMx16ZnzhMk2Za8l6uGOaaCHvI3x73iR1/tX
	MBQ8mhTE2xE3XWMc00mK2Uib+lh0kK4xDRWlOv8MMv1dlabRCbqRlef6+k5Ozix5iwQ=
X-Gm-Gg: ASbGnctcYvre/0sb7KnTlzef0tihLdq4sEpNGawJylVyH3RD3FgnZMS+rwayqyYXh28
	9lHxJPLNE4F9By/yZgSlxOK2/eopeswL0GS6dAvKmG8DGIzBTqZP6tfZTjn4fe+yXSnW0KDKtUX
	9Y+A8IXqxHkFJV/h9hiPiv4pHtSsACtTEc58A9/WkZqglWyfeSEZZpjdZjB9juwiPFM2Xml1UTr
	VbTTD6gGEIyW7jZaDCZD2dQnTk3udSavv7tvY0n7QGm6h0Vf544N+5MRHOvfuQKsEcBccjC1aiX
	O0Ac44StaLNxWdd+u9v2uriou58aye/zGcJBrTGaS/FS7oRBFrXxJPHKWuM=
X-Google-Smtp-Source: AGHT+IFEmFKxxVooMk9m5sytVg+Zna6ENvDoXcuW8IhxlbaSwnqKU859/gen5tJ9vcjwX7ev/s+y6A==
X-Received: by 2002:a05:6602:1483:b0:876:7555:9cb4 with SMTP id ca18e2360f4ac-87688258c05mr1636794739f.1.1751321310327;
        Mon, 30 Jun 2025 15:08:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87687b0e644sm208250439f.37.2025.06.30.15.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 15:08:29 -0700 (PDT)
Message-ID: <dd82e081-a508-4b55-9ba6-36bbb54a2c2a@kernel.dk>
Date: Mon, 30 Jun 2025 16:08:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>,
 Caleb Sander Mateos <csander@purestorage.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Subject: 6.17 block tree rebased
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

As per discussion last week for ublk, I've rebased the block branch
for-6.17/block to be based on v6.16-rc4 to avoid a bunch of issues on
the ublk side.

For ublk, could you folks please check the end results?

For others, just a heads-up if you had a tree based on the block tree,
then please do rebase it as well.

Sorry for the trouble!

-- 
Jens Axboe

