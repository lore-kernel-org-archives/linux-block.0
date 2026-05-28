Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4181732
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936535; cv=none; b=akWW2tRfjtCVpRFltU+3K5OxtZfCrSj/wH12x0mZrIyruiasJhnSqh15ynNHxnrUnj0rraScXnhtjG05V/dkh+ZK7cr1I6lwfzkTmNwWuzmo9OFCz/ji8JMCOVUHceV6YMf60yGxEtNuX0svoRFZBgdY6htnGGqtE+w5Kr6a528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936535; c=relaxed/simple;
	bh=hEMiF3S5n7GD3rgFs1MSCMOijiI81jrIRmqCj3tGYEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sr7A7G4STaaT0V40UtzMHdCt/hpp4Jtapj5hKVkWXiNYFSlndHF8j+wlRib2QKD5hTu8TTfbczN6l44x0O/TPkWqqaov5tzFTJNY8bMQMf5Oa/kDbzHAea9r4fP8Xxy1tTl7RFEH3iEzphhCA4CGV5pqVzchqoyuQ/p8tKg6PsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCmtmwQs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCmtmwQs"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-834f1075805so9330742b3a.2
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 19:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779936533; x=1780541333; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mHoOLXw1ORyK+bjLW8SaA8gqA96ImAqk4cz+WkSseo=;
        b=KCmtmwQsAUgddrCgHUpBzgPHK4YznK4z+jAhu6d537AN4xwK3dS//AGoAemrYIwYgi
         55Rg2Aj/jwvrHDe+xz54mRUw/I20sxjohnDSt6QVK5FIlcS+pJYiHCSlkKsjsx4CWni/
         0CcDIg7yddTqiEO013xrRyOUU94TusqN6wzlNrp6EkAgEO/cyzOK3Fb9B89c84FFcvJW
         VMTrB6srX1eGh9M+o5MZWSIpygwRIzgiUxYIQoklFQCcy/dr44MjqogFYkTGxfEhEg5L
         mgszAXCHFpsT2hQNkhNaIFQfTr1J9IpmPd88+mZ2LbcXWnehU3ps5gOIIsmO1/VvUPKz
         cgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779936533; x=1780541333;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mHoOLXw1ORyK+bjLW8SaA8gqA96ImAqk4cz+WkSseo=;
        b=icyPXditxS1FFsCQ1EZCvAcujLseeTPzeZwCwip+USisd2wB46jqRESwJjBiAda6gL
         5B66eTeLkW/0XTmrQubwNZs7IzMz4tlYVgPipVggHlp1mZqVpUdAnB/VbaBCPj18pCJm
         WmHfsJj/I+5Jr3PLzyMjEwnr/Is4XbFgazNQ7HrA6cv+jgpSpCGJAltLPJvX7j7TSdhB
         OB4w+RU9qtbAYD6OLh/hzCKVp8w6JZuN0zb/lkQBUXmXSqe2U11Dg71xxIzuFBSxc2Ec
         7YP8d02x14GsBMrG8W6n3G+Ost2qlpW2zRNYvNZZd9ArLxr8cdBKVk4pQAowXYYUN0dV
         a+Xw==
X-Forwarded-Encrypted: i=1; AFNElJ9Nx4wPL5DBuZ69LTayCl6OSAjxIzkp/bFXEtFuSL5NwQNmDt9+3gKGKq+FI9T2Axk5SHt0mL3cOq0wag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yztgf1bDoeVFURKEkzMxtnwh3rP3U89P9rB7vSY9zs+ojtNlPxV
	nXlIyIClcCCEv4fEYzjjKFbRO5FjS19SU9himN5t/HFw526FkCN0gp3h
