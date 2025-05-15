Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1250A1BC4E
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314521; cv=none; b=M7hxZ2X8oWy+XXCin4b7XVBb6jzqQBwEPs4Ur4bDIoOIcAX0MX4ejkPxSd7MuouBSsgYWT064iIkG7hqMbV+KwHhY+CAwfwiOLAsopLza2VOCUm1n4IrCAZtwuDmxlEsaK1Yo0/uJN3XYWGs6sHlZ3Uc8Ma+Duu/pbHd80u2C4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314521; c=relaxed/simple;
	bh=JpKkHNvKIe47WNMooTHDXK01S0jIkBwe9BgMNb/81g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETImVqWYRAn1YBejjLjl0uzKc8tVtqRnYPGdH1Gw4+m/SPOoTWUmTkVP8nVYSunO5eMaM1MifRwF2/nlrLHf4BRvP7gs+WP+dAu6jhi4qRckDWh2jFdXs0vMUn5HUaWiMN4hy1eNF2KBu8X9fCVyTt3/zzcyPKlBDFO69DcFmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F88D14BF;
	Thu, 15 May 2025 06:08:21 -0700 (PDT)
Received: from usa.arm.com (unknown [10.57.46.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80E623F5A1;
	Thu, 15 May 2025 06:08:31 -0700 (PDT)
From: Aishwarya <aishwarya.tcv@arm.com>
To: wozizhi@huaweicloud.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	tj@kernel.org,
	yangerkun@huawei.com,
	yukuai3@huawei.com,
	ryan.roberts@arm.com
Subject: Re: [PATCH V5 6/7] blk-throttle: Split the service queue
Date: Thu, 15 May 2025 14:08:30 +0100
Message-Id: <20250515130830.9671-1-aishwarya.tcv@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250506020935.655574-7-wozizhi@huaweicloud.com>
References: <20250506020935.655574-7-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Observed the following build warning when building the next-20250515 kernel with defconfig+CONFIG_BLK_DEV_THROTTLING applied:

Warning output:

../block/blk-throttle.c: In function 'throtl_pending_timer_fn':
../block/blk-throttle.c:1153:30: warning: unused variable 'bio_cnt_w' [-Wunused-variable]
 1153 |                 unsigned int bio_cnt_w = sq_queued(sq, WRITE);
      |                              ^~~~~~~~~
../block/blk-throttle.c:1152:30: warning: unused variable 'bio_cnt_r' [-Wunused-variable]
 1152 |                 unsigned int bio_cnt_r = sq_queued(sq, READ);
      |                              ^~~~~~~~~


There’s no warning with defconfig alone, and I’ve confirmed that the warning appears when CONFIG_BLK_DEV_THROTTLING is explicitly enabled.

Thanks,
Aishwarya
