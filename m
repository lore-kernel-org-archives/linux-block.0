Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479BC1F1304
	for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 00:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210143; cv=none; b=ebR9TsPi2Af6IE8kneBih5/OuBlnI1bGheF3NMdoiyKKt1CAOJi43+kDASPHSg+dTAAsy3LlsiDpKE3Kn7vzB4atlqLdtM8IhzVgwsuwXDfenoQzLUMOHrjvF6M9hdgcxnZoeYCHyZQHkR5ikNdEYWbqAxxttGjYgeJ3/+gv/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210143; c=relaxed/simple;
	bh=IL6SrhP13FcM6bA3H2bJNtyJI6PfQqcwkzPwvea/Fsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nK94mj7BPKU8ghP69fcgr24g6s44qaIMqAbY5cS3h5UvqKSerh+kf5F+v97/GCkMNP1ZfuvZOt9ciifr3COZeGtiCGyvaU7ZcYgbl4WpfGik7cK0yO9BNkkxlAB6hPtio6Jr/ohKVDOVu6kM1+dgmhe7ZvxKukmVLPBor7gsJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I5b7oKZ8; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I5b7oKZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IL
	6SrhP13FcM6bA3H2bJNtyJI6PfQqcwkzPwvea/Fsg=; b=I5b7oKZ82jibNYEfFb
	LAYRMk3KzhG96BmjdntT7lwnORCHkpwJaFz4R5FHVgcirxW3FDbjU6PmmruAcq4i
	lqFnuHISpljRNPR2T7IxC8/oLTQIu1g7YA+PeZOpLHi0udQCAt12rUZUAT8aTR07
	2Afd5/GEPBbjxgd/lDpZSRUfU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnNhc+cLRqWTWxAw--.57379S2;
	Thu, 24 Sep 2026 08:35:12 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: hch@lst.de
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	linux-block@vger.kernel.org,
	mkp@kernel.org
Subject: Re: [PATCH] block: reject polled dio with user integrity metadata
Date: Thu, 24 Sep 2026 08:35:10 +0800
Message-Id: <20260924003510.4072211-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260923143937.GA28622@lst.de>
References: <20260923093732.1504291-1-yangxiuwei@kylinos.cn> <20260923143937.GA28622@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBnNhc+cLRqWTWxAw--.57379S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUeuWLUUUUU
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwQDzhGq0cEC4kAAA3w

Hi Christoph,

On Wed, Sep 23, 2026 at 04:39:37PM +0200, Christoph Hellwig wrote:
> Can you add a reproducer for this to blktests?

Yes. I'll send one that expects -EOPNOTSUPP.

Thanks,
Yang Xiuwei