X-Gm-Gg: Acq92OHl4HMxA2zVsAIG8VZyj7lQUOgjsQq8cN1CR7mOFn9fj5UFh6ij/QlMWOzUvDz
	Z/2qalFd7ru1fXHXNaRXq+CyF9V3TgT9Z2lNd1czSs+fCkqgml0C2B6Oawp61hAdU4y1k7Tm6R1
	Cy8GwwJd4bBrLr5ylds2H+v/2MqcEx7/m7zw3YXyWscLpbOGeMOk04hOq3LIdwZRU/QR3C8XNUx
	Qyzx9lj8q+a8YZxWF2HDj7GFwPozVq3y8X0G65eyok+pPiQGRg1ylkg6uWLrL6dQ90wXVX9Rgq1
	W7/e/9SE0HIddeKo6/bgJ9x6pqZ/F+VfS4fUlD+0Ivk8aV5TrLezM+774HxuwFw7X27PK9OgDX5
	Eb/fFje7op8GiZNGb8godMoU5f9N0gwNliIbvriuGg5/L+liY4a4hDAbHdlteHhbWRFhkwCMUmo
	JmdXwIZKe9hbEWFPRyCzPKZiT2iXjImsuWrg==
X-Received: by 2002:a05:6a00:91c1:b0:841:dc7e:6adc with SMTP id d2e1a72fcca58-841dc7e7888mr4287582b3a.19.1779936533561;
        Wed, 27 May 2026 19:48:53 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841f3cbcddbsm366877b3a.4.2026.05.27.19.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:48:53 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Subject: [PATCH v3 0/2] zram: fix UAF in zram_bvec_write_partial() and drop
 dead bio plumbing
Date: Thu, 28 May 2026 10:48:43 +0800
Message-Id: <20260528-zram-v3-0-cab86eef8764@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAytF2oC/23MQQrCMBCF4auUrB1JxiZVV95DXGTipA1YK4kEt
 fTuphXBhct/mPeNInEMnMS+GkXkHFIYriU2q0q4zl5bhnAuLVCikRoNvKLtgaSqUVPDxhlRXm+
 RfXgszPFUugvpPsTnomY1X79A8wGyAgWOlXWE5K3fHdrehsvaDb2YgYz/RggS0NO2Jqlr0u53N
 E3TG7bTpUPNAAAA
X-Change-ID: 20260526-zram-b01425b7e6c6
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yisheng Xie <xieyisheng1@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779936530; l=1246;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=hEMiF3S5n7GD3rgFs1MSCMOijiI81jrIRmqCj3tGYEk=;
 b=b0BDviFETroiomMLL7jl4q+mx7Zxj3oBLg5d53SGnqIPES4wURls/SzkCaj/bSMVLu7RDu0Nh
 FQNi/cpR0KuDbjHlHbFkwfXLikSkTIE9UCFOw+gYAtjyOvG21yJL0pA
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=

Patch 1 fixes a use-after-free in zram_bvec_write_partial() that
happens on PAGE_SIZE > 4K configurations when a partial write hits a
ZRAM_WB slot.

Patch 2 is a follow-up cleanup that drops the now-unused bio parameter
from zram_bvec_write_partial() and zram_bvec_write(), no functional
change.

Patch 1 is tagged for stable; patch 2 is not.

Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
Changes in v3:
- Update Fixes: tag to 8e654f8fbff5 ("zram: read page from backing
  device") per Christoph.
- Link to v2: https://lore.kernel.org/r/20260527-zram-v2-0-2fb84b054b5c@gmail.com

Changes in v2:
- Add patch 2: drop the now-unused bio parameter from
  zram_bvec_write_partial() and zram_bvec_write(), per Sergey's
  suggestion on v1.
- Link to v1: https://lore.kernel.org/r/20260527-zram-v1-1-ce1acb2bfaf9@gmail.com

---
Cunlong Li (2):
      zram: fix use-after-free in zram_bvec_write_partial()
      zram: drop unused bio parameter from write helpers

 drivers/block/zram/zram_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
base-commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
change-id: 20260526-zram-b01425b7e6c6

Best regards,
-- 
Cunlong Li <shenxiaogll@gmail.com>

