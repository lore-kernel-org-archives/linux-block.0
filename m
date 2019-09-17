Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455B8C4CECD
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 19:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8AD214AF
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 19:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="wdBSHBFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfIQT4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:56:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33065 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIQT4V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 15:56:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so6032940qtd.0
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PL1mRKzXUWHREIk21ddzeksuzTaYTi6Wrm/WJnUT+DA=;
        b=wdBSHBFTPIkxPq3x+6FibDhUOlxnom/lyb/KlSp5XixtqruDwQXR/F6/cZbVrQoPrn
         dRzicqus/a/GQVcBfVSzycHFk8fggxsH+eXa+0onwna3KgI+IyT/8UUztGuEF3BsPfTQ
         0qUQV7MNYjwmPKjD5oaL4ZLDQ++HzPSBcRDhfq8rlE5sUFEPzbfFJahee9NiChCWtINo
         euaPju+Q8y0z4KSmsJSzKovEeQldexZWfnuAM3mt6xIc76LAYpoBNlEy7Z+S+SmpB+TE
         BfG6usu3xcf3PvpPVHh90bzX9/4D1M5OsTXQkSDHu+/hjjVszkIT/vanZ9hWTxOH6NjU
         YZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PL1mRKzXUWHREIk21ddzeksuzTaYTi6Wrm/WJnUT+DA=;
        b=Krl7CLxooMbu62WbmDnn0zOHmY0aLWFP+oKoq3HNfqK9FfZdxl8bIkhHuObutn99DD
         eHpHeAnaysTb3Zvb405djbR8Bh6bGG+06WWOpyYFdNKeCU/4g0iQGDhYWcVr7P5qShWh
         9rk/aS0vZRyX50a6oFZxM17TtmEWgWeLBytD8nabRsfwRhVUngepYRPabzc+pbTlXsBX
         2K+LqLTm/vtbrs9lW+wmLPh+k+1fOABPerwfv9wyuOgv91jTgwk9Vr8ywLSuVtxqNNZB
         8vJRFv0uEX5E+EvodkMDLBCqefsBqmqzdGoLZdZt8BkPU36xjDSRe4S/QOZIzFn1OdNC
         0K3w==
X-Gm-Message-State: APjAAAU+5f0svgCmAxw+tItjz12Tyo+SaBjRZSH7aZBVsuOjPLcCBo1O
        X1zSK9kqJ5hCasVcKBzHCCdKsp3VQzasaQ==
X-Google-Smtp-Source: APXvYqzAcRYzD1AI2/G3bLvf1L7ZR3tE/Yxnd99j+pNPL1cYO4ZHkEo1O82DnfbXBtHErnCNC6bbDg==
X-Received: by 2002:ac8:814:: with SMTP id u20mr617324qth.178.1568750180614;
        Tue, 17 Sep 2019 12:56:20 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 20sm1709735qkn.4.2019.09.17.12.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 12:56:19 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:56:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, xiubli@redhat.com,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 2/2] nbd: fix possible page fault for nbd disk
Message-ID: <20190917195617.i52mfc3pjik5p26i@MacBook-Pro-91.local>
References: <20190917115606.13992-1-xiubli@redhat.com>
 <20190917115606.13992-3-xiubli@redhat.com>
 <5D812669.9050901@redhat.com>
 <20190917184011.74ityetkw7n3sqbs@MacBook-Pro-91.local>
 <5D813789.1050400@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D813789.1050400@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 17, 2019 at 02:44:09PM -0500, Mike Christie wrote:
> On 09/17/2019 01:40 PM, Josef Bacik wrote:
> >>> +		nbd->destroy_complete = &destroy_complete;
> >>
> >> Also, without the mutex part of the v3 patch, we could race and
> >> nbd_dev_remove could have passed the destroy_complete check already, so
> >> below we will wait forever.
> >>
> > 
> > Oh hmm you're right,
> 
> I think I am actually wrong about that part too now :) I had forgot
> about the idr removal under the mutex when making my original comment.
> 
> If nbd_put grabs the mutex first then it will do idr_remove under the
> mutex. If nbd_genl_connect then runs, idr_find/idr_for_each will fail
> and we will allocate a new nbd device and NBD_DISCONNECT_REQUESTED will
> not be set.
> 
> If nbd_genl_connect grabs the mutex first, then idr_find/idr_for_each
> will succeed and we will set the completion. nbd_put will then grab the
> mutex and call nbd_remove_dev and see the completion.

Lol we're all wrong.  I had it in my head that complete() just did a set_bit()
so wait_on_completion() would not wait, but it does the x->done++/x->done--
thing, so cool we're good here.  Thanks,

Josef
