Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CD3C433DB
	for <linux-block@archiver.kernel.org>; Sat, 30 Jan 2021 19:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E848260234
	for <linux-block@archiver.kernel.org>; Sat, 30 Jan 2021 19:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhA3TJ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Jan 2021 14:09:26 -0500
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:39440 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231690AbhA3TJZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Jan 2021 14:09:25 -0500
X-Greylist: delayed 652 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jan 2021 14:09:25 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 21CC118016665
        for <linux-block@vger.kernel.org>; Sat, 30 Jan 2021 18:58:33 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2EBA1100E7B46;
        Sat, 30 Jan 2021 18:57:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dad66_00075af275b3
X-Filterd-Recvd-Size: 1822
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jan 2021 18:57:49 +0000 (UTC)
Message-ID: <5deee552f4bcfd81c6dc6ec3e8139c0c4ba27d31.camel@perches.com>
Subject: Re: [PATCH 06/29] drbd: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 30 Jan 2021 10:57:48 -0800
In-Reply-To: <1c8081264d82101d7837220c5ee221c307da5d91.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
         <1c8081264d82101d7837220c5ee221c307da5d91.1598331148.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

ping?

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/block/drbd/drbd_receiver.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 422363daa618..87f732fb5456 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -111,8 +111,10 @@ static struct page *page_chain_tail(struct page *page, int *len)
>  {
>  	struct page *tmp;
>  	int i = 1;
> -	while ((tmp = page_chain_next(page)))
> -		++i, page = tmp;
> +	while ((tmp = page_chain_next(page))) {
> +		++i;
> +		page = tmp;
> +	}
>  	if (len)
>  		*len = i;
>  	return page;


