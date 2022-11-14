Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8713CC4332F
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 18:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiKNS7z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbiKNS7w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2022 13:59:52 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA36726A
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 10:59:50 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h24so7362820qta.9
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 10:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMP0hLXvzFDzyLxrmXeMLYbiPQz2Cr2H0O52Ty1NFlQ=;
        b=1r69zTNQj2Uo9qDNy7T5oCzGQ6rmNIq4FS3A8Ml5ziS5+nIbCm/U8ekv/6pi+BnXZB
         WSbUvTUu6PZW5qsJOJSMtvD+4dVxiLehX7TD0KitwiBTDAPyjt4WtbWhzvraYcZd3K/l
         xPGLlaw9PUOHjfpNd8zEVzrKfDg8cQaB+6ZdFDtV3HbHtdK0WnDRin5e0bzRX1xwVte9
         ib9tFy0VLoV6dwrzi51D44+w8CxkDQs+IFKdktoMxCOQ4U8Fv5r2+fuBDSF9V4gRXHeV
         euGjPJ2E5U6/qqpo3h4SvIOz7uRqswVOuuVCYAu51ugc3impl2YUiZcumdqzbiTBFrUv
         DGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMP0hLXvzFDzyLxrmXeMLYbiPQz2Cr2H0O52Ty1NFlQ=;
        b=nBLtXYhE6bh9t4qBRwYaTVwiSpeA6xqQ1QDqYVldeE/yT5BERnZAu37Zwdra8zlyzG
         +bjz/UBK8qyJ9kzkg7wuCbbaVbtylFa8pdxPAMIzFabesu3cDxQ0Q0TYRqrRnsx0WjTN
         3zGPTfrXJuJNEPeKpbmmmigZ54tUys3Eor/1OJ9g7mVtWL+5+GXjPdRhM3iq0QbFO6Xn
         mktG2F7+1LJfb49Y1GOT37z3PXOJOCdwXTNh7Tqmyqz3+rJa54gcON4Z1Fg77pZZm3rN
         hpWrTO1CA+vTR05E/xI1OMiG5nHgYhED45bztW8vbQTzzq/q2ARSTbbFs//CgRiGqkeb
         iUfg==
X-Gm-Message-State: ANoB5pnWAdrkUcDGyC3A6pN3RaTa3IZUWpm8SIaFW+mzF1n0x0aPtAyY
        Zv2OxmoCXh4c4FCwi0ZJW3p5FQ==
X-Google-Smtp-Source: AA0mqf4ubYqBP+lzIilpxvsjMHfbXvYnP/3pM4CbyAT6MbEft0T8wVsmIdfV2Ks8HQeTX8xg2VQEnA==
X-Received: by 2002:a05:622a:5919:b0:3a5:4502:3da5 with SMTP id ga25-20020a05622a591900b003a545023da5mr13391622qtb.658.1668452389837;
        Mon, 14 Nov 2022 10:59:49 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-3663-3884-f85a-44bb.res6.spectrum.com. [2603:7000:c01:2716:3663:3884:f85a:44bb])
        by smtp.gmail.com with ESMTPSA id bp44-20020a05620a45ac00b006f956766f76sm6882405qkb.1.2022.11.14.10.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 10:59:49 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:00:10 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Mason <clm@fb.com>
Cc:     hch@infradead.org, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, riel@surriel.com
Subject: Re: [PATCH] blk-cgroup: properly pin the parent in blkcg_css_online
Message-ID: <Y3KQOpn102h64mEd@cmpxchg.org>
References: <20221114181930.2093706-1-clm@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114181930.2093706-1-clm@fb.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 14, 2022 at 10:19:30AM -0800, Chris Mason wrote:
> blkcg_css_online is supposed to pin the blkcg of the parent, but
> 397c9f46ee4d refactored things and along the way, changed it to pin the
> css instead.  This results in extra pins, and we end up leaking blkcgs
> and cgroups.
> 
> Fixes: 397c9f46ee4d ("blk-cgroup: move blkcg_{pin,unpin}_online out of line")
> Signed-off-by: Chris Mason <clm@fb.com>
> Spotted-by: Rik van Riel <riel@surriel.com>
> Cc: <stable@vger.kernel.org> # v5.19+

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
