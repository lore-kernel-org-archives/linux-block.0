Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96C1DF72C
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762642871; cv=none; b=jtSOPufFV/tUxOF/R7LWWvkC0s68yq3uNAzmqeR64wmYehQaCJuNu3TQhjOSChy1ia74RiXiG5wfgRXeKPsw5PVHnk6RNAsVQXQ+hRgGrv26g/O2aX3VxbCDyUrPy/wovu/gkCiSIGzKnlaBqbmhTuL3mptxjJbxB3OEJtebq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762642871; c=relaxed/simple;
	bh=ELCrrGtrdySxwwWAm//4H4Qes1u+2MVrTViH+GLXMhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ho6wSQiJgGG15Lk/4C9Fgwj666qydfxgpDwtCLSTTvBpJvgYKbuHgIS0OVw6peH84FSxfv9N6n1ESV9FnRyeX/qPd3EGUMk0auH4StlbPI04Obz5Bwdi5dtFe4iPBsNl6GPGwK5tCLAjcY+W1dcrJdt6zqXmxG5UCSKIhAtdLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NEv/GsMb; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NEv/GsMb"
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-b72e7205953so15836066b.0
        for <linux-block@vger.kernel.org>; Sat, 08 Nov 2025 15:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762642868; x=1763247668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JRDSAPEErao6vhdU+yX/E1lGKcHqsrIexk2wWTATv1Y=;
        b=NEv/GsMbOH4omCoq6q9baqxkEiEHHAQuyokbP65SqbtrXn7BG6VatEAzJe3nRPja28
         PnbKChUoYOxs+kBPpsanN4KhO81p1brmUk9k0NlPXN1FG4DzaNU0z5z5mXb0c1N4FGH/
         +f+tk1wroM7HYlRIOGfRUbzeg1nnm1zFBk/sSiH14b0aesOZtZxPffks9tpgCLmwx7Ky
         Nm/kMtvi7QfaEDcwmuPJjev3Hil3VQGwSQtVffaKqwUbiWjnl8Qt1W91lmwfW80isHbU
         nv94DJGEJ+av/xqU5jISdsRzTjuz8Qz7ar+kq2GOlnIDqJgZJ9PMSsx9zJNUOBVBOVSx
         0d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762642868; x=1763247668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRDSAPEErao6vhdU+yX/E1lGKcHqsrIexk2wWTATv1Y=;
        b=E0K6yw7xsqiIECw+iTjoZGokrLBL3tvLS4hgBy09XPSVweH/dVz+H8CDNismpFoWBs
         4FQ2VMPIXamf/MN4r/7ZUTQ1Zku9hNjlLQnSO9GdWvgLDeSc1x/+qO7h60vtH7/lgI5Q
         esbP1lCVT6o1bGZSNuoPKiLDzHzuFKlMZE3jPqUtzP64l8ekvVq7u359Xd5lfifVBjKf
         pCa8D6AimTSu1HMtJrFLudLt/euZrSTcd/zk/VUvspDX3ZoCsf1F0SyodQmPgYHA2zhu
         Z/SwSK8hNZ/hkTh274+xOyR5ohJpbl88fvpmjaRD2F5KcAX8k4eyVU2oKjmPiUUnuW9e
         DUwg==
X-Gm-Message-State: AOJu0YxQx8KYxHe5+hE2aNRqVQ0+jQR/9vF1SYJpYmEpzVnXzBDR7UDr
	4ARVT0M5jxjVpDXM+zTFV6EK8AaZrfeaJxovoVNMHWEhp5gUqXEWPLumDKu3zKjyoA+dEdCrKdG
	nePz/DrMSXpuUSwWs4gYSclweiYsox4S1K/QOcgYBu5knM7Cp+aKV
X-Gm-Gg: ASbGncvq/DfqdE1DnLgxzDV1sDWIf7Vba7ZlhTWvI3YOph1y38yJ3Zg6fIxCycdKC8C
	LJAFHIv6D9//Ef90Xvs2JMbtEyvdXp/QgAeT7/n3Hh1bJsb7C6S71UILizWNpSQdEodrMtMCpDi
	kthEUPd3VEkYrOqCWMFUN5RQhOdHpGCE+vkCxxYK2mr5CTdtljhwP7pDy9VBdXoke1FWlawwO54
	rYhD3sTMqkKljRW5PusCngoQJm0BGk/WuM4ImXII2XseKoHeJo84DS3zEM0ajqsgIsUFcc/EkgD
	dVVve/3+qT7/30EbZeoRHvk5mfGKM109baEQkI66ru19A9ceqlAfZUXBY8e2Nl0F2N4Zh+/1+y3
	ZkU4+LVXswc74nC04
X-Google-Smtp-Source: AGHT+IEMd+m9WWXrqh8XFpPvM49jh9lbnX3DzcemwYGT2EGH+S6yj+AppF1rpNbc9Ne+H7XQyIDKrQOXg45e
X-Received: by 2002:a17:907:6d0b:b0:b72:dcdb:1320 with SMTP id a640c23a62f3a-b72e05a3090mr211515866b.8.1762642868337;
        Sat, 08 Nov 2025 15:01:08 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b72bf93b18esm102059266b.94.2025.11.08.15.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:01:08 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E6DB234039D;
	Sat,  8 Nov 2025 16:01:06 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E0A76E41BD7; Sat,  8 Nov 2025 16:01:06 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/2] use blk_rq_nr_phys_segments() instead of iterating bvecs
Date: Sat,  8 Nov 2025 16:00:59 -0700
Message-ID: <20251108230101.4187106-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor simplification to loop and zloop to get the number of segments
from the request directly instead of iterating over all its bvecs.

Caleb Sander Mateos (2):
  loop: use blk_rq_nr_phys_segments() instead of iterating bvecs
  zloop: use blk_rq_nr_phys_segments() instead of iterating bvecs

 drivers/block/loop.c  | 5 +----
 drivers/block/zloop.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

-- 
2.45.2

