Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E7E3093CE
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683128; cv=none; b=s9ANV3n1gRUA3ePgNV1GMC1pMvvMgMxRq6etYG+w8KI3qCGufXYM1mmjjFywXgifAnbg3OXjDIj2xgodvUxP8vdVxvSnKuuwMK/uhSYC9zbLqKdkAgZcSOUWiRxL0UavoaBqO2KF52vQYZaN9m4E6HIEYE1F4P+BpsYaIoE+2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683128; c=relaxed/simple;
	bh=/jy8PWjGAF9cEhVahjUz8KqHL9lmBNs98pIAwzSS4vE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d2Pk3PTKlrGuUeIacILUndyj8Ykk0PV3FpE4Xk38gjRWV+1GlyUYp0JI5lyr4PuAQaNyX2WLVdRZpNbj9HNVvcVqlf7xeuh0Up97HnWLi/dERg+cnYlcC55p8XlstOrvvFTckDKkPKsvWCC0eHdRcYEsYqJPJ1R3+6Q2V4UAylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5N5tqQk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5N5tqQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86329C116C6;
	Tue,  6 Jan 2026 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683127;
	bh=/jy8PWjGAF9cEhVahjUz8KqHL9lmBNs98pIAwzSS4vE=;
	h=From:To:Subject:Date:From;
	b=Z5N5tqQkI0b+P6KCX6hKwpBfbcF0akzKVBIMO1lqE7MidJQaDOYjEmnflOdFJICI0
	 jvz+mxZ0SLJCjB59c+LfZqPPwmJxeCWGTtFkRJhLEbZG84u0vE46CjBRsBQzcVzVMQ
	 JhZ9AjHQJLjysDpPP7MqFOTAJYL3XCHH+uDHlgItRm4uZc8VD1I6uKveRyWoLaaaWT
	 LfMER2Jsc9Z8mvWozHnrQOjbNUy6xl1brhHeVyT5rf2SEUclOIeIIMK3tGWFerFkit
	 MjTuUQDS7NmgTw0Pcbhml46CUToh5C8UV2d6bYVmwEu9PoABprdUrz2WZvxm6xYa+L
	 U/5bx29mMklww==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 0/2] Improve some comments
Date: Tue,  6 Jan 2026 16:00:55 +0900
Message-ID: <20260106070057.1364551-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

Here are a couple of patches to improve helper function comments.
No functional changes.

This also gets rid of the "XXX" strings in the comments, which makes
temporary coding easier as XXX is often used to marke places that need
some more attention when developing.

Damien Le Moal (2):
  block: fix blk_zone_cond_str() comment
  block: improve blk_op_str() comment

 block/blk-core.c       | 10 +++++-----
 block/blk-zoned.c      | 10 +++++-----
 include/linux/blkdev.h |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.52.0

