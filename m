Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7612D3725;
	Wed, 13 May 2026 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681028; cv=none; b=ZjMhHEFnfs2C2p4Wu2eo+rJyoRdfz3681e/AKtIl2s4gJfhvJS+8x2uy4FlWCmq6beH8vOleHKufAySkjekBBdtRsf/FlmftjnbC1f2blJ9IZ++57YHMGp2z0Y/I2DzYp9On6RsyffWQl3lpQmvt+6sOwVUk+ynmjxTxiRrWOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681028; c=relaxed/simple;
	bh=+DlhqxbsUxs8TSFy328TyjZOji9gRCtPaLK2MQ9YrE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTaPN23S40goZkUr3BwP0onqQRqGwuevUe3KQXzaob+Z6fxt1B5PGiR7zFzlT2XDIMTO4HJO3mgbjPC5qYYHNj6mPMnvQn9kd/V1Ro5/ChGrWFFGv32PV69elWvyeA5UNFi4PVebkHVBQIKvC3xnGNDt3OKrNw26WN264deq96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JWcMztLE; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JWcMztLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/l
	wiOPTnvlBpog3cv49D12gfGRsm5qJ0BLZQamnSSg0=; b=JWcMztLEhA7kS0JHqg
	EmpAqZK9WQoqCxXZzTk5weZVCoW5P+6gMt9FWbXLePTUj99/RmkKih2od4xB9KkN
	mMIcTzWJKPsUHJUCMa6ZdpHsRESXVyZfJOgRyWkT3SCfLP+WuD+23QBggiJUOYhm
	e1kSjxxpLh3U6zFEF4St6CCIc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXniBxhARqrEiHDg--.29S2;
	Wed, 13 May 2026 22:02:27 +0800 (CST)
From: wang wei <a929244872@163.com>
To: richardycc@google.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bgeffon@google.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liumartin@google.com,
	minchan@kernel.org,
	senozhatsky@chromium.org,
	stable@vger.kernel.org,
	wang wei <a929244872@163.com>
Subject: [PATCH] Re:[PATCH v3] zram: fix use-after-free in zram_writeback_endio
Date: Wed, 13 May 2026 22:02:18 +0800
Message-Id: <20260513140218.7425-1-a929244872@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260512074918.2606208-1-richardycc@google.com>
References: <20260512074918.2606208-1-richardycc@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXniBxhARqrEiHDg--.29S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRPrcfUUUUU
X-CM-SenderInfo: jdzsmjiuuylji6rwjhhfrp/xtbC6hTZgGoEhHRf4wAA3F

>@@ -847,7 +849,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
> 		release_wb_req(req);
> 	}
>
>-	kfree(wb_ctl);
>+	kfree_rcu(wb_ctl, rcu);
> }

Do we need to add a 'rcu_assign_pointer(wb_ctl, NULL);' before 'kfree_rcu(wb_ctl, rcu)'?

Signed-off-by: wang wei <a929244872@163.com>

-- 
2.25.1

