Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DE3702F2
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763521585; cv=none; b=ZkzbHuiLePV9oL/cVVuS89mtFhNh0zd9jyv5b0+BsivJL2AnhM5qO+ptS5Vs/pNa7HuX9fmRFkEy9GvdwK/ckSGf0RvMpWjb67C+xGfAPN2Ki8sFNf7+ovCokvRN3h2Ag3Y/plFTDYrXSNNW5lo2T60EM/xH8EjYqn1jMfpvSvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763521585; c=relaxed/simple;
	bh=uEj8XXRkoC+Xw0LOXAJW97xjT/KNry7qBrrFlAhzPeA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FCK5jC+ES5IbsctO+/3J0kzNL7B7sLQ1B870R8YLegqtg/xKfJZRkeYOF0VDJa8H0Ei6+bFehVuRdqGDK9nBexHOZ5OV4ELxDb8ZD0G1B3Z3Shwux54M7fPZqHq/0KTkHZcgvqw1gb/CT3EfPi6KNCfENIDxENemha2HaaTOgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abVuKILa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abVuKILa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307DBC2BC86;
	Wed, 19 Nov 2025 03:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763521584;
	bh=uEj8XXRkoC+Xw0LOXAJW97xjT/KNry7qBrrFlAhzPeA=;
	h=From:To:Subject:Date:From;
	b=abVuKILasUyrWi2y/xM1I65VENXBQwJ+rl8OcQKj1YrePhTow8b2X0AT4rOdxhx4r
	 BEY0Vqa/FcB/YmiClmfBLBtgtaR0NXmiIX8QaBoadsrQYz3ynfY+0gQIKdsfmtkHnc
	 ctdveiBAl3Shg2j5YKHZSSJgUi6uhGIe0dsH3E5ESOOCkbl6TPEUQSIPaLJ5y1XEjx
	 LRBFu575LNk6L4mA+UW7p49riDJJt7rAZX/D8HU37vSzhOmUKD55ToJ4cO/agkrI2s
	 snqEXP5Hueh2jCUosWzX3lLNYAQSE0G2Y1KO+IwqdZHUYWBVSvlNiOxO45QIczJU6J
	 +doh5u7tBzW2Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 0/2] Update MAINTAINERS file
Date: Wed, 19 Nov 2025 12:02:18 +0900
Message-ID: <20251119030220.1611413-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

The first patch adds missing DAfile matching entries to the block layer
MAINTAINERS entry. The second patch adds myslef as the maintainer of
blk-zoned.c. This is a request from contributors of changes to this file
so that they get their patches automatically sent to me when using
scripts/get_maintainer.pl.

Damien Le Moal (2):
  MAINTAINERS: add missing block layer user API header files
  MAINTAINERS: add a maintainer for zoned block device support

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.51.1

