Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62718C433EF
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 13:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiCaNt7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiCaNt7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 09:49:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A18510CF0F
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 06:48:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z16so22085569pfh.3
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WIjS4hHkncWnADQSguPcZ9yDRhMIIgfXbDG/5koXL+M=;
        b=8JdtJA3KoB9+DGVHgZEvfjxJgMQB8AJ3+FSa/hLLh59tuXtTzMTYqls626HhE0Xx60
         M8oCxHsUeiyFnCM6zqv7RaiC1o3cURHKKd8TiUDajJIKwDH91uIAhjAWsRucpfdjRjaL
         MNyNzgTZVBriuzx0dA4ay60uAVu43DYTvPKr2G0XVXQ8KissoueE1rxxZFNyFbs4ES5/
         j4bv8lJfqwpnH0vwKGlzFRvcN1mAMxs4MPKKIb6qB3gRrEdaWRmCGB31IUaoOfyPhuIW
         RShLIX/p6TZP2ZhVRV6PkG5Qw+d9y/FGgpiUFEywgccI3/V+ah8sVNYNy6QbTu0k9Ed1
         DeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WIjS4hHkncWnADQSguPcZ9yDRhMIIgfXbDG/5koXL+M=;
        b=AyMi+vy6gHnYVxjYwQphxrxQ78b7uVbXggamEIMEphrbMCoFilzrf5AjhTkQMhVDbj
         tFQZXRs2JxPC3PnZVLL9o1rEYvH/og3ndhFRreVbIt1Qu9iVdMmOx1JZdhYU0EaIuRh4
         EyLEDw+c179+3u2iiZFifFCKMaHiJ6uuHMHnOD0NctMamv7UFKk5O8Xm/BQBdrsq7PyM
         xtkyLmMPjzBL5Riy+ovWYEAAJfCa5Y74B9itcFM6G+b+i8iTNy1uhNcc79T/AMosaO8/
         IDF+daroVwxDGMAyLKMANdCIL8SyCB/WH+HmIG5yG3YL9tcX98HzEBQl7RxdsQIRT7Xe
         fFGg==
X-Gm-Message-State: AOAM531JfgyLRtemhmxvMohAFcE368CWMi/RosXQDOM3E4IXaeUHf2eH
        R9rBupk4GLEtyoyld6rWyajVrw==
X-Google-Smtp-Source: ABdhPJx1JWwl3z3vLqKxPFPwBAUbmruyet8e5XAqvGozXt0cKP0NQz5DfjALnTIZvovc9OIbpJ01HQ==
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id bk3-20020a056a02028300b00342703e1434mr10853784pgb.74.1648734492091;
        Thu, 31 Mar 2022 06:48:12 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id lw4-20020a17090b180400b001c7327d09c3sm10037155pjb.53.2022.03.31.06.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 06:48:11 -0700 (PDT)
Message-ID: <8dbb5fc7-7170-d190-ba24-2ef13dc73623@kernel.dk>
Date:   Thu, 31 Mar 2022 07:48:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] MAINTAINERS: add drbd co-maintainer
Content-Language: en-US
To:     =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org
References: <20220331134236.776524-1-christoph.boehmwalder@linbit.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220331134236.776524-1-christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/22 7:42 AM, Christoph Böhmwalder wrote:
> In light of the recent controversy surrounding the (lack of)
> maintenance of the in-tree DRBD driver, we have decided to add myself
> as co-maintainer. This allows us to better distribute the workload and
> reduce the chance of patches getting lost.
> 
> I will be keeping an eye on the mailing list in order to ensure that all
> patches get the attention they need.

Can you go over the ones I already listed? That'd be a good start.

-- 
Jens Axboe

