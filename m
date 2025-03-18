Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E11AA782
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306125; cv=none; b=ZFQrCD5RMi1GIa0HDHGhd0fUgE/OQbmvGLV4EP7a0dde3YxMPpm5/WGb6p8DnWHa97YPWOZosNNw1iILL6R71qFTolJOi1NtJpean/+nuKJgISN1CE8hYmUPcXsaXY7aId7DJjSDrH6SrO7nsIvy9RVYDnMT21ZSyMaUF/sLFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306125; c=relaxed/simple;
	bh=hi1cz4btmftGd08/kCDcX4OXZ0DoVEanqevkOT6Aa9A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bTFZreZGRnNFwJ1hFQWGnzGv51f6ynl0V4XgbhdwaIQfpFw/FOjx88DnpVnQp7EE3UOAn2m7U3LL8rvCiKj0ICE2iCH162MgXZ3qLNn+Z+OPj+P3O1JB/wCfzdgpstKz827KntDyo3txHfSJcH+zvbqsG+kovfXiHVk5E6JMJrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YeIAbuA4; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YeIAbuA4"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85b41281b50so143951439f.3
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742306120; x=1742910920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibKX9VHJ/5b3jlIORHIOcdh+PG55pb0HT12F88G1TDM=;
        b=YeIAbuA4K/yqE2nCPbFsa2e9t21NXvpv4K2FbC2Qygk18ibSzhBt7wHrTgWq7yRY9d
         KkhIY1QoSSagc1dpxd0Yf0JTlSlO2Zgyg6XWu5it+KSaESkHQ3w3ZcVk0EQeDagWl4t6
         mYkmNeFRPJy7AAf6RIfEdLXTyqaZ+nd1Lq/hlHygdwoqxArEGc2RjMK37gx8FXsSqLkp
         XVIWWLOC3SrDKTtal1yQYvWz9Q3Q8OuIfOayx1LXp+etSsMWqfvoceohKS7YmVzKyJl6
         gdEeX4ww0wGZGMNPj0uWBmANiqKojTKQl0Qqw8VLM/WihjZWQ9uVO93p5OsIERYIZe9k
         tT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742306120; x=1742910920;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibKX9VHJ/5b3jlIORHIOcdh+PG55pb0HT12F88G1TDM=;
        b=kKkRVcjjuCyOCWlEDg7/hDSb7yffWwXbzWK5fuFUEaS0LVR5S5npSaQG6wpI9mhIg7
         EjlOEn9m+g50Os0svwJA7YGrgQCFwA5XblBaW9TsubApNEU4IyCvxhDxIbO8/Tjc+jmO
         jWxkksZHwbwOD32INGydzwDQs0QKTqKrpWas26svzyKroi08ombi7r6NX/LBXCkHpCPX
         46yVXnAVx+Fi0E9/hQUviKvSi0Zi+j96+Kr5VU5H84hGUEXsALfM9HN/Rm4zZN5pejM3
         FrOLzO9WsAsaISJ+ETkzVFWCz4UhbSkA8E48z5q/DQgYJrFZOqSO0lPWGfbDlvtq0kfP
         XUZA==
X-Forwarded-Encrypted: i=1; AJvYcCVCI4XrJjlAXN+0ZsJ3i6gtebF8vmDs6VH4qrmFlbjpJKG7uO+6EZiFj74PjKuWM/OD2s/gMCoeY4Ia1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjhO5/ieGSCt+H74+3JK1dWwKXthx2OyFtlg4S8fma99xsVIk
	ftYYRf6YtLj+IBy0DHDL1iNHUmy/vv2CtVUaW70DrX8+fHfny70PKznC8vE5FrseJwlvSYXdzTr
	H
X-Gm-Gg: ASbGnctBKq4yt2OefkJpXxj2JNHOHSpiOCSQP4f6O1n84PNYPNS8DaVDMrHC3YHs4jD
	lXe+D/MAJoYws0FqD+W98IIbd4u72W6J7FqxJG/k04eHFLbKoUetCgbSNJt5OPmPMBDGtfnGe9H
	oXWHP7NEkYQPMu9s5CeV2D3Vlc7dEtHp7zLgK/rXjqiRKrvFPjG1kC47H2qEOAQxN5qW/ad0lq2
	dEtUy3ZzpiQM0Xm18qy8EEwPS/krCiYTo5e9paBP88R/0VHa649sousJhR6Usg8YXG1wwr6zbn7
	7tqeAaxQHGB/DGY363yuCzXFai625bOU7evt
X-Google-Smtp-Source: AGHT+IExGUnvtSHXNfIVjPRtmk2V7VYIwbrIi3txpZSIqOOX+CEbinG6K7FNjXpan58uaU19JUeZlQ==
X-Received: by 2002:a05:6602:3e99:b0:85b:4ad1:70e with SMTP id ca18e2360f4ac-85dc47b4e91mr2150031139f.6.1742306120427;
        Tue, 18 Mar 2025 06:55:20 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e0bd1c125sm13128439f.17.2025.03.18.06.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:55:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: nilay@linux.ibm.com, linux-block@vger.kernel.org
In-Reply-To: <20250312150127.703534-1-hch@lst.de>
References: <20250312150127.703534-1-hch@lst.de>
Subject: Re: [PATCH] block: fix a comment in the queue_attrs[] array
Message-Id: <174230611942.124230.14573789019024369621.b4-ty@kernel.dk>
Date: Tue, 18 Mar 2025 07:55:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 12 Mar 2025 16:01:27 +0100, Christoph Hellwig wrote:
> queue_ra_entry uses limits_lock just like the attributes above it.
> 
> 

Applied, thanks!

[1/1] block: fix a comment in the queue_attrs[] array
      commit: b0d42581195603f38184d7c130d0e2f43f40fb33

Best regards,
-- 
Jens Axboe



