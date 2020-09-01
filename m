Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092E6C433E7
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6472214D8
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mKlfVeSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgIAOCt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgIAOB0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 10:01:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CF6C061245
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 07:00:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so653334pjb.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wPLVXP7MXQ/gpGheLR9ao0yK57Bv1IbbqoqRbOfjXD0=;
        b=mKlfVeSDrtPKqcrMYSuqiw8Dm5VMotYzqUbdoT2kpLWEuCNe1utgpEkpOmLsTv4b2U
         pT2rDbvJLr/Vkac3Dzm12NmoMXo+8vp1lnYb4kqPd+BMypOC4kwuhVDP1PniO+65ep9c
         gjOQDw0nvx4R/s41sor5LhdEYZkjOAg1nzXj60REEjDRrlefacBALWmHi1YC81LAxx4v
         uYb1kunUBn/q/xUtpU0eenLs2LyWQmRZ67NysD9lBtYEn0jACWU+hehcACuJ7h0BOxI+
         TbYc8phs2kuGgtcV3GRe3U3tjXgXgFfm/TnJzRjHswf1wEC9Kd1HjjEBz7nFlCyZMFO2
         wa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wPLVXP7MXQ/gpGheLR9ao0yK57Bv1IbbqoqRbOfjXD0=;
        b=LFmI4ujyLQq8BnnphSmL8+IIZm3ACOo/2yt24ZwWfL+b6wYPKg9tYmHQ2cIyf0e4Ez
         R2xYPgSRQJZ0mFuY2cFTvv8ZsGvDj88dmeuQbQ6f025yiqMuTf1HXgLbDkKtM800qmpF
         f2gnOJJAsPXP0LnnHxdXcJbJIHTFUjkJaCRxOVapnHqzghLH/KOPWTco1o2EwsU3bKt6
         Ajg+ULGaAK93OUWvhWq2L7pLuZH9vZnwl2Ga98NJQTQo259/NSsGQB2vHDbkmtD6G8II
         iz6jwc4IRmgqCZwsWJ7b2X2HTh2E+qZw3jugVqwPfbuWJZH9DsVUuvUxaJqA25IB4+p5
         1b4Q==
X-Gm-Message-State: AOAM5306yAdZGg8ryvqIeAvGdHp/N87fV7BKlcDwfo2EPLnv3woYiXeG
        HvIaP+j34VOs9dfPlIGlpl3BExiADpRR3E2A
X-Google-Smtp-Source: ABdhPJwC0Yk55ZCQaCX+YlmUhqj1aD8X72YlBWfj9T3k4oyLeClXBIGIO/kMHHkcv/lT/QjcDxxyKA==
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr1685529pjb.139.1598968857848;
        Tue, 01 Sep 2020 07:00:57 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id ga20sm1643702pjb.11.2020.09.01.07.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:00:57 -0700 (PDT)
Subject: Re: [PATCH] block: ensure bdi->io_pages is always initialized
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <346e5bf5-b08e-84e8-7b0e-c6cb0c814f96@kernel.dk>
 <20200901054343.GB29886@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e22c756-f4aa-1cad-2e16-26a104c9aa37@kernel.dk>
Date:   Tue, 1 Sep 2020 08:00:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901054343.GB29886@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/31/20 11:43 PM, Christoph Hellwig wrote:
> On Mon, Aug 31, 2020 at 11:23:32AM -0600, Jens Axboe wrote:
>> If a driver leaves the limit settings as the defaults, then we don't
>> initialize bdi->io_pages. This means that file systems may need to
>> work around bdi->io_pages == 0, which is somewhat messy.
>>
>> Initialize the default value just like we do for ->ra_pages.
>>
>> Cc: stable@vger.kernel.org
> 
> This should be a fixes for the commit originally adding ->io_pages
> instead.

Added that and your reviewed-by, thanks.

-- 
Jens Axboe

