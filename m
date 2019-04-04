Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF525C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 14:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6812147C
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 14:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ytkjuPb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfDDOh5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:37:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44330 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfDDOh5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 10:37:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so1334422pgj.11
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2019 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2nsBitIrQDU00C7pV7eoPW99k5WkEBUd+i7nBmDCTKU=;
        b=ytkjuPb2YgAN983gXFG8uvfmjXWj2iI9akDbFpg2hMOO80E8vd/vfDWUsJeCcU9gmY
         BhjF1RivYDQRxV2wjBuSM0ZZm4G3CM5p+2mqfIDHrWO2tVX221hg6WLXfqQJ1Rujt0bn
         0LFx1ggs7uL9aJw54MYM195RLrlHrWWSOD+LMvACZCnM+r4+88bkiEgBQT7E2T9txgEs
         3Yn7L5kEdzN5ZdyjFMy/0CtJh4yxPH+TIHyOhGA9Nw8Al1ER57pMHJWw7yJc4luPtj4E
         3kI6fWyE63/cnmY7oYwoqgcL/WtRD/8l4wu+SNkVUdENRpBz8h+ARiZAAPuM9cVTtef0
         G1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2nsBitIrQDU00C7pV7eoPW99k5WkEBUd+i7nBmDCTKU=;
        b=GzjLUawkYS2J7ipf5qtHNwI2GKEGSc1/UiyybMTxM7+sUf54DwsOOGOfPq02dt8jPh
         jqsg9YQpDQ6kAM3pDo98t0XzDH1zmbKwR9H28EZeWxi+gEjJL62YA48jez9REQBHkDJy
         9QKqwzIn+wMIuzMqi6Wd8MdnAGQSOiQsxBlelh9v2oY5ZoqL1dp7B3MAoF9NxRnCIo+f
         e9c387Je5cHkJxfyqz9NGkPkijQQCrSpfqHa8eTv1AoA/EriKHjut6/vSaWuPKgqpVRg
         pR8WO8fvMux65kJERoKGWWTa2GjfB4pueb/1NXk1DDQzh+ROc1Sm3od6wqA80cR61Ysx
         4C3Q==
X-Gm-Message-State: APjAAAXwP1gzm895/HaJLkCIqwW+KDzfBVIdOAVgzT/6ZJ0j95AsgNFW
        dpIUxwTgueQUi/Wckrb+vCuoAIQSeXU=
X-Google-Smtp-Source: APXvYqyvIO1lIEAGSdrkoa/xRd13DwIICrCmZzv2bbqLIu3kW96kRtpq8sXNOVPeFhKe1827sznBUw==
X-Received: by 2002:a63:28c:: with SMTP id 134mr6359794pgc.278.1554388675463;
        Thu, 04 Apr 2019 07:37:55 -0700 (PDT)
Received: from [172.20.10.3] ([107.72.96.208])
        by smtp.gmail.com with ESMTPSA id i15sm25043254pfd.162.2019.04.04.07.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 07:37:54 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: do not reset plug->rq_count before the list
 is sorted
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1554346664-24038-1-git-send-email-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e5c00bf3-79d5-b0eb-f38a-a912c5f85c33@kernel.dk>
Date:   Thu, 4 Apr 2019 08:37:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554346664-24038-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/3/19 8:57 PM, Dongli Zhang wrote:
> We would never be able to sort the list if we first reset plug->rq_count
> which is used in conditional check later.

Well, that was pretty stupid. Thanks for the patch, applied.

-- 
Jens Axboe

