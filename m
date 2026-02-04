Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8C2C11FA
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770172115; cv=none; b=MKrbEpcg6vO5FpUeJadxvfACzHhiPl54qs+kW17FpwaqGEuXBxplXPsn3mkd6AUo1vsqP8eVI5+ndAH6vWbz85YZUWQkbglWCwZMozhWVFZM00fmFtnExpTBLfzzJcvQn69gIpOgmdg2g/LpGSCD8L+GYnE3xFjrMqv60imigxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770172115; c=relaxed/simple;
	bh=XDRVb9CWRW+G0SfTvZO0zjDG1jtMDeYXPxuCpAp6xms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZTpV1Rm57ja7esrzMgzFRPgPhJZJSlz1BvqAEy/H88bF4QTPzkw3OM1yehGr7wrzkVSbKHMfzD0F85aYnxz9MDC0mZoiIaLdPsQgGMTSRNPEXJ73+JF+lB02+FyzOAnOqR95rdlKtwtHwP6clyATgLiGGhaM1rjim9xFWp4Ub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UXGlxCKV; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UXGlxCKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5u
	y2FZqZ06G3MYx+hL/Vnhq+ZuzXJJyK5+7hfPg8cK0=; b=UXGlxCKVimWX6F3qZ2
	Ysb1TmgGpTZa75/G87tMpDCUNNiGzU4x8VN2kjr+F1KOl95ggdjR2pBb+fygTkOT
	VPnIZzVTAAm40lRpEaUHXtuRmF9gMur4TnC65gnqc0j6QK5ZxZlddBwq4W+35FZ7
	bgbxdKq6YrFU1HJTvWyoNsXog=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_3a7roJpzxzJKw--.22037S2;
	Wed, 04 Feb 2026 10:28:13 +0800 (CST)
From: Yang Xiuwei <yangxiuwei2025@163.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove redundant kill_bdev() call in set_blocksize()
Date: Wed,  4 Feb 2026 10:28:11 +0800
Message-Id: <20260204022811.3498546-1-yangxiuwei2025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260106024257.144974-1-yangxiuwei2025@163.com>
References: <20260106024257.144974-1-yangxiuwei2025@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_3a7roJpzxzJKw--.22037S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4iWlkqDUUUU
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6R3VZmmCrr31TAAA3G

Hi Jens,

I wanted to gently follow up on a patch I sent on Jan 6, 2026 to 
remove a redundant kill_bdev() call in set_blocksize(). Christoph 
Hellwig reviewed it on Jan 8, 2026 with a Reviewed-by tag.

I haven't seen it merged yet, so I wanted to check if it's still 
pending in your queue. I understand you're very busy, so no rush - 
just wanted to make sure it's on your radar.

Thanks for your time!

Best regards,
Yang Xiuwei

