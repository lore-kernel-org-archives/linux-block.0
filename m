Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1261C432C3
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F23206CC
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 18:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="GKNVzz82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUSaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:30:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38852 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSaV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 13:30:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id e2so3945736qkn.5
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2019 10:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KIV6C8dEDRsWYAQ2tTt3LiUnyRDtIsvpcdrWmt9koPk=;
        b=GKNVzz82IHSesvkhRwLOrdR1guhy1ks2Zlv5Ig9t4AOGgFyjYCJJLijnX+MsFowaXV
         RsyaqXjmaAhEKGmtYxEH+iPKkLHXHFpTuRz1wKvwFc70VrQxaOGVXyBOhjWMJ0JMhJfB
         8v+EDESV8ao55NbiACdWSRh4IaD2WVhHfWfoBmYoqyjjdN56d6gqKA7Cu41Pm+WwmeDB
         tyO7+rhHbotOPjRQIwIj/EKC9fMRPXOZ6XbEU38Q4t5aqxY1CA+7/LlSoWUbFjfiiLLT
         reR0lZBlCbK1tCyqtsYZVzBMydx8fC7iTyCWACTRNYORaRYTgseS+RgEGgiaHgUtbuc8
         240g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KIV6C8dEDRsWYAQ2tTt3LiUnyRDtIsvpcdrWmt9koPk=;
        b=nyfOVHkJKfCRbJ3eUwgff/Oi8xEzJ+bZ5S1Ms8lQvGe453fJ9vXbr6r4HoyiKTvAvJ
         q3c/YlTSPhZFYmr+T2fI9fu3KqWMsKt3uE68KlgYFo1TXDe7c2o8XGQYkfsjs04m38jd
         Ho3ZX2y9ky8o/CsVTIVH+vGThIzc1wONm4rAw6AANIyNGKUBkzg/qNtrRz85YIEfXgtm
         Le8B+x3BwVSfgxXcxOK36MeDQ6QXVhfO1XjvSukLiyWOtTSuffqtZW3gvaPwlnT2xpQU
         Vl3hPdJGfRVxBBh7e/7ZLve22R0Tje1xGSeuveT42rrG2iDxlItFngIH5VcAsohSMS/O
         46LQ==
X-Gm-Message-State: APjAAAWvEi1GC9z1+c+OhS6brs7TYiwai2ascaYBY2qsSr46xf68OHY/
        /ozkwv9L8+MAFQUTVOyjqTxWaw==
X-Google-Smtp-Source: APXvYqyaGMwQheyrHGh2wyVCXUzgK0AD9nF7B5VCw+XZF6QwzxAqrPIjnl8qwfQqMknP9QjM9fRjDA==
X-Received: by 2002:a37:78f:: with SMTP id 137mr8854398qkh.321.1574361020373;
        Thu, 21 Nov 2019 10:30:20 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g17sm2036642qte.89.2019.11.21.10.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 10:30:19 -0800 (PST)
Date:   Thu, 21 Nov 2019 13:30:17 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: prevent memory leak
Message-ID: <20191121183017.h3qkpib5re27ty3b@MacBook-Pro-91.local>
References: <20190923200959.29643-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923200959.29643-1-navid.emamdoost@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 23, 2019 at 03:09:58PM -0500, Navid Emamdoost wrote:
> In nbd_add_socket when krealloc succeeds, if nsock's allocation fail the
> reallocted memory is leak. The correct behaviour should be assigning the
> reallocted memory to config->socks right after success.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
