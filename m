Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB58230997;
	Tue,  5 Aug 2025 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754379906; cv=none; b=Cx/bRx0lXYDrSQ49oAly2C/NJIixymSO4Zi+5NhXJw0z284RNv/f/QWzRnmy/jQ3qRIyj1lRMzbHzSdYgYOuKZC3AHyRlb//o1HOJIzgMXTxfYoh3M7bpVWdsXK5TMuJtTm8QHthSxDkJ6nTG041VelL9vy8lGQH7HsCRFUfF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754379906; c=relaxed/simple;
	bh=y1uNWtwyyYBpELdDHwZWX70cVDhU+lAdCSyByB5Wmgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m8MiqBojh2jdsJdn2tX8nzZprCdJe52BJeyc+wg+juHpRJHBYSJJ3mBHi0y/lFQs/MJI/lS2D7V/v9FxiQlbperMIpZGMGBG09FdKxzU6rOdCs3msqiZvjp0uuPzX3zCtJ5o9OXY/O+pLVki170wM9OpF/teELAQNXHrxegw90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bx5734Jd3zYQv76;
	Tue,  5 Aug 2025 15:45:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3FA191A0B04;
	Tue,  5 Aug 2025 15:45:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhN8tpFoEsmICg--.25448S4;
	Tue, 05 Aug 2025 15:45:01 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: yukuai3@huawei.com,
	axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	dlemoal@kernel.org,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 0/2] lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
Date: Tue,  5 Aug 2025 15:37:46 +0800
Message-Id: <20250805073748.606294-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhN8tpFoEsmICg--.25448S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45JryxJr4UJw1rZF1xAFb_yoW5ZrWkpr
	WfKF1fKr18Zry7Wws3Cr43JrWUJw4xGr1DWFy3KF40kF45Xwn2qr4rG3WrJFZrurZ7Ja12
	kFykAr1Dur1jqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Changes from v2:
 - split shallow_depth to each word in patch 1, suggested by Jan;
 - add review tag by Jan in patch 2
Changes from v1:
 - fix some wording in patch 2
 - add review tag by Damien in patch 2

Currently elevators will record internal 'async_depth' to throttle
asynchronous requests, and they both calculate shallow_dpeth based on
sb->shift, with the respect that sb->shift is the available tags in one
word.

However, sb->shift is not the availbale tags in the last word, see
__map_depth:

if (index == sb->map_nr - 1)
  return sb->depth - (index << sb->shift);

For consequence, if the last word is used, more tags can be get than
expected, for example, assume nr_requests=256 and there are four words,
in the worst case if user set nr_requests=32, then the first word is
the last word, and still use bits per word, which is 64, to calculate
async_depth is wrong.

One the ohter hand, due to cgroup qos, bfq can allow only one request
to be allocated, and set shallow_dpeth=1 will still allow the number
of words request to be allocated.

Fix those problems by using shallow_depth to the whole sbitmap instead
of per word, also change kyber, mq-deadline and bfq to follow this,
a new helper __map_depth_with_shallow() is introduced to calculate
available bits in each word.

An example how shallow_depth is splited to each word:

assume sb->depth is 32 + 32 + 32 + 16

shallow_depth word0 word1 word2 word3
1: 1 0 0 0
2: 1 1 0 0
3: 1 1 1 0
4: 1 1 1 1
5: 2 1 1 1
6: 2 2 1 1
7: 2 2 2 1
8: 3 2 2 1
9: 3 3 2 1
10: 3 3 3 1
11: 3 3 3 2
12: 4 3 3 2
13: 4 4 3 2
14: 4 4 4 2
15: 5 4 4 2
16: 5 5 4 2
17: 5 5 5 2
18: 5 5 5 3
19: 6 5 5 3
20: 6 6 5 3
21: 6 6 6 3
22: 7 6 6 3
23: 7 7 6 3
24: 7 7 7 3
25: 7 7 7 4
26: 8 7 7 4
27: 8 8 7 4
28: 8 8 8 4
29: 9 8 8 4
30: 9 9 8 4
31: 9 9 9 4
32: 9 9 9 5
33: 10 9 9 5
34: 10 10 9 5
35: 10 10 10 5
36: 11 10 10 5
37: 11 11 10 5
38: 11 11 11 5
39: 11 11 11 6
40: 12 11 11 6
41: 12 12 11 6
42: 12 12 12 6
43: 13 12 12 6
44: 13 13 12 6
45: 13 13 13 6
46: 13 13 13 7
47: 14 13 13 7
48: 14 14 13 7
49: 14 14 14 7
50: 15 14 14 7
51: 15 15 14 7
52: 15 15 15 7
53: 15 15 15 8
54: 16 15 15 8
55: 16 16 15 8
56: 16 16 16 8
57: 17 16 16 8
58: 17 17 16 8
59: 17 17 17 8
60: 17 17 17 9
61: 18 17 17 9
62: 18 18 17 9
63: 18 18 18 9
64: 19 18 18 9
65: 19 19 18 9
66: 19 19 19 9
67: 19 19 19 10
68: 20 19 19 10
69: 20 20 19 10
70: 20 20 20 10
71: 21 20 20 10
72: 21 21 20 10
73: 21 21 21 10
74: 21 21 21 11
75: 22 21 21 11
76: 22 22 21 11
77: 22 22 22 11
78: 23 22 22 11
79: 23 23 22 11
80: 23 23 23 11
81: 23 23 23 12
82: 24 23 23 12
83: 24 24 23 12
84: 24 24 24 12
85: 25 24 24 12
86: 25 25 24 12
87: 25 25 25 12
88: 25 25 25 13
89: 26 25 25 13
90: 26 26 25 13
91: 26 26 26 13
92: 27 26 26 13
93: 27 27 26 13
94: 27 27 27 13
95: 27 27 27 14
96: 28 27 27 14
97: 28 28 27 14
98: 28 28 28 14
99: 29 28 28 14
100: 29 29 28 14
101: 29 29 29 14
102: 29 29 29 15
103: 30 29 29 15
104: 30 30 29 15
105: 30 30 30 15
106: 31 30 30 15
107: 31 31 30 15
108: 31 31 31 15
109: 31 31 31 16
110: 32 31 31 16
111: 32 32 31 16

Yu Kuai (2):
  lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
  lib/sbitmap: make sbitmap_get_shallow() internal

 block/bfq-iosched.c     | 35 +++++++++-----------
 block/bfq-iosched.h     |  3 +-
 block/kyber-iosched.c   |  9 ++---
 block/mq-deadline.c     | 16 +--------
 include/linux/sbitmap.h | 19 +----------
 lib/sbitmap.c           | 73 +++++++++++++++++++++++++----------------
 6 files changed, 65 insertions(+), 90 deletions(-)

-- 
2.39.2

