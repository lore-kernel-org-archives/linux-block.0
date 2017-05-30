Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64238 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdE3SLt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 14:11:49 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "keith.busch@intel.com" <keith.busch@intel.com>,
        "krisman@collabora.co.uk" <krisman@collabora.co.uk>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: WARNING triggers at blk_mq_update_nr_hw_queues during
 nvme_reset_work
Date: Tue, 30 May 2017 18:09:22 +0000
Message-ID: <1496167761.2627.22.camel@sandisk.com>
References: <8760giqnyb.fsf@dilma.collabora.co.uk>
         <20170530175549.GC2845@localhost.localdomain>
In-Reply-To: <20170530175549.GC2845@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2017-05-30 at 13:55 -0400, Keith Busch wrote:
> On Tue, May 30, 2017 at 02:00:44PM -0300, Gabriel Krisman Bertazi wrote:
> > Since the merge window for 4.12, one of the machines in Intel's CI
> > started to hit the WARN_ON below at blk_mq_update_nr_hw_queues during a=
n
> > nvme_reset_work.  The issue persists with the latest 4.12-rc3, and full
> > dmesg from boot, up to the moment where the WARN_ON triggers is
> > available at the following link:
> >=20
> > https://intel-gfx-ci.01.org/CI/CI_DRM_2672/fi-kbl-7500u/igt@kms_pipe_cr=
c_basic@suspend-read-crc-pipe-a.html
> >=20
> > Please notice that the test we do in the CI involves putting the
> > machine to sleep (PM), and the issue triggers when resuming execution.
> >=20
> > I have not been able to get my hands on the machine yet to do an actual
> > bisect, but I'm wondering if you guys might have an idea of what is
> > wrong.
> >=20
> > Any help is appreciated :)
>=20
> Hi Gabriel,
>=20
> This appears to be new behavior in blk-mq's tag set update with commit
> 705cda97e. This is asserting a lock is held, but none of the drivers
> that call the export are take that lock.
>=20
> I think the below should fix it (CC'ing block list and developers).
>=20
> ---
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f2224ffd..1bccced 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2641,7 +2641,8 @@ int blk_mq_update_nr_requests(struct request_queue =
*q, unsigned int nr)
>  	return ret;
>  }
> =20
> -void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_qu=
eues)
> +static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> +							int nr_hw_queues)
>  {
>  	struct request_queue *q;
> =20
> @@ -2665,6 +2666,13 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_=
set *set, int nr_hw_queues)
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>  		blk_mq_unfreeze_queue(q);
>  }
> +
> +void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_qu=
eues)
> +{
> +	mutex_lock(&set->tag_list_lock);
> +	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
> +	mutex_unlock(&set->tag_list_lock);
> +}
>  EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);

These changes look fine to me, hence:

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>
