Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9692DCF71
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918533; cv=none; b=RugA7X8WzU10d0rv81eTfIhnVX3rUURKtcWhgWW9ZMhavB9sgN/Li/TnFy8E+hixh2oo1Kvg4pF0x39bLlswFexVSkB0qZpF9msYKayswUG4tzWYsNizutBiunB+KMz//C/j8+S9lL7U0qWF/wUiNL9ITrlUn/60K7zPKEg3OAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918533; c=relaxed/simple;
	bh=CfpxUiHBdhu2G6Ba7HFsEFU/rymlqX4utjgUVBB7ly4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3HR4Kqt/v94dHR4l+vPytKQMWDC5oMBFsL14FjOeFUK1iSj0ETjtlRRGpb8uiy+l5ku7pHqyhzTqIZo/XijbfH6dZVLIeGg+2g4bboI/zmLV/AxgfzsqxOjC6Jv462n84hp0EBL2lbkSHbqe5/zxyQNq3nAIvwJ3hnuWXItuyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=KPQQCul0; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="KPQQCul0"
From: Eric Hagberg <ehagberg@janestreet.com>
To: christoph.boehmwalder@linbit.com
Cc: axboe@kernel.dk,
 	drbd-dev@lists.linbit.com,
 	lars.ellenberg@linbit.com,
 	linux-block@vger.kernel.org,
 	linux-kernel@vger.kernel.org,
 	philipp.reisner@linbit.com,
 	Eric Hagberg <ehagberg@janestreet.com>
Subject: [PATCH] drbd: Remove the open-coded page pool
Date: Mon, 11 Aug 2025 09:16:02 -0400
Message-Id: <20250811131602.978555-1-ehagberg@janestreet.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
References: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1754918170;
  bh=CfpxUiHBdhu2G6Ba7HFsEFU/rymlqX4utjgUVBB7ly4=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References;
  b=KPQQCul03cpE2v3a8J/51343S4VrnSIKOwhxPcd4nx4XdeWfOssd4cmi3OKnwKjwr
  qbITIRUC+blle55bZ2n6o38qPRlA+Z7FDybdBzOXSZHSnhuf7F2n4GxmTbuXYXFo9v
  XKq6S43UG2b8hJpTeDfF/oUKGB7vvXfwrKEpIiIkdiXMe7jBNBBQIvwRlbf4EOJTIG
  Wo/8zx7mVhKNmOEaA2RXTpdPxvxY+WRbqVnbk3W29IEO0nf/gLL3qZ0G3a7jTm0iS9
  8+T9QFlQ7OsuEzQnURnQoJ+ueUUoY/GDDCqk9HGC8609FB3l4qWcKxVSdXrk60Du4O
  cbs0464r6Qp5g==

This patch has ben running on thousands of hosts here and we've not seen the memory leak that
was happening previously.

Tested-by: Eric Hagberg <ehagberg@janestreet.com>
