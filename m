Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE90FC47404
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 03:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E2421721
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 03:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KwXd9fN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfJHDSA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 23:18:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37484 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbfJHDR7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Oct 2019 23:17:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so9951392pfo.4
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2019 20:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sBhKqNlCBDPkftr27P/1IjQptr0YXTqXNyc4wrCVHCs=;
        b=KwXd9fN7sM6S4HqcH6F8Fq+m+XYPerHKPiNSvQR2F1QiQtVIQE+nIlWn6Q8PpHhho3
         iKAX+N6dedzbUCk0rOTijgDmFBbGQtrLv6csEuCeXIQjzImHbAUoIN37aOc5gpctJxOF
         5Yb3hQt9N8P0fH/XEiIrrHtWqRrpULXdYkgYDxM/+CbOlnP5yhRkxO94ecv+W1Wr0Nm1
         YO7fIF7mJQ265INnz8hwnN3iqExG1g6CoqkHHHDDpjbhSQqpUSnIyQcF05FOL71TosBQ
         prc/hZax9kJYb46OUODcifTFk/n2fFG+Isyhs4q2PZUng5eh+rzPDInIdxsDVxA18Ohu
         T7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sBhKqNlCBDPkftr27P/1IjQptr0YXTqXNyc4wrCVHCs=;
        b=D3lJWmf4JygeAFxp9EeOpLWee2duJ0hlTPaN9JemEPJ6MF3oTPtmtcXiZKRMPoIafR
         gZIhesqQMTlwVhxJa70sIbdPbYhQPxzCD+O2Brej86NjFnXBgfLfvfxUmQ7gk56jj9p1
         yUQ//miNDhtZ6Kig324UKvijVpYdP2pM7QKUl40bOBVT2jnqQP45eq4/8pDUlHBAgT7A
         8TEVyQdAJd4qUom8KkRL7qDPgPYlBD/+ZVDxIj3hXu5PjNRkF7yOrgp7hQ21ddyTpOye
         2JMtd0ENhc68pgQ99S55N9EjmZHsH2Sc7w9oaTQ4wy2hwLEs3U4GUXljg/uGEgkGBQYC
         PaYg==
X-Gm-Message-State: APjAAAXK4FUwby2dvl5E3R2KEMU51KMz8dx/4tqWEy9QFZtrVVm7TAqU
        XfYAw4JO2C2nYE9jF4Dpkik4/A==
X-Google-Smtp-Source: APXvYqyVEEx/94ZCOojqFRMZtKBTarDNA2EnBJ0TsDkKhroTKOhYv0wamthRODhio5AJVBqSSnilAg==
X-Received: by 2002:a63:dc4c:: with SMTP id f12mr1766256pgj.29.1570504677476;
        Mon, 07 Oct 2019 20:17:57 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 64sm19333739pfx.31.2019.10.07.20.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 20:17:56 -0700 (PDT)
Subject: Re: [PATCH] blk-stat: Optimise blk_stat_add()
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <39dd33cc6f0264b2ec2f79f1dfe21466c2180851.1570482929.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e5df36bc-1beb-403c-8fe6-624fecc938a2@kernel.dk>
Date:   Mon, 7 Oct 2019 21:17:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <39dd33cc6f0264b2ec2f79f1dfe21466c2180851.1570482929.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/19 3:16 PM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> blk_stat_add() calls {get,put}_cpu_ptr() in a loop, which entails
> overhead of disabling/enabling preemption. The loop is under RCU
> (i.e.short) anyway, so do get_cpu() in advance.

Looks good, applied for 5.5.

-- 
Jens Axboe

