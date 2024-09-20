Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA38142E76;
	Fri, 20 Sep 2024 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726830248; cv=none; b=mUAF5hL8QQCZTDRnq5Mdl1aZF0wcHNLYmdtrcvDaQFwFIu1wtY2I1scO6PPpJRCHPL62mwADwHQuPm4QXFuxl6LACRgWK8sX7qIbR5Z2YkD4ibxmaAIlUJ6xEXI/7kXN26l/Pvl8utg6e9fwGW2ZP5N09w2nom9FzgZvD2G9/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726830248; c=relaxed/simple;
	bh=k9ndXh/Z2Lyi5mD7CmboUdiTNcsMfHAILqtOJ7bUFqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NpeMcagPy9T6AmIaezsQz5+FRfVd+QeGnxOOMAvShQS4FKM5bzKslebxI2tx855zqstz6HNDz6n9ZZ0+W2NuGw0XnZpvH0e7+iNl6L69kIn7n0VuTEUpKaOQgCVOjZYd1WpMwfYLGQLUavE87hLPQ0+SH8i1yk72viYhWr7ca14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BWOEimD0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BWOEimD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4320DC4CEC3;
	Fri, 20 Sep 2024 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726830247;
	bh=k9ndXh/Z2Lyi5mD7CmboUdiTNcsMfHAILqtOJ7bUFqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BWOEimD0k41i6spYVEccLuUPnaEIm9zoJRbTyyi/Aj6jZreN/e6XNXvhwLuYMHB/g
	 JPqkmmyho3hnPqCjpkeCacGU3rj7pzunF+4G7rSXrtdVZeKds+ljHu5K3Ij8tKUOqQ
	 k23GFi9J4QArZYzIor9yPC2OP8SDZ3bGA7FJkbxY=
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Fri, 20 Sep 2024 07:03:26 -0400
Subject: [PATCH 1/2] MAINTAINERS: fix PKTCDVD DRIVER to use L: for the list
 address
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-maintainers-m-to-l-tweak-v1-1-ea80b5cd3420@linuxfoundation.org>
References: <20240920-maintainers-m-to-l-tweak-v1-0-ea80b5cd3420@linuxfoundation.org>
In-Reply-To: <20240920-maintainers-m-to-l-tweak-v1-0-ea80b5cd3420@linuxfoundation.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 soc@lists.linux.dev, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=899;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=k9ndXh/Z2Lyi5mD7CmboUdiTNcsMfHAILqtOJ7bUFqg=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGNLehi3yXTh166Eq4+YS97c6ix9Ki847dVB56cQbEz5Ju
 q2bFlCypaOUhUGMi0FWTJGlbF/spqDChx5y6T2mMHNYmUCGMHBxCsBEVG4xMrwx5NE+fmxpMse0
 R4IrXzp4acw3Ekzcd3jKfFNDGf3T4jWMDFP27vzBf07b3mCP0ZZv75I2rp7eV3r+y6OQBpevf94
 pXOcCAA==
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E

The PKTCDVD DRIVER subsystem has an M: entry that points at the
linux-block mailing list. It is perfectly valid to have no M: entry for
an orphaned subsystem, so change M: to L: so it properly indicates that
the address is a mailing list, not a person.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5526da33d4cc67eca7dc0c36410e570ba492486..60f07c11353412891707311d6d21fed94156ea8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18263,7 +18263,7 @@ F:	Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml
 F:	drivers/input/keyboard/pinephone-keyboard.c
 
 PKTCDVD DRIVER
-M:	linux-block@vger.kernel.org
+L:	linux-block@vger.kernel.org
 S:	Orphan
 F:	drivers/block/pktcdvd.c
 F:	include/linux/pktcdvd.h

-- 
2.46.1

