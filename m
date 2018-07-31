Return-Path: <davem@davemloft.net>
Date: Tue, 31 Jul 2018 14:29:59 -0700 (PDT)
Message-Id: <20180731.142959.500369535656671181.davem@davemloft.net>
To: keescook@chromium.org
Cc: axboe@kernel.dk, hch@infradead.org, martin.petersen@oracle.com,
 jejb@linux.vnet.ibm.com, tj@kernel.org, bp@alien8.de,
 manoj@linux.vnet.ibm.com, mrochs@linux.vnet.ibm.com,
 ukrishn@linux.vnet.ibm.com, nab@linux-iscsi.org, tglx@linutronix.de,
 pombredanne@nexb.com, sboyd@codeaurora.org,
 cyrille.pitchen@free-electrons.com, jgross@suse.com,
 viresh.kumar@linaro.org, u.kleine-koenig@pengutronix.de,
 sdharia@codeaurora.org, rdunlap@infradead.org, vinod.koul@intel.com,
 david.kershner@unisys.com, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] ide-cd: Drop unused sense buffers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180731195155.46664-2-keescook@chromium.org>
References: <20180731195155.46664-1-keescook@chromium.org>
	<20180731195155.46664-2-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

From: Kees Cook <keescook@chromium.org>
Date: Tue, 31 Jul 2018 12:51:46 -0700

> This drops unused sense buffers from:
> 
> 	cdrom_eject()
> 	cdrom_read_capacity()
> 	cdrom_read_tocentry()
> 	ide_cd_lockdoor()
> 	ide_cd_read_toc()
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
