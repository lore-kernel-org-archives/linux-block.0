Return-Path: <axboe@kernel.dk>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: Regression caused by f5bbbbe4d635
Message-ID: <bae37c56-3f12-448d-cdb5-6ed2c2d069a4@kernel.dk>
Date: Mon, 24 Sep 2018 12:44:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi,

This commit introduced a rcu_read_lock() inside
blk_mq_queue_tag_busy_iter() - this is problematic for the timout code,
since we now end up holding the RCU read lock over the timeout code. As
just one example, nvme ends up doing:

nvme_timeout()
	nvme_dev_disable()
		mutex_lock(&dev->shutdown_lock);

and things are then obviously unhappy...

-- 
Jens Axboe
