Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694ECC433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F953206E2
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1Xvx7tjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbgF2Tcp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733218AbgF2Tcm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2F9C0307B1
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 08:56:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y18so7263764plr.4
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wC1a43zyQWPn3gtOzkZQyfjyAzgJ9BNHPEib+IMkUGo=;
        b=1Xvx7tjwTuUejF4o4SEoq5uUDybyR1kygg+u2TRdUzd7spsD2fxdq8bRvGRLUCJsjX
         N/B6zDTTfsosZAJTBlU9qU1PoqPKBXoJu/c83Gpc2/pGNT6osM/MNYH4MIzUeeMZQe5v
         j52f5Te72U73zuu393oF17l1y7aOQ7I59nFpdB166eAfSucg7dd26V3chci724yug5wx
         4edL30JJ00Myif8s4MxW2e2Gp96gqD7pMj1eCLp+qqzAUX5bujDftVI2VrJcA0mGQguD
         xpt4z/37BZ8pTe3tqpZmdC+sxrkd1SWhH/1tsE2RObkRWJQjOKJL7r/x3eZuOGSzn6W4
         8drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wC1a43zyQWPn3gtOzkZQyfjyAzgJ9BNHPEib+IMkUGo=;
        b=qNOnjX8FDTS8DLEj3QSnfEk6Zv8jpJyIYuu7Pb1z59l50obRFC0CXXKg/hIGx4aTbz
         x02STO/TMCDyYr7+laGh5cmk1y52hcmBfGLWn899anCv7lW5zc3NymJKaTIjTrh193JQ
         Z+n49bs2r2ldOKL81l7/duyWOL0j+ciaF+VUNvZd+9FxMzolSUh8IzLQWi+y4ezb5Hpl
         T8rk4f+kQdGVuM441Eaju3LUS2Yir324Hx0l7pFQ0Qw5GKQwU2tqeIEr/HwTcEK21Bxn
         orDws+4+q0nphXIGPMTqObm3yY96c7/+1hOmYV8c7hUB/ZrDozfG2e9cl5xlEIpKqhPC
         MxRA==
X-Gm-Message-State: AOAM5334E7UV3qgxnUM6897Wv4dwkFmDExZUCYlAz1y4EhdfNPJ7aCte
        IePuoj3ysJ6zDSYlr31xliorGsoHiZXYug==
X-Google-Smtp-Source: ABdhPJxfnTUlSmBWTEBKPOpJODSJXEQC+hzSZzjlubf8wneZJTQb+4RlrbRCJi1W/QdCHlxTybGp7g==
X-Received: by 2002:a17:902:a611:: with SMTP id u17mr14094683plq.263.1593446195096;
        Mon, 29 Jun 2020 08:56:35 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id 4sm201021pgk.68.2020.06.29.08.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 08:56:34 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: put driver tag when this request is completed
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20200629094759.2002708-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5107209f-2e5e-86fb-d5e7-db15df18085c@kernel.dk>
Date:   Mon, 29 Jun 2020 09:56:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629094759.2002708-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/20 3:47 AM, Ming Lei wrote:
> It is natural to release driver tag when this request is completed by
> LLD or device since its purpose is for LLD use.
> 
> One big benefit is that the released tag can be re-used quicker since
> bio_endio() may take too long.
> 
> Meantime we don't need to release driver tag for flush request.

Applied, thanks.

-- 
Jens Axboe

