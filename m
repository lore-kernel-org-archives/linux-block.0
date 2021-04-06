Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EBDC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC4F613CB
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbhDFPYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhDFPYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 11:24:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B0C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 08:24:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s11so10670462pfm.1
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UPJ22AvRb4DeKuZ23b0TfwlLwVfzrMoVWDy5v1hhRY8=;
        b=zNIEb7bx1qF/sljAbnjufyRYUE509FSg6B4h/2IDK5ZGSKsuyTFR1ZvdgdO1+IujFq
         wE+uiQWrJitmRnmyFkd96vi2hi8hDypAPmyyquosjD1W3bziUaLGm9vkeaUw+FPslrrE
         9cH4I5hRCC1UjAQFpOFTDREfbI1q0hEzpMCHKLD9eMPsZ2lo+v3Xi5QtSybO/+dnEF+E
         FvUrTKOyPrHe+OqJX4Mw0KYOqy8RYIhHSYQyLd1Jz8xqT4EEJ07PB+sS5RbXkCOSYUYY
         4SMu/LuTlENASRE9qa4UPetCG19rQ5C+cmfOvyx9oSxYP54xbXtqCmyaa/Ycys8tnUCx
         wUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPJ22AvRb4DeKuZ23b0TfwlLwVfzrMoVWDy5v1hhRY8=;
        b=LiZeESgf7cHMnmhN8XXCb31m0+GR6DbIV2U0XQ4T8UgsmdRgTMUsE1OBd7hwyZM3Wa
         6NoAVHxuyWHPHaseEdeedB4K2CNR/QC4opxKCSH0iQO3EH+TWkzkDH8zj7DgddnCek3c
         p9TkSRbMQdv2DUx2GKEa3ihW7BYwp6EYcIvOEXgn0+BPSWTEoZhiW81HAgxxtlvK2y7m
         +gYnKSBk02NMA4qcFfJLsMpFNERi7xNlyFh0ulounxHNgz3S8Xo+KdVnEfNc7iOjRHJd
         oivaLLqhIUtOIia3j+pB75gFr8jwVsPdr/cMotBVINZJInXd4TyFN9TdvN3Y+VDHXrbD
         J45A==
X-Gm-Message-State: AOAM533IUIymDuLd+96HyS709H7O4PEzw0ucF4h0V/OZhf2Y5DFrsFrQ
        siLKsBaDGrWdqO4TdqTMtEaXFuuUJb/BKg==
X-Google-Smtp-Source: ABdhPJypLNT1ZMixFudO6b9JnryvqbezBwCcI7xUAzA8iKAhBEm+2wx7E7iNEureScZWjDwCMEhFNA==
X-Received: by 2002:a65:4942:: with SMTP id q2mr26975514pgs.34.1617722679135;
        Tue, 06 Apr 2021 08:24:39 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x19sm18979176pfc.152.2021.04.06.08.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:24:38 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Always use blk_mq_is_sbitmap_shared
To:     Nikolay Borisov <nborisov@suse.com>, linux-block@vger.kernel.org
References: <20210311081713.2763171-1-nborisov@suse.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90601984-3396-4954-e91d-42d13914e42e@kernel.dk>
Date:   Tue, 6 Apr 2021 09:24:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210311081713.2763171-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/21 1:17 AM, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Applied, thanks.

-- 
Jens Axboe

