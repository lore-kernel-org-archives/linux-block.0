Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB02FFDEA;
	Fri, 11 Sep 2026 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789092836; cv=none; b=KwPIxmbEOEYPrs4/Gp7HdXYtSGSb1zoTLNY0YdER68wY6DDLZszvvy1Red24fhUt7gVzUnJilyNiQ8PQtXyvIXAMzl4b06KqyoESZ8U/1usgov652CnQ51XGgooW/4TDHmdAsh/vJ0TcTbdeEOu+RTEzS8JNv+KcTQ8otGjJAPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789092836; c=relaxed/simple;
	bh=Ya0X1TVrY7Ryrt9XBuN2tXv5UpL+TpHTJwwAmyI6zLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XeJEOQGjooaYV3TvaX4xrYWpZofxNDA3kil/Nd3V7cbednuqAfCFybdJv5bKflPy1muYj8EmiYkcEOyQ3hETuGa0rK+Vcog86DNxaSxKAzBuf8jjQv4Zlg5DEbPUIshva1PM4HazJ87f7P0BQJUqNaUZqtrZByjDbDJVG/PwURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ESMIEi6I; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ESMIEi6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ya
	0X1TVrY7Ryrt9XBuN2tXv5UpL+TpHTJwwAmyI6zLg=; b=ESMIEi6IrhQ2JtYjzh
	kkZ3NAa17iBUDFKJZhPbMX90Qi7dlCQYOg+NP6OkDt3gnQB6cHgwSGsfBcOFbWVG
	r88VGNZZZCornrqnKX8mJkC7p+lVTQMe/Yh5TUyZa31YcaTpTr+EBBWr4TlrNaSv
	+3hBnb3Cp8reSr315HqZuaVXg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBX4BfDY6NqRsP1Qw--.51695S2;
	Fri, 11 Sep 2026 10:13:24 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: yangxiuwei@kylinos.cn
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	tom.leiming@gmail.com
Subject: Re: [PATCH 0/2] ublk: fix force_abort leftover after quiesce recover
Date: Fri, 11 Sep 2026 10:13:22 +0800
Message-Id: <20260911021322.103149-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821103047.369522-1-yangxiuwei@kylinos.cn>
References: <20260821103047.369522-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBX4BfDY6NqRsP1Qw--.51695S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUeuWLUUUUU
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6gSNHmqjY8RVuQAA3-

Hi Jens,

Gentle ping on this series. Ming has already reviewed it.

Thanks,
Yang Xiuwei

