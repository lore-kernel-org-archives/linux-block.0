Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE431C00140
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 18:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiGZSWI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiGZSWI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 14:22:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B6224940
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 11:22:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so755843pjk.1
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UI/OSA2Nkzzb3jXRB2HUYuZlIW1YoZHLlMWH//r0FHQ=;
        b=61h2chFjRK9qMnSsbjw4sASCXmN2H9Fas5orWT5lT9vGOb0iS7nuKKNBtIjB+w23fu
         ARsumdyf7wSWufnNsxN1xvs2dWNgBVOtcaLDAQzKspyjf21kgTRjHJSnIIPEbjJ2RYOZ
         P9cf6+U+87E8kn36N0R18CC8tekumbIVD12gVU1sztQW9XQ2HDy4aiJt6HN1TkVY9708
         icU4F1TtbpLA9+Umf4P6YfoH0ikFmaNL7YDVTKMZqnCUY3rZc17VkAKCI5GjBuQ+cpQm
         F6Km1E2rKYWe9I7XUkzUbf01kGW1kJbZAB5XL+svRryzjemy1giBNCzogBYE8Em/Tcu6
         0xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UI/OSA2Nkzzb3jXRB2HUYuZlIW1YoZHLlMWH//r0FHQ=;
        b=JyRVtsh8UlefjiGROmzboZ2NZmZtoJ6MNt4J6NX7FPMhkzuZEVN+iQp2TFGRnT/VAy
         swB9NnbYaYtbjMeL/mdl8tlJGGxaUmrrL2MrBr93YiIAaIhwiulxTfyiQa/zuroCA3g5
         TbLhMhbD3j4O1ScLkyYnBgUSNHfN4WOzHaz0eurgJYVXy97asfS9nta4ii6NfHdDe43C
         QzMn5+3cNyqqKvbJaJ/Y2+XXJe4Yq0P0TD6c/Pf+J/9dqGzbs//SCZHgM93HtmkjKW/M
         rTgzmFVXqno9Tk+tcvhpc8yZiTQj72/HCa3k9QB8hW2XXJiT6u7tvljd1avxDGv+cbC0
         bclA==
X-Gm-Message-State: AJIora/hNJPVIE5D2H4sis/D2StTV/1ChTSdWdOemYD4HKfuapaDv4B2
        zhC/4+1gzlM1kUX9eHtz9EVS3fG3pLNnMw==
X-Google-Smtp-Source: AGRyM1sxyD6llXa7uOJFkWKjE+98Va/gmwu03tLOe2nZ6tRFsuEaiG3UFIUDv5/EiTjnICMdHR+O6Q==
X-Received: by 2002:a17:903:230c:b0:16d:8b52:e60b with SMTP id d12-20020a170903230c00b0016d8b52e60bmr7077207plh.160.1658859726234;
        Tue, 26 Jul 2022 11:22:06 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b0015e8d4eb231sm11920771plk.123.2022.07.26.11.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 11:22:05 -0700 (PDT)
Message-ID: <16f5d4bd-283d-9622-8da7-ec8a9ee7048a@kernel.dk>
Date:   Tue, 26 Jul 2022 12:22:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: bio splitting cleanups v2
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20220723062816.2210784-1-hch@lst.de>
 <155c447e-9e4d-8e07-0810-c58973d65bae@kernel.dk>
 <20220726110511.GB30558@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220726110511.GB30558@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/22 5:05 AM, Christoph Hellwig wrote:
> On Mon, Jul 25, 2022 at 05:06:19PM -0600, Jens Axboe wrote:
>> Since this clashes with opf changes from Bart, would you mind spinning
>> them against the for-5.20/drivers-post branch?
> 
> Actually.  The conflict seems to be that for-5.20/drivers-post still
> has the blkcg_bio_issue_init in __blk_queue_split that went away
> in for-5.20/block.  So while I can resend against drivers-post, that
> seems somewhat counterproductive.

Can you make sure the series applies to my for-next? Then I'll create a
temp branch for it.

-- 
Jens Axboe

