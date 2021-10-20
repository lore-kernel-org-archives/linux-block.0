Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DABC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B73610E6
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJTORn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTORn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:17:43 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322CAC061749
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:15:29 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id z126so9767118oiz.12
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rIyq7IUV9k8HKy1VYrDAufTXSjpjFR6prPZSOKn4PZA=;
        b=nO7Y8XAsNH/KLneiYvbUODp8zmfoE7doXZCQj4IBMFtrvOlt0sa6fQ7kw/wQYxB64i
         Hyap2y55n1KfZ7YdViOpYl2YF5Wkof19wh7Oi7KQNtRO+ubA38m0MP9ame0/lRDjCvhG
         tdn1kGJqI5EKy5XDvuiGlqB1rwU03BimKD/XeQyusI9zgj8rkXILY55gs58oWu3yvp2u
         oYP721HL15HNrKsJv0/RAd6L0kk9VVzvGG2uOEgOUHvObgDxmkophsPBVCjUH693ffJM
         iyeGx2wQ0PbZ+5dd/Hv2Y/TrNCo3730UuLgGOOv240lsjI/3YZQNcfObX9oGQAKcOnoA
         InyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rIyq7IUV9k8HKy1VYrDAufTXSjpjFR6prPZSOKn4PZA=;
        b=LOWQbqf1OzUoHt2SwXkGPmb56fpyavLBaFmrNgx8hYbw0wx9Lcf67Ut3QYogMIY5ZY
         KRf1TXYy8IZ/R2SR/s9UvNEM9eLMcQ3dNDgWFB3XFJgFdOA2dezD8baJxt0IvAIsQgq1
         4YM2TN56hKLJtWqkwBkcpss9/Tpa5A3g6ONReYbB8eTb9z1H0ZYfocbQ9YMAcMc0f7fV
         S/78aAWvtfig/GJkxrqBerfH6z+7bTZ922pqaVOc2LhWq65lItGpskWFTfy37hanQdQA
         Emfb5ASUKmGyDVLCzu+03W6SXZnaUVGsgAHBakVEMf4U6MIz1Wr6V9R3cEQT4+YSFyNT
         hhrw==
X-Gm-Message-State: AOAM533EDqoWL5+cy7mnYX1OlA8kTKtjA2vT2tJetIGE44DwXy48Vp7p
        FTvynH1oZfCvY1+vf0OiBhHyQqB02y0=
X-Google-Smtp-Source: ABdhPJxG1EtTL5hgHyV5q85CUbdXf4UTR35sN5tnLVdUPUW4q6gjXIOkFVQcKjdVRpTA3tWF3d5lNw==
X-Received: by 2002:a05:6808:10cc:: with SMTP id s12mr9866124ois.164.1634739328293;
        Wed, 20 Oct 2021 07:15:28 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f14sm427508oop.8.2021.10.20.07.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 07:15:27 -0700 (PDT)
Subject: Re: [PATCH 05/16] block: inline a part of bio_release_pages()
To:     Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org
References: <cover.1634676157.git.asml.silence@gmail.com>
 <c01c0d2c4d626eb1b63b196d98375a7e89d50db3.1634676157.git.asml.silence@gmail.com>
 <YW+zdYMG2FUlzXWA@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dd5451ed-f0ad-98b0-18c1-5cd2aa87aaef@kernel.dk>
Date:   Wed, 20 Oct 2021 08:15:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YW+zdYMG2FUlzXWA@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 12:13 AM, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 10:24:14PM +0100, Pavel Begunkov wrote:
>> Inline BIO_NO_PAGE_REF check of bio_release_pages() to avoid function
>> call.
> 
> Fine with me, but it seems like we're really getting into benchmarketing
> at some point..

I just want to be very clear that neither mine nor Pavel's work is
trying to get into benchmarketing. There are very tangible performance
benefits, and they are backed up by code analysis and testing. That
said, the point is of course not to make this any harder to follow or
maintain, but we are doing suboptimal things in various places and those
should get cleaned up, particularly when they impact performance. Are
some a big eager? Perhaps, but let's not that that cloud the perception
of the effort as a whole.

The fact that 5.15-rc6 will do ~5.5M/core and post these optimizations
we'll be at 9M/core is a solid 60%+ improvement. That's not
benchmarketing, that's just making the stack more efficient.

-- 
Jens Axboe

