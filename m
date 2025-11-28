Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3F285C84
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349515; cv=none; b=jCyAyiRpmNv47TXCHV4B2lr7CnouHmO0cLl0iu2BJxO0VJGbBi2nGQjYWJfxxvG9JyGrFftf3foEcOc7c0OEG5vd+knvuflqTgQcAf0lUdk3M94W+zSpgOIWS0hVWMCP9+pn/l3e53Pxje5vu5hzJm2gqeELvQn5CsaPUOTiKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349515; c=relaxed/simple;
	bh=KyZJyyLsn2XWhRjPG/8OgZWmaYkGwV4gdnUK3aswyjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbsOQA4ae/AEotvzEAYvwwNMuDdb+1OVIkms0dp9GOaV4C8vHVMFEND4n5p+gpApUZrBxWkI4z2xMsk/v4R5UuXYyEhCu4rsb8QZB5NIqw7mIDpZXZ470JF280Ul0b1InGcn5wJf+OsU4+GDAJkS0h2/5IhRGpi1nddkeTI+HTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FyCxuEYO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FyCxuEYO"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so1897027b3a.3
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 09:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764349513; x=1764954313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gHDOsFG83iDIKKsmQJJxjvLwkokZvWuQS7kXsZY8RE=;
        b=FyCxuEYOLV9d4uHescUYsTw2OYk8sWuo7BYu67hMlyt1Rt2KfM6ObTt7k3mAQpzHTE
         ewnpRDtSuNbXczEYXjbzVI0oOvYlBy7Vl5ZVNfZewEKLYU85w/4NoflB51KBJrDx3aJ3
         ga1yNv9YJ32isHQYN9quZa4uyR2GBpIswoVx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764349513; x=1764954313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gHDOsFG83iDIKKsmQJJxjvLwkokZvWuQS7kXsZY8RE=;
        b=SD4JXQ63Kizf1ifeMpHh/4G4UmAZMpdWvOAPCuyZ1HKkEl0WDnK8jZNsops9ovZyTe
         QcUSLoi+r2xwsRbFoinD8ox2LDmwnZXj8bIzbpg6ZMJBYftCISDN5dbS6mdbudSZpMu7
         vEFSAWx+Nue3Y8IMKpnbmoAHji7CsQaRJXca1ext4hN+j2O4FrOswBDVJEVCbkErZWCr
         B0MzerAS+/EEtRrEwFHsUxfPOPlT9Ky02AuuCkbqJvQ0miwAB39lBQD3Vi2GFjmLlmLw
         GWr1LgoiBHb/LoXZl5lUCMRdUbwNYV53EaLIsYSN1Oey81xG3Me/+Zwwuh4TlDLACNcQ
         jrig==
X-Forwarded-Encrypted: i=1; AJvYcCX5zJM+R/PD0127M2Lnqh+b9Y/drBHpMvgNgd3UWKRTF3+7tEH+NJsJuoucOmnwu2Q2R0q6yjgQzEXrfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJaCkT3TEixaC1IlnFNG3EqNIXS7z0HO5OFmit1LQS02vlvVIY
	xUrWr5tglhjuFr9uNsQqup17LpLUystz3sV/kH0wbET5Glc8Ou4ZxmOrL2jzR8O5vw==
X-Gm-Gg: ASbGncv8un9lmGrMgInmtvy/Rrvwk4rd4vxLzQBYjKwQnDnnaOyNgESesMimz3HuuUg
	n3p3JAA6qrr0D43Ry85mUTXw+3T0C12CDPOP2mf+3Eu9zsS6/72YS7kMtQjSACF19kVvAHj05sH
	UeKXtmqp90TAaoZ+HUPqAdAXnVDVa5D+DJIWm/Wj5VGjfMjPhIDnNE6PFl1rEuNXgj2+dVA3Xf7
	YAB1wvOjw8Wn8k/u4YY+0G1FEq93KzXjykrqWdUxxir/TVAtzHftS6v9fZqCKwhCPiuvaWxJq3X
	dGVdahiTYHxfy8rajz/PinpgF3jHZ8ioJ/a4a3DEu93vROQIRcL+uMYuaAiRN/yCzKaP6hVvnkb
	2LPya/JHJbkzGbV1q/U5ccWlXqp9Pvlr1w9LBA1iOx6EPqvUFrJtfW9axX+QTPrINiCp1S2xQGy
	+TA49tTEv/aEMNTDGLXytShyTjRMZopTmlUqfJd4mG3l+a9556f8Vw3LwH+PegBmnPzBisqCJ5U
	YXzACiaKOXL
X-Google-Smtp-Source: AGHT+IE6t6L5aaKbxaT3dZ25iRzUTepkjauFQFax/3eE7D/nAmf1/UU/2rIe75MhhwGWaFeuU3AClQ==
X-Received: by 2002:a05:6a20:e211:b0:35f:27d:2ded with SMTP id adf61e73a8af0-3637db539ecmr16627880637.25.1764349512883;
        Fri, 28 Nov 2025 09:05:12 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:5b9f:6c7b:4d09:6126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150c5e611sm5568242b3a.6.2025.11.28.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:05:12 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 0/2] zram: introduce compressed data writeback
Date: Sat, 29 Nov 2025 02:04:40 +0900
Message-ID: <20251128170442.2988502-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As writeback becomes more common there is another shortcoming
that needs to be addressed - compressed data writeback.  Currently
zram does uncompressed data writeback which is not optimal due to
potential CPU and battery wastage.  This series changes suboptimal
uncompressed writeback to a more optimal compressed data writeback.

Richard Chang (1):
  zram: introduce compressed data writeback

Sergey Senozhatsky (1):
  zram: rename zram_free_page()

 drivers/block/zram/zram_drv.c | 260 ++++++++++++++++++++++++++--------
 1 file changed, 202 insertions(+), 58 deletions(-)

-- 
2.52.0.487.g5c8c507ade-goog

