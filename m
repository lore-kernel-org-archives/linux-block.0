Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AB8C3F2D1
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 21:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6235A20848
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 21:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ol9h7NST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbgCCVNY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:13:24 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38093 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbgCCVNY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 16:13:24 -0500
Received: by mail-qv1-f67.google.com with SMTP id g16so14306qvz.5
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2020 13:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AgLd9ecB3xJpGa63JNP+56+CM8f5C5uRGJU8kSIBW9A=;
        b=ol9h7NSTqG/w/KKyNPlxUrQTpPcy4KKTUZ/mrRQAzPMw5XGJ/P/zbApLF/VBFNj3NI
         oxXNotk/e/2qo9H7euspM5os7xoAnPDQKQGm3y6bh6qWbr34tV0/QRaWn6KA93JZczrq
         mYzWYl1o4DHi2i/ERjq3DAzTZTDhmGocZjBxd2RYfmAvedMpZE2exOlSEOfOAFfyNcPn
         QvFP3Bi++tPo+k+lO4vB4ejcpDBKhhGvrlDcYQ+36DikjHJ7/TaU+yPkDNxxW6VY5N9V
         56Exn8cBIPSXcaPYFA19ue0pkXtF/yyUlfTWqJB3Bu4rKnFICHdlrOJvhs3NaX4+8pkE
         rizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AgLd9ecB3xJpGa63JNP+56+CM8f5C5uRGJU8kSIBW9A=;
        b=XaJ/OOCR+AWad29cXtt8YVu9LJon0RMC/D3NNzkRlwnAcIhivCJMLLnMZ2TPWaAlK9
         imy5H7TdxzNJQnwP/64QDInFHEzBx/FxQ+cAd+ZAyNj4lKkShd3vrjQ73oC5hxgd0ZQG
         RYtERsR3jHa9w9Hd8yttwO0ov2qwahl8/ooqhKjOF4H8Fg9OAKFj8cv1IBXADwKod0pT
         vIwn1ZX9MMJczAOkTXkZxa0aTCG6mHDnHlvdULeZmDDCMu6lOGqtZv+EzQD+DY3AdUTY
         /t/J8lICIoUujajijC9R47KCdkZCFC82wuzVrpmwhNbQxaaakAep9VKrrmyVyQRTEN70
         4GJg==
X-Gm-Message-State: ANhLgQ1OKumNKqaLNFMDJ0a/GQ1dTXEkLZPTdVigF72rdJYp6DWO2jhM
        rNzWda+FTqpjxDS+Wpg1dPwvIQ==
X-Google-Smtp-Source: ADFU+vt2SgrsWRmw/PrsGdszCg8sQB/RJ1Z8RUPeY1eA2A0+Lgm6t4h3a3T2IB9d4NOizHb3IJX1gw==
X-Received: by 2002:a0c:f905:: with SMTP id v5mr1950220qvn.174.1583270003184;
        Tue, 03 Mar 2020 13:13:23 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g2sm12632889qkb.27.2020.03.03.13.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 13:13:22 -0800 (PST)
Subject: Re: [PATCH 2/2] nbd: requeue command if the soecket is changed
To:     Hou Pu <houpu.main@gmail.com>, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
References: <20200228064030.16780-1-houpu@bytedance.com>
 <20200228064030.16780-3-houpu@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <34249aaa-7f0e-d0f4-7c1a-28aee9bddaa0@toxicpanda.com>
Date:   Tue, 3 Mar 2020 16:13:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228064030.16780-3-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/20 1:40 AM, Hou Pu wrote:
> In commit 2da22da5734 (nbd: fix zero cmd timeout handling v2),
> it is allowed to reset timer when it fires if tag_set.timeout
> is set to zero. If the server is shutdown and a new socket
> is reconfigured, the request should be requeued to be processed by
> new server instead of waiting for response from the old one.
> 
> Signed-off-by: Hou Pu <houpu@bytedance.com>

I'm confused by this, if we get here we've already timed out and requeued once 
right?  Why do we need to requeue again?  Thanks,

Josef
