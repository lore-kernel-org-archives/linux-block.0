Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 3/3] nvme-pci: use queue close instead of queue freeze
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, sagi@grimberg.me,
        keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
 <20180905220910.GC21352@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8ba97c77-0c3b-75df-0259-3c97ef7b774e@oracle.com>
Date: Thu, 6 Sep 2018 09:28:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180905220910.GC21352@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 09/06/2018 06:09 AM, Ming Lei wrote:
> nvme_dev_add() still may call freeze & unfreeze queue, so your patch
> can't avoid draining queue completely here.

Yes, I know this. We still need to freeze queue when update nr_hw_queues.
But we move forward a step at least. :)
We don't need to drain request queue in normal case of nvme_reset_work.

As for updating nr_hw_queues, we could try some other method on it next.


Thanks
Jianchao
