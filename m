Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDAB2EAE5
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825704; cv=none; b=UAtE7EjCZQeU9jZ2GOPz72iiQ8gJkVFAsbgyx2TJ3YZcO+ng7gkw745yMgc9xRGT6rL2zRQelDlPjucx/jLebhZ8Ebtw0YzpJrYS/Czn1cMHbi7m5OfXsApMD/H5pahcUyd3OvFfYysmzQaAY/eACk+L7plqG4PG3PYqsYzVgdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825704; c=relaxed/simple;
	bh=Uqf7esb5jztDRHZu20T1KSbCzhM5F6ZpV9oUUEwEmL4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pkkJ9N7zTtTLtnP0/aW8ZXorFr9BoQ6/Qqa6oVa6TfZSOcOfitCYNhIWgVXTXZfZg0Rzzs5P5oZWgP7oAEDNcvh5MqqVWSjK1+0uzSSD9GPqBZ1UwakJoDr2IUAKlGaauqI9rPoqumOxklY+rPwLaHDnr1F1+1jbhgHF/LJBElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZva+6MO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZva+6MO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2ACCC433C7;
	Thu, 11 Apr 2024 08:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712825704;
	bh=Uqf7esb5jztDRHZu20T1KSbCzhM5F6ZpV9oUUEwEmL4=;
	h=From:To:Subject:Date:From;
	b=dZva+6MO1gJjLk95e4F/s9dqVeGRKKLP6j1WU2G8S+iBFkwR+mV7btTbMNWKpTi7R
	 dxaO7cN14pOVQLP/iNjqXWEfOOcQ4ZB4s7tSIDFyE4/K5mRNbeB3ZzcxSBRayqsTF5
	 ew14F9aDehsZ0i/UM1YWbhk36wR8e3ErrJTwe5wSQjs9QtTyfX+wE4WWyfAHz00x1s
	 pLj12OT46p0qwarXjZ6zhEoMMNnsZsC8MOrHTNo3mbdihMK5ytgiaEEf7WM3g8HGiC
	 R/QviTsXc5Wr554fsjsHbDPL+TMFi9NE5TkWMcYWKeGyGorJgGFfCjQjW9DotAhg7L
	 YgM03ruFbGJkQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 0/3] Some null_blk cleanups
Date: Thu, 11 Apr 2024 17:54:59 +0900
Message-ID: <20240411085502.728558-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

3 patches to cleanup null_blk main code and improve zone device support.
With the last 2 patches, some performance improvements (up to +1.7%) can
be measured for a null zoned device with no zone resource limits. The
maximum IOPS measured with zone write plugging with a multi-stream 4K
sequential write workload (32 jobs) is:

Before patches:
 - mq-deadline: 596 KIOPS
 - none: 2406 KIOPS

With patches applied:
 - mq-deadline: 600 KIOPS
 - none: 2447 KIOPS

Overall, there is no functional change.

Damien Le Moal (3):
  null_blk: Have all null_handle_xxx() return a blk_status_t
  null_blk: Do zone resource management only if necessary
  null_blk: Simplify null_zone_write()

 drivers/block/null_blk/main.c  |  18 +-
 drivers/block/null_blk/zoned.c | 343 +++++++++++++++++----------------
 2 files changed, 187 insertions(+), 174 deletions(-)

-- 
2.44.0

