Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CE4C43461
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 21:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB09461352
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 21:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhELVmc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 17:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392440AbhELVhm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 17:37:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709FBC061344
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 14:18:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f8so14172892qth.6
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 14:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1WOYTnceRFp/6vjBoeb3YHg7/Lybn8v51JI9ZefX0q8=;
        b=O8ogX+BpL3ElBKB/k+j7SIW1hUQcNxE/eoGVmVSCHtXeAgTuAvBXTYHh86e+nVn6UP
         2Zda2AxVuR6fuzDop7ohUcY0+lU7eDfk2tAXbMtuvDz+/nnIT2fu4EVsuOVFy9i4py6I
         CBPtRkHIZuuIZ3gnuG3h0ivoFXkX639diMhq1fzoyEw9HL/wRh424FwzlDQ1IAVAfV4q
         dUl75XigOA7R8XkcAKMJKMX1A65vIZ38hfo7K6V2/YM1zNV/9vo/2rM8iZAgPjb1QVD/
         2WXB0hOjnKOQuhGb4MeLPCRwgJjwrsJVBepADiF5PdPmtjlLVE218QzDFxVFBqoV5aG/
         N5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1WOYTnceRFp/6vjBoeb3YHg7/Lybn8v51JI9ZefX0q8=;
        b=qkwNmBmMzTGC0SrVB+P7+3UYvkEca0ITm92w1sNB5lqFDAVGV71wcsi7YpO3YDbrG1
         bV5lt4sQkk13GWdSrPY5XCOIbwabCq+bTuIn34fehbL6byydPuxz69Q+63AbAw1M6lCE
         F0qw3uccgDcmOFKI0I/nN29Tp8TAcfVvtVzWXagScfxPbKHCdUTTTVcp3iS4F9hiSJOh
         YX8wYnWg9F05J7zp6CPWp/FBQkMGmK7RJuxun3OwlObltPdD7W9K4mBCoQW+ipWboaS/
         6ysdEkpmoWAPzmgGqB3tGj5CP5xQIJzcu0KKWMusR7FZ/mVOKcjfBjrdOMOASFJ5GNGn
         ImIw==
X-Gm-Message-State: AOAM530iDdLHPuT+iZbAgDO8Yhhi7YUfJpyR+/cO45XXbYJFSc4csknR
        9OVw5WfwaM0o9rk1Rd7udW91jbrqSMb4cQ==
X-Google-Smtp-Source: ABdhPJw02+zK01bwqDc0U88/KuAik8nTXQHko4wv830+F/IeyCwR090IgfmIyW2UwET2k8Zu4Q2ADA==
X-Received: by 2002:ac8:4a01:: with SMTP id x1mr24100791qtq.8.1620854291839;
        Wed, 12 May 2021 14:18:11 -0700 (PDT)
Received: from [172.19.131.127] ([8.46.72.121])
        by smtp.gmail.com with ESMTPSA id f16sm865356qtv.82.2021.05.12.14.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 14:18:10 -0700 (PDT)
Subject: Re: [PATCH] block/partitions/efi.c: Fix the efi_partition()
 kernel-doc header
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@math.psu.edu>
References: <20210512201700.9788-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ef6562fa-6f8f-da28-b0f7-90a126ab4222@kernel.dk>
Date:   Wed, 12 May 2021 15:18:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210512201700.9788-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 2:17 PM, Bart Van Assche wrote:
> Fix the following kernel-doc warning:
> 
> block/partitions/efi.c:685: warning: wrong kernel-doc identifier on line:
>  * efi_partition(struct parsed_partitions *state)
> 
> Cc: Alexander Viro <viro@math.psu.edu>
> Fixes: a22f8253014b ("[PATCH] partition parsing cleanup")

Heh, I think using a sha from the history tree might cause more
harm than good. If you want it applied to any stable, probably
better to just use:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

-- 
Jens Axboe

