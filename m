Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D715C4332B
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 14:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB622077D
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584972267;
	bh=s2NbQJjle+0OzIirrPM+TLR0bDT4Bsx1I69q/jCQKMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KkqRKD7kqL22xpcTlp62yvaoGFbnmksNga9eo5rhhJVIoQljKEn3WkQicXGw5Bi2a
	 SbMxcNjE+yAInzoKuiu+22GeqwFqrqbwpFLqhxgWsxkHV8iRJLuq6jIATh5NWjYg2/
	 i8JS+vEIDtxiDK3nik6n6Dn8sKuWLxBseG0MJVUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgCWOE0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbgCWOE0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 10:04:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2512076A;
        Mon, 23 Mar 2020 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584972264;
        bh=s2NbQJjle+0OzIirrPM+TLR0bDT4Bsx1I69q/jCQKMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0JLIB8OTtTcgH+XZTnGtGS+5XCEF0ztyGqJtW8wr61SkA5In0i+4cekXFDZXJzF0
         GcwQQNRsU5DczS2q9HjtUwmz23116PdLu5KEsRDBfGqQh2a4f5qmHa3vG8OAHlT+QU
         omIZbpEWtAgyWLKvvWPZRKzww5YGqxS6EpWcyBoI=
Date:   Mon, 23 Mar 2020 15:04:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu
Subject: Re: [PATCH v3 4/4] bdi: protect bdi->dev with spinlock
Message-ID: <20200323140421.GA7976@kroah.com>
References: <20200323132254.47157-1-yuyufen@huawei.com>
 <20200323132254.47157-5-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323132254.47157-5-yuyufen@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 23, 2020 at 09:22:54PM +0800, Yufen Yu wrote:
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 82d2401fec37..1c0e2d0d6236 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -525,12 +525,16 @@ static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
>  static inline char *bdi_get_dev_name(struct backing_dev_info *bdi,
>  			char *dname, int len)
>  {
> +	spin_lock_irq(&bdi->lock);
>  	if (!bdi || !bdi->dev) {
> +		spin_unlock_irq(&bdi->lock);

You can't test for (!bdi) right after you accessed bdi->lock :(

