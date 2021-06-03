Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDA3C47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 20:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA6D613D7
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 20:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCUja (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 16:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCUja (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 16:39:30 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58065C06174A
        for <linux-block@vger.kernel.org>; Thu,  3 Jun 2021 13:37:45 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q9-20020a9d66490000b02903c741e5b703so5908264otm.0
        for <linux-block@vger.kernel.org>; Thu, 03 Jun 2021 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HacZyJ/XEl8lej2g88n/UCGuAMjnKzeTtEY1sUAioq8=;
        b=FdYTtkBdGng7CLLhjL+Of3tpBMt3KLmDwrytYWjY7Isa8HJ6neSTSdIZG/Icz1bztC
         es5H/yGUr12nSOFIfuho7SSCLOmay9UMSxtb2yKRRawnW1g7vnm7B3CxrL5GbxVJkJyz
         HIzGyb07OCn40Ggl0wTAGmNeVAQPZArKTM3HaNxxPYcQkh1xKsIPDosi5LENsn9G3gBF
         6pyDzWEmFLBTb/kYA1U4RzjOVDj90rFm2CvFk/4tQV/bhrcnouk4lepvf/55HIJaCcp+
         5SaGpvR6wMltQVP3MKAZEyzdrcRqcFNtlMOfGwbw+RRmqm+wcykOUQmN+FmQhZhGSBM+
         UrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HacZyJ/XEl8lej2g88n/UCGuAMjnKzeTtEY1sUAioq8=;
        b=eA43/m/E07lJ9kbKc8ogKmuhlwVdEogHfMY4vnV+i+frIfhGMf4z7zli5OjyQVlLla
         x4FAZ6M8fV2xPJD7j+fG7iy7TAouiyZqbxSZ271oiZV1PaJqsZa1hLy/6C5egwKwpW+T
         5m8+vi8449Id42M/s7vt8F0fYdjPjkuHs6DIKbw4Lux0XUDHaGrrWwVI1dejGKaL8CjF
         o9pyeHsCpXW67X5CPM0/j41lIzTZfkOjEDJrOB3/POTUpl8krgWWdSg9HwKwGievD6Xu
         LqBJVooHP9KN7fDw2Fd11eClQ+jVkyOLr+8F1PT0kiiZOVu4NRmBYCWpbuLNYSDVuD7g
         4OwA==
X-Gm-Message-State: AOAM532eQ+Aw0YneGtbhkzXnGn6Zh2bwwg5VThNjC0Dj74j8FyGA5SyM
        wv+dnyAL2LUMgyBkWKT2nzaltQ==
X-Google-Smtp-Source: ABdhPJxFrwE9Ikh4IYth4P+KG1Jk+VBGzkZ5sxFlELGwIh9kpfASBeIko/9YIIz+8NbQxmLyOoz0Ug==
X-Received: by 2002:a9d:798c:: with SMTP id h12mr926846otm.253.1622752664503;
        Thu, 03 Jun 2021 13:37:44 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id n11sm868254ooo.12.2021.06.03.13.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 13:37:44 -0700 (PDT)
Subject: Re: [PATCH] block: Update blk_update_request() documentation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
References: <20210519175226.8853-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0869d606-c473-d004-605f-6d3f4d19ffd9@kernel.dk>
Date:   Thu, 3 Jun 2021 14:37:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210519175226.8853-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/21 11:52 AM, Bart Van Assche wrote:
> Although the original intent was to use blk_update_request() in stacking
> block drivers only, it is used much more widely today. Reflect this in the
> documentation block above this function. See also:
> * commit 32fab448e5e8 ("block: add request update interface").
> * commit 2e60e02297cf ("block: clean up request completion API").
> * commit ed6565e73424 ("block: handle partial completions for special
>   payload requests").

Applied, thanks Bart.

-- 
Jens Axboe

