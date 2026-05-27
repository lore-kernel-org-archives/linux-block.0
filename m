Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8402949E0
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857371; cv=none; b=ioSTYMSM/M3+6UAmHtJffEe8D/ir7+WQuyBeFoMsVFMn/39Zz90Q4euhJEqMhJuS2Wf9iv/MmRzhVpj+Rm6nb0P51mxZHXA5ig/Rx9YuIIApf1EyHVwWs1+ewCIf+dWjkqMR43jd+91Ee2I8FdVCliyoTJMM4RIqFgudW4u1AYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857371; c=relaxed/simple;
	bh=MWXxtYUJHKCFAwaYN7w+xkzs9tEH+b5cbl78IjB6IzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pDFMJLpjrz19RSbipNrgGhMy3I9+fsFEcOpV/DXhDZgcWmjrpo8d+0seg2uTC3Lmvks0raeSTM6XRtvftJJLLTHJ3+3Be6IDqA9xSx3/LX3mzk7OvGmqYIICf+y8ULWqIBnVYsKpAlCuQVKH33Wgt6j398mKZ8WwjCT3EdRVbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M389yDtQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M389yDtQ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba4efedbeaso85341505ad.1
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 21:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779857369; x=1780462169; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtWoDaWr1fAVpczHdMCywjJZwwAcuUUA2TuUPYOhsgk=;
        b=M389yDtQv0kt9VYx5Wl5UzXjCXCJ085Q8qpo/OqWFhj+Nh1g6lSUKrwjXPZ++6NFgh
         GJbjf1H1yizBdY3kMz38nMllW0bBf2IVlo9SV8GbFJ9tl3YlGyk8WjJnrlbrKWhpL7Ef
         TsCcxnEGkOUyYcO3D1F3scMR6UeVuoOLFPh5vEWJUbGafVwyo7EeRNQAn0AM7jBDRKRn
         hUw5P6af4NR6QKYIMykw4rPKBvWFh+z8ofsAV2BjlyyXJ3p3aDo/rD8AKUUt5/lmzZXs
         g4oF8ecw29LlEsfT4OU02ci94c9khKJ7dFTL8+GHV1UtdL2P/OFiOB+boDK/ibUt1OAX
         63sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779857369; x=1780462169;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtWoDaWr1fAVpczHdMCywjJZwwAcuUUA2TuUPYOhsgk=;
        b=HpHxZMxg1gfP/6ii4+DWxAfvo43bSOcEKcSE9/fg/DfWnHECpUWtPC4S/SOEEGFz2l
         ofnJ0awFMTgJ46ZHxLv6M4TNYs9j9oElorh+G3+xD0X/VIoTjHzA6JH8xoPWJd7EGWhf
         +XppCMKX9+jSLlR/f3aQpncfu1wsUDzcRPoIYJdM17+d/XH+n8JLN5FO8Z54ZHhroqiL
         9OggmZJ3F12fNAIf8L069GQFX1CYokAddgBj+3UyIn2haTxAAubpSDPFntgRqHNXA7+S
         ad5kZ/NMPnKjs4LWRhuv5cGtJ6pENspozhZN0q4zJFoBgfAE79QoNhCfyUN83bMyvLij
         je8w==
X-Forwarded-Encrypted: i=1; AFNElJ9+cDZv9Waiz1cpKBiA1gnfPQWYKBQbNzUobCvsAV+VAC97XKnICQ65j4Hht6NxjCY05n/p1AnAc23+DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdnc8TdMtlVIjauQX5gvMTeVvH2t4FiGMffZ4VMWH6NUdq/+7
	1yIrQ3YQaIkAHj+OQHJW0bXF01iW5PD84F9+qYsQlnYwBBBoLNCBJ7zt
X-Gm-Gg: Acq92OECXnd9DsPz8zv+Qcnstip9SzBMXnB55OqZeTBLDLoe/kTx5oIJeM9Yaxm3xbI
	gYLOFsowOzuaTHoH2SJ/riiOrnkMfpYU/i9X4RnquguXJKELnpGp74pdKKq/5XsjGjGOwTsTMQa
	orBrqlqk70RnircYc3wuI3INSxJeMuuvmyRbrFqlSdtewom2T1f8fzopJE7SLYRywcFvGdlW0Rv
	thMcC0BlLh38AEkG8QEzi3QJCLRlQRp4HWRMxSt6hgPCX0V5Umn7Cz9AbY/b5VLGR62dUeYJQqd
	C79yiCSry5kSKQnWvw3EwgNbpwt4t640YcPMnCAz6RKhyIXtwAorE6HMibq+RhSog+QRpWt4NHS
	puu+a8wjQbOeCWR+g8VhBgSjjcZ+EI6VyxL+YOUc9/QXvOa2LhsOorHgbQXhkUYnmztezSxENdF
	UVaukPIPRgl1W4nkasWm9i1Zi0TkMCbizYaw==
X-Received: by 2002:a17:903:1a2b:b0:2bd:ef12:14d6 with SMTP id d9443c01a7336-2beb06cfc33mr237395755ad.34.1779857369510;
        Tue, 26 May 2026 21:49:29 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dba7bsm135704105ad.66.2026.05.26.21.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:49:28 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Subject: [PATCH v2 0/2] zram: fix UAF in zram_bvec_write_partial() and drop
 dead bio plumbing
Date: Wed, 27 May 2026 12:49:23 +0800
Message-Id: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANN3FmoC/zXMQQ7CIBCF4as0sxYDE0ujK+9hugAc2kmkGDBEb
 bi7WOPyf3n5VsiUmDKcuhUSFc4clxa468DNZplI8LU1oEQte9TinUwQVqoD9nYg7TS06z2R5+f
 GXMbWM+dHTK9NLeq7/oHhBxQllHCkjLNovfHH8xQM3/YuBhhrrR8t8VD0mAAAAA==
X-Change-ID: 20260526-zram-b01425b7e6c6
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779857366; l=1050;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=MWXxtYUJHKCFAwaYN7w+xkzs9tEH+b5cbl78IjB6IzQ=;
 b=awVJ3Reynx/9qKcpkry8pPVO6WO/SxEC+sbgYlB/AXjE7b9wokupd/75eZl2DJa0r9X5EKc89
 efYJzuJECK2DHFqkFpgYD8dIqvHv2XslkX3RsXOW5OSU8b65Aik3V+A
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

