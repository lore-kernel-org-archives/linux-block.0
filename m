Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5415BC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201ED218AF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RF5mia1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAXSLE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:11:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53279 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfAXSLE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 13:11:04 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so6447498ita.3
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 10:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yv3l0UjgLDkklzmGFgbcuHG+uAotlZ+Pw7UY9yLIlU4=;
        b=RF5mia1r5TmVBcOpce1Qar48lyntl54LNpfUPqziMMYM3ex64X/z7ADx/ZD/J1oH0o
         ix2o7MTdO1qgPvj17Jv/5EL/7zYp6l2eeecqPVrKwHF4E7GJ5JxLWdrdpjt1aJktwbOi
         dyo1fpfNixZjYe0Ge3PeELGB8tmzc4dK1UyXel3w+e7WKiRqgrqQz0Ps1MAQ9eqeNnFU
         yR3LfFC5FaEdvk9Aq1CFHPPUK6JtzB7E06SHoM3zZtsaGVQnbH6JtgODMvFcHa7qWcHM
         w6f1F1iUYVUkiW6kPOeflM4g8sI8Dw3ajBByL5h4lOdLTaroOdp/b2rkCGGYpiyI3/SP
         7rmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yv3l0UjgLDkklzmGFgbcuHG+uAotlZ+Pw7UY9yLIlU4=;
        b=mTUxqG4SVxxNYH+FDioI6PLfKSbJEXcOo68ygIQsz7w7Gb52bvxtfkKMXFjVN1Jqh0
         9Ef6B+Luhn8TbC+lBO4hv1r8tP65oeNSu8w8DIzgTEz2GZmupbT72ik2qv6lK7bkMKaG
         nTo+hnOxdXzW2Y6ciPsfAE20OFYHaGbLSfNJRbHmLGKhxnTmuaQT+McSKIT9/NQyuTKS
         t3sNAca0R3++sNoUqErk7JUWfGJCo1yudTHY8KlZnqiKcVZSACPJyLKiMDDBf9aoraau
         07DcmM+3Vp/1X03UZOXRJhWiSYz3LsWZ96nlQjkFWnluLVqFPJRC551FXren5zXSwGvs
         q77Q==
X-Gm-Message-State: AJcUukfu3M++cD9Q7wZQgAt0uG3GJqve6ENZZhUZpZUoMSDAJaI+UY9T
        NXAeZ/NJcvPAg+/kIV+ldva60z57h6c=
X-Google-Smtp-Source: ALg8bN6CC0BDoEclbzxirFwaMQTle+iObw7iCKf6KTq4a/juY+fDZfuZn26AlYznHQBHlouD84BwFw==
X-Received: by 2002:a24:6192:: with SMTP id s140mr2031239itc.97.1548353463403;
        Thu, 24 Jan 2019 10:11:03 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a10sm11567865itc.3.2019.01.24.10.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:11:02 -0800 (PST)
Subject: Re: [PATCH 0/3] iolatency bug fix
To:     Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20190124001655.92508-1-bo.liu@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d2ccb98d-2880-5ba0-8871-f92f1a6f60c8@kernel.dk>
Date:   Thu, 24 Jan 2019 11:11:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124001655.92508-1-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/23/19 5:16 PM, Liu Bo wrote:
> This set is to fix a hang case if blk-iolatency is in use.
> 
> The 1st patch adds a warning for unexpected inflight counter.
> The 2nd patch explains the hang problem with more details.
> The 3nd patch is a cleanup of blk_mq_freeze_queue.

This is much better. You'll want to reorder 1 and 2 though, it's a known
issue that we can hit the underflow condition before you fix the issue.

-- 
Jens Axboe

