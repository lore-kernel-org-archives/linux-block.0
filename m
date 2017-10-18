Return-Path: <keith.busch@intel.com>
Date: Wed, 18 Oct 2017 16:53:56 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 13/17] nvme: track subsystems
Message-ID: <20171018225356.GA1796@localhost.localdomain>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-14-hch@lst.de>
 <20171018223913.GA1846@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018223913.GA1846@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

With the series, 'modprobe -r nvme && modprobe nvme' is failing. I can
get that to pass with the following:

---
@@ -1904,7 +1907,11 @@ static void nvme_free_subsystem(struct device *dev)
 static void nvme_put_subsystem(struct nvme_subsystem *subsys)
 {
 	put_device(&subsys->dev);
+
+	if (list_empty(&subsys->ctrls))
+		device_del(&subsys->dev);
 }
 
 static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
--

But this is racy with nvme_init_subsystem, and it creates warnings:

  kernfs: can not remove 'uevent', no directory
  kernfs: can not remove 'online', no directory
