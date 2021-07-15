Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A15C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 15:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25E361360
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 15:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbhGOPc3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbhGOPc3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 11:32:29 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F43C06175F
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 08:29:34 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id e11so4026092oii.9
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qgDH1N5Uy14MfuAqfgBx6Idjxx/UikhQEHNv7cKKrRs=;
        b=y6xEEiIkvVgaYQ4DnUbj5rUJjOnSC2sbuP5RFUONiGRLXX21zOIC9Azer7zPAh8KLM
         6Yp/fw/waAyPpJNfB3GwUvaSiifPEf0xlssPSUoSgbsBaOo0l68McSPAhNJN3zgvoqhW
         um1KLL97IuJaurw8pVYcME45Uid6UNaK5ESlfug2JWfK5oUhYPw5EkU+aFwaEPWg88Ar
         0qeMimRIUfvOv26Jx2GTGtfq/InGAM4BrcaLrCk2vNZe9UyNP1Pdvqr9jgVFxRrbpFbD
         CunDAYj9hSZtpIhfuAX/6tIO7ixbJmuRmx2ZJUlXSQIzeNndNNglyeeoqWxFOkpQ6JcI
         R6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qgDH1N5Uy14MfuAqfgBx6Idjxx/UikhQEHNv7cKKrRs=;
        b=VpekU0uAf0J7jPAF3DpYMUYkmbXFcWbCDAIRALQYrEzCcEviOOaJNVr9hOujpgw6y4
         0YiwMXzoc3nrMuOPjrz79nNQbjCVUTiL4+XQkX97CnGWzqHfLgBtqhUA/nwzz9v3ZZuY
         uVivbWCgmNGjbBOXPYlWEetoNNfYi7HsDglBguNQOrQmerrx9qB9MjJwxSpjzfcHUMp6
         kQELNdSZuzNLLBVBfwQez5k2MvTJuQdsibzcxwewbuUX6h1kTFE13VXWQx/DEENtbN/I
         d37P0ceACU+jMFhgFGnJTZzJMbBOvd2A0AtLWqdkFcw+FleV2vnE+AniWvU8X4otnuMg
         2CsA==
X-Gm-Message-State: AOAM533LpfUQ9SgJRJguzm6EGrskzy0tyKWV9YHN5KwJwMf22JX4sobL
        e7RIoovBTJQHsxpe/LszDmE9qNXMQQ24Ig==
X-Google-Smtp-Source: ABdhPJza6Fu43aGqAIEx+1KBF3dJZX8t0KYg7A5DBhUDuKDj3qyMlkZg3ZgKGdMfFvjH1/Km48jZAA==
X-Received: by 2002:aca:b502:: with SMTP id e2mr4079329oif.61.1626362974025;
        Thu, 15 Jul 2021 08:29:34 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g66sm1161523oob.27.2021.07.15.08.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:29:33 -0700 (PDT)
Subject: Re: [PATCH] pd: fix order of cleaning up the queue and freeing the
 tagset
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, tim@cyberelk.net,
        hch@lst.de
Cc:     linux-block@vger.kernel.org
References: <20210706010734.1356066-1-guoqing.jiang@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82b448d7-0459-9b6f-7743-a54ee802ce73@kernel.dk>
Date:   Thu, 15 Jul 2021 09:29:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210706010734.1356066-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/5/21 7:07 PM, Guoqing Jiang wrote:
> From: Guoqing Jiang <jiangguoqing@kylinos.cn>
> 
> We must release the queue before freeing the tagset.

Applied, thanks.

-- 
Jens Axboe

