Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3489361674;
	Mon,  1 Jul 2024 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719815893; cv=none; b=Bho1dYHfUJD39nXQqwzQmIJcODrbR0RRtvqzUZfZoFcPi9tls8Y9pN/nGR9JoITv39yG4PgotEtdBuOVT0Gokz6RGV4de9PJpJSc25S/A3HPe9AOE+zArIOWtp8FQJCilqDllji5jUQUr98nJKfcNbw2L9Wf1gXIv+GbhiStrog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719815893; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDRxKVC3Ztnj038NDeGDtr450ylm0f6E0OUZtTeQk9XGVYzPVUWKvyanqu3DWLW5p7bPrpGUfOLjjdcdxcFha7fPkpXtDSKi/BCZaKm9SynMt9ZnSqYIAFdC7e6eJ5iqERcRLgS1Yg+/TcKIy8Bj43O9RL7p40eY7cDzo4paOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sTdkgt3Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sTdkgt3Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=sTdkgt3ZrLR9Kxxa8VTGEJWtG8
	qoGg1/IpFB0fhtCCYGb8Ug5c+4hzO64p3aadV6kybqrm/DlLo1YWVdJ/4PHIiV+G1OdNUzZjn2eIW
	ESNbtqnwTTGqqJMpVmS1az7JhNJSFLyIp0XWdEgTKGuSq/EhZx1BKDemtNwT0l8GYElR7RkVSYVjW
	YIeM9Gzj1gI2PqrcCwR5pBS1QrMUBPfdbhTXlIn5GDDFsgjijDmO+Q5gjfTrDqWKyftiH/wS6ihh+
	bNrYKby/simnLTFYS6kreIT4UzSPsHnSK1uh85JkFBNPkwmBu/7vS85doFDuVzYR87eAlBT80SyGG
	lFAo5wTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOAfx-00000001tKZ-3JT2;
	Mon, 01 Jul 2024 06:38:09 +0000
Date: Sun, 30 Jun 2024 23:38:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: libaokun@huaweicloud.com
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@infradead.org,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	houtao1@huawei.com, yukuai3@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH -next] blk-wbt: don't throttle swap writes in direct
 reclaim
Message-ID: <ZoJO0QbQWA8bJL5L@infradead.org>
References: <20240604030522.3686177-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604030522.3686177-1-libaokun@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

