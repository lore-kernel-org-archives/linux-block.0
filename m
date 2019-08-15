Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA74DC3A59C
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 12:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25322173E
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565871864;
	bh=RtoUap9Hk0Zwa+hD6d37kWtHgQ3GthgQOTFPuugX+54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dVjad9IFgnf2m5/a1wzvQBYRyUS4FRNxUwo3zzHO2ptPJrBT1mBl1YnoSzZ+Jbpwk
	 ++sWgGGEsX30bC4ZUsnYh6+NuGltyxUP/rxMBBcDmpb2z92TQSib5z4alCDi+Xrnz9
	 kdQy9IbRPdYjqphVgonhSLSGjVLLSl6UN3aj42rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfHOMYX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfHOMYX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 08:24:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13F302083B;
        Thu, 15 Aug 2019 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565871862;
        bh=RtoUap9Hk0Zwa+hD6d37kWtHgQ3GthgQOTFPuugX+54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTGojPDbIdJTK6FgkaDE5VaHtJYb/xlSg7nGZWn++FL9kFiGGU6X5/Ko48fBSaMCO
         +zJGLizncYkyNCZJmiGlDVq4dStlofeA5amsypdj7gJ0xi3wd4nL/BEPzHYVOLcjbf
         X8U56IdCsTe+m8JUXG9KhE7DbdR5miye2SNm7d9k=
Date:   Thu, 15 Aug 2019 14:24:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Mark Ray <mark.ray@hpe.com>
Subject: Re: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
Message-ID: <20190815122419.GA31891@kroah.com>
References: <20190815121518.16675-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815121518.16675-1-ming.lei@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 15, 2019 at 08:15:18PM +0800, Ming Lei wrote:
> It is reported that sysfs buffer overflow can be triggered in case
> of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs in
> one hctx.
> 
> So use snprintf for avoiding the potential buffer overflow.
> 
> Cc: stable@vger.kernel.org
> Cc: Mark Ray <mark.ray@hpe.com>
> Fixes: 676141e48af7("blk-mq: don't dump CPU -> hw queue map on driver load")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-sysfs.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index d6e1a9bd7131..e75f41a98415 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -164,22 +164,28 @@ static ssize_t blk_mq_hw_sysfs_nr_reserved_tags_show(struct blk_mq_hw_ctx *hctx,
>  	return sprintf(page, "%u\n", hctx->tags->nr_reserved_tags);
>  }
>  
> +/* avoid overflow by too many CPU cores */
>  static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
>  {
> -	unsigned int i, first = 1;
> -	ssize_t ret = 0;
> -
> -	for_each_cpu(i, hctx->cpumask) {
> -		if (first)
> -			ret += sprintf(ret + page, "%u", i);
> -		else
> -			ret += sprintf(ret + page, ", %u", i);
> -
> -		first = 0;
> +	unsigned int cpu = cpumask_first(hctx->cpumask);
> +	ssize_t len = snprintf(page, PAGE_SIZE - 1, "%u", cpu);
> +	int last_len = len;
> +
> +	while ((cpu = cpumask_next(cpu, hctx->cpumask)) < nr_cpu_ids) {
> +		int cur_len = snprintf(page + len, PAGE_SIZE - 1 - len,
> +				       ", %u", cpu);
> +		if (cur_len >= PAGE_SIZE - 1 - len) {
> +			len -= last_len;
> +			len += snprintf(page + len, PAGE_SIZE - 1 - len,
> +					"...");
> +			break;
> +		}
> +		len += cur_len;
> +		last_len = cur_len;
>  	}
>  
> -	ret += sprintf(ret + page, "\n");
> -	return ret;
> +	len += snprintf(page + len, PAGE_SIZE - 1 - len, "\n");
> +	return len;
>  }
>

What????

sysfs is "one value per file".  You should NEVER have to care about the
size of the sysfs buffer.  If you do, you are doing something wrong.

What excatly are you trying to show in this sysfs file?  I can't seem to
find the Documenatation/ABI/ entry for it, am I just missing it because
I don't know the filename for it?

thanks,

greg k-h
