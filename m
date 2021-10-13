Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEF9C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B171D6101D
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhJMRsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbhJMRsJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:09 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F73FC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:46:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j8so556188ila.11
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7fEZ5rnBRdDspyoejLNWPyy1H9Xqf8tOCmcYbMpo85k=;
        b=mXnSN+RPQ4Q5oYQSCR3SkrX4e9F30cy07XrTn8iVPHc2se7QjKnLwj96ddt204RHcw
         u7fCZFzN1PhLsBJlcy8Vra2DJbHomC7C+OwHAcDW9G71eIw9m3AdoGhRAwOwyvAa/9a8
         PiWX5SbhOSNvBrG0DhG7WcUNkWTXTqRs6Uv/M3kh3w0V/7X3SdzO39JbUjJwkb6LKRr0
         +7EiE8wx5DaSHwshpPhOErb9NRzUBLeJ/fmCOc7r7ojpRuJ7LGSR2rTpzXqXGWbZ1XKF
         R3/C/C5eIjKOrEPAGEOho39QmH0XiGG/VA1M06/f1TbHw1r3R9UwQDBOdHIzGDaS2cuj
         8cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fEZ5rnBRdDspyoejLNWPyy1H9Xqf8tOCmcYbMpo85k=;
        b=SbfckOzv5QvNLY+92o7aeq9ZVcuVCI+XjwxlTpMkALuzc/+od2IGlN5VTirtkvIteE
         EcSIhB25QMv1xl+kQIrFkK0O20XHYDLv7SEpFs5Y4OqpiLliZOKMjqv8tqIXDbsGyjun
         7482zMkwqRPUepZ1J2wvswczMAjKKEVnqcDi/fw3mvUeKzQwylyy6MI2Owfmx5Y14Ubj
         iaWn/ztmX+sdHfIdTqJdwwtszSQMtGtkpIJ364NKsrZ/rvqNBKGOY+dH+enxNmxJs9RB
         SQA/fzMOC31Jc9m2j932s5pnOxC6QqAMcnNaF+Je3w4SsbRgHSbR5qbWtG8jCUkI11xW
         KOwQ==
X-Gm-Message-State: AOAM532WzKSDx5rwvUZ/rY7NRhdi2dN+XIXOcgnhPE/57aHV6KP2205t
        iZ1/wQKMcI+e4w+LiywCMnKgmEHrKua4CQ==
X-Google-Smtp-Source: ABdhPJxlgbJ3L+9pvMa2YRQh21OhZUW0mYTiyYHzpNv4NcCr4dMslMjERkqamLo1kURgQAdBfKHQ4w==
X-Received: by 2002:a05:6e02:14d3:: with SMTP id o19mr378564ilk.156.1634147165349;
        Wed, 13 Oct 2021 10:46:05 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m10sm89661ila.13.2021.10.13.10.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 10:46:05 -0700 (PDT)
Subject: Re: [PATCH 2/4] block: inline fast path of driver tag allocation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-3-axboe@kernel.dk> <YWcV52525ZR6ilwx@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad0cc4dc-1742-87ac-73f7-2d16be37f44f@kernel.dk>
Date:   Wed, 13 Oct 2021 11:46:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWcV52525ZR6ilwx@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 11:22 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 10:49:35AM -0600, Jens Axboe wrote:
>> If we don't use an IO scheduler or have shared tags, then we don't need
>> to call into this external function at all. This saves ~2% for such
>> a setup.
> 
> Hmm.  What happens if you just throw an inline tag onto
> blk_mq_get_driver_tag?

I'd be surprised if that's any different than my patch in terms of
performance, the fast path would be about the same. I don't feel
strongly about it, can do that instead.

-- 
Jens Axboe

