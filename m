Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866C2BB15;
	Tue, 10 Jun 2025 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749516533; cv=none; b=iebPATzPDXLjlsq0icyEzPwc+nSjjga3fRcrSt1QavG67sxN9v8Rot78CBVpoHYMyr/+0FyipLHZbLg3ncbxGFGoAxRt+ZIEBozvurprcyHmlsHOWH2gW7vkzm/b7f+kvl/RK69On23BGdNSdAt8yHUyMGoKzs/rnwn24uy12rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749516533; c=relaxed/simple;
	bh=TKX9xhoUfr2FpVu/AMpSpqSgRDwxY0TkzpBWvT4v7fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OJyCeEWXCqkeC4pFXlHePM0xbw+C1Hd1YfQqPaVS02V37QUt56GBT4FX1Yz20BI63CVK1xe+wFMD84NSpXt850yWeXgmqfDihpubrPPxxXKibJUPVBntZ0UhEUF1kb+vIX0zonLdWWZi7J6hgpysQwB9Gjwys45UX6xdSM33fUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyxqRqoh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyxqRqoh"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3139027b825so858399a91.0;
        Mon, 09 Jun 2025 17:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749516532; x=1750121332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NaVATDcL4O9YAAl/SPidKePRRvkUVimJOCIa1jkbWDQ=;
        b=ZyxqRqohyKSB4XjfVE8ChulnPyqdHA7kJkvSKolW39c+2dBc07eg3thE3kiMLC4PB7
         ndaSa9csp21B2ov6JLXS6ZoHD98FKi+dFjXcv2JMvGVummc0OdzOczWMG3hA87MSvT5P
         zmvnI7Wo2HhVlqhGhaohC0XhBosvSQl+/5/sMKEprUShTt4C1oZRhIg1Jp1YaQ2RB70P
         osiHJDuVtAODh+2GCu1Mrs8r3xYhsKMJs/RrtRcZN0/teeuMiwePCR4jdMwTf/6WxIBs
         BdEgIJ0mknJhrtIB1Z8Vk0cU2oM8iliFUp+fWZo3DhLqhjFCu5hNJZfN7rKu4nSuspUG
         OOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749516532; x=1750121332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaVATDcL4O9YAAl/SPidKePRRvkUVimJOCIa1jkbWDQ=;
        b=Pw888cMgxeEYrxR81xj6WPDxfbz06Izo3G7zig0qbM1LuGkub4E2jEHmu5j+yOJWbj
         oso9HiuiDTJARuOKFpLpwZsqeLkyWKiBqmPRKf+FzPP3a3EDXbPGOI8kAtrUUxubfWbC
         Wunw6U2Wz9HLkN5plqC6J2XzZLK2umq1zTrcFofw2Lz1yp21jMyi2q+IxUszW/e6BaDo
         3b11T+YZhEQ97QK9aVjjP5LDT/f/j82atFHC+FERrivUudOODrYFvZadCNcFmX/oadQn
         PwkAgtamDwInV+50bQhAcDUAjFsJez9gozvYKYO44G7/uudob948ALIX3hLXWLK1TAXS
         uLqg==
X-Forwarded-Encrypted: i=1; AJvYcCV3V/YsRBF64TNkhpwO0sVUsUoIaAGwfYFNN4RHlIiX76AkZs577RWYxq3iHKUlSzf8vg+wEA25Lwujeg==@vger.kernel.org, AJvYcCVOY1opZc8c2RiPZ9UyO685k3zDD8vOOispxrlrlmwpechPyHzc5hJhST6pJoiuXRTnobtGGhjLeoH9gMberQJfpfz2@vger.kernel.org
X-Gm-Message-State: AOJu0YwzsUlvvnz9LtJ4tq8Ga09YK2ZzjaOMaZtNiYSehF3V+9UdY3Gg
	3Ku2N3zAz7anhivek5GPMDzoNod3/Xj+w74JiMVgNIYJXzqRBpjS2Wu1
X-Gm-Gg: ASbGncu5vn6qDuEoUethSEZWYNRUGssxwGDd+ZQYG/8LYPNWJFniNf91CC6qu2wW8Gl
	dqPtb4cq2EMwLx1bDs4HqGzb6u74ZAGR5C0WSYnGOOCvUSJn/NyqwhyBtm7uC5sIqopzMTYfyTc
	OAEbq+NRcJAJx00FEtb7B812oZg9IaMc2c3Z5vcoqrhVW79j8ZPRImsTWl+Pn49AQSmaoXup/mw
	AKGc+DplTNiHwhAe5OI/8twQ7FXQ4V4mwwogyffce/jzQRkP7D1/drByCXGRhZTJsiKqRUwFb2h
	8Q5kfYAuFePKft9QvCKo9ZhKjXOKXhACGiWPQ+oO/v1jRgXOqELuMiqZgLe2Wom5WKO4M2xhg7F
	3UmvW80/vAgum517BzupSZuRIzlAYtCAVYQ==
X-Google-Smtp-Source: AGHT+IFqNEuhrlQtr46GGwFpA4ZzCF8UsgHje0IMsZNCUKfokdLVnx5VRGMkHTEb6hxigCRnT8M0lg==
X-Received: by 2002:a17:90a:c10e:b0:311:abba:53c9 with SMTP id 98e67ed59e1d1-31346af9a80mr22378222a91.7.1749516531680;
        Mon, 09 Jun 2025 17:48:51 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcd58sm60713845ad.122.2025.06.09.17.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:48:51 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v4 0/5] relayfs: misc changes
Date: Tue, 10 Jun 2025 08:48:39 +0800
Message-Id: <20250610004844.66688-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The series mostly focuses on the error counters which helps every user
debug their own kernel module.

---
v4
Link: https://lore.kernel.org/all/20250518025734.61479-1-kerneljasonxing@gmail.com/
1. add [1] as the firt/prep/clean-up commit in the series.
2. the rest four patches are not touched, compared to v4.
3. add Masami's reviewed-by tags for last four patches.
[1]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxing@gmail.com/

Jason Xing (5):
  relayfs: abolish prev_padding
  relayfs: support a counter tracking if per-cpu buffers is full
  relayfs: introduce getting relayfs statistics function
  blktrace: use rbuf->stats.full as a drop indicator in relayfs
  relayfs: support a counter tracking if data is too big to write

 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c |  3 +-
 drivers/net/wwan/iosm/iosm_ipc_trace.c     |  3 +-
 drivers/net/wwan/t7xx/t7xx_port_trace.c    |  2 +-
 include/linux/relay.h                      | 24 ++++++--
 kernel/relay.c                             | 66 +++++++++++++++++-----
 kernel/trace/blktrace.c                    | 22 +-------
 6 files changed, 77 insertions(+), 43 deletions(-)

-- 
2.43.5

