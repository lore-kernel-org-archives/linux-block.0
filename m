Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3771B3B
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120724; cv=none; b=O5Wc2jzLnGWaX572Bb/EeAnwAZXxxue9lV1zJU0kSn5iyitBAA3oVoK8E6um1vwnDshMiDBW4DCZJ+RAfWvOjQc0hQbXzC6NUf+bYqf01V12A1eioXPMFEWeZ2b26UHaXF7O3yTJw7FtNqajLmWOOW3ZQ2Q5j0OkClPFszxBRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120724; c=relaxed/simple;
	bh=cdmwGod86e1GaEl/KcA+WhyFzaSJgaV6HXPz7qipZ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgXj04ZOqd8M0GRwt7tnAlgy3UKgECsvTwiGEpPAIxpV6cWhoDTL7mCkbXGN3UOsceQ2KBm5QY5i4BqYUMYSKeU1NXPJG6YHTLT8RlVwcvAAV+BmwV4TItWa70HOHTnnxk6dAO1snubaP6c3jxJ6QmbQ3V9FD/xhPGiT7Bv5XqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=sU9YEQO2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="sU9YEQO2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41ba0bb5837so26031955e9.3
        for <linux-block@vger.kernel.org>; Tue, 07 May 2024 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1715120721; x=1715725521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UjBQYEAlMSfNU69eljTVaTQiLRaL/00/PFqK1oJM2tY=;
        b=sU9YEQO2T6fHGf5NzLDVBJvInUeIYUeRA5TIhFcb+zAGTrbxJuX0lrRPX8VwB2WVa4
         7FzxiUkyA5EuawW22pVsRecR/KzphpO19RPtkXY2qstWC+4zFIATyzCb2s4acAbJSi35
         vvaK+fXfqkZSEuhGZ+r8RDo6MTcWTsvZEenQ91NRUoz3WPBzmNtBIICgjBBuBlhEUcMJ
         7H0TqTx3U9FlszjuH1Ni+CX3REfBSaxX9TMW4YOPmdlFMh22I1SqkMZNPgZa8aaQhwv6
         kvgCACJunAQpdDnXg78N4uO7OvE/2Xq9xhVmYCt9tJQhb8ekZ7+VpyWfQA4NCNglAuxw
         rt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715120721; x=1715725521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjBQYEAlMSfNU69eljTVaTQiLRaL/00/PFqK1oJM2tY=;
        b=ZqGzwdeSGZGN4T9mQZHcYIrV950k/juZf0ukX5PzLrUVuPWqtUdp7yz78L8A1lSaCP
         BuQWrhyWquRBHkmDiaNvIvAzqp6vIGdbnNWSoW++M7ir2Cs80aaK35/tRBf46ckNQDPc
         qHUWfEUZxIs93+L3RirAFAZtTdLfAoagoFzbgI35ROXyKxxPECiJMsyG2zL/hybtJT7t
         M7tn8u0nl53WQUDbr7ycJ3Qp/eMY7hhIhXUl/KfRu18x0Q1cV2gzpiRFuK09G3GjFV4z
         XaS+Izi2WRgRZCqK/9a3BCfEzddsYrjQ/5D9POwWx1xk/PlrmmiF5K3GHPU7K6qYvTg9
         FOBA==
X-Gm-Message-State: AOJu0YzHCvM7vGfgO88eJKWBwetevgSDAtZK4pHaBrYx/+Fj1P3Pu/4+
	2O2thB3SIDlcEAYm4UJoMDZgDSZxt4BnNCMs2GxrU7jWtg+s6Pe9qwKMgS26VYQ=
X-Google-Smtp-Source: AGHT+IHXPerYMtIVBVSuzqJV5UJK4N1b1bqNqHFCihndejng43jN8S8Wgt1BGoeod+4lHOkXaRSbSA==
X-Received: by 2002:a05:600c:4e12:b0:41b:b013:a2d8 with SMTP id 5b1f17b1804b1-41f713095e1mr8803805e9.10.1715120721211;
        Tue, 07 May 2024 15:25:21 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b0041be4065adasm54878wmq.22.2024.05.07.15.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 15:25:20 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 0/1] cdrom: patch for inclusion in 6.10
Date: Tue,  7 May 2024 23:25:19 +0100
Message-ID: <20240507222520.1445-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

Please apply the following patch to your for-6.10/block tree from
Justin Stitt, that changes a media change condition in a sensible
way to not require a subtraction anymore, thus no longer triggering
the re-enabled signed integer overflow sanitizer in Clang/UBSan.

Many thanks in advance.

Regards,
Phil

Justin Stitt (1):
  cdrom: rearrange last_media_change check to avoid unintentional
    overflow

 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.44.0

