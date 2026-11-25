Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604653;
	b=UTtWXz4RTiD64g+ENkvpswLNGqnUK13ASTsmpgEqu6r6hOHEo++EayvTqQkFxHeN80Xw
	 vrNaLKxJy0fwj+UnzUFDw1Fd43i8z3XflOOTm0xArb5ckU+BXEgAerpCZGUQ3SwStlw3J
	 n4zCG60BLPEU9PMOb8pVMJzRpff8ElFyp9Q6qy6HtG2PnLXxU/H5JDOZCfwmARjs1kJXr
	 YJU26yKLLF7+5EzClujDhTH5fvgqCFVc8/3Yg4yikO7XlHevZnQ+X5ni14Lnz/HksUY0N
	 rA76wwUbjJh31vxgiRgMWTyDa+xtRrIt+bDzSYdF7DhuKMiNvwdGyMGW6CdojfBZTXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604653;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3Ed/dwsYEtwCWH9KjuZt1ohLbpuZvRwKKfK5cvZH8Hs=;
	b=OWJApgaTZyIL0fXINOIz0mmfGNevKjeSFDV9K9pAz+MteKfNASiuaQO9vy3ioafk6WDE
	 x7IUWuRuUQoh4WZOtIA1ywffkJPwp0qXr3uaa48Wl26oQZDWvucf74Yg8cqQ+5j0+h39F
	 iFZ+yYoBHZax+Z4hMGgHdhaTzyctvzd4Nnbxm3h00lD2Jqnmz6H9FBwhdptVYnIMnuRgu
	 3y2qK+zijtqkgitkVPZvSO7r+pNTGrf41N3Ht/UMpTgVlcbl2ItH97AMIQRruhrvQJGJ7
	 oW559ExG1xFz8UA668+BBJvvBonLtjwkw20lJGWiqceg9+hPftRWTFqMHgKCuIhPYqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=w7TuWmIZ;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEB5606A32A;
	Wed, 25 Nov 2026 11:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DEB5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=w7TuWmIZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=w7TuWmIZi9CEgr3hX7ejxjWTpnz5EjVSaZSyLxdk1dkcvgyPOAUImfSiCOvRWKzOsBoSjREZEp1az
	 bAIszhVj4oJ6GXTy31b46dX4PUoYwTjATYZC1opVgdXCTohawZ8FYJpzYDYoJkB+CqWcTz3rbsIRM1
	 oPeWtxk/0pqT41u8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46b06c0a3b3e-f23db;
	Wed, 25 Nov 2026 19:04:06 +0800 (CST)
X-RM-TRANSID:2ee46b06c0a3b3e-f23db
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96b06c0a3c87-442e4;
	Wed, 25 Nov 2026 19:04:06 +0800 (CST)
X-RM-TRANSID:2ee96b06c0a3c87-442e4
From: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: tongzhiwei@cmss.chinamobile.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] block: fix divide by zero in queue_limit_discard_alignment()
Date: Wed, 25 Nov 2026 19:03:51 +0800
Message-ID: <20261125110353.366-1-tongzhiwei@cmss.chinamobile.com>
X-Mailer: git-send-email 2.45.0.windows.1
In-Reply-To: <20261120103040.610-1-tongzhiwei@cmss.chinamobile.com>
References: <20261120103040.610-1-tongzhiwei@cmss.chinamobile.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christoph,

thanks for the review.  Please withdraw this patch.

I do agree with the design to fix it on setup.

Sorry for the noise, and thanks for the quick review.


