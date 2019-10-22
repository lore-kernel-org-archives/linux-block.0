Return-Path: <SRS0=K2Ob=YP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAA9CA9EA0
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 09:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4C620679
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 09:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SA1jISKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfJVJcd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:32:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24491 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJVJcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 05:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571736752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5ttEye6MuoUjK3FV+/868ElGC+9PXIvThqd2IGzK4M=;
        b=SA1jISKSZWPTVDSyQQh/8AxE1a8vBi3t4jPdfI1giqfUQUAWQOlS1C13tO8Mad5T568/s4
        q0n39PIYD9oH8DpmC9ETxAS8dNSkjFHlnGHi4FskbTkt/JmkO3g6SUFxtIK/lN/rt3R1D9
        mFITIvi7EpuePEJDLpffrAsYBeVk054=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-F2g8yxMpP3CvJaUJevOPjA-1; Tue, 22 Oct 2019 05:32:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 799991005527;
        Tue, 22 Oct 2019 09:32:27 +0000 (UTC)
Received: from ming.t460p (ovpn-8-36.pek2.redhat.com [10.72.8.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 024DF1001DE0;
        Tue, 22 Oct 2019 09:32:18 +0000 (UTC)
Date:   Tue, 22 Oct 2019 17:32:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 1/4] block: Remove the synchronize_rcu() call from
 __blk_mq_update_nr_hw_queues()
Message-ID: <20191022093212.GA9037@ming.t460p>
References: <20191021224259.209542-1-bvanassche@acm.org>
 <20191021224259.209542-2-bvanassche@acm.org>
MIME-Version: 1.0
In-Reply-To: <20191021224259.209542-2-bvanassche@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: F2g8yxMpP3CvJaUJevOPjA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 21, 2019 at 03:42:56PM -0700, Bart Van Assche wrote:
> Since the blk_mq_{,un}freeze_queue() calls in __blk_mq_update_nr_hw_queue=
s()
> already serialize __blk_mq_update_nr_hw_queues() against
> blk_mq_queue_tag_busy_iter(), the synchronize_rcu() call in
> __blk_mq_update_nr_hw_queues() is not necessary. Hence remove it.
>=20
> Note: the synchronize_rcu() call in __blk_mq_update_nr_hw_queues() was
> introduced by commit f5bbbbe4d635 ("blk-mq: sync the update nr_hw_queues =
with
> blk_mq_queue_tag_busy_iter"). Commit 530ca2c9bd69 ("blk-mq: Allow blockin=
g
> queue tag iter callbacks") removed the rcu_read_{,un}lock() calls that
> correspond to the synchronize_rcu() call in __blk_mq_update_nr_hw_queues(=
).
>=20
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8538dc415499..7528678ef41f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3242,10 +3242,6 @@ static void __blk_mq_update_nr_hw_queues(struct bl=
k_mq_tag_set *set,
> =20
>  =09list_for_each_entry(q, &set->tag_list, tag_set_list)
>  =09=09blk_mq_freeze_queue(q);
> -=09/*
> -=09 * Sync with blk_mq_queue_tag_busy_iter.
> -=09 */
> -=09synchronize_rcu();
>  =09/*
>  =09 * Switch IO scheduler to 'none', cleaning up the data associated
>  =09 * with the previous scheduler. We will switch back once we are done
> --=20
> 2.23.0.866.gb869b98d4c-goog
>=20

Reviewed-by: Ming Lei <ming.lei@redhat.com>

--=20
Ming

