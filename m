Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277134E745
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449428; cv=none; b=ay649YqCM6ebdCdRY2WZkrJ1zjfgsZWzT4eAPximJ7o2pNNKPRe1ClLKCHuy/nTkxe2tw4ZuucOEyFj5uPkbtSL3xRV6NU0paVJ5cjSQmbyWhIk4tUkZrhzuyxCReI0R4BktISlvDvCxTDH6Itrc4PVHxVEmk2MJpiwyHyZyKuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449428; c=relaxed/simple;
	bh=gt/p/EbEc6xZeA53Erqi17gRBSJxHFx+if2j/kTWoMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0bEP5z55V+DKsT5eEHeGNForcq/MrwOxO2bjx15z2edxMURwwnCMIjyLzl+dyiN5rCpJYcXFvwWBCn+TaHJMj3ZqOeszU4M6iSUmhQDYiLwhuTxJ5pyITlgw8KSZYlHrUIBbFhvvwTJAWtzBv8U5Eae4oAKb2XbWt5+Y/Gx2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CpxPn/1f; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CpxPn/1f"
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-948805697a8so3611439f.0
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762449425; x=1763054225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NzzbeNT2m0LtL++SkTSwDyMSMA/3/EjGOUNEaInd5U0=;
        b=CpxPn/1fOyKR1gBFsqD2gw9RG8+4x6EuBLZpKUBOnJ96/oQ2+JO1JgKsaIG5zRQLKP
         yxEfW92LwZEfMu6i227krav1R7FNJGDcPFT5o9z7APUDOOkfq0JXf1oU5HxkPx1hC5cN
         rB1Twr8tdH0XedFXC6jZaXE1idR0yjAKizRkes1ddvOO5NM5ka2T2vK8NCfcSOFyMnF0
         vMc1ibO4hDpjimvsSXIrt9nzuI5KJYDL7C0txuULbCyT8EYRefVPVnELDQXF04LzbbK2
         wV7CWZrsCze9CFHeN99HuRY5JonskQJkDIg0iKm9u618iqi3Rm6qYnG02Dn6ltFVjnbN
         LTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449425; x=1763054225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzzbeNT2m0LtL++SkTSwDyMSMA/3/EjGOUNEaInd5U0=;
        b=DeeKsq6kA92lQEKt6HN52ELwROh+QtknyJryMEfEf8gBIJjUAHVteFv1wzyABfWGHr
         MhPBjv4IB12MjzZAs8nVlYDCnOILt3T53ywfcOKAGhC/M6Amk4vC/udms5s4mA529pyW
         KOJk4pTAbpppGxJTrE/WW3dp0eoPG+OLNc10UfmQV5/JSAz9KGFC7TqEaKc2dOJ+qe5H
         LOFI94d4xRKtzLiwjNAMJwx6kWl7QhR7k2l0TPn9NxTsfpagxMPqOhuNPODhDBk3e4ON
         wd81t7nlGMDJIYXiAeBDkWSqptuO8TXYr7Mp+4ULFZjx9oTIOe3v8MHRlAxfCxaU7b7/
         YKng==
X-Gm-Message-State: AOJu0Yyem+KnaSIlrbWKsB1gl4PIiBDnEiZ/yARdR+dhgGCL6CtOegj3
	yb8Z0IeZAmZM8FavJcO+i3SE2344TIN/V83ridFN40KhUa4BcEGOZS52KCMdhrVWeC5rjOr7JvL
	6UiLoo1VcDveuxxEmQ9Wp6tc9iOIVU16JyxXqiLJPtHUyY/uVltFE
X-Gm-Gg: ASbGnctq6RYiQ8xWt8a7R2IOqKhTLxKkkqgoDZhTYGFCUnL0UuR/4jDienxaVe92/6M
	PFQVZejV/G5UbSVgeN2N4lMUdJh9RKLUSspEixxZhoH9Lhgc2z8+MtDpY00xM0CxXPzh88ND/DR
	xc9QVKkYA4Eo0KrXMb4zAep2p+/47L8FBy0xU2G12d4dmWj2155c0Zq6eInNYCTR1Od8Pe6m3Fb
	9o6D5Qd2xj51GORNo88VPHSZXFlraN1zicEB7OOczKyl7xxgjGlz+Fk5z15fQ5jGylET8Zup4/Z
	X4oP70EGz0GGJs3NT8vkyEYKBFmPRZ5fmSEqKUxQ70ZrQcpwixuNV8QjGVpicSHfy/NIWO8sP9J
	3mgBTwGPY4gcQ+NSD
X-Google-Smtp-Source: AGHT+IEc27rJmKKtZGHZD2OrmvuLl/Cn20PXlrooe8EjSnRJECs5BhOtRCQQ/lkEA3RQJeSPJPMdrCxudQBR
X-Received: by 2002:a05:6e02:218f:b0:433:5c6b:4b86 with SMTP id e9e14a558f8ab-4335f4a07b2mr694235ab.5.1762449424536;
        Thu, 06 Nov 2025 09:17:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4334f45665fsm2389275ab.8.2025.11.06.09.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:17:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EC689340315;
	Thu,  6 Nov 2025 10:17:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E543EE401BC; Thu,  6 Nov 2025 10:17:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/2] ublk: simplify user copy
Date: Thu,  6 Nov 2025 10:16:45 -0700
Message-ID: <20251106171647.2590074-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use copy_page_{to,from}_user() and rq_for_each_segment() to simplify the
implementation of ublk_copy_user_pages(). Avoiding the page pinning and
unpinning saves expensive atomic increments and decrements of the page
reference counts. And copying via user virtual addresses avoids needing
to split the copy at user page boundaries. Ming reports a 40% throughput
improvement when issuing I/O to the selftests null ublk server with
zero-copy disabled.

v3:
- Use rq_for_each_segment() to avoid copying multi-page bvecs (Ming)
- Add Reviewed-by from Ming

v2:
- Use rq_for_each_bvec() to further simplify the code (Ming)
- Add performance measurements from Ming

Caleb Sander Mateos (2):
  ublk: use copy_{to,from}_iter() for user copy
  ublk: use rq_for_each_segment() for user copy

 drivers/block/ublk_drv.c | 114 +++++++++------------------------------
 1 file changed, 24 insertions(+), 90 deletions(-)

-- 
2.45.2

