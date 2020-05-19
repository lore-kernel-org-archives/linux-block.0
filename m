Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DADC433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F756207C4
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VKd2LrRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgESPx0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESPx0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 11:53:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9364BC08C5C0
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 08:53:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci23so1619694pjb.5
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y1RGSewIaTRFHzOgTU+0GGzCEEGXRli6VliNNR8QS9A=;
        b=VKd2LrRh5QtpdzCIgZVaVIiUmXhxTKUrjNGmth4uYzDJWNegG5wYTnubrK6a7C9l5B
         YskYCkPa8PaIwhw/gxJL53ZQJlUXV4hT4rFnvehQOrhr0hosbIAdN+HAmDR0faQ0C1g7
         I/6QLj4s3oO0l33Dw9vxaJpGX/P6tfomrYafA3/lXHdXkxGRhF2nSZHJaKo/mqGDcq7n
         yf+Q0wAJyNizhz/DqV9uOzZ8JoPpY/qLJkPNrBmmY0YmuIIo7CDc6jDz53jcmcfZd1ge
         lZc+CcyLK+siZaAbVtUy2H0hfZv1GFc369qGWYjFPsGnS4IiV4Ie8BeiTOAtLtr9lORj
         VebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y1RGSewIaTRFHzOgTU+0GGzCEEGXRli6VliNNR8QS9A=;
        b=UNv2KEgbw+wD6w+wmw1lAomgFIwqiT9ImmFkbatGvj/i50YnFkgMYe0p4brQKfyjwv
         fq2+7dF/p/J1eTom64pZFRWTDvvs7qY8HANcJPmsF+OqvXyC452U7/sV7Ll5UAJ6tfMa
         WoxhK2vNZKD3qSNtK6dn4YP+kkzeqOlOAiWNvNYfEUhmZLAth5jhr2XoZqvQkJdMK7LR
         WCphVh7OfnJgyf8tehgXxslxTvG0P7Lq58VLvBVXqJksKXg/4GkkM7ndqRbUWyc3K31J
         SdtjF1YamZk9AjbSXIhIdicXq2Ox14rtlJqPkoONwg+K9D7VtFaNVSbNlpbGS/NcLVrz
         4o7A==
X-Gm-Message-State: AOAM531GjfxbJRu/qmd/UAuMbaMoXrd63Qhu6MsVaxF5e+WZ7D6QwQiW
        6lLZCV3bUbolng/NopLRcp7kqOz9MxA=
X-Google-Smtp-Source: ABdhPJzrjXYUZtheJd3idCv8rqFy4S/8pY5KcOjZGorzCIlc81cTwgNTReVEtSbjVMrpV1tsGbkqVw==
X-Received: by 2002:a17:90a:6d90:: with SMTP id a16mr224113pjk.138.1589903605163;
        Tue, 19 May 2020 08:53:25 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:14f4:acbd:a5d0:25ca? ([2605:e000:100e:8c61:14f4:acbd:a5d0:25ca])
        by smtp.gmail.com with ESMTPSA id t20sm33084pjo.13.2020.05.19.08.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 08:53:24 -0700 (PDT)
Subject: Re: [PATCH] blkparse: Print PID information for TN_MESSAGE events
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20200513160402.8050-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d82a514e-390e-b268-dc19-45cb7be51ac7@kernel.dk>
Date:   Tue, 19 May 2020 09:53:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513160402.8050-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/20 10:04 AM, Jan Kara wrote:
> The kernel now provides PID information for TN_MESSAGE events. Print it.
> Old kernels fill 0 there so the behavior is unaffected for them.

Doesn't apply to the current repo, can you resend?

-- 
Jens Axboe

