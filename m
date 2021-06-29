Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E415C11F66
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 13:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8D161DC4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 13:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhF2Nn6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jun 2021 09:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbhF2Nn5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jun 2021 09:43:57 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5024C061760
        for <linux-block@vger.kernel.org>; Tue, 29 Jun 2021 06:41:29 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id t12so12108759ile.13
        for <linux-block@vger.kernel.org>; Tue, 29 Jun 2021 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nr3o7XsdiG0qI89NZwngmWI5K7qu5SFlJJKAQXuzd4Y=;
        b=ExdDdmPx9b3VSyebgWKu1kSFv2lHdHRUBi9kTxtsT0DCJa2OXOVZmXpbYeYgBikuTW
         UFyDbKRR+D5RjorBCxQodqaj2vbfnnnDNJBTkhKyrmN+Rdmy6dADItoCaar9GmKfEwAA
         QL+Cqi93FOBwsPLrIUk5zcEWvTTQjNWc7rwVzz7gVBGk8S1Ub6hSgrBFP1E4yHnWLtfC
         X9WBWvK2vUulE5qJ1flONzwTLzLq2qQEUMbZYEdB/zgwiiMlZMOCIjV4Pjx4/DXp1r1W
         F03tFY+kTD8bgcYj6xrQRa3PmHN5RIe4liV4sGDjmnogvkRte5sPYbU+KK7zBRxzivwV
         hc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nr3o7XsdiG0qI89NZwngmWI5K7qu5SFlJJKAQXuzd4Y=;
        b=DUMhemS+R8jHK8ki0P6bzCmQwdas9fFMe1BnetTr7aRrC4Oef5GWwUSf526VmUC8sq
         EFrv3zEOkOt8U0MPQtUK00it4RXb0kivlm0C5i5s5pxY7mKLOotLlBAWKnsSqr3GuMN6
         0JkW0qopuAIbRPNUTwPKFBvzkHnNiyafkw9qJ9IQfhbVgn9XDxbo1bWz3HaSgRAXo5tZ
         TFM/BiJWhq1Q5oxsTQIVu8XdYUXRq985S2uLMZu7oYqKqwZuQ9WKYsKcv9Pzi/bO3jkB
         DvMbfsVIYoHvQpLGbw5sbD0Lt0b6ombK3wjUb80iBA+XkgG5ozMdzMi6C+vEcdUEpazs
         Kt/g==
X-Gm-Message-State: AOAM5301eXhzDNJGJ6Yu17ZP0VKX/v/CvtnBKEQOAxm/qiwJpcxmfn5h
        /53dCEbeRK8iiSsGAkQYGtoRuQ==
X-Google-Smtp-Source: ABdhPJx0WELLl7f9x0a8p/89cfY/JY+v6VoIPRre4y/sxYomOgZVwFfnGNhg0q9DrUapC9X3Pf9TEg==
X-Received: by 2002:a92:c703:: with SMTP id a3mr1844903ilp.118.1624974089215;
        Tue, 29 Jun 2021 06:41:29 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id s5sm10127909ilh.19.2021.06.29.06.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 06:41:28 -0700 (PDT)
Subject: Re: [PATCH RESEND] block: fix discard request merge
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Wang Shanker <shankerwangmiao@gmail.com>
References: <20210628023312.1903255-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3087bbe-a577-1f9b-561d-49d99f4dba62@kernel.dk>
Date:   Tue, 29 Jun 2021 07:41:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210628023312.1903255-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/21 8:33 PM, Ming Lei wrote:
> ll_new_hw_segment() is reached only in case of single range discard
> merge, and we don't have max discard segment size limit actually, so
> it is wrong to run the following check:
> 
> if (req->nr_phys_segments + nr_phys_segs > blk_rq_get_max_segments(req))
> 
> it may be always false since req->nr_phys_segments is initialized as
> one, and bio's segment count is still 1, blk_rq_get_max_segments(reg)
> is 1 too.
> 
> Fix the issue by not doing the check and bypassing the calculation of
> discard request's nr_phys_segments.
> 
> Based on analysis from Wang Shanker.

Applied, thanks.

-- 
Jens Axboe

