Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49DE3769F5
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192331; cv=none; b=skI7Fz4ayCjpTXegVSBAs9NIaDHWBPkZiIaZ33ArNtK5vnUVI7VijZiIZ926QGc+bTwaG8+osIY0M1p+Omib3qrhdv3KPvgNHoPwo8EOjsUH2U6xYQvUjhGMGEk3eBG9t2ZKZknpVuY64BP2XyJRQZeOOTp0nUctN3rm7z8gjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192331; c=relaxed/simple;
	bh=q9qogy1WIiqJOY5KNh4LtX6QAwCZeEiN95IXZgMpMSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R18x3JkWXt9tyvhoXcPyTLItdlrnNAidZn3mLjzaJV8FyAiR3Poul18AtLyUirFkA0nhi3qb7zeVZUGZFXitS9V9zSyMue05e9J+dKQT97Ma8Z+0GLaefhJQPZ5qTmRmQKv7vZdNRc1tbxUjsM3HnnKcsCuDXsylC6sgX+/c1CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hQRtb5sjtzKHLxM
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 10:18:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D626640561
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 10:18:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP2 (Coremail) with UTF8SMTPSA id Syh0CgCXAooFZIZq1z7qCw--.40897S4;
	Thu, 20 Aug 2026 10:18:45 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH 0/2] disable I/O priority when prio_aging_expire is zero
Date: Thu, 20 Aug 2026 10:12:44 +0800
Message-Id: <20260820021246.2681624-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXAooFZIZq1z7qCw--.40897S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1fuFyfJryUKrW5AF47Arb_yoWxuFc_CF
	y8ZryUGw48XF90vFyayFWUJFWagF4Y9F17CF1vvrs7AwnrZw45AFn7J34rZF47Za17tayk
	Aas0vr48JryYgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Since the mq-deadline scheduler introduced support for I/O priorities, if
a process does not have an I/O priority configured, it becomes bound to
the process's scheduling priority. This change forces applications to
re-plan their I/O priorities. However, applications do not care about
I/O priorities, yet now they cannot disable priorities.

Ye Bin (2):
  block/mq-deadline: disable I/O priority when prio_aging_expire is zero
  block/mq-deadline: add module parameter for prio_aging_expire default

 block/mq-deadline.c | 84 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 13 deletions(-)

-- 
2.34.1

