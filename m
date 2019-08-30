Return-Path: <SRS0=imVF=W2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661E4C3A5A4
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 13:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382A421897
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 13:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lgZ6msSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfH3NQc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:16:32 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:33493 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3NQc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 09:16:32 -0400
Received: by mail-io1-f46.google.com with SMTP id z3so13949016iog.0
        for <linux-block@vger.kernel.org>; Fri, 30 Aug 2019 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ao7Wdofaa1sKJzWGbAawdHt4adOohg/VMTdip0vQIa4=;
        b=lgZ6msSPYo88sZa7ohX40wFMd3R9PsCKmRzFiRBVGvPEXWMUsGmTNK/bJNOMRsj8ZY
         WXeeZfOewC/GXAZFxEMiiN6P/Am+zJTjqZinv1txwUjp8aNd590Kl5fYCgOZ+zUZ0czY
         ZD/aT5v1ON/tS5f5hfu8TujR454GHVSfiTqeZpx2YLxG2WsIntIRy1IrsfGSmLuE/PR1
         anFGybLfMZbEsbMWKi52Lc0Lc4p1TDrpcit8uv+X6hV39EZMs7OJztcsb4aZcufQiAOj
         wJ3LztiUU7V0AIYp8KeRpZaeMl2TjKeRJoy0deDf5vgEa8gM/Tyf5dlQ065BHPCvywVz
         xn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ao7Wdofaa1sKJzWGbAawdHt4adOohg/VMTdip0vQIa4=;
        b=kpjlSid5S42+25zbbhd/CCnFaLG4ANdDTJ9mTFM2Sp1PCW9axG6RfIzFjfv/2K/mcr
         mfd6mCEjRON9uOB7QpZX1HvWHX6p6CFvCSWSuzOYKFfPUax+ONHyEcxqaNX+DFP0Bljc
         Avc7mVFhPky8ZvCDeP+w1T3xL0vPuhm7ybvvLopwdVI59x/X0nvo96iM5CFgqo4/USkE
         j0ITxoBs3GKe+0OHUbSifB7PDBCT0X6dSDMS6h/rx4dIbQE5AXNlHsVvQgi+83vkFtQ/
         j4PPd7tq6cz3CN1jxAQt78KopmKczRdycBf/S3TWOdixhZH88DhT17RBP8xysVn9nXWd
         M8eQ==
X-Gm-Message-State: APjAAAUfX/vdqPdoOWeoq0Ykeo5dmjRGDmxz2hBnzl65/bAn4kPVcK3E
        KsZJ1OCfgxNE/5uU1h9Dvqm+KA==
X-Google-Smtp-Source: APXvYqyZwQo3R9eCAX7RKQJl8KgsD+8eb15pZBdtUzfE/XNeCx4wyJxuH9bF237vIg2miKtu62M59g==
X-Received: by 2002:a05:6602:c7:: with SMTP id z7mr18714299ioe.130.1567170991487;
        Fri, 30 Aug 2019 06:16:31 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l13sm5866169iob.73.2019.08.30.06.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 06:16:30 -0700 (PDT)
Subject: Re: [PATCH block/for-next] blkcg: add missing NULL check in
 ioc_cpd_alloc()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190830131058.GY2263813@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <24a39d46-5c3e-9e45-bfaf-6d92448aea99@kernel.dk>
Date:   Fri, 30 Aug 2019 07:16:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830131058.GY2263813@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/30/19 7:10 AM, Tejun Heo wrote:
> ioc_cpd_alloc() forgot to check NULL return from kzalloc().  Add it.

Applied, thanks.

-- 
Jens Axboe

