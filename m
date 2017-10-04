Return-Path: <lurodriguez@suse.de>
Date: Wed, 4 Oct 2017 03:07:54 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v5 1/8] md: Introduce md_stop_all_writes()
Message-ID: <20171004010754.GO2294@wotan.suse.de>
References: <20171002225218.18548-1-bart.vanassche@wdc.com>
 <20171002225218.18548-2-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002225218.18548-2-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 02, 2017 at 03:52:11PM -0700, Bart Van Assche wrote:
> Introduce md_stop_all_writes() because the next patch will add
> a second caller for this function. Rename md_notifier into
> md_reboot_notifier to avoid that the name of this notifier will
> become confusing due to the next patch. This patch does not
> change any functionality.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis
