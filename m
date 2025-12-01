Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A782C030E
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579898; cv=none; b=J91+KjYSoT32cGXqaUP6EI19Fn/amu5Pmj11q4vg7iolgHbhY/a90a6v9qXdCq7A1erNdqFoP3jbV/aD66SJjurRiI/w8hukDXgkddhe54Z0CNfBjgZ2zGKalf2luGhGy00c1M9hGTdRfy+umNDmee5qsUF7PAZezujI85ssWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579898; c=relaxed/simple;
	bh=wWI0hn55fvTvrLDkP5A9I3pEc/gcCNnN7tnCnxLnN0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GFWMMxgyvtqBC7oTg3myiD07OvJ/WI8sLj62OA8wb4oXSu8CIhPYkOfrBe2bcY2NTM3Y8kmBhF9Rcow1ef31eXP7wF5IeAYoKvuk1qDLWkBm+Fuou4MlQh6orhf3YNtkyAXWSymRspvlYC1KKjlVPfotWWUcFe3kcMqv1IqNFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtBy0pek; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtBy0pek"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so4021057b3a.1
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764579896; x=1765184696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfhO4t45NNnLyH8RgYmrHOJVhdz/vqMYLwrTLqjFvMk=;
        b=ZtBy0pekBD/gUg8jySnBVBNbx69k6M2G26ckUriUnPI7WozVcodiDpH/u8mTtfxOLD
         cUbX0TSpX5ySIc1//GgFIY9PDN8WAnGYakxTFh2t/tbX/VESJhOOBVQz4hznfmjn4BzP
         813bAOyweS7A89C8e2u7EMbbIZLfil+U06/231ktfMTXvDqXndhgKCOF8LIN1v/OebMJ
         Ffgz1/79HHW0wSFROdOEZEWBuF40/Yn8BDKEyQHgZf/MJ0zD5OyjsdZhwg3lNW8MieIZ
         3wMGIsYi9jXwcsx2DJ33gCQQJdOWB0gtS0hP0QCpsw7wJg7l9QijzTdc2FwUmHpyVG6c
         YnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764579896; x=1765184696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfhO4t45NNnLyH8RgYmrHOJVhdz/vqMYLwrTLqjFvMk=;
        b=VnmmSgdgAWldSgGC+HR6pi0iQulaUWmi4egBgUlkuzRJ0ntz3N+Lf9Jtl24pulP4cS
         WZlE2tEmJdwBusDEnuRKwSDWfpBmKWL4srMX0hW2ZnfdtJbTy9336/Mapgpl/Ilf7vlB
         HdHCOt8bbPGxzJZmrwXpCK8PbW+wzF6tavVZchSD1tq0AzBwuk6B+0Su1yVzOIjYTnGj
         VeUPmRJEolaVzMsmYOObhBT067/HELj8S8vbIIP04KzbvyhRpoR5hdAlc9s0Pvs86Lcv
         db9wUUWPkQnRTmGtlb6Ivx6vhYKd3wZz2WAuCRSNhKaRmbqW9fC/giENU1Z0ncNlEZiX
         25Jw==
X-Gm-Message-State: AOJu0Yx8jOoLQptXNh4tcOmRc3dqlcGF0ez9jOJogzmMKFmRWjLwLpGr
	8hyx1tNXR9GMh2CIm+9uq/4eKd210zCSNtuqWb3wZT4k+7ufd7KYe69T
X-Gm-Gg: ASbGncvcC+8CiIEXqyHPGJDQ2ngWGr+0M1EqyNMWrZIVYBx5sepi6ISu2Lae15s9OZ/
	Ab6CyrPCpx+in/ptu7I4ha92KIl3PqXrgkQNEb8oPkpfAAxJipBf+pOkaXPYM9PmhhkWIYQNb25
	2z3sE5OQuUWrUaagJK3hChBRBwCJcdyjS6ZBPGNoo73Vx/TbryPmnHv6SFAA763PUolGhT0pyqd
	DTifFzMcwKS9Qulb1XADGwq/tzOL3fNvp+hjQ32by1Syxm40rVaMVAwDoa7nXakIydnkqlASdCP
	gYoveMZOQnXKY3ZY6KHLs1F2wgdnJZLTXm4T3DU1AqQ5hpKzjwGR1Y09lTOn32cV04hQseY21R7
	aDvferj0nQDWxmclTETjaZxoD4dLS4BWdCAW+sH66FoLqE8YD6SmXsH/oZ/Yc4D9Hn/wKUUA7oG
	PZHRYqLVXyuLD9dhpsAPtX/iA6vQ==
X-Google-Smtp-Source: AGHT+IEacD7nIRpWHZXiz4TsORsmjqaoL0X94j8cSIbshETof7GukRtdYu3CFoH/ye5Jv7+JumoDAQ==
X-Received: by 2002:a05:7022:2393:b0:119:e569:fbb4 with SMTP id a92af1059eb24-11c9d864e98mr25000325c88.35.1764579896080;
        Mon, 01 Dec 2025 01:04:56 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm54908307c88.0.2025.12.01.01.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:04:55 -0800 (PST)
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
Subject: [PATCH v4 0/3] Fix bio chain related issues
Date: Mon,  1 Dec 2025 17:04:39 +0800
Message-Id: <20251201090442.2707362-1-zhangshida@kylinos.cn>
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

Note: Patch 2 must depends on changes introduced in patch 1. Therefore,
patch 1 is still included in this series even though Coly suggested
sending it directly to the bcache mailing list:
https://lore.kernel.org/all/20251201082611.2703889-1-zhangshida@kylinos.cn/

v4:
- Removed unnecessary cleanups from the series.

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

