Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7513AEF28
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707142; cv=none; b=tj0gC1j5PN8OJY9Lw8iwMwXDF9PBBuJjJ2+O9XROr+bX9UrYTMORnyY3t+Tkdiz47bWTVzQLcOKI2bP3gqhH8NYkVJSnWrPFbkAfsolMtWuSgcDyeBEMO+PAqVu2Y6xmjJuu/wyKCW1JRMvjiDsbGUlcN+qlxOA6Bt/8uKJE8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707142; c=relaxed/simple;
	bh=W+IZT4lm8eTvmuYi4jc8cI9w0GwrE2RFhKBcdt3CeAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I63by6edGMfjDkH31cVuqmu0wtNm7OPxGj9u2Jj2EFuuqisdhrEYC62r0/GdlBIhj53Js0nu9l2hlW5hHeCv1NI9puzwCx9GbdbC3y1s7aUgBqz3+t2SUmI3s+bzkfxtO/G68qv7ga0GtNaa34wwhNf05jXR8UZ6DH2ih2jnr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GWL8gq6Y; arc=none smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GWL8gq6Y"
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-12c8c3f48deso240913c88.2
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778707140; x=1779311940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFK5xCMLqXEdldmPRaE9fIROx7TOzGdWNTbY/u38MiE=;
        b=GWL8gq6YRQGAb4tz3rvymGJzW+kdq4qejN8TRK5cWLnoBSCvBOJMUs+OJpKKC7I55e
         /bP4LQvktN9VEGkpLq5fDsE7J9laJxKO8DxR1HhfF1oQOlf4R/uLnzVgnSagBh0bAYEU
         Tk4ORM+GyIUpfPy61CA4cJGqn5nakjlCCOF5EIoBO97BavMLXee5s2PxtDw9hldBCAUS
         z/ztmn54hErKMp/b5W+tUFQhgh/Q7jBemKvWHibpYBMGT1dOWy2vJxNeeAEvVYYSaGu1
         dtVVsPcNCfR13tm+pxkabvRCVN5RiKWp61chrrJwPF+G3NHO/XkNctsJ7RF/sp7BngYq
         otjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707140; x=1779311940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFK5xCMLqXEdldmPRaE9fIROx7TOzGdWNTbY/u38MiE=;
        b=YwP+mJFFpZtZ7pKKQy2jA0+LD9nxTTlkDgIYCcws2ZfqfudB6efy//3BXwZpYPW0B1
         O0/j+6M6Q7euFsaRSwRTBpKH7KVvySCzBMi9wzbZa1/TqUnvs06VuY5kZyLacw646bUx
         MsnIx6PDwaW1rXaSIrVyUqeD84oCubT0b7Nyh1weDEHrl9YwnafSYWL0lG6gk5mVHS6f
         lOPMxfNl1kQelQzeV3WzmtaIVj35kwnWLHeGsCbadgN9oOgZsY3l4uVMtjqlZEudU1O+
         FU2wXUGtFMcNwGxzdmQ9/a8At7Mdqbg/7AerBzFFeUymPVd5iveASgAXJY7eYR4ZXcRY
         Z8hw==
X-Gm-Message-State: AOJu0Yxz2vJ1s2nxqnAxggKf/bfQseSdduA0MfOhqJANb8soe8/br5fg
	OJ0PmQvdYDZHrnl11yIPpXJn2Jfm0nSFZ44I+kopgHsPQxUOWwtr+/fdUxtgSIQ9QSp+etjyt6T
	p3S0HB4vy4IdLGjPalrV/85ygFDJVIyMOkgFJ
X-Gm-Gg: Acq92OECsSfKpJbd4J+R4xQR5MXTPjR3TG8tYVqxCOUBlf0hTT9FrgoZPvOFTVwv+fS
	dS27NDwWod90x9U4QAYgd7PkZBQfyWbjafebG4oC+8BxY2/I67rD6IZBkQEw0WLieLHKwftduDr
	RU5nMRjeyzcedC5HXgJbpcnJrhQDpeBMn+mG0+zvtkw9ZHWNiXi332khIUejlA6F4Y1HP6gqx4i
	XW+gDDBCs2M9X1x02vThGKuTz5DmXllz62eFdOzOyCIA/Fqyj/ZWoObb7cnTJxfdBkyJC3B1duf
	+QszOBIieqY1lyL3j7KWzAe2NDRw/rQ/RbBvht4Mi+WQwLMUxVm+NO77kxzIVqDQ3ciPM4wQXD0
	PrMQu9Y2Xtor9pHhioSZeEQ4ViFT45VeWip65/TilipQUyEeSkVK47w==
X-Received: by 2002:a05:7301:fa12:b0:2d4:62f0:b2e1 with SMTP id 5a478bee46e88-30114374c8fmr1424231eec.0.1778707139477;
        Wed, 13 May 2026 14:18:59 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-302944ffbbesm28820eec.11.2026.05.13.14.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:18:59 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.46.22])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A916B3402D8;
	Wed, 13 May 2026 15:18:58 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 92396E41188; Wed, 13 May 2026 15:18:58 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 7.2 0/2] ublk: optimize ublk_rq_has_data()
Date: Wed, 13 May 2026 15:18:44 -0600
Message-ID: <20260513211846.1956810-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_rq_has_data() currently uses bio_has_data(), which involves 2
indirections and several branches. Introduce a blk_rq_has_data()
analogue for struct request and use it instead to save an indirection
and NULL check.

Caleb Sander Mateos (2):
  blk-mq: introduce blk_rq_has_data()
  ublk: optimize ublk_rq_has_data()

 drivers/block/ublk_drv.c | 21 ++++++++-------------
 include/linux/blk-mq.h   |  9 +++++++++
 2 files changed, 17 insertions(+), 13 deletions(-)

-- 
2.54.0

