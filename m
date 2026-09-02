Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD64490C1B
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374249; cv=none; b=AW0oDqVtUxAUJwM+N0seB13XIKM43HItF5uXL4011EBbC7BKFPa7jxuT8Sdr3hIbJZ8F6c68xlRnKjKkpAUYxiIT0YRGXiab8P58aDxQFmL43m5e8FriP4i8a+25vwC4MKmX9gpBoUOrpoTlFmd5L4aDwGNDq/wUzh0IZb6Pv3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374249; c=relaxed/simple;
	bh=k5kfZ76Nc+X3NUrkmtuPJx5+ejj9SwRxHimGl+u1BTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7XSohNCCzMl9MOIFDWlD8+jbBOVqIExQ9t8esy3TZ9J/IOqdmWNcR1rRzYUt1mzfBIVSwgD05hHXG/zKF8nR06yRbcxPKSulplSG3eFqQ/PhUonm8x8xXzmNYbFeHcpQnVREKJ2MJvygfVbpj1PjcbotCDEsMKLpMXE5tthmtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b=y+O0j6MG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b="y+O0j6MG"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482dd6ee390so1431706f8f.3
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1788374244; x=1788979044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKI/iPpIJXftpmW8ewf8Hpv+D13IkCpeu6dCIEp5MsY=;
        b=y+O0j6MGqOpisAZbqdsjrXg35vZR3Sgx2/Xqz3AAmUiz+LY4Pg4MRO+QCsLlvx4y+M
         zJs8UTKxMakAFXf1G8fLFEHiVXMYHaYkJELIzljlZex0ls2ZRed8GYriTr0/whdAljRX
         sU3LrDdRE7lwZrJG/9IN2YLS9hBtuvYf6jrgA0btP0gXf2vlXRKtm0Uy+ZBDEYsyVyLw
         ayBehEqSkoKjt7uyk7qs0mGIB/RGIIhb2YOdODXmi/xDiwziyrfeBDXUWMesX9LNheq3
         1ay5vKd/C2r5+c0rTemIki/V1Y2lQKaxeEPRfWF2vFPe47dZ2O6YzzqNXPcfnoKfXhrS
         cb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788374244; x=1788979044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKI/iPpIJXftpmW8ewf8Hpv+D13IkCpeu6dCIEp5MsY=;
        b=nYIHKG0Sz2nWaSB+vy//oqEbmX+WQRxL03/dRkspR6EXu+fFMW5gNfc9A2UzRj1KKK
         zuR4xXs3bUyKJkJJzFgt2znf5rwkQQlFeooE9sKCnVU3atLwMKxSLMJobWAqP3eFsPQB
         8Ijq4jlNY4VnCJGULXZa4dgsG8eYRsdo08eK+JxvInCLrSP8xRIy8tWItdEwzFefLSFs
         qbA5yj3NAWzL1RLmVCvbPQo4+HZEsUEoneXsHg5knb0vHfkfC+2DVTuQDGqeQ0nnxwDS
         iL17933ng+SnOywI3Nc9fJRho0ZVdXy37ZL4oeb7zMKfHY284lsrzj7Q8mZ+e1DhGOc3
         etvw==
X-Gm-Message-State: AFuF++lnFnvcLO/sG72WTeJqWu2Yn6hBrOnKDrh0KvQS0QYl+YArkPUO
	nHD81MO8rVImFouPfuDnliiDtd5/QBW3uUlr8U0TASNveLX5D8QfAsXfV9F+OCON7awEcTDYKCG
	PYpF1FRs=
X-Gm-Gg: AYBFou0FmJTOI4T1ttxVDjFDWmPYq+p9YkHO5Z8XrekUy4tuz7NFg8rO6nCbkSJZOC6
	MhvPe2Iwu3pkgfHRDk88jxLcbfJDdIf1iMNl7HrekDfYgV5AyLc7MmxuWCnRVQDTzZIXO5WOq2G
	SW06oBh6kxkPUuq334PStSdfTHaK+xrvx+xg4k1sPejTJv25GorkMhCOs5NdIfbA8qV+ULuCUOZ
	LvpYH0Kfeq9KpJZGNyIjp9qwc/4oQnThA5/ExDzWqMe4k2+w78B1aY1FJckxTlB4C2N+v/D37Qs
	OAgd77Op73wX3VrUTRWGoDgjJdfeKAqi0+wSRyWvQCz9xAvpci3PXATnfnRKQZ3uuzk5FqcCXj8
	td1TfpUfG6DjhWHMtrN2jgzoHFa6eeKuUte6kpxQmV/d4PqQRXbT71Oucdw34d+TVvlbN3WMcYn
	znSjDIFMsmoyeWGjdzsmDyrX63q84ToAdEB2cAgL+YNbczdXR8sbK+uJt7SS69RI9ZVEQmutctF
	1tRdS53y5DxDoMYqPSJtDh1RHvNSNvjk4FfRSDBQ69GWgbh
X-Received: by 2002:a5d:5985:0:b0:484:40f5:da6a with SMTP id ffacd0b85a97d-48488f103ccmr14448096f8f.15.1788374244428;
        Wed, 02 Sep 2026 11:37:24 -0700 (PDT)
Received: from KernelVM (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80020sm8482309f8f.10.2026.09.02.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:37:24 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 0/1] cdrom: patch for inclusion
Date: Wed,  2 Sep 2026 19:37:22 +0100
Message-ID: <20260902183723.1584-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

Please apply the following patch from Manuel Ebner, which fixes a typo
in the CDROM standard documentation. It has also been reviewed by Randy
Dunlap.

Many thanks in advance.

Regards,
Phil

Manuel Ebner (1):
  cdrom: fix brackets

 Documentation/cdrom/cdrom-standard.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.55.0

