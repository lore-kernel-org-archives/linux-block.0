Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A6C139D0A;
	Fri, 15 Aug 2025 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245411; cv=none; b=i26igoVkQgCc9WI5ZD/kvpGaddiqYM1D5OSweayS75qQbiBG6fRhnXHMhuJoh9YPzUzy+yYTiVYlttpV2JLuzkKk9G9+60BP8OfnEzIBfh0KqyNPiThwCXUt2gfMt2KTzCJa66aJInLC73zOZQOBh/+oEFSTURoYG/ztfOK7Trk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245411; c=relaxed/simple;
	bh=k+/+e4AWRrpdbBp5u8hgkSMNujqfS4CeCu4haa/mHJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HLBiIQP85paFwsS8RGfEmkK4PlQFGfJT81zxYgxBh5el6Eq0hJIAW7v4DXJmbmw7r1T/yYbCWQ305ycFw7mBUYE1kg0AydRzRM90dZ64HQM8wPybg/A4dYBpN6NujiWbZQsfC5ME4Rzv91LSbCIJceYYFCQqAMpcoYo8i6yyLx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3FCM5J6ZzYQv7Y;
	Fri, 15 Aug 2025 16:10:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 590321A176F;
	Fri, 15 Aug 2025 16:10:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxBc655o+xX_Dg--.53834S4;
	Fri, 15 Aug 2025 16:10:06 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	hare@suse.de,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 00/10] blk-mq: fix blk_mq_tags double free while nr_requests grown
Date: Fri, 15 Aug 2025 16:02:06 +0800
Message-Id: <20250815080216.410665-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxBc655o+xX_Dg--.53834S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4DGr17tr47Ww1rGr43trb_yoW8Ar18pa
	yfJF4akw4Sq34xXF1xA3y7Xr1Syw4vg3W7GrsxtF1rGr1q9wn7Ar48Xa10qFyIyFZ7Cay7
	Kw1DWryDWrs2gFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

In the case user trigger tags grow by queue sysfs attribute nr_requests,
hctx->sched_tags will be freed directly and replaced with a new
allocated tags, see blk_mq_tag_update_depth().

The problem is that hctx->sched_tags is from elevator->et->tags, while
et->tags is still the freed tags, hence later elevator exist will try to
free the tags again, causing kernel panic.

patch 1-6 are prep cleanup and refactor patches for updating nr_requests
patch 7,8 are the fix patches for the regression
patch 9 is cleanup patch after patch 8
patch 10 fix the stale nr_requests documentation

Yu Kuai (10):
  blk-mq: remove useless checking from queue_requests_store()
  blk-mq: remove useless checkings from blk_mq_update_nr_requests()
  blk-mq: check invalid nr_requests in queue_requests_store()
  blk-mq: serialize updating nr_requests with update_nr_hwq_lock
  blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
  blk-mq: split bitmap grow and resize case in
    blk_mq_update_nr_requests()
  blk-mq-sched: add new parameter nr_requests in
    blk_mq_alloc_sched_tags()
  blk-mq: fix blk_mq_tags double free while nr_requests grown
  blk-mq: remove blk_mq_tag_update_depth()
  blk-mq: fix stale nr_requests documentation

 Documentation/ABI/stable/sysfs-block | 14 ++-----
 block/blk-mq-sched.c                 | 14 +++----
 block/blk-mq-sched.h                 |  2 +-
 block/blk-mq-tag.c                   | 52 -----------------------
 block/blk-mq.c                       | 62 +++++++++++-----------------
 block/blk-mq.h                       | 17 ++++++--
 block/blk-sysfs.c                    | 44 +++++++++++++++-----
 block/elevator.c                     |  3 +-
 8 files changed, 84 insertions(+), 124 deletions(-)

-- 
2.39.2

