Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D7BC4320A
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 01:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9568D6105A
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 01:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhHLBlJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 21:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbhHLBlJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 21:41:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18856C061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 18:40:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1so6698467pjv.3
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QBCEaZn4CkWRVtl+4I6ERHHpNUJaxKMTsA/sipIS2t8=;
        b=CM78Fh2Auz/7fwp3c1OCG1ZarsHT0uzIu+sCKUYn2QgLIlt51/uN8Ng2sX4wJlxHrV
         8rd96CJaVdL873wttibwIjmkjaNugm3J7k5z2hmsvwXOLrbg7xl4hkftSfZFk+kj/j8Q
         ydIy8DFRMpJsr/hFQDN6hJTgW+IUlNZBo7tr5ePW8evU1U+oTSgO7u3Px7YaiQCSzn1h
         FR750BuKAa83EL0e9kRGzjErM6xFdMUAI7zjHdkqUKZ6YywF5/ahW/9bb9WGNogNjmS1
         K0zRqG4Zyftq57BC6TFVAYbBeJrjz0SnwGv7ymjL4LaEbpXdyzzgGRtTI24BSRCgYrlI
         u9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QBCEaZn4CkWRVtl+4I6ERHHpNUJaxKMTsA/sipIS2t8=;
        b=M4EpaH4WyssHuV5eCTqnazrARHfuLh5hp6uf3KfLYDA8XcXwBCjJiWSkP8zjeH7Srm
         LRJW98XkHjCkqg0GUVCcWD9w07v+mUKdGsGfo8K/LpD5qKQIwkeUmJTk3ASKP5QLvyO+
         VN1fxaI+DLTisMwLl0jiUffIKSxY0pnNDFHZf9OFACCZJChjMDikD8K1DegbT10pF5uj
         EHIJtpfDLft1ifbTu08iZ5YXtaIYcLwKcBdnB0/hn0+0DxtR3dmWJxJ3ZIG2JTg2CIaM
         E3iQkqxtHv327YCH0EafkQKcLJD7cMzjwMBc4AfdPkIqLGtSQGL5yaTucUvcq5azxVdS
         G5zw==
X-Gm-Message-State: AOAM532m+HTyFDkUY2eVpyHgGeK65I6ur0W4JAByQey640u5UFXznH82
        wvSrGVPUelHffQ7ggoSTcO3Fgg==
X-Google-Smtp-Source: ABdhPJzl/5HjrqjAQCGK1rRIV5X/InNfmv/4mjaWA+B4xSMg0kQhVfZ5cUxBLeChlLpXX2OQaNseQw==
X-Received: by 2002:a17:902:7041:b029:12d:267a:d230 with SMTP id h1-20020a1709027041b029012d267ad230mr1394258plt.55.1628732444664;
        Wed, 11 Aug 2021 18:40:44 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id ca12sm745528pjb.45.2021.08.11.18.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 18:40:44 -0700 (PDT)
Subject: Re: [PATCH] block: move some macros to blkdev.h
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-bcache@vger.kernel.org
References: <20210721025315.1729118-1-guoqing.jiang@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0a648cf7-69fc-d5c9-9a8d-537a644527f3@kernel.dk>
Date:   Wed, 11 Aug 2021 19:40:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210721025315.1729118-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/21 8:53 PM, Guoqing Jiang wrote:
> From: Guoqing Jiang <jiangguoqing@kylinos.cn>
> 
> Move them (PAGE_SECTORS_SHIFT, PAGE_SECTORS and SECTOR_MASK) to the
> generic header file to remove redundancy.

Applied for 5.15, thanks.

-- 
Jens Axboe

