Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC1145B00;
	Fri, 20 Sep 2024 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726830249; cv=none; b=Uukekm7BteFsxZjM1KJIR9FLs9028J4lCTmSltBHMOPr7A/CdIZJdX4Vl/4W2vaYc4fy51v4b3Ec4TI6V50hNy/GrmZa+4cU15hGpSEVjuC7SJQ6ts69FKzWi7HBkcHeCcF7BxzY9MMleCfTuStMCDC696mRqC4XLQkJpdvYDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726830249; c=relaxed/simple;
	bh=/NmMJLxTvWxuIn0cbaOvs14svwWZw49nE2EhDGPDvZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bhjdV8E08CKMD6D+oQ7qMC1d5LMrDG/ZX/Iadj8uW3klV2Ld1Sxwg3ABbNhhbr7ZyHeZ6cDq9FxdQSN0X/da5DeF5GJ6FN78O1+0OYAe3zkyP/ZO+YLuKwuX2fq+l2IzknvUKoN+UO/8yP413CSfJICJEdDw/XRQdDJyRwBgSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WfPtNv7T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WfPtNv7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A49EC4CECD;
	Fri, 20 Sep 2024 11:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726830249;
	bh=/NmMJLxTvWxuIn0cbaOvs14svwWZw49nE2EhDGPDvZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WfPtNv7TDfx+0kosdXY8p14ik7o8x+kwrM3OOSDUP/EljL0ChuzYTGDlfZcM+z4Mt
	 5FG1MArxoku2OxMvyaMdkCcq9iSNEUwrInDy/LvYsiwYW8WE3/s3DPxM0FVUTuatMg
	 Sg5Ao5BnAU0ku6s7DhrJoTEVrHF2FC3SG/wkbQ/M=
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Fri, 20 Sep 2024 07:03:27 -0400
Subject: [PATCH 2/2] MAINTAINERS: use the canonical soc mailing list
 address and mark it as L:
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-maintainers-m-to-l-tweak-v1-2-ea80b5cd3420@linuxfoundation.org>
References: <20240920-maintainers-m-to-l-tweak-v1-0-ea80b5cd3420@linuxfoundation.org>
In-Reply-To: <20240920-maintainers-m-to-l-tweak-v1-0-ea80b5cd3420@linuxfoundation.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 soc@lists.linux.dev, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=/NmMJLxTvWxuIn0cbaOvs14svwWZw49nE2EhDGPDvZg=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGNLehi125v/QvP6Jm9Ymw4v5q489LD35d7tfe8ey+ynqL
 7VaWR4rdZSyMIhxMciKKbKU7YvdFFT40EMuvccUZg4rE8gQBi5OAZjIsS6G//6fZ4pNVLyXn8Wv
 45iWMX+6WmJNI0Ojl/vFspWsoYLzvzIy9BmybvQ/ZtPXbr2xqyK2dfHj0pSIyQqqbIkGcgL+2kq
 cAA==
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E

The soc@kernel.org address started out as a mail alias, but at some
point became a mailing list. Use the canonical name of the list and
properly mark it as L: instead of M:.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60f07c11353412891707311d6d21fed94156ea8c..5f9a0e2ca5c7470a89a20517087213e916ec9e09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1717,8 +1717,8 @@ F:	include/uapi/linux/if_arcnet.h
 ARM AND ARM64 SoC SUB-ARCHITECTURES (COMMON PARTS)
 M:	Arnd Bergmann <arnd@arndb.de>
 M:	Olof Johansson <olof@lixom.net>
-M:	soc@kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	soc@lists.linux.dev
 S:	Maintained
 P:	Documentation/process/maintainer-soc.rst
 C:	irc://irc.libera.chat/armlinux
@@ -21650,8 +21650,8 @@ F:	drivers/accessibility/speakup/
 SPEAR PLATFORM/CLOCK/PINCTRL SUPPORT
 M:	Viresh Kumar <vireshk@kernel.org>
 M:	Shiraz Hashim <shiraz.linux.kernel@gmail.com>
-M:	soc@kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	soc@lists.linux.dev
 S:	Maintained
 W:	http://www.st.com/spear
 F:	arch/arm/boot/dts/st/spear*

-- 
2.46.1

