Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0535AC432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 00:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F6720665
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 00:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQ5gqUXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK0AoK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 19:44:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57423 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727016AbfK0AoJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 19:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574815448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHOdA3zO5j/29imx0bRJye6LGkUp5aoRtGJhP7+JNBg=;
        b=RQ5gqUXqw2XCP6HmLjqVL9dqHWWgiGHmUhRIW0vg3/RDnVYE8PohN99nUliGI1N1zw+i/x
        9lrsMO4J81PoWa63e+v6e6/fR6L0d+aKHF852XmKZx+JDZHGmgpfiWxRI7ztYCqG9DTVYc
        yBgper0P4hgbN/Og/zKDKiO4tgarfi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-ZPzcyhORMWuiV3-stvRUAA-1; Tue, 26 Nov 2019 19:44:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED25E85EE84;
        Wed, 27 Nov 2019 00:44:03 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77A35108F80F;
        Wed, 27 Nov 2019 00:43:56 +0000 (UTC)
Date:   Wed, 27 Nov 2019 08:43:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 2/3] blk-mq: Move the TAG_ACTIVE and SCHED_RESTART flags
 from hctx into blk_mq_tags
Message-ID: <20191127004352.GA2876@ming.t460p>
References: <20191126175656.67638-1-bvanassche@acm.org>
 <20191126175656.67638-3-bvanassche@acm.org>
MIME-Version: 1.0
In-Reply-To: <20191126175656.67638-3-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ZPzcyhORMWuiV3-stvRUAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 26, 2019 at 09:56:55AM -0800, Bart Van Assche wrote:
> If each hardware queue has its own tag set it's fine to manage these
> flags per hardware queue. Since the next patch will share tag sets across
> hardware queues, move these flags into blk_mq_tags. This patch does not
> change any functionality.
>=20
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq-debugfs.c |  2 --
>  block/blk-mq-sched.c   |  8 ++++----
>  block/blk-mq-sched.h   |  2 +-
>  block/blk-mq-tag.c     |  8 ++++----
>  block/blk-mq-tag.h     | 10 ++++++++++
>  include/linux/blk-mq.h |  2 --
>  6 files changed, 19 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index b3f2ba483992..3678e95ec947 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -211,8 +211,6 @@ static const struct blk_mq_debugfs_attr blk_mq_debugf=
s_queue_attrs[] =3D {
>  #define HCTX_STATE_NAME(name) [BLK_MQ_S_##name] =3D #name
>  static const char *const hctx_state_name[] =3D {
>  =09HCTX_STATE_NAME(STOPPED),
> -=09HCTX_STATE_NAME(TAG_ACTIVE),
> -=09HCTX_STATE_NAME(SCHED_RESTART),
>  };
>  #undef HCTX_STATE_NAME
> =20
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index ca22afd47b3d..7d98b6513148 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -64,18 +64,18 @@ void blk_mq_sched_assign_ioc(struct request *rq)
>   */
>  void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
>  {
> -=09if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
> +=09if (test_bit(BLK_MQ_T_SCHED_RESTART, &hctx->tags->state))
>  =09=09return;
> =20
> -=09set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
> +=09set_bit(BLK_MQ_T_SCHED_RESTART, &hctx->tags->state);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_sched_mark_restart_hctx);
> =20
>  void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>  {
> -=09if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
> +=09if (!test_bit(BLK_MQ_T_SCHED_RESTART, &hctx->tags->state))
>  =09=09return;
> -=09clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
> +=09clear_bit(BLK_MQ_T_SCHED_RESTART, &hctx->tags->state);
> =20
>  =09blk_mq_run_hw_queue(hctx, true);
>  }

RESTART is supposed for restarting the hctx of this request queue,
instead of the tags of host-wide, which is covered by blk_mq_mark_tag_wait(=
).

> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 126021fc3a11..15174a646468 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -82,7 +82,7 @@ static inline bool blk_mq_sched_has_work(struct blk_mq_=
hw_ctx *hctx)
> =20
>  static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx=
)
>  {
> -=09return test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
> +=09return test_bit(BLK_MQ_T_SCHED_RESTART, &hctx->tags->state);
>  }
> =20
>  #endif
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 586c9d6e904a..a60e1b4a8158 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -23,8 +23,8 @@
>   */
>  bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
> -=09if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
> -=09    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> +=09if (!test_bit(BLK_MQ_T_ACTIVE, &hctx->tags->state) &&
> +=09    !test_and_set_bit(BLK_MQ_T_ACTIVE, &hctx->tags->state))
>  =09=09atomic_inc(&hctx->tags->active_queues);

The above is wrong.

With this change, tags->active_queues may become just 1, and the
variable is supposed to represent number of active LUNs using this
shared tags.

That is said the flag of BLK_MQ_T_ACTIVE is really per-hctx instead of
per-tags.

> =20
>  =09return true;
> @@ -48,7 +48,7 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>  {
>  =09struct blk_mq_tags *tags =3D hctx->tags;
> =20
> -=09if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> +=09if (!test_and_clear_bit(BLK_MQ_T_ACTIVE, &hctx->tags->state))
>  =09=09return;
> =20
>  =09atomic_dec(&tags->active_queues);
> @@ -67,7 +67,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx =
*hctx,
> =20
>  =09if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_SHARED))
>  =09=09return true;
> -=09if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> +=09if (!test_bit(BLK_MQ_T_ACTIVE, &hctx->tags->state))
>  =09=09return true;
> =20
>  =09/*
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index d0c10d043891..f75fa936b090 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -4,6 +4,11 @@
> =20
>  #include "blk-mq.h"
> =20
> +enum {
> +=09BLK_MQ_T_ACTIVE=09=09=3D 1,
> +=09BLK_MQ_T_SCHED_RESTART=09=3D 2,
> +};
> +
>  /*
>   * Tag address space map.
>   */
> @@ -11,6 +16,11 @@ struct blk_mq_tags {
>  =09unsigned int nr_tags;
>  =09unsigned int nr_reserved_tags;
> =20
> +=09/**
> +=09 * @state: BLK_MQ_T_* flags. Defines the state of the hw
> +=09 * queue (active, scheduled to restart).
> +=09 */
> +=09unsigned long=09state;

It isn't unusual for SCSI HBA to see hundreds of LUNs, and this patch
will make .state shared for these LUNs, and read/write concurrently from
IO path on all these queues, and performance should hurt much in this way
given all related helpers are used in hot path.


Thanks,
Ming

