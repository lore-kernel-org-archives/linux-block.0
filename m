Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E997C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF81206E0
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 13:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsnHnUhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfFTNky (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:40:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35967 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfFTNkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 09:40:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so1715158pfl.3
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uMLQuGNemSrSzWsE0/6zTnYQ6NRODoVSf1zVwacWkEM=;
        b=RsnHnUhIlhL75n5aSjLKJUFGA4hl51Lp8AzZk8nCCIcVIP4vP2yRG+gw1aI96uilgf
         qvwFYBmjyyazr2+Rdnc0FYyC2Am2xkZYYsS7AK7QW2UY8sN6c9HWDBqYqATHy2Mu2M90
         z4gn0s/SKEIAhmslbjj2o4kvULtgZlRoe0EKBQs9oNgLjypyEU1A+wkO2R+uhKy/H7nz
         xzb6IDTrOJMaqK6PMjbmtiPWz3joAZmbLAtJxs490fXX7HFt1xfvdF1lO/6NdT8Jwx+X
         Qp7IqNJSbE6Yu8yXSfoaxZb0+21haxbH12Yu5vAquOVAhutxwO6MBYFB4ZM2TQVwcybe
         WsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uMLQuGNemSrSzWsE0/6zTnYQ6NRODoVSf1zVwacWkEM=;
        b=SUqcFWEoyUbTsUf484BtxU2CoF12QLJ8XAk9Oo72xdJzfj7CnFb8ARxB0rT8yh7zKX
         DuE6ViKWr3DpHHpq5bAr4w+SebOx9/ABVgMGiaSIeI8FfABl6kQ4OeZPhldGQqya8rV3
         Hmab6txjI7KJmAUPO3JXogr76d5t+7RlDV64zK/XM3u1eWr5hRWizyaJNk+ARdpvLpKR
         AcQ3mc+e1LxQwRoXnL8IhrSFUY0selpNtWmAnwGySRYbVEtnj5pzyCZPIdMKQQeqDv6g
         Y2aq4PyGhGIgbnkAdE8SqUqo+MpNqlaLvaYPpf3nTPCQWV2cQpjEh/am4ev0jVBuqc2q
         MtfA==
X-Gm-Message-State: APjAAAVJFFLTimG2CxHNineZXsA0Y6EWEBJXG/z+haFpSAE18JWxEylT
        aoW4J7ubbw+3g8CDQB+brlM=
X-Google-Smtp-Source: APXvYqyvIpGfGwvAVtERNfWP/fMj4SrNBpZpfctpjgb8fwzYHT11V+iUIOF9rSu9riMB6PZK7xUt7Q==
X-Received: by 2002:a17:90a:214e:: with SMTP id a72mr3309406pje.0.1561038053031;
        Thu, 20 Jun 2019 06:40:53 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id g17sm26809169pfb.56.2019.06.20.06.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 06:40:51 -0700 (PDT)
Date:   Thu, 20 Jun 2019 22:40:49 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 1/6] block: initialize the write priority in
 blk_rq_bio_prep
Message-ID: <20190620134049.GA12032@minwooim-desktop>
References: <20190606102904.4024-1-hch@lst.de>
 <20190606102904.4024-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190606102904.4024-2-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me"

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
