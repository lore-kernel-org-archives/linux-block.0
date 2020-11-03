Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2B3C388F2
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 04:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C1E22245
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 04:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzpY15iF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgKCEMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 23:12:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbgKCEMw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Nov 2020 23:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604376770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NgYZUQ3WOulleStwOp1G16UNxwlI9rafuhu3xgy1Db0=;
        b=GzpY15iFWS3+j8BQSdvHp0qdYSkCffoeA9tBRC90ESZhoFgVR4uRgI2GyBj2nU76aparxT
        z/xlkpnGqRPLVv1eCz+RLcXH5T4yb19VIQGh1oPzjrWI+wEkx3a5r6g1JiXeaRm0YiJqJU
        ihUO4CDT+CqvCCuz2FuNhR1KbLR6k14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-EB9aRCxWMfK-qixqLQiAeQ-1; Mon, 02 Nov 2020 23:12:49 -0500
X-MC-Unique: EB9aRCxWMfK-qixqLQiAeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D81868030AE;
        Tue,  3 Nov 2020 04:12:47 +0000 (UTC)
Received: from T590 (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D56E672C0;
        Tue,  3 Nov 2020 04:12:37 +0000 (UTC)
Date:   Tue, 3 Nov 2020 12:12:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     xiubli@redhat.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, nbd@other.debian.org,
        linux-block@vger.kernel.org, jdillama@redhat.com, mgolub@suse.de
Subject: Re: [PATCH v2 1/2] nbd: fix use-after-freed crash for nbd->recv_workq
Message-ID: <20201103041215.GD25186@T590>
References: <20201103030758.317781-1-xiubli@redhat.com>
 <20201103030758.317781-2-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103030758.317781-2-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 02, 2020 at 10:07:57PM -0500, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> The crash call trace:
> 
> <6>[ 1012.319386] block nbd1: NBD_DISCONNECT
> <1>[ 1012.319437] BUG: kernel NULL pointer dereference, address: 0000000000000020
> <1>[ 1012.319439] #PF: supervisor write access in kernel mode
> <1>[ 1012.319441] #PF: error_code(0x0002) - not-present page
> <6>[ 1012.319442] PGD 0 P4D 0
> <4>[ 1012.319448] Oops: 0002 [#1] SMP NOPTI
> <4>[ 1012.319454] CPU: 9 PID: 25111 Comm: rbd-nbd Tainted: G            E     5.9.0+ #6
>    [...]
> <4>[ 1012.319505] PKRU: 55555554
> <4>[ 1012.319506] Call Trace:
> <4>[ 1012.319560]  flush_workqueue+0x81/0x440
> <4>[ 1012.319598]  nbd_disconnect_and_put+0x50/0x70 [nbd]
> <4>[ 1012.319607]  nbd_genl_disconnect+0xc7/0x170 [nbd]
> <4>[ 1012.319627]  genl_rcv_msg+0x1dd/0x2f9
> <4>[ 1012.319642]  ? genl_start+0x140/0x140
> <4>[ 1012.319644]  netlink_rcv_skb+0x49/0x110
> <4>[ 1012.319649]  genl_rcv+0x24/0x40
> <4>[ 1012.319651]  netlink_unicast+0x1a5/0x280
> <4>[ 1012.319653]  netlink_sendmsg+0x23d/0x470
> <4>[ 1012.319667]  sock_sendmsg+0x5b/0x60
> <4>[ 1012.319676]  ____sys_sendmsg+0x1ef/0x260
> <4>[ 1012.319679]  ? copy_msghdr_from_user+0x5c/0x90
> <4>[ 1012.319680]  ? ____sys_recvmsg+0xa5/0x180
> <4>[ 1012.319682]  ___sys_sendmsg+0x7c/0xc0
> <4>[ 1012.319683]  ? copy_msghdr_from_user+0x5c/0x90
> <4>[ 1012.319685]  ? ___sys_recvmsg+0x89/0xc0
> <4>[ 1012.319692]  ? __wake_up_common_lock+0x87/0xc0
> <4>[ 1012.319715]  ? __check_object_size+0x46/0x173
> <4>[ 1012.319727]  ? _copy_to_user+0x22/0x30
> <4>[ 1012.319729]  ? move_addr_to_user+0xc3/0x100
> <4>[ 1012.319731]  __sys_sendmsg+0x57/0xa0
> <4>[ 1012.319744]  do_syscall_64+0x33/0x40
> <4>[ 1012.319760]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> <4>[ 1012.319780] RIP: 0033:0x7f5baa8e3ad5
> 
> In case the reference of nbd->config has reached zero and the
> related resource has been released, if another process tries to
> send the DISCONENCT cmd by using the netlink, it will potentially
> crash like this.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  drivers/block/nbd.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index f46e26c9d9b3..3bb8281bb753 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2003,16 +2003,31 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>  
>  static void nbd_disconnect_and_put(struct nbd_device *nbd)
>  {
> +	bool flush = true;
> +
>  	mutex_lock(&nbd->config_lock);
>  	nbd_disconnect(nbd);
>  	nbd_clear_sock(nbd);
> -	mutex_unlock(&nbd->config_lock);
>  	/*
> -	 * Make sure recv thread has finished, so it does not drop the last
> -	 * config ref and try to destroy the workqueue from inside the work
> -	 * queue.
> +	 * In very rare case that the nbd->recv_workq may already have been
> +	 * released by the recv_work().
>  	 */
> -	flush_workqueue(nbd->recv_workq);
> +	if (likely(!nbd->recv_workq))

It is actually unlikely, but doesn't make any sense to annotate the check
since it isn't fast path, so please remove it.

> +		refcount_inc(&nbd->config_refs);
> +	else
> +		flush = false;
> +	mutex_unlock(&nbd->config_lock);
> +
> +	if (flush) {
> +		/*
> +		 * Make sure recv thread has finished, so it does not drop
> +		 * the last config ref and try to destroy the workqueue
> +		 * from inside the work queue.
> +		 */
> +		flush_workqueue(nbd->recv_workq);
> +		nbd_config_put(nbd);
> +	}
> +
>  	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
>  			       &nbd->config->runtime_flags))
>  		nbd_config_put(nbd);

The approach is fine, and the reason is that nbd_disconnect_and_put() still
can be called via netlink when the nbd device has been closed:

Once the above likely() is removed, feel free to add:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

