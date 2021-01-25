Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414EFC433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 18:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1408C22B3F
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 18:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbhAYSPz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731376AbhAYSPs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 13:15:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C719C0613ED
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 10:15:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gx1so115029pjb.1
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iLTv01uXk/wv0jk2KXYxjzAWyCAaqM7QWnaj23VL+4A=;
        b=N3FFRAlRD/9nw0aEhT0IQO/81yQJl6pBnnKfFiRnZMDXbK8bn6gjnIZXv+hqFsM9vh
         UBhGMDmJKHn7nDSSJFU2x+31ngWFqsGcPGfYc8jwDkq/SSy/nVAxR8fsF1YgtzhZA4WM
         KhGnVIhc7rNyO02j744t7bpmCa7sQ9+7YRWgV+VPGbc/d79DcYfiDRZAEPPAgCUCjejF
         v7iS/voN07Mzu3Dx0qcSh4bbCHr+k9o/uFOAx5Vi2TqqfkXRGUQH5u3vHYncvfjBBOiO
         QVg06lL8Pr06ku0smZoPJOEXr2tJh2aZUvCV3jwbc32dG5ftzbmAzr2k6i7B9ObE+pQo
         6xLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iLTv01uXk/wv0jk2KXYxjzAWyCAaqM7QWnaj23VL+4A=;
        b=kL21YNHvHd1qN9sGp0ZkxmKeGTuwsbJSv+f+AlNf1tgsdCaThSxegn98J7ZvsQbmMy
         nnxV9PLKhYwQEoNDDK/ZUV0t6Gi7dQjvliiRnzTEJBz7RgzEStHiFObbbEW487kPJeTW
         UWepgi2gewbTI5ZETZVtoQ7taHFtT8ySOgL8pqlZa99YML3ipqgJQV8t6P9NewLaDGs5
         5wLNaMtRyFEO5J0FL7C4SLyKEZglAzRWjOIg0LARxSN8x7kNVgmSgLwqt/ALyN34W3xt
         aUz3BLY5ZzCZU2tcYB5fchcHN//7bDjOx7zA5jB6BlOEet2btfTfEw3JnNUF0wt9noEq
         u5Uw==
X-Gm-Message-State: AOAM531Sx79ojzOx4pLp/zXaJEVEYrIiguNbkjIq0TDOGSgMnrirof7W
        cjpJzYy2mVs2qY0uZF4BLA4AqBUKa0LlUg==
X-Google-Smtp-Source: ABdhPJz8SyBo1RX92xF49AhFTV3BqR0FC5DwFrUN23IIQ1Vim/H9NC7K0PDXzYiDOKSkvVh6fA2QIg==
X-Received: by 2002:a17:90a:9912:: with SMTP id b18mr1531400pjp.120.1611598507845;
        Mon, 25 Jan 2021 10:15:07 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id o13sm16813902pfg.124.2021.01.25.10.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 10:15:07 -0800 (PST)
Subject: Re: [PATCH 05/10] block: do not reassig ->bi_bdev when partition
 remapping
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>,
        Song Liu <song@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-bcache <linux-bcache@vger.kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" 
        <linux-raid@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
References: <20210124100241.1167849-1-hch@lst.de>
 <20210124100241.1167849-6-hch@lst.de>
 <dfdff48c-c263-8e7c-cb52-28e7bee00c45@kernel.dk>
 <20210125175528.GA13451@lst.de>
 <2b600368-96fa-7caf-f05b-321de616f7c9@kernel.dk>
 <13667b22-029b-d7be-02da-96fce22cfd8f@kernel.dk>
 <20210125181349.GA14432@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1c0fabdc-9b73-dfd7-f49d-c211d58cbf12@kernel.dk>
Date:   Mon, 25 Jan 2021 11:15:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125181349.GA14432@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/21 11:13 AM, Christoph Hellwig wrote:
> On Mon, Jan 25, 2021 at 11:03:24AM -0700, Jens Axboe wrote:
>> Partition table entries are not in disk order.
> 
> And the issue shows up with the series just up to the this patch,
> without any later patches?

At that patch specifically. I bisected it, and then I double checked
by running the previous commit (boots fine), then apply this one, and
then I run into that error. So it should be 100% reliable.

-- 
Jens Axboe

