Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610818C22;
	Tue, 17 Sep 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556995; cv=none; b=Wd9H5Z5CuGd+/eomZG9HJustRxI5n4p9c+/Td+6Xigab+aJWVDOOwYkulZpexvLe0KwkH3jXQi4CIUR+ssL/3pcw7fPUQYP8YAyryzqSfACo2gqnNbBHkpT0k+YexbzItAl/e4jbBvMf/8E5vLh2WV+VJLT+8P6OryiILxN0EvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556995; c=relaxed/simple;
	bh=QP5z3YpQ64vercqehKu18xDUR8Ghf0PcF4X/8nrkZms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UW3Kfm+nw+3S12LzsGg1h+4k3yg0nW93M4WrlqQ6USJJOS7GNUix4aGywP6AMCjM0hpmvHu1kChKPa9D7ZU2WD3q2O349fxBp5BW6p9PQ2dvsmV8inxcLDX0UlfFIb59HwymC+FpNbOKO4w/Gm8TB2m9hAITpXsT4rST8/aIF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=W1NLbyAo; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="W1NLbyAo"
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 3D5B8100002;
	Tue, 17 Sep 2024 10:09:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1726556972; bh=2uWqrevBYsQgvajuGiIozG7sst/1v+BZ6EvKtuKwz+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=W1NLbyAoBZNeoTILFieA4L059ydXzmCxaSYzoFXiH0QVaQNe9o/n4jEi81nvvUb4o
	 H707PmqEFlJseXu8KsSnnEBvSIfXLnJhCcAJ4LsfYVch75TYSi9eb5k1oJUwQTunbG
	 pSVM3jTeY0hJr+UXYsaBvoMrOhfJXN5sqcWuqjI5cG32yIlAe909a3sKwsyCR+VQz+
	 rdz/XhB405NGhV6rtI276RPGeTXyPec0qKjSFq80yEe1WZk7SDPyvexGHxfbe/JUC8
	 qdmOjns+fmbOgkeQpb+hpQ8Roa4Nfbf5pG5IRvs4EhQMtZKJgYQ+9EMTC4h2t9n4ML
	 7bV77vJ0bZHEw==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 17 Sep 2024 10:08:09 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Sep
 2024 10:07:48 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Shaohua Li <shli@fb.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Johannes
 Thumshirn <johannes.thumshirn@wdc.com>, Chaitanya Kulkarni <kch@nvidia.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>, Chengming Zhou
	<zhouchengming@bytedance.com>, John Garry <john.g.garry@oracle.com>, Yu Kuai
	<yukuai3@huawei.com>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] nullb: Adjust device size calculation in null_alloc_dev()
Date: Tue, 17 Sep 2024 10:07:29 +0300
Message-ID: <20240917070729.15752-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187786 [Sep 17 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/17 06:34:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/17 06:27:00 #26601446
X-KSMG-AntiVirus-Status: Clean, skipped

In null_alloc_dev() device size is a subject to overflow because 'g_gb'
(which is module parameter, may have any value and is not validated
anywhere) is not cast to a larger data type before performing arithmetic.

Cast 'g_gb' to unsigned long to prevent overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2984c8684f96 ("nullb: factor disk parameters")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2f0431e42c49..5edbf9c0aceb 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -762,7 +762,7 @@ static struct nullb_device *null_alloc_dev(void)
 		return NULL;
 	}
 
-	dev->size = g_gb * 1024;
+	dev->size = (unsigned long)g_gb * 1024;
 	dev->completion_nsec = g_completion_nsec;
 	dev->submit_queues = g_submit_queues;
 	dev->prev_submit_queues = g_submit_queues;
-- 
2.30.2

