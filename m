Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6B2931D0;
	Tue,  4 Aug 2026 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825158; cv=none; b=ofpQYOwD7tX+mGS1W2AnbBPfBwVCoKeRx6IFNHy5PEDlw+MhOkJfim8y0z/g72tueXDSBy3RNErYdUIBxZBS4spcv4saBHVS8Y8UBevAj05AXXSQQTovSDbQ4Om/0l5l+MF0JIwGIt5Ul0Ty6S6TSPEtawcJEyMmlU6YppK2F64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825158; c=relaxed/simple;
	bh=jhi1nC7l/++E+UDsPuGo7Gh98rUrGxhUa/6tWOb7E10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O50+8TtZmYs+D3l8DafOJE3IBA715mhMuYvJNiPjaVFLIhauZikScFOm7E7pDMiDIjc9a1o9w5Q6iy51cXnU2Qxyywc1GPbvs48txtz022w6Xg050CKBKWMKAe2d5Yx23wdXfV6WvwwWo3BFMkMcRLBUxsXJ6lmSdH4N6/9mUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IhHcNObU; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IhHcNObU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=h3
	PSLjp0j8Tepq1b0TAb1dnNlyLzYbS8AZCQmjDnKD8=; b=IhHcNObUrJvioqZGyv
	WfFMsAlGIXyK/mIrbtyveX3zO3Pg0W12dcuf0CYmq7x33EnkeVEcOBU50GqxrYCj
	ff+pTarbKwU7EPidPqz5DX2+/ZkcA2HQiUZrQJYZVOxkd1uz/3fQmCwSn0JI75m8
	1n0cbWKxkb2FIspijaFqWNq9s=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDnrJBjh3Fquyx7JA--.32550S2;
	Tue, 04 Aug 2026 14:32:04 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com,
	csander@purestorage.com,
	shuah@kernel.org,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: add rotating auto_buf index regression test
Date: Tue,  4 Aug 2026 14:32:01 +0800
Message-Id: <20260804063201.3740465-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <178581121634.578215.15829017092257405641.b4-ty@b4>
References: <20260730024050.1062354-1-yangxiuwei@kylinos.cn> <178581121634.578215.15829017092257405641.b4-ty@b4>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDnrJBjh3Fquyx7JA--.32550S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1ktFykKF4ktrWrWrWDtwb_yoWxCrgEkF
	WqyrW8Jr48CF1UCa13KF4UJrZayFZrWrySgr1rZrZ5Za43Xr4fKa95Xr1kWr17WrWvy3W2
	krnxGr1qgr1qvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjT5l7UUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6gfxgmpxh2drAwAA3N

Hi Jens,

On Mon, Aug 03, 2026 at 08:40:16PM -0600, Jens Axboe wrote:
> Applied, thanks!
>
> [1/1] selftests: ublk: add rotating auto_buf index regression test
>       commit: d507d3cb19e71f10336e41deeac517cdc21c34ea

Thanks for picking this up, and also patch 1/2 of the driver series.

I notice for-7.3/block is still missing patch 2/2:

  ublk: clear auto buf reg before updating io->buf in batch commit

The rotating-index selftest depends on that clear-before-store fix.
Could you please pick up 2/2 as well? It already has Ming's Reviewed-by.

https://lore.kernel.org/linux-block/20260730010910.799346-3-yangxiuwei@kylinos.cn/

Thanks,
Yang Xiuwei

