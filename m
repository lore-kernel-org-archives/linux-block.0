Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42835C4338F
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 17:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2345B60F25
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 17:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhHIRvZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhHIRvZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 13:51:25 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6922C0613D3
        for <linux-block@vger.kernel.org>; Mon,  9 Aug 2021 10:51:04 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r5so14223851oiw.7
        for <linux-block@vger.kernel.org>; Mon, 09 Aug 2021 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p35CO2b5gVHFfM+jxHUIY4WYpGVVYWhxKX7SG5GDBak=;
        b=S3/RHtcTruJhUiNdtPzy/p4wCKHvWk+EKVo3GBgNQku9x6vwEy6nubV3OIP9/WjJvi
         70zcMxQ5ELbqSmy5RJhzD7a+RGroQnC9yKd6J4RYknLRzw/lmfezU6GOi+bFdWReKfWy
         vjUMuQ+EPZWZrDJRSjgQ8bWOJLkGEnPIjAb0ZRp0B3tP2O6w4x8z+rlZKmN0DQm7W39w
         hzd6/hBj/4vV11BN1mfl1BVQItxwRZo9zNd2tgS7Iu1QREHfSenyYKeFpjp5P7dO5WVt
         2qbW1nDMClHCjWetQqpMHokbdLD1WICaXYWyw0XwudjEaHgJyREAxvfC4wYTZqoows1g
         eseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p35CO2b5gVHFfM+jxHUIY4WYpGVVYWhxKX7SG5GDBak=;
        b=iM18RxrD+Cm9NRXgxqtspXQF1Ekl7RAHiOGcAQDj1AOYnWay3lKMnzEcrUrOcro2BW
         QaIklASoXnpHwDOr48O2Z/4FatK7ycs8sapgS5Uwl3GzQ7XrpsE7O23Z5A+p+PDmRsSz
         8ql1TzqlZpPCRiEn6keIBmlwAOcHmMtXvKEPMK4jEgCf/9TG8n65Q4McQeFwH+0TXOAF
         CY4QBHVcdk5RQxFIXgWYLMNfFfDDRWAEihp1l5MXanWSkctGrLsJJbgM0zUVQueSCEyw
         QDdfXXuWlvESFtocmEHAPDX67USVkfJ5aieb7/yooztv3sq/+HVglWMTg4pMz7zT5Y7x
         +8PA==
X-Gm-Message-State: AOAM531dvUJqKRKrm2WVqd5lTAzRkKYNbYcjPAe0vA0DKUBIj3LNnQoM
        73bNfUdHFaFrZ/PjLlopfil5ZpCQIhu+56j5
X-Google-Smtp-Source: ABdhPJzwsv5SQcHRxm7Sl/e2di0rC3ABebpdSF5xZJkvxk5NwzpQIhEQGqAzJVzEeHFCABUKrfkPMA==
X-Received: by 2002:a05:6808:b13:: with SMTP id s19mr14536801oij.45.1628531463898;
        Mon, 09 Aug 2021 10:51:03 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p4sm2881825ooa.35.2021.08.09.10.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 10:51:03 -0700 (PDT)
Subject: Re: use regular gendisk registration in device mapper v2
To:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
References: <20210804094147.459763-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b93c771f-792d-b892-c88d-e28c81315860@kernel.dk>
Date:   Mon, 9 Aug 2021 11:51:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804094147.459763-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/21 3:41 AM, Christoph Hellwig wrote:
> Hi all,
> 
> The device mapper code currently has a somewhat odd gendisk registration
> scheme where it calls add_disk early, but uses a special flag to skip the
> "queue registration", which is a major part of add_disk.  This series
> improves the block layer holder tracking to work on an entirely
> unregistered disk and thus allows device mapper to use the normal scheme
> of calling add_disk when it is ready to accept I/O.
> 
> Note that this leads to a user visible change - the sysfs attributes on
> the disk and the dm directory hanging off it are not only visible once
> the initial table is loaded.  This did not make a different to my testing
> using dmsetup and the lvm2 tools.

Applied, thanks.

-- 
Jens Axboe

