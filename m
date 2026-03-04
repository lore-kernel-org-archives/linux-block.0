Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F192628D
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587603; cv=none; b=SZUtqsX97gTxfQKZ3z2rp7c76jgQHgiaryGI058XtYN4np8n4zYf4HSS82L5JZc7u7+lJ1uHTq6HP9bkj13jfyCllQnYlsnnE6aZvdrkKbhTSignfnhfZKBn079P52KWmaktU5V98hucu0JWbQOKwyMeQeICP36Hrfsec5x1Jbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587603; c=relaxed/simple;
	bh=+WmgJG0BpoDQ0KUadKPgpmGGLl9I2e/g1yI8mHSTrcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiPhfBnS+jBW2LUOpU6eyw/4atCmixuHaEuK2YNsZk2pxWQ6n51Nck+p/jXfKlwLuSm/8WPF9r9T4A5qqMtRU+9gZyzb4FKAnfrQX5+lGy/DUxyOYjEtPwmiMcHanGCSwuBVWIQWcppSkumgOIsT93hNh65hl0t0weasadrnU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OvtNPOSm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OvtNPOSm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+W
	mgJG0BpoDQ0KUadKPgpmGGLl9I2e/g1yI8mHSTrcs=; b=OvtNPOSm8ltyACv3pm
	XQygdklwulGMRH3h/zHBsjZkzh/6Yq1qnhi3cNstsdOe2BooCvEeNcR2FDGo8mTe
	FYHE/+tVSK50uayCsX+eqIjZrhbbAQmJ4WM6x5w1bpx661lZxt3yyIo19XEImrhY
	bJqvrd9iLIknwpS7Pg2bK1K1k=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCXLP0yiqdp8zXwNw--.65455S2;
	Wed, 04 Mar 2026 09:26:11 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: hch@infradead.org
Cc: axboe@kernel.dk,
	tom.leiming@gmail.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix page leak in bio_copy_kern when bio_add_page fails
Date: Wed,  4 Mar 2026 09:26:09 +0800
Message-Id: <20260304012609.100232-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aabrTtw6WpPl3cvk@infradead.org>
References: <aabrTtw6WpPl3cvk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXLP0yiqdp8zXwNw--.65455S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjHUqUUUUU
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwRPyg2mnijPt7AAA3V

Hi Christoph,

Thanks for the review. I understand the issue now and will drop this patch.

Thanks,
Yang Xiuwei

