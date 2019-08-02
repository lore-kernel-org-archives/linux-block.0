Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A433C433FF
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 13:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F93420665
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 13:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MeCTKCBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392103AbfHBNgS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:36:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46687 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392140AbfHBNgR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Aug 2019 09:36:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so33637092plz.13
        for <linux-block@vger.kernel.org>; Fri, 02 Aug 2019 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gcYPbkJCzR3yzBT4yRJWzMKrfncN/11MLd/vWc609SA=;
        b=MeCTKCBpwnUhYR1D0XypWXIETuL3nvPB0hB7qo5Zvh385wB3kWovl1E3+rEbd8LtYE
         wfp/tZBuARA6SXIlXeHEe62KHxK+BzU2FY+SLgNkYhNV9SLLtb0ydH7C5IrH5rRpq6BZ
         kgGbXhMDwjLem3X5ZKRFvgjkpVLzM6xXJaawOVzw2RCLgOQd/WNHi+9dkShLXe00K2v2
         6BamISfTkn7j4Puy7IQA9/4BVc2qRGaEwbWGrGtK86LaX0c9sWZA2il2/2PR/+VLP5/l
         vRQ6q6zU/grRtJ+Aa2yD/gfyipwCd+lgyJzLuyqgk2R3OjuD3Vao4kmlAoev4AN9hn8S
         k6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gcYPbkJCzR3yzBT4yRJWzMKrfncN/11MLd/vWc609SA=;
        b=lmW7Yc7GqsJQU+1czBzGhtm35wPs8ywpT9/9j64sZwzxxKrMIXOxJqTgxy8IgGxSLY
         +4vHy7Fsy3p8BUhXdzB2MCRf/QilwCVEikOeKnVb8OVeEUMgAxPWsxzh3R1XxPWvoxD4
         om/qW6xrRODu9drKUvEIIhrZHGu+I9N6HtQZCVOQZThIH/Vtak1TFsLjjN0ZsFH3A393
         e7M/c12Ky7NaOgAwvyeuSdvE2/UAjPjcosrE/ySyKF/9TfRLpnuLeIRkWr1oEzx01sUI
         nGMoggKdhLwvoXeWlVrp8iH9uj1RuDgG6a1GWxFrv3Y2hgOzzeaGf6Pu3ztM3qLVFX3v
         RUnw==
X-Gm-Message-State: APjAAAXcfQqXL/Jl1M9o4ULk4sksRjl/ARFu/3seE+YRCUza7jyQbyHj
        YxShvrE/w5G0NXlUviJpAS0=
X-Google-Smtp-Source: APXvYqwYyfEFUbsPd38C5HAIn/fZbDZU4LEDTE6/5z9sIJNniaAV1F1ahC+kPgUlIwTW5XHTGXGMfw==
X-Received: by 2002:a17:902:2aea:: with SMTP id j97mr118465614plb.153.1564752976447;
        Fri, 02 Aug 2019 06:36:16 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id r61sm8309513pjb.7.2019.08.02.06.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 06:36:15 -0700 (PDT)
Subject: Re: [PATCH] block: Fix spelling in the header above blkg_lookup()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>
References: <20190801223907.141042-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8f12fb9e-71fc-7677-9ac2-815937b1d751@kernel.dk>
Date:   Fri, 2 Aug 2019 07:36:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801223907.141042-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/19 4:39 PM, Bart Van Assche wrote:
> See also commit 8f4236d9008b ("block: remove QUEUE_FLAG_BYPASS and ->bypass") # v5.0.

Applied, thanks.

-- 
Jens Axboe

