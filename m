Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1759CC433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 15:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96332078A
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 15:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hh7H3X8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgHZPav (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgHZPas (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 11:30:48 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88022C061574
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2020 08:30:48 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id q14so2110862ilj.8
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2020 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IsIyBknNylFf5m5VOIdXuEbI+/EI8PgsechiY9tTkJw=;
        b=hh7H3X8bBuf9HMTCqyAfQF1uFdMMtQoBcx+QMusSAh9nEGH7Z/jxZO9sqPObxbY2p6
         nZl6EgKI4G3CBdBWLhcuSbTltH2w8Xzps2bwM7sjKgrXAAlksB8vZ8BTrpXubDDeJIJP
         PBHp9rFO4KorX95tlHkov5lJVZO4jWIeVxGjE7pRVx6qGDjBG0TGEKKrjmSbOsVQl2s5
         qHKcLr7ywCndmlLFZblsWsyELR0JQREgp4rP4BD0u8CWz0ksHzmarAOcS4GSR+EBUBnC
         73PMeNDxg485hdmjLWZ+RLbJ+y4LDlugDVWZ6H8me+yyyjxJKou9DMBsfaGppFRdlzzx
         4uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IsIyBknNylFf5m5VOIdXuEbI+/EI8PgsechiY9tTkJw=;
        b=IHkeLat+EaPwqdamcK5X2gfZh166Z1TOPSnfW31FRRgefUzEoItXpbA9J5+fTJYbug
         WBVzv9tXrk9HLdwwH6t/AF1HPTEBIifQSk3aPTB9BCyCi5LQ8JYEFXrdacBknXMvX6sF
         NV4gWnogVRZ0O7iRvr19RIvZ6AftkWAj/A+J3KEnV9Ib8OBOUKjN96P/pR8p/Hf16IRg
         RfmjXiNvd0xg9llZB2Z338Zuimlvn+afBJglv505k/CviS9vnK7hfmFiuJ7Hk5D3FFKb
         oOeyYFuLLihlGdx4Nn6QcwFxYYL4e83/tWYXyGsP2vfCANzGAJCl+5jtkJhUBsNDJzqs
         Dhuw==
X-Gm-Message-State: AOAM530bIR/RV8RDoIs29igSL5QpFaB9GhCdPb8inJN03oKUM6bd17p3
        /k65Pwx479V/S4ntu53bp1U6WQ==
X-Google-Smtp-Source: ABdhPJyCDypNHQccqZIJm5en5K0Kjf08saDvkXA7FYNnIQoZHP0SmNRB9et524EkTeNPtuuMfX0/Dg==
X-Received: by 2002:a92:ddcb:: with SMTP id d11mr13664092ilr.56.1598455846869;
        Wed, 26 Aug 2020 08:30:46 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k2sm432796ioj.2.2020.08.26.08.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 08:30:46 -0700 (PDT)
Subject: Re: [PATCH] loop: Set correct device size when using LOOP_CONFIGURE
To:     Martijn Coenen <maco@android.com>, mzxreary@0pointer.de
Cc:     linux-block@vger.kernel.org, hch@lst.de,
        xuyang2018.jy@cn.fujitsu.com
References: <20200825071829.1396235-1-maco@android.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8a3f37fd-f562-ac29-205c-9433d969d4ee@kernel.dk>
Date:   Wed, 26 Aug 2020 09:30:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825071829.1396235-1-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/20 1:18 AM, Martijn Coenen wrote:
> The device size calculation was done before processing the loop
> configuration, which meant that the we set the size on the underlying
> block device incorrectly in case lo_offset/lo_sizelimit were set in the
> configuration. Delay computing the size until we've setup the device
> parameters correctly.

Applied, thanks.

-- 
Jens Axboe

