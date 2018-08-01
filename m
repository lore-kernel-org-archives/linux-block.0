Return-Path: <BATV+568b9e22b4768da93666+5456+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 1 Aug 2018 01:24:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"David S. Miller" <davem@davemloft.net>,
	"Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
	"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
	Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
	"Nicholas A. Bellinger" <nab@linux-iscsi.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
	Juergen Gross <jgross@suse.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vinod Koul <vinod.koul@intel.com>,
	David Kershner <david.kershner@unisys.com>,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] cdrom: Use struct scsi_sense_hdr internally
Message-ID: <20180801082407.GC26378@infradead.org>
References: <20180731195155.46664-1-keescook@chromium.org>
 <20180731195155.46664-8-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180731195155.46664-8-keescook@chromium.org>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 31, 2018 at 12:51:52PM -0700, Kees Cook wrote:
> This removes more casts of struct request_sense and uses the standard
> struct scsi_sense_hdr instead. This also fixes any possible stale values
> since the prior code did not check the sense length.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
