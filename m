Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E89DC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425F961260
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJTMK4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJTMKz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 08:10:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A6C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:08:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b15-20020a1c800f000000b0030d60716239so1073157wmd.4
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fnSXd6pECZmRz/MR/flYEHcSEh197wOm5ugPJahV2NI=;
        b=VdriVTbzZ6vzNejOqhEI9yxDPZIxxOjgleA1Rz8BCObquriCABxq7YpJrXdt35dmBo
         XYl96Knz0P41w/BjtHSrqRw7JNDeS2S9UBSSAOBioMIBUZn6Vv+3nSrQ84BUiHQi7+AX
         HJytMpOI8L1LfgdDrws90rFu8loj0QulNDasYuPuyA0LdOlwW+4sZs2ZGok3b4CHgJkN
         rRGrPnjyxI+/G8lZCmMARJdiPMXmGCecdhzIhuVWUSU76wm/HOO3SAjPxDhver48qaIR
         bMuPC7EFQsj/nxQYoyUS+ePUjdXV9WPc9booVnE2BcjRc5K4QM4VXdmydgrpy2f1gmgd
         caYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fnSXd6pECZmRz/MR/flYEHcSEh197wOm5ugPJahV2NI=;
        b=TTBSK9G4Z+ipvMhU6RYiY6GI7uTAepLZajli/EnqsQoBDwP2ADo6TvW6+Aj4OOOena
         HxvTZlDSACXpg620yu8Ock9ObXTlVf5LLX3L9UdkjvikCormuO5jdpyGkMvogPnuWByA
         yDk/v0XYOjTbZ3LeZxBqlQ78ZUyuZC0W5wNkRka8hGvAo443omBjlRxezEyht31TNJ1V
         iVPep5c7HWTiFCTLnsxa0H87fPwi9OEGd3ivY6E3Sn0mYGlhnXDBKUPYgfXFcVT7r/DE
         Q8EacHDAPCx7IJ6FKHIfrLt6Oau1NMJ3FXjK+ipIVSGcyIxyE0y65m7KcTbAqdo6hH6n
         X+0g==
X-Gm-Message-State: AOAM533s8Plw7VPysSWauJG1nP99bbIxWSC0qXBSw/XwvYIjXLLI6ONw
        JmDd6/v38jTMKcq64M8to/o=
X-Google-Smtp-Source: ABdhPJzF5cFqktld7wthoU4tXRD8uS4Gdfn5Y9hRfset/lVAp3WYgxDcU7Dwd+MdIgJDT/IZYoBsRA==
X-Received: by 2002:a7b:c4cd:: with SMTP id g13mr8144722wmk.34.1634731720033;
        Wed, 20 Oct 2021 05:08:40 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id v185sm4920798wme.35.2021.10.20.05.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:08:39 -0700 (PDT)
Message-ID: <ff6cc7ef-cf16-712d-af69-61db1a23df08@gmail.com>
Date:   Wed, 20 Oct 2021 13:08:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 04/16] block: don't bloat enter_queue with percpu_ref
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <49bff6b10644a6c789414bf72452edb7d54c132f.1634676157.git.asml.silence@gmail.com>
 <YW+zUKSJQe3sEk4P@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YW+zUKSJQe3sEk4P@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 07:12, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 10:24:13PM +0100, Pavel Begunkov wrote:
>> percpu_ref_put() are inlined for performance and bloat the binary, we
>> don't care about the fail case of blk_try_enter_queue(), so we can
>> replace it with a call to blk_queue_exit().

Thanks for going through the series!

> Does this make a difference for you?

It did with a different compiler with extra patches and a different
base, but checking with for-5.16/block the binary size stays the same.


> That being said using the proper helpers always seems like a good idea,
> so:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

-- 
Pavel Begunkov
