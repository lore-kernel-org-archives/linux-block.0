Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE11C28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244F92416A
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N3XcJ43e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfE2Ud0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 16:33:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51821 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfE2Ud0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 16:33:26 -0400
Received: by mail-it1-f196.google.com with SMTP id m3so6255601itl.1
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 13:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3lMbQjLFFefvrRYspYY/REyhMYMiOizpemBpfNsWqvU=;
        b=N3XcJ43eAGEJAS0KIoFQDT/qHU//+lpv6dUSzqGcGd+Oy8n9w8NoWijXEOA+clfbwl
         hQ0NelSWykh/gnUUvrnpzxMHfnqvpjf5ZuB9KJJYVwdinBc3r25Lkbh6DJrskuRAL6Fp
         byMssHGiFI/0M6zZGu+ZGGpezHzhWs9BQMdGV/uokzkyU2Zh2x49KR/T7vmR0s056KJR
         Pb5tzVI4I2z/R6TtstAqqCBMbyHKIxm5X2uhKjxosgz1oTMlMbVFxu5jkF9sFqaF2QSS
         Vu3WPUgCeWFQ2uVSPeds+J22rjUztYquNXUA5MFYI/NrPxJfoCM4A0V85uoDkRJNpbZh
         a5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3lMbQjLFFefvrRYspYY/REyhMYMiOizpemBpfNsWqvU=;
        b=qVC4I3Knw+nSFi7eakcnugs4ahW99b0CIzNFbE1X82baWUt0g45yT/5FerJmdUp457
         RUOp5hLC27krf88sb41G2SPUOXkuZE/3HbukKmY7Rclvjti7NzBTbTQE0vdaHmHRTZZT
         eAV52/I5TOTfbXy7QocPTE4KGnHLHsHv5nCIPpFtBlv/xyCPK+nmP7r/OiYyVCqKFPJV
         0tCtiLim/CS70P7igedA6jZHir1uHcioeOcAnChNeNk1JeLQ1N8DICVjflqbzx3AVLO0
         g4AYN6pr5kMCWCKDb/4ZiuZWK4StpqdpCYUO06W2dlMi/S8y4JU1uqSTYlDi+04Nmzun
         KxJw==
X-Gm-Message-State: APjAAAVydtIsckvqMsZiCdy/pr5qfECEoHAXMAXtWVaPqXDwXkPpNQ7j
        BpG9mH/ZfVJaGec7aTx0DcrIDclSf9WNqQ==
X-Google-Smtp-Source: APXvYqz7LElgtrLAMCrhGsTHZT2hqSzE1H4Edmu1j34hJAScCMjQ1IURLXTltZ5KSsgw0wfrWvR2Ew==
X-Received: by 2002:a24:ac49:: with SMTP id m9mr157468iti.174.1559162005460;
        Wed, 29 May 2019 13:33:25 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h26sm194913itf.13.2019.05.29.13.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:33:24 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: Fix memory leak in error handling
To:     Jes Sorensen <jes.sorensen@gmail.com>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Jes Sorensen <jsorensen@fb.com>
References: <20190419203544.11725-1-Jes.Sorensen@gmail.com>
 <20190419203544.11725-2-Jes.Sorensen@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b3a1029-233f-71c4-acf0-9c501db47201@kernel.dk>
Date:   Wed, 29 May 2019 14:33:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190419203544.11725-2-Jes.Sorensen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 2:35 PM, Jes Sorensen wrote:
> From: Jes Sorensen <jsorensen@fb.com>
> 
> If blk_mq_init_allocated_queue() fails, make sure to free the poll
> stat callback struct allocated.

Applied, thanks.

-- 
Jens Axboe

