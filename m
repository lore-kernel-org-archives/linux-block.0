Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C9153824
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734556997; cv=none; b=roINNhmPDPQJYj1IyBPY3dnLgkUr8pR9ifjc5N5UdUBTT5OWVVZiKxcY4fl0IcKRKchNrZqbXmipUwjyHtZCX7gVI+JvgFSjSuj1IgXIDoWO2jp3FO3A5t2ATTspJ7EWYAKrcWE3kFA2vOeZUzvr6T6GVI9u4lgtXpfCvS75K1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734556997; c=relaxed/simple;
	bh=BNZkmb/LAF+sP6ElkGrpZfb95162+HzX7ithY9pUsT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogyAJBFMjTmVunEqmifs9PcD5OFTgPYLfKangcnHiE9lO9VGYATPu1RIahneGwc8+U86Vk0/C4ITKsUruwrMa2Zp6FVJzpyfdpAOvIVYz2LCUXpVl0fI04B86Lwt/XVyHnefc15wHBRFY+eGTP17scVCqBsURgCU5SJfzwJ3uWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nbfK0L+C; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nbfK0L+C"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YD6984qYZzlfflk;
	Wed, 18 Dec 2024 21:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1734556986; x=1737148987; bh=MoqvsV+dr4wUyw+fazcnHf9oAqqaUGdtYCd
	2JUuZgdo=; b=nbfK0L+CnQgyHBbLcRfk8RPggWzvybGL1o3gblzeFpchIaacKfb
	FeKCvspOwbaaCoFuJwjyYpnr4Y+63JPtzTFa6UNs54/LiyMKhzVEhuJvP7mJuGav
	kReW58gGU2ZpH8st3uKU5y4KFB3OXgdm3z3yXV6npLlbW9El0pMM8tWTfRrFBRoQ
	S1VI5kQ3NJnUkgj62A7uqEr+6RrlxeHZguSB2Dm0v4Nqqdhd50z67cTpsB837zk+
	EFMJk+CQLzG/+0yVVGMcs5NlcqJbuSwcxQjXO7nlYDvFEGFOunKouGI1qYvx5pWw
	3Q3kMZqjIM8wBBKk+uCnkEysJ2WzH0DZNHg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id s98Sv6QqfiET; Wed, 18 Dec 2024 21:23:06 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YD6944Q7wzlfflB;
	Wed, 18 Dec 2024 21:23:04 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/2] Two blk_mq_submit_bio() patches
Date: Wed, 18 Dec 2024 13:22:44 -0800
Message-ID: <20241218212246.1073149-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series includes two cleanup patches for blk_mq_submit_bio(). N=
o
functionality has been changed.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v2 of this patch series:
 - Changed the title of the first patch.
 - Added unlikely() in the second patch.
 - Dropped the patch that was added as the third patch.

Changes compared to v1 of this patch series:
 - Addressed Christoph's comments on patch 2/3.
 - Added patch 3/3 to this series.

Bart Van Assche (2):
  block: Reorder the request allocation code in blk_mq_submit_bio()
  blk-mq: Move more error handling into blk_mq_submit_bio()

 block/blk-mq.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

