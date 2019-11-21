Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E0C432C0
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 18:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F392206CB
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 18:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EJjPbSz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfKUSh1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:37:27 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41859 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfKUSh1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 13:37:27 -0500
Received: by mail-il1-f194.google.com with SMTP id q15so4281190ils.8
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2019 10:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=faq1HCiwAUKpn9KibrFveIIN8Gq95mpKVvXAdv0gtDk=;
        b=EJjPbSz0Y6tDOEGVI+1jJ8atWnfgVSawkkT8eN6V6cCPix2Oo1Ul5auUyUzMkYlDoK
         3qNVcfI7jBdMccdBn/qZtJ6b635qSK6GyU075QBm/DiZL+E8zm9p4ZUKRL1MoOZVUo9N
         hoLYwkn2XLv87sQlikDmsBXss5UhTiaeuDHLmSWYC9JxUub0lmUUW2xZVXJnpyOXNaGw
         y82WJV8Pyc4iflpx/NYF12hA4nSerOKHfUJ23hnfkFrUUUVENyO4lqlRhEgEEDYvonHB
         7Ro2z4dGPGwjzFmYorVFleDJuov531ZDGun6BqLfvQZGB8jgtd1IecdJaPKyCHOmApK5
         PRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=faq1HCiwAUKpn9KibrFveIIN8Gq95mpKVvXAdv0gtDk=;
        b=lTFR+xjRZcpkd1Gi/hi417k2uyr7l1wf/paHhh6qqMJDEmJCh4bVIdgFCn+ygAGJVO
         t1WXN7XT76XrWaB8LJfLSFkiLv5o7LnNu2ogQzcXb4f5FYhclMDGvE7+/xDQ4D5XtmXg
         HgSY4TI/p764QIFb6SsWcSNsxskimqAzXEXIalawG96beZXYLjd0CIjqTYxd/6L4vWVd
         B1wVhHBvHZ26fUc56ng+cmFGdfblX7DK2m5PWd7cNWkV1a63q3TY8A/g1tkCqT3js7YT
         usI/N3oWk6imOLBvYxKhnOXAqjcy5tn1ys4bJlJnof/HcfLTDv/Y6EZoigsWr65IergX
         EH+Q==
X-Gm-Message-State: APjAAAVp/Fzr1pKBYG74iZ4rNaPXpqEtaMTKyF4sorqV6hkQQQpo02sR
        zsj3WcU+GQGgafaFB7TSiGtxeQ==
X-Google-Smtp-Source: APXvYqwleGilbYtjejG0htBS2Id79yaqhJ2aVAJKwRv51I6HzmumqzuaenMu1RY8209HZRrCTLCAsA==
X-Received: by 2002:a92:b686:: with SMTP id m6mr11013166ill.35.1574361446126;
        Thu, 21 Nov 2019 10:37:26 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s11sm1518746ilh.54.2019.11.21.10.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 10:37:25 -0800 (PST)
Subject: Re: [PATCH] nbd: prevent memory leak
To:     Josef Bacik <josef@toxicpanda.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20190923200959.29643-1-navid.emamdoost@gmail.com>
 <20191121183017.h3qkpib5re27ty3b@MacBook-Pro-91.local>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae75694c-02a5-6f7f-c812-1350512490da@kernel.dk>
Date:   Thu, 21 Nov 2019 11:37:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121183017.h3qkpib5re27ty3b@MacBook-Pro-91.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/21/19 11:30 AM, Josef Bacik wrote:
> On Mon, Sep 23, 2019 at 03:09:58PM -0500, Navid Emamdoost wrote:
>> In nbd_add_socket when krealloc succeeds, if nsock's allocation fail the
>> reallocted memory is leak. The correct behaviour should be assigning the
>> reallocted memory to config->socks right after success.
>>
>> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>> ---
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Now applied, thanks.

-- 
Jens Axboe

