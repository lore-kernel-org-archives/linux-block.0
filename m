Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0127A3B1034
	for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576665; cv=none; b=Dl8Ea9ihr2ap5f+zWDC6B+LW/90flGNEzX5weYJ/aaE3nS6jpV8f4P40FJKSd8U2Z8tTRq6aLm/MMWywGINAmSUDX5MD2JjUMDBjsx5rqetdT5i2zXuG/5XPsPPfvQ6Ti2vBgxzrEQyysmxP2MRy7i34SK59gr1bfVE/IKZnYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576665; c=relaxed/simple;
	bh=v8IlEKMDStUjOQv0esgJZ9jSoqmbxKsTaYrQiOeawqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5PoA8eSg2JJZX4KROHssP8uRXeEQOaEzlRun5xakbg3BTLgSHnVZUzaD6Hl4CXN1OKikM0sFiX+pliw6wckMTU1f5+YzPsN0G5TAjyDEAtunU/5YVMsnxlTjDlSG3V4lpyZNQ5OAcxTVfm4tHpkp8mfEnpSUmPMUU+r4Lxdo2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b=Oaeh4E8M; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b="Oaeh4E8M"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47de0093c42so5782073f8f.3
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1784576662; x=1785181462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W9vqeady1YfwdygOjWYvP9P2M9PpzsTLEpX3WiTv9vU=;
        b=Oaeh4E8MA9O7Q7KvATS8OO+xR84kxG401IDHP0MmnEfN0zkdpE8CnjUvJmLlgRVZsI
         w957sSaqbtPX5L2YAsUYIvQcOHw+z0ehOnlt+Rjnmug7wae0OkIsIahE4sepHRZnoEHC
         yAa2nnHdh+h33nCFArklDIlVQq2+7JDSdxd5AmWysoe1iScJP9XSJMTS0Xau7TT478VJ
         gzO4zrtCeR6w0X5CBL8YdNRnKD35U/i55Ea+a3E1bUMOXbhK4i5ThprC+8D/EEEfOyqi
         G1dWxL/ZiynPc6h54mgb8vdkapserxAoozkjtJI6qsC2xrqT6cEmK9tXDG6yKih/WUc/
         hBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576662; x=1785181462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W9vqeady1YfwdygOjWYvP9P2M9PpzsTLEpX3WiTv9vU=;
        b=H6+bia6Wa9oYgSD7L0IDNrS+jpAkfjC8ci5lQ+55cZtlNj0tOasUDE1Mx6kVglmwAu
         2wT/DOopKry93bRAXMUW09bI1VFYwwjW58EFNb//XIh5z/Fhj5J+U0FO3uPrNt+asHqG
         yT05VWThgu3r4dS75Dd8MzFD8yBSIJpYbOAatKDgARTHGhDVmrEdHCMKPJbCd7xeQk3g
         cpP7a0ESyCiD8EBKJTLaEvzZgtz09VhNfY8ZI2Qp443aqNGVrbOfBSnl7m9Z0baXSIL1
         YpDCKy5l0XWp6xe6msAnqFIOYq5p+YrmOX+GGwfnOd6uC0/JW5/1ZwRK8NNL7j1AfCDJ
         PqBw==
X-Gm-Message-State: AOJu0YyNRfwEtv6+QHtwzAZqcAgqMQG5V+ALChDIT1E4PJlxysmWMB0i
	3QGXAgDIbJG9r+DS38shY6AZuqY1UuyVrKZ2ntgGamjE87zNEqicte/Mrf1DHr8rVnA=
X-Gm-Gg: AR+sD13POVKZHMgF8jyf2XqpVOAFQFoQ4r8KdejH9/MwAibsx0yZBdus7wQ7F161m21
	vOauwvIT/oOoZ0XmbD7AppMpWtginP5ve/XeItHz6yScHCsdN4yEOqnxDFBerim0DRMHpBPZfra
	sD+hElYLUCLuuchziwotEL8K6k7G4FMr9GYtmAfd/q5Z2M+ANE3olRVLl4mjlP3UctDoFrxZ4xJ
	UN0UtJ2R9JBtxQ9vvh/P3DOnfgBds8qeP3ZWbLhIaGahO+/qUXe0Ej9Y+QcNs2w/VtlA52dtg4R
	sLB6CpVh34GCHILIV3456LMhuB6pBukW7CYKy4nHizNCG4vbQcXGN67vRVQGm1MdsJOjZuYP8Tg
	Icr0M7dKk7+XA8IyBeeqrCcttP6suBWhH3eEjrtOhEpPGf/XYdgs9S+YF+u7s19dWgjK6Q7O65P
	EYso9eHfhT3XNotPNrfXE9At2NO7MWmQq+cVuYYYM2TDtxu4uBZ0PPBF7DxMNaxQ==
X-Received: by 2002:a5d:6f0c:0:b0:47d:dfc6:b28b with SMTP id ffacd0b85a97d-47f6231c388mr15929041f8f.30.1784576662031;
        Mon, 20 Jul 2026 12:44:22 -0700 (PDT)
Received: from KernelVM (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51986sm37031348f8f.11.2026.07.20.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:44:21 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH 0/1] cdrom: patch for inclusion
Date: Mon, 20 Jul 2026 20:44:20 +0100
Message-ID: <20260720194421.1497-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

Please apply the following patch by Xu Rao which fixes an issue with a
stack array and length mismatch in the CDROMVOLCTRL ioctl handler. I
have reviewed this thoroughly, and in addition I have built and runtime
tested it, including the ioctl in question.

Many thanks in advance.

Regards,
Phil

Xu Rao (1):
  cdrom: fix stack out-of-bounds read in CDROMVOLCTRL

 drivers/cdrom/cdrom.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.55.0

