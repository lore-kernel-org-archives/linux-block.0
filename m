Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921CFE7AD6E
	for <linux-block@archiver.kernel.org>; Tue,  3 Oct 2023 15:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjJCPs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Oct 2023 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjJCPs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2023 11:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB59C95
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696348059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jbXBlrMhQt2+H3/t00rahbjKJXb0XTBcj1f4kJcqcLQ=;
        b=SgcJSl68l77sRRyMHSWRIVLOISJnHZXJWIg7qfUyf/riXH/qe5qezrQsMVaukOAaeQid/l
        ZTWqYpBDF9XtjiG5PzU98cIDbLT2jJUlkjveOWDJewpYdErBJiDtWCVp3Qu/sxT8B/JhVw
        RDy7p0IT7Vxm9hkCwDauEw0r/S0ARPc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-w2c2ooY0Mt62Bf_I48W0EQ-1; Tue, 03 Oct 2023 11:47:27 -0400
X-MC-Unique: w2c2ooY0Mt62Bf_I48W0EQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59659811E96;
        Tue,  3 Oct 2023 15:47:27 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78B192156702;
        Tue,  3 Oct 2023 15:47:24 +0000 (UTC)
Date:   Tue, 3 Oct 2023 23:47:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] ublk: Make ublks_max configurable
Message-ID: <ZRw3hzwTkvA4D8Ee@fedora>
References: <20231001185448.48893-1-michael.christie@oracle.com>
 <20231001185448.48893-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001185448.48893-3-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 01, 2023 at 01:54:48PM -0500, Mike Christie wrote:
> We are converting tcmu applications to ublk, but have systems with up
> to 1k devices. This patch allows us to configure the ublks_max from
> userspace with the ublks_max modparam.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/block/ublk_drv.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 18e352f8cd6d..2833a81e05c0 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2940,7 +2940,36 @@ static void __exit ublk_exit(void)
>  module_init(ublk_init);
>  module_exit(ublk_exit);
>  
> -module_param(ublks_max, int, 0444);
> +static int ublk_set_max_ublks(const char *buf, const struct kernel_param *kp)
> +{
> +	unsigned int max;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &max);
> +	if (ret)
> +		return ret;
> +
> +	if (max > UBLK_MAX_UBLKS) {
> +		pr_warn("Invalid ublks_max. Max supported is %d\n",
> +			UBLK_MAX_UBLKS);
> +		return -EINVAL;
> +	}
> +
> +	ublks_max = max;
> +	return ret;

It might be nice to reuse builtin helper:

	return param_set_uint_minmax(buf, kp, 0, UBLK_MAX_UBLKS);

> +}
> +
> +static int ublk_get_max_ublks(char *buf, const struct kernel_param *kp)
> +{
> +	return sysfs_emit(buf, "%d\n", ublks_max);
> +}
> +
> +static const struct kernel_param_ops ublk_max_ublks_ops = {
> +	.set = ublk_set_max_ublks,
> +	.get = ublk_get_max_ublks,

Same with above, '.get    = param_get_int,' could be better.

Otherwise, this patch looks fine.

Thanks,
Ming

