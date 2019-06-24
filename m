Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B3BC43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08512054F
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 15:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfFXPnN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:43:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39290 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfFXPnN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 11:43:13 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfR79-0000Pc-UN; Mon, 24 Jun 2019 17:42:40 +0200
Date:   Mon, 24 Jun 2019 17:42:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Weiping Zhang <zhangweiping@didiglobal.com>
cc:     axboe@kernel.dk, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>, bvanassche@acm.org,
        keith.busch@intel.com, minwoo.im.dev@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 4/5] genirq/affinity: allow driver's discontigous
 affinity set
In-Reply-To: <1ead341c6d603cf138aed62e31091f257cb19981.1561385989.git.zhangweiping@didiglobal.com>
Message-ID: <alpine.DEB.2.21.1906241740320.32342@nanos.tec.linutronix.de>
References: <cover.1561385989.git.zhangweiping@didiglobal.com> <1ead341c6d603cf138aed62e31091f257cb19981.1561385989.git.zhangweiping@didiglobal.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Jun 2019, Weiping Zhang wrote:

> The driver may implement multiple affinity set, and some of
> are empty, for this case we just skip them.

Why? What's the point of creating empty sets? Just because is not a real
good justification.

Leaving the patch for Ming.

Thanks,

	tglx

> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>  kernel/irq/affinity.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index f18cd5aa33e8..6d964fe0fbd8 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -295,6 +295,10 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>  		unsigned int this_vecs = affd->set_size[i];
>  		int ret;
>  
> +		/* skip empty affinity set */
> +		if (this_vecs == 0)
> +			continue;
> +
>  		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
>  					       curvec, masks);
>  		if (ret) {
> -- 
> 2.14.1
> 
> 
