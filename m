Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D51B6D1A
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765110110; cv=none; b=tw9kYEdGLHhki5L8MJew+ObeV0q7L4qEjpPE1PPOiGeQIRxqeQKY0KDUlWG/q1/HPlfOIXgBsBtjUYo0yKeFqH+vq1l8l++3B8czJlzuILfElXf9KkrcmciztUbtYPZbHRvzhP350hdk+/6ORAOqmGemNez6vDwmZ1wWw1o6OhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765110110; c=relaxed/simple;
	bh=EdAQp9CHsrjyYHWEK1NLd3cyuoRw/bMWYJkcM+8jzxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ijEsTgHI58NjT9g2suN8xTHZJOHJdvnnoi5/KiBFXnfRuW1Ver6TE9n5wnraqLyUgBn26VEBMudTHA9E7Zjq0/7ZLrW+ca5sYKINH2lBkVNRYFYKjREMp6tdQCdqia/nYv/eZHuVPfGIQIY2QCRDRoqwhuwko2ZStt/AEaQu+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2rqsv8R; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2rqsv8R"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo4047638b3a.2
        for <linux-block@vger.kernel.org>; Sun, 07 Dec 2025 04:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765110108; x=1765714908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=joTQfPhywjCMY+5oDHnst7DgiG3VJz2oKR4JgFEEjaA=;
        b=f2rqsv8ROnq2vdZG7gkLyt3kFx7zSQj3BRwTcF9g5/I7Jca+yQLWLKe+sUDDTHi3+I
         HHxf6WuXLyKokXnb9Sov6+UYuUiDERXcu1mhAZZm+PZLc3YinOuWkadz8dt9WJDR2idn
         Wnp+YPxXAXck4RXmfqMpn9yiH2aXsbB4aVppJ4KCYwsnk6YEtiFlju11xr/hlE5+kwx8
         7vl6LS5qwoUs+YhlvnelDzkfPr+mtHIkU8PRSIhoEZDhB2WQRudmXeRqV4lxeZzTgVlR
         lxw3gINpigDFrBLIPtGMdFn/q05ZXHOMCRJvEzvQL2hyyfvjeYzY00Fh1SyDSThmrtg0
         o42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765110108; x=1765714908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joTQfPhywjCMY+5oDHnst7DgiG3VJz2oKR4JgFEEjaA=;
        b=nDOmo/NjTlJUGyyITSq+GdaW3wfb9cQLYQ1qMsbAtmzJMx+8RVxzgECUQEY3K/DIqA
         LqznZeuEDLAKyfEUm4i57XGyNMEU5gATvT3Iy0K9NVdCI3Uv55OjLrGlVMTSWcmsrioO
         YqYljBi50Ta7fzhD84bBRXUftinHcE8Tdv729MwRtI7d3Uik0qMa5jzoK3xHNeN9YCnu
         5oJ5GFcP7E3otjOep6a1LVRherOuhPrMZS1WO1I/ZTQvRoeclc15WYGtlK2uqqEDCfNx
         YcJZeWjxiyzhJL+XE5pR8rwJy7DhEAlkQOrANc80a3oc7RerMRC9+xOw10bNnIOCXa79
         xOUA==
X-Gm-Message-State: AOJu0YxwKED6s+VAdYIFFgnTQPlKnlUe1dQE8agxFR3mn7eGL5oXfnyv
	y2iAgQEFro+ih6TdkhiaE3YkZb65y0ViLmsuXBsv+GanmtUfOlbUfHGe
X-Gm-Gg: ASbGncu0FdyqgC96iS4A7KqxnAe2xVYhFwv/EOA63NYNL9DKtDj71HZ5YXcjaslZR9q
	9V1M8/OuokFcrQaFM6bMagcR8j7EV+77EGH7FKJ0DfkUncLEkyeVn3uMDdSiyXok1bLrP8G/X3O
	LVSkcWDfLxpr3NuIRoFVJQoz9Wu/+mWQl+9p+/19YBNyxXg/hr5OnGZomJ4nsmGir7K+WZMPIzx
	YelSTU0ayX8PMtbmMaQdoR0JNLSgPxvjjbvj7V2B/t1i87et+n9/9pys1g1opcEfLsL77CGUjLH
	jxo0sE7u1y5juRWxvb0kbdTCqJ88igY2R0vk0jWwVtNdmW3uSb5hktR1PTn7e42IlfCmjtjMARR
	vbtHSU68bMPqa3TqhKB6cX53KNdMdnm8tdIUI7+/Yql94sJUh5FAPEhFanbIzlGwnPY3mOZcMFp
	hx1ULlwayBAoD/1jCxiy8UE9k3GQ==
X-Google-Smtp-Source: AGHT+IG8BbDKk36cm/PHPVqWDlq17iC4do7MY7rKoUCFS0nZ2SwpdfJ+A5u1l78OZShYQYwtPCeo3Q==
X-Received: by 2002:a05:7022:699d:b0:11b:9386:a3c4 with SMTP id a92af1059eb24-11e032d8b2fmr3479895c88.47.1765110108364;
        Sun, 07 Dec 2025 04:21:48 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm38598822c88.5.2025.12.07.04.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 04:21:48 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com,
	colyli@fnnas.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v6 0/3] Fix bio chain related issues
Date: Sun,  7 Dec 2025 20:21:23 +0800
Message-Id: <20251207122126.3518192-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

This series addresses incorrect usage of bio_chain_endio().

Note: Patch 2 depends on changes introduced in patch 1. Therefore, patch
1 is still included in this series even though Coly suggested sending it
directly to the bcache mailing list:
https://lore.kernel.org/all/20251201082611.2703889-1-zhangshida@kylinos.cn/

V6:
- Patch 2: Fixed the comment format.

V5:
- Patch 2: Replaced BUG_ON(1) with BUG().
- Patch 3: Rephrased the commit message.
https://lore.kernel.org/all/20251204024748.3052502-1-zhangshida@kylinos.cn/

v4:
- Removed unnecessary cleanups from the series.
https://lore.kernel.org/all/20251201090442.2707362-1-zhangshida@kylinos.cn/

v3:
- Remove the dead code in bio_chain_endio and drop patch 1 in v2 
- Refined the __bio_chain_endio changes with minor modifications (was
  patch 02 in v2).
- Dropped cleanup patches 06 and 12 from v2 due to an incorrect 'prev'
  and 'new' order.
https://lore.kernel.org/all/20251129090122.2457896-1-zhangshida@kylinos.cn/

v2:
- Added fix for bcache.
- Added BUG_ON() in bio_chain_endio().
- Enhanced commit messages for each patch
https://lore.kernel.org/all/20251128083219.2332407-1-zhangshida@kylinos.cn/

v1:
https://lore.kernel.org/all/20251121081748.1443507-1-zhangshida@kylinos.cn/


Shida Zhang (3):
  bcache: fix improper use of bi_end_io
  block: prohibit calls to bio_chain_endio
  block: prevent race condition on bi_status in __bio_chain_endio

 block/bio.c                 | 11 ++++++++---
 drivers/md/bcache/request.c |  6 +++---
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.34.1

