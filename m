Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0938C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 11:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F17206A5
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 11:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="hhWDdo3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfLKL2w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:28:52 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:53431 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfLKL2v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 06:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576063730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XucGklAb5jgmbxF6Pb2nFFWPeBSLiJZB8kC8WOl1g1M=;
  b=hhWDdo3j/GIBvV5KNzTHjTQMN+1efJa6USctQyNoj+FO/A6jquddsemB
   Ci7BZsbPJ0y9mwenucFDWeE77bOzgZpfWexjLz8OxBmU46W30DtweM95t
   PcI53tffy59GvQGUkRghSk1ISEeteane8XhPG/2q9+tS3zMK0He4WS8Mv
   o=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 7w5bhG9ESC4u0P4EtihWi5RlqDTDjkW2s2g6HAHsX8PFXfgpTaqORTFL1uohkzwfN+cdSPVYT/
 mNOSDco1Q8HOXkY7WUTGiGl/ZJutST2wamJXl9CokOajDu1W8tyh3L6lQwjvcfTLwvqa0rFwF5
 5hb7kI3heHhUzBnuN/t0XSRxqN3RbCE64boZ7HRFJnfNrB3b/2g1ULzvbYBazcJY/VkmENqrHv
 hrtIkNL2l/ok5nQMXYi/3BTc0FZ4KwjLZkcjknHCKQiIQ3WRoRtFRvhbR1mKzPmCCHFlt0Cryd
 eqk=
X-SBRS: 2.7
X-MesageID: 9870771
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,301,1571716800"; 
   d="scan'208";a="9870771"
Date:   Wed, 11 Dec 2019 12:28:44 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     Paul Durrant <pdurrant@amazon.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] xen-blkback: prevent premature module unload
Message-ID: <20191211112754.GM980@Air-de-Roger>
References: <20191210145305.6605-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191210145305.6605-1-pdurrant@amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 10, 2019 at 02:53:05PM +0000, Paul Durrant wrote:
> Objects allocated by xen_blkif_alloc come from the 'blkif_cache' kmem
> cache. This cache is destoyed when xen-blkif is unloaded so it is
> necessary to wait for the deferred free routine used for such objects to
> complete. This necessity was missed in commit 14855954f636 "xen-blkback:
> allow module to be cleanly unloaded". This patch fixes the problem by
> taking/releasing extra module references in xen_blkif_alloc/free()
> respectively.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

One nit below.

> ---
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: "Roger Pau Monné" <roger.pau@citrix.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/xen-blkback/xenbus.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index e8c5c54e1d26..59d576d27ca7 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -171,6 +171,15 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
>  	blkif->domid = domid;
>  	atomic_set(&blkif->refcnt, 1);
>  	init_completion(&blkif->drain_complete);
> +
> +	/*
> +	 * Because freeing back to the cache may be deferred, it is not
> +	 * safe to unload the module (and hence destroy the cache) until
> +	 * this has completed. To prevent premature unloading, take an
> +	 * extra module reference here and release only when the object
> +	 * has been free back to the cache.
                    ^ freed
> +	 */
> +	__module_get(THIS_MODULE);
>  	INIT_WORK(&blkif->free_work, xen_blkif_deferred_free);
>  
>  	return blkif;
> @@ -320,6 +329,7 @@ static void xen_blkif_free(struct xen_blkif *blkif)
>  
>  	/* Make sure everything is drained before shutting down */
>  	kmem_cache_free(xen_blkif_cachep, blkif);
> +	module_put(THIS_MODULE);
>  }
>  
>  int __init xen_blkif_interface_init(void)
> -- 
> 2.20.1
> 
