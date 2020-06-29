Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B80EC433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119F220656
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sDghGYT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgF2Vod (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgF2Shq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0401BC02A57B
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 06:48:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f3so8336739pgr.2
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=is2MDArUjmLbci5ARNa3nligWhPuwd5VekPQ5kda5TI=;
        b=sDghGYT4KrQQSgNceMYsQDGhJdByivo3fv1u1RK68yEb+mRv0n/SOH+FWANVMy1jHu
         KGEtXCZUtRjaPFIayFSLQL72j43GcIVlLrQIg8ws9+VZ+3JWyt52gpWV1oPSoTG253kO
         GuAMHAplOeVA0lZbVPeDOtEvX1By7XyctKOBvwFC4NG3v2fNfuBRGANjm+0wUyXwD0Zx
         zZjUWpka1Bl6hC/ftiKm5L5wWvtCWhwHv+8wFTE4phCXEJhNvpDR7vG7q71MTljinyNt
         wC5mdsKfjQV5vQKJh4KQ+r9wgjdsCN/0+7zPD4iqVwadNy8nh0e8SuUM5isz4w1VFOyd
         7siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=is2MDArUjmLbci5ARNa3nligWhPuwd5VekPQ5kda5TI=;
        b=Lwncz1bAUEj6l7ZR97di//mA4BXpfOfxMcyJ8Lsff6Uh1WardqzfC2AvioGuG8KZjR
         HOJ2kleJVurm3ZvffSLnA0QkEnrFBfCUKKgoN+zI6biFJQRlVD0cGueVRr3vfdbXLUhe
         X0k3SxYnKTUXiDzuD0ND5mLV/2Y0kc4ipHawnCAOmRYGYHD1mKteYrHmo6zccvSJIkjz
         3IKYAE7x3DkiGpWTj7QqI9KYCmm9+2VvNIgETSczYx8awy9dvxF/8cEK6BOV2FqzE1wu
         TXB5STVILuiUeIkmItyja5DI8zyydjLrzAZYbVmttm0mcjdoJPjQHKfnAr5tUviq/Si4
         5pXQ==
X-Gm-Message-State: AOAM532NUt/H8/RZKaXT2A7jaPw482Fk2s4HMBFEo8cTZYCyCe4pQfqV
        UER2HE7EN6e0S/G2seqTaJYkKg==
X-Google-Smtp-Source: ABdhPJxdUlBsQn7Ov3nepRzYk5ScVOlIZYLPMXL+7Zok+W2jK3st+lrKLIgCrQAGw3DsyH7pFTBZ4g==
X-Received: by 2002:a63:d318:: with SMTP id b24mr9564638pgg.403.1593438487481;
        Mon, 29 Jun 2020 06:48:07 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id bg6sm64196pjb.51.2020.06.29.06.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 06:48:06 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] block: drive-by cleanups for block cgroup
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>,
        paolo.valente@linaro.org
References: <20200629082622.37611-1-johannes.thumshirn@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff2a6aba-a84d-c4f5-ebdf-c78806172bb4@kernel.dk>
Date:   Mon, 29 Jun 2020 07:48:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629082622.37611-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/20 2:26 AM, Johannes Thumshirn wrote:
> While reviewing Christoph's bio cleanup series, I noticed
> blkcg_bio_issue_check() is way too big for an inline function. When I moved it
> into block/blk-cgroup.c I noticed two other functions which only have one or
> no callers at all, so I cleaned them up as well.

Applied, thanks.

-- 
Jens Axboe

