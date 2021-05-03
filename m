Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE09EC433B4
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F181611C9
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 16:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhECQeQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 12:34:16 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:43993 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhECQeP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 May 2021 12:34:15 -0400
Received: by mail-pf1-f176.google.com with SMTP id e15so4532591pfv.10;
        Mon, 03 May 2021 09:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/qET3Lktp5s2i945ZGAweG/BlCuasSiVEat+RjmthiM=;
        b=EFp1+Lm6LaYoZTInhhHC3oEJhkfSwjTHLiWhNEkCjXF4Y8yk8hmXeAOJM5idCO/xWG
         57FWdxmsb2R1PwnnywnnYKAcpUHWRnyKcLwrhcDKen+8KSAoklC1HXCDOgybBGBHCAZB
         39zWts3S0G5d3ff4KMrU51Mt7GX7/4WoHmgw6/COtX0KrNcxOCixMUpmNDT51w0w8YEU
         BN302rirQSHXbhiGu0DJabInLXJNRSJGO9G4pv4JKQMBqg5vPe8luJVPwQtok/HJ4Ar8
         S1iZ8lxnvvI474KFDaBziu3LNgriXBobNHg4e1YUo+KX5Ex5rIzb88oGZy9d2OHXqfXH
         EQ4Q==
X-Gm-Message-State: AOAM533FDAxNXtKnJ/XjAp4bLmBhcrU6IPO0yYRkaREx4g9KpdWnDh2e
        SIRUdTRAvqdJpzIoJ5tl2ys=
X-Google-Smtp-Source: ABdhPJzK6s1ugTZAhrT/VbnqCfOz+VfOn9yXtCqLuI3YAEkDP4NorkAIPh/QcWMZ+JlGHG/WW7s+Hw==
X-Received: by 2002:a62:3344:0:b029:28c:6f0f:cb90 with SMTP id z65-20020a6233440000b029028c6f0fcb90mr17558114pfz.58.1620059601501;
        Mon, 03 May 2021 09:33:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:e960:31db:6b4:8ca7? ([2601:647:4000:d7:e960:31db:6b4:8ca7])
        by smtp.gmail.com with ESMTPSA id h2sm91618pgr.37.2021.05.03.09.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 09:33:20 -0700 (PDT)
Subject: Re: [PATCH v9] bio: limit bio max size
To:     Changheun Lee <nanich.lee@samsung.com>, axboe@kernel.dk,
        yi.zhang@redhat.com, ming.lei@redhat.com, bgoncalv@redhat.com,
        hch@lst.de, jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot@kernel.org
References: <CGME20210503101008epcas1p25d6b727dafcf9ff24db6aa41a3f611fa@epcas1p2.samsung.com>
 <20210503095203.29076-1-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f2529eb0-b388-9ecd-f74e-7bf004902c9c@acm.org>
Date:   Mon, 3 May 2021 09:33:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503095203.29076-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/3/21 2:52 AM, Changheun Lee wrote:
> bio size can grow up to 4GB when muli-page bvec is enabled.
> but sometimes it would lead to inefficient behaviors.
> in case of large chunk direct I/O, - 32MB chunk read in user space -
> all pages for 32MB would be merged to a bio structure if the pages
> physical addresses are contiguous. it makes some delay to submit
> until merge complete. bio max size should be limited to a proper size.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
