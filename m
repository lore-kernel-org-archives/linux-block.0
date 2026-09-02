Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4714A8A22
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374249; cv=none; b=DeQ64P+rqB+9Vf94DzN3D0fnoFlfZDqr6StNzuCI7tEpfCKPNL+L1TgkClubRDMBJC4bBTSTh6XylBykXnBmzxbvlST7q516tI4PLt6h71QQR++8R4zy05eygoDWoE9rn4IhsR78K8MKrQu6UQ8Jmh3PE6gEPbDf8xo8gszaQ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374249; c=relaxed/simple;
	bh=sDiBzvrIeGGcOoW8jB0jmI/sOrJQb3Ec2Q+DjE0Wbwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eznezvAT11PW2niRAmvT+oUtelw93IryKyyejRLnrNkw0zstbJrpDblO1FW0TwM4ak6P/gyARQU8RnTmkw86Z1xs+KCEZ5zhYqAfwiKdMzFecypYVB8Cn2VwKQHjVzwqdzDN5mi/pWWfwmQQwlJ8gdoPFMGUyKRjhwXYV1V2ULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b=WJxQwvnR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b="WJxQwvnR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47de0093c42so1518229f8f.3
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1788374245; x=1788979045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fW70CWoXK7UdBCsCLsbwU7NeRdCgF+7xxCY44/2OdfE=;
        b=WJxQwvnRv+76orFSsIC+RevuS+U2MopOM2IAc9ruBBV9VQ4UxIfcbGk1/oNwtQUntZ
         UoqXNc1a1F7sMnPvvH1qVTasjNokRM+QqoAddqdcpuj1tjR3o9URlxm4xA4poWW+x+eR
         KdyAW5L866IzYlHL0vb6Hf+rCnnOtMOMp1Jr0izruMS+Z0w7vnYwEQ7NOF3Sii1/alsL
         J8KqNCxK+7K8oNgk+k87vKq/MOSomL1lb9oHV3OnB/ELTALspYA9B45mSfvNC0zF+CCi
         D3SaH3Qp/OvgXyrOJahKk5rm8QnenxE4u5IwjDiIUv+OWfjsuKJ3G2X6fIyVRslqIAyd
         IQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788374245; x=1788979045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fW70CWoXK7UdBCsCLsbwU7NeRdCgF+7xxCY44/2OdfE=;
        b=e9wjsl8oMRxiZ9+6ot2QSn4Ma1RAomUfIeJNeUTaNKMilgX1b3BxE56Ia7GQ731OO1
         18WZUc8fAhcv0sFF982JAjRcMKu+UNfMf7ZoT8WPTejx8wb3dOi0YP9/oIB8bqWsfIq9
         9tfJ7B20y2Pc43r+dSyKiV/QXvd9rvXvdtRsxe4v8puoTdQ+O92v1EQdtLmywslPLv37
         w6rvBfj0rGapdmGHuwOocqoAufXud/bQD+9NVoo8RtekVlE3KxFOu1dgfoSwhs8Kg0Oy
         c9WL5URpIk+XWpnoH5fAoY5jVr1tMDTman3GlvdzXD+nokQsPSKoRscLf3Kq7qH+HzgV
         B9qQ==
X-Gm-Message-State: AFuF++nYAOkhM/2iWaQiMA66CQ4KrhYhXTRrPCu58O7dZKGRlfE26ehc
	nhJYih0bJ/tLoCwEO4cd1HbyQ5MwSUjG0RgwFeSOwxp0aNk/STT6LO4HjJCQ6dfsNX/PL9Qyc/g
	tD0P7FCE=
X-Gm-Gg: AYBFou1514RsNoqwjDQaylgASA7pKQAoherVOiaz47XZi8G5t9ZOn+lJywiccvzcv0L
	LxXrHaywnB8WBDyxfkpDmlpw0kHUSWOOjKsupMFxF2aa7hCX/11WH+g6qwLGoF1/04u5Iax1VZn
	Yu2He1eGgAOh3v/o9qSBtiUzUQWlIiOB5lVJBYHAXGAX/Ru4KjdvAXftPrPorArXh+TMOZhHFKf
	V+GxbitH1qHhomualbYE4a5BpL4UWlWwZUGziNtCZG4dgADeziOIyYdsHNdU6Zcre6SuKX2mm/f
	P/4A/ttYZiAUZxIahoXnx/WyGaRmeeDko0Fjt8/hGuCygjVO8o6lsCtb+LwuCcELomK7cFu7u0o
	SEynUJl9R9HHOXLZ2m6ZUQOU1BIdEzACa0bWrnI2WpeWMpQu9Z0iOnJuhYK7eKbMl/gUf/DtkuH
	ynHuzNH2OjPRhuOPJbf4yn+3DComOtTyIY9uSjFfWXYV0GbN82XGG8W/ag/mfxEUlUB8C4Vh+Iw
	bFpA8GllkNr6aTGzxFqS/EDwaFzL69waPCx69KEn0G1azO/og==
X-Received: by 2002:a05:6000:1884:b0:484:410d:c5a with SMTP id ffacd0b85a97d-48488deee78mr12151705f8f.5.1788374244903;
        Wed, 02 Sep 2026 11:37:24 -0700 (PDT)
Received: from KernelVM (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80020sm8482309f8f.10.2026.09.02.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:37:24 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/1] cdrom: fix brackets
Date: Wed,  2 Sep 2026 19:37:23 +0100
Message-ID: <20260902183723.1584-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902183723.1584-1-phil@philpotter.co.uk>
References: <20260902183723.1584-1-phil@philpotter.co.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manuel Ebner <manuelebner@mailbox.org>

Fix missing ')' and add '()' to function.

Fixes: e327cfcb2542 ("docs: cdrom-standard.tex: convert from LaTeX to ReST")
Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 Documentation/cdrom/cdrom-standard.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
index b97a4e9b9bd3..b6dde1d1eaaa 100644
--- a/Documentation/cdrom/cdrom-standard.rst
+++ b/Documentation/cdrom/cdrom-standard.rst
@@ -1014,7 +1014,7 @@ How to update your driver
   just calls to the routines you adapted in the previous step.
 - You may remove all remaining memory checking code in the
   *audio_ioctl()* function that deals with audio commands (these are
-  listed in the second part of cdrom_ioctl_. There is no
+  listed in the second part of cdrom_ioctl()). There is no
   need for memory allocation either, so most *case*s in the *switch*
   statement look similar to::
 
-- 
2.55.0

