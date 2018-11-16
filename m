Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F79EC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 14:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155E0208A3
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 14:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEakseb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155E0208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbeKQARy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbeKQARy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 19:17:54 -0500
Received: from localhost (unknown [207.164.22.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB82C2086C;
        Fri, 16 Nov 2018 14:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542377121;
        bh=x5gX0HwfCljpgoOapldO4AV4hsidGApMzLe2amvXrXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QEakseb8ShBU/qV22UlRjqfTqbR3Pdy1AcKAmjwUNQLjYg+f4ktYVe/74X8dewMoH
         2+KYn+bdiAzP5INIDj9qrAIK7cX8ca+eA1Dq/cOz2JZEGLePkYZRjFJ1fZ0C+7ERFP
         YOYdJijSF42DYc0H60sTs22Cwyhep3+YiICh9O3A=
Date:   Fri, 16 Nov 2018 06:05:21 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org
Subject: Re: [PATCH V2 for-4.21 1/2] blk-mq: not embed .mq_kobj and ctx->kobj
 into queue instance
Message-ID: <20181116140521.GB4595@kroah.com>
References: <20181116112311.4117-1-ming.lei@redhat.com>
 <20181116112311.4117-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116112311.4117-2-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 07:23:10PM +0800, Ming Lei wrote:
> @@ -456,7 +456,7 @@ struct request_queue {
>  	/*
>  	 * mq queue kobject
>  	 */
> -	struct kobject mq_kobj;
> +	struct kobject *mq_kobj;

What is this kobject even used for?  It wasn't obvious at all from this
patch, why is it needed if you are not using it to reference count the
larger structure here?

thanks,

greg k-h
