Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C73C433DF
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 20:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB24223BE
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 20:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eQYbLSkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgJSULs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgJSULs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 16:11:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE485C0613D0
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2020 13:11:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h6so636717pgk.4
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2020 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=R+VZxLw3M5VVMS/Oy1ye3FEsyXYNvktUSMjfNrh7K8s=;
        b=eQYbLSkG9xq6qO/TTxN4Oktwj9Tl2zd9eBNsRi1Spxg8LXN7/k4yZK3tXiOmMUPZKa
         f2rnKFtkPwloBbk+UqEQTU2XAR5NLLXyuAV85J6y/ebcF/bY1xGpXAr9lqQlXOKQGZ8C
         YngsD/nKFa+65nVuU/H+P6lCWT93T/Yy1g9whDWf/NlplBFSAUriWT+qnIZ9yHjt6/If
         MEpmSGmk+qto28lTPXZA6VG6ONkY4o1AMLAuOHMfv68D4BJMFXWR9y98Lj0hmkes2y2+
         /tkIdi/6WtKhn6NMuY9/tADf6PsE/Qgry5WiG9YYy4PG5O7j4b/pGltvjTuMKoX4Y25m
         tIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R+VZxLw3M5VVMS/Oy1ye3FEsyXYNvktUSMjfNrh7K8s=;
        b=TdN1dk3p3+f/ardWall4/o2H0vdIUqDuaFwQxukhptNM/88kit50Rzlfw0Edbf0ADR
         53WWvS9opvM07eGVAYskX6gIzC327A12vFy8CnskABZthzcYmjJGsDEab//GaGuttB5W
         4EkzDPmXKncvygdtT6tSlvwdDKjONWeCKZZmr1+J39wecTy5TwxwBU4BBBbODolvLOMJ
         CnmP7shnArvJQ4AkPGQHjpUlkIHpyDc0C2dmoSL8ZiIvSVpyOcO9HqUwCiLxtQYYVTbu
         V6gfM8Xx7Zb0lf4e3qKny2Va/YYZBLOnJHwgxCx9Sy6PYL6WcaPVGPnK+g3Ek2NH75YK
         C1sQ==
X-Gm-Message-State: AOAM533LyW7ha9LDG4eulplT/8BYsH62yCYu/47VJL5FGKwnz7zkhySj
        4ju5/y7Ff7gey/32zuzHCLRvk9S+h4EirF6S
X-Google-Smtp-Source: ABdhPJzhZ1+c/FI1IIIsPu3ZdVZt9Xtq0jyr7PwLKkWN/gCtz9q7A/q0TjxkJ50gR3xOjghDYI28BQ==
X-Received: by 2002:a63:541a:: with SMTP id i26mr1199135pgb.117.1603138306070;
        Mon, 19 Oct 2020 13:11:46 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l3sm306197pju.28.2020.10.19.13.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 13:11:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: Add some exports for bcachefs
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20201019190241.2910492-1-kent.overstreet@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <37a5f032-4979-706b-ea34-926e1756ccb1@kernel.dk>
Date:   Mon, 19 Oct 2020 14:11:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019190241.2910492-1-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/20 1:02 PM, Kent Overstreet wrote:
> bcachefs has its own direct IO code.

I talked to Kent about this offline, but just for completeness sake,
my recommendation is to keep these as prep patches for the bcachefs
series so we avoid having modular exports of code that don't have
any in-kernel modular users.

-- 
Jens Axboe

