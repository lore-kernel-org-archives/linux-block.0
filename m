Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2906DC04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E275D20862
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VWflfrzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfEPOMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 10:12:46 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34874 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfEPOMq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 10:12:46 -0400
Received: by mail-it1-f193.google.com with SMTP id u186so6505540ith.0
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CZ5zKe+6aaCyZlPCuGCRPvDSVoeQjQ4UXVU27yKfTIk=;
        b=VWflfrzoWp8eecwsn+S1CLQua2ifmxZ4HA84LCP2cf+OGJcfF4DupD1bhTH8b4JJZ9
         /OpkqcwYS9RCbf+9WiJRjEaXDGcnhPKjDCwjBz68ix+IBr+DOAGvMD66nRA0PzYodv5l
         vn7KcnDZl3muIPj0lRSJA/2FCTaKLNjejF8d5TDGuEasGGqkxwPOociQfnC9X3Imk8MO
         Lvt2PwRIxtPH+jyXO+x+l1takQu315m/g7czWNgqx271QX2DqSp2u5ewjHrjh0rSlBu0
         Sjsc7jC9s8QyBsgSWbqkG1W7y14bUzIcZw2waW9pXhgwpEEArU3lLvjraJeeJgkHAnl4
         UDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZ5zKe+6aaCyZlPCuGCRPvDSVoeQjQ4UXVU27yKfTIk=;
        b=CF4aWI0VgezzaDaeDGRwPusRKJbpu8/t0M3TBETVaO+4gz8OPKCXk3gcZKterHqOX7
         /sWeqLP0BbjuiIdedFbArG1D21TvfuspZM04a4YBwnMLTTxYPgr8rmi/I+IARseIYcvK
         DuFLrIBXBSBvS4wwzqb1vCojK8X1Y17sbvIQmujpKDSj9yq3XfCJdE31vW7Y6eb0lbD3
         b+4FFxyX7PFXL4Q5casdtZUsUwCzrCTtW+iuLt1tZ7A7zj4WUVZpKNWDck0md5e7KmBU
         u5HvHZWEFN8YZNqS3ZTid11BE6YU/opbJxC+4aQA8ednpnVKzbQJJcLyOWOjb9nFiCqs
         uq7w==
X-Gm-Message-State: APjAAAXU9YcdK/VLUuKSnhcTPRlGe/Lb22tpKxpRncNMXYwBanCJiSou
        OqAsTtH7YekPPWYveFdzTas7JaXOJbLinw==
X-Google-Smtp-Source: APXvYqwG/0fVlXGGCtEp8FRBHGn1+0MmiLe1GOMGpjSU7LvV6R62p56K4RnVJG8kFLf2t8ssHmGHCg==
X-Received: by 2002:a24:2758:: with SMTP id g85mr13464455ita.30.1558015965140;
        Thu, 16 May 2019 07:12:45 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w194sm2052487itb.33.2019.05.16.07.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:12:44 -0700 (PDT)
Subject: Re: [PATCH 2/2] io_uring: use wait_event_interruptible for cq_wait
 conditional wait
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1557978391-26300-1-git-send-email-liuyun01@kylinos.cn>
 <1557978391-26300-2-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e2c00e5-3fef-a450-1a1e-4d29701e379c@kernel.dk>
Date:   Thu, 16 May 2019 08:12:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557978391-26300-2-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/15/19 9:46 PM, Jackie Liu wrote:
> The previous patch has ensured that io_cqring_events contain
> smp_rmb memory barriers, Now we can use wait_event_interruptible
> to keep the code simple.

Looks good, applied.

-- 
Jens Axboe

