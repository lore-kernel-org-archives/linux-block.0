Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D581C6A3;
	Sat, 30 Nov 2024 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732947065; cv=none; b=J7HAcggxkuaTgfUtJQ3/Vyx/vo6J9KenfyPulpe8pjEqxGiWteYlkjk9krQhRMM6DYui4j6VnVOEBgx2YSNo6y06vgVVm+GbIEuoZKUf0HZNi+xaZGPAEO+9I8A+7QMX5pIB7w5DCS8vYLv7kkkz+E83CPZ/ytQR2hLfXnP8m+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732947065; c=relaxed/simple;
	bh=x5pvY7QeB2hU6DCrlLsOPv0rtVWwVD5kjFqKWvAwFQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lEfrbeP00FU7s4b0WUQawbQ3H284qZSIDYDsJW/4cMHITn+wOb3V3yea+A9Q7JhlA5FyPNkdLSNWu8Yw+SF7m3UIJd+D6Ypu/gUaV9DliWu5yMYEE5yHs3J7zMR55PgDLRnQE2cxDrTN7ql+EpxSVbdvgOi8WyhBbQHMI+VyfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R43Mfy4g; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R43Mfy4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gIoTD
	7f1fIu8H1dclXCi7rJHwAV5+VzXKP6fC6h8sxw=; b=R43Mfy4gF4ANTOXrT84bG
	NrqqurkZkj/JiCQhjbPntv9zzBxcQuMS38XcGbjNyK01D9akX+HB+Dmq8asfUW4w
	QN8VEpbJSIKV8QcmsauN/Onj83X0uNfYl4otmH1VAp1FDl7IZZeoWSrm4B+DTXGC
	crOwUk6edPh/7JkeWkmvEc=
Received: from localhost.localdomain (unknown [111.35.188.140])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3XzItrEpnUFMcCA--.50644S4;
	Sat, 30 Nov 2024 14:10:06 +0800 (CST)
From: David Wang <00107082@163.com>
To: chris.bainbridge@gmail.com
Cc: axboe@kernel.dk,
	bvanassche@acm.org,
	hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	semen.protsenko@linaro.org
Subject: Re: [REGRESSION] ioprio performance hangs, bisected
Date: Sat, 30 Nov 2024 14:09:49 +0800
Message-Id: <20241130060949.122381-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAP-bSRZehc2BxRC_z5MXKQ6qHNPXPgZoOQTtkiK_CFd494D_Fg@mail.gmail.com>
References: <CAP-bSRZehc2BxRC_z5MXKQ6qHNPXPgZoOQTtkiK_CFd494D_Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XzItrEpnUFMcCA--.50644S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw48AF4kCF43GF48uF48Zwb_yoW3Jwc_ZF
	W0qF9rtFyFgrsxKrnxJ3WxZFnI9r93W3Z3X3y7GFsrJry3WFWq9an5ZFW8Awnrt3yUAa93
	Crsaqa4jqryS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiqjgDUUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRqnqmdKpauZbwAAsr

Would fix/revert reach 6.13-rc1? I think this regression has
significant nagative impact on daily usage. From time to time,
my system would *stuck* for seconds, sometimes even when
 just `cat` some small file it would take seconds, and once,
my desktop failed to resume from a suspend, I had to power cycle the system;
Polling /proc/diskstats,  I noticed Block-IO read latency,
delta(# of milliseconds spent reading)/delta(# of reads completed),
is very high, ~200ms average, and frequently reaches 10s.
 (Strangely block-io write latency seems normal.)
My bisect also land on this commit, revert or apply this patch would
fix it.

Kind of think that 6.13-rc1 would be very unpleseant to use without
a fix/revert for this.


David

