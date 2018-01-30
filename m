Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Tue, 30 Jan 2018 09:27:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20180130012755.GE17176@ming.t460p>
References: <20180129154455.GB17176@ming.t460p>
	<20180129204031.GA5499@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20180129204031.GA5499@redhat.com>
Cc: linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org, Linux-scsi@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Two blk-mq related topics
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf-pc/>
List-Post: <mailto:lsf-pc@lists.linux-foundation.org>
List-Help: <mailto:lsf-pc-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: lsf-pc-bounces@lists.linux-foundation.org
Errors-To: lsf-pc-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 29, 2018 at 03:40:31PM -0500, Mike Snitzer wrote:
> On Mon, Jan 29 2018 at 10:46am -0500,
> Ming Lei <ming.lei@redhat.com> wrote:
>  
> > 2. When to enable SCSI_MQ at default again?
> > 
> > SCSI_MQ is enabled on V3.17 firstly, but disabled at default. In V4.13-rc1,
> > it is enabled at default, but later the patch is reverted in V4.13-rc7, and
> > becomes disabled at default too.
> > 
> > Now both the original reported PM issue(actually SCSI quiesce) and the
> > sequential IO performance issue have been addressed. And MQ IO schedulers
> > are ready too for traditional disks. Are there other issues to be addressed
> > for enabling SCSI_MQ at default? When can we do that again?
> > 
> > Last time, the two issues were reported during V4.13 dev cycle just when it is
> > enabled at default, that seems if SCSI_MQ isn't enabled at default, it wouldn't
> > be exposed to run/tested completely & fully.  
> > 
> > So if we continue to disable it at default, maybe it can never be exposed to
> > full test/production environment.
> 
> I was going to propose revisiting this as well.
> 
> I'd really like to see all the old .request_fn block core code removed.

Yeah, that should be a final goal, but may take a bit long.

> 
> But maybe we take a first step of enabling:
> CONFIG_SCSI_MQ_DEFAULT=Y
> CONFIG_DM_MQ_DEFAULT=Y

Maybe you can remove legacy path from DM_RQ first, and take your
original approach to allow DM/MQ over legacy underlying driver,
seems we discussed this topic before, :-)

Thanks,
Ming
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
