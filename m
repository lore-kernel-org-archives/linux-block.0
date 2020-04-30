Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57E8C4724C
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 14:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE1A2074A
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 14:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="R2kzMJS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgD3OwM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726357AbgD3OwL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 10:52:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A458DC035494
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 07:52:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id f3so1764253ioj.1
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0obuZL34SNwf2OpV1DaozbHGWW+DMGnoweGGUtL7lnk=;
        b=R2kzMJS19NaHc3zKiMbq7fp+B2jy0ImQjyhXkFCwfNlQ2LT0FJsbKEdADkX4Z3xVoR
         oexBVB9nSWNaePlolvTQHO5ODuzDmQHw+uLu0/36sl8QlBnHkALPwMjGx5dXIp20Nr3R
         QJ9oT2yxBR9k2kYGbJB+gC1z4SfPsSxXToK0MtY8Zwcq2PmzPTn91q6qBW+hHrcLiL0q
         tenoc+Kadi57+9BoH8X1V+V9pEo48rVRvtkJ5AgH0T1bKEoeCUgPl3wKJ35m+LyWxpVR
         NTbLouoLI1b15yeoG3g0EF13mp8LCXspl9Mle8N0kmQ795mBuoDE6BFbHOSM7BGMVsPx
         ZpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0obuZL34SNwf2OpV1DaozbHGWW+DMGnoweGGUtL7lnk=;
        b=EYSK5u8M4cNqdass0rZU/vbz8K0KgbrFzgSLxpnT0mG0ImXQm5iwHucEelhVz/SD1Z
         ruhs3ahfdw9jNQDqgRjuwWMvA48uIsjnjWlMGa2VT4eLSwhNA8KVkALDBgqDdImoIKYf
         LUYIEaMYrguOm+bNv3Mk7I1vZP6Tq0PSadSr4henDOyi1M0JhbR9LcGdcUiKfdpS6cpb
         c1txi4rx8JaoDXqzXUz7ZozgnnO/mLzahLFfOHwDNnQn0Hzie0FGhe7MRvV2t8+zjtq5
         7xeeMuOZcRpIrV039QAbAPa/OiSG2blKggHfvuSY3AUa3evwREudwupif3PdEb7TND3J
         UoVw==
X-Gm-Message-State: AGi0PuZwfEarF+5g2zV5xHVMyufIuViUa5LxCL9yoioy40RmS6aevZkn
        zA5qwCyCBCwLtAJfBJhEbQkZHodwgb0d+w==
X-Google-Smtp-Source: APiQypJRrsCU0fYkLMpSGCf1HO4/iNTTL+no6pN3tuk0PwK/xBUDMeNwxqpf7qfT31WuVWlBqJTXGg==
X-Received: by 2002:a05:6602:15c4:: with SMTP id f4mr2352752iow.108.1588258329707;
        Thu, 30 Apr 2020 07:52:09 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f28sm25046ilg.52.2020.04.30.07.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:52:09 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: use proper references for fallback_req
 locking
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1588207670-65832-1-git-send-email-bijan.mottahedeh@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05997981-047c-a87b-c875-6ea7b229f586@kernel.dk>
Date:   Thu, 30 Apr 2020 08:52:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588207670-65832-1-git-send-email-bijan.mottahedeh@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/20 6:47 PM, Bijan Mottahedeh wrote:
> Use ctx->fallback_req address for test_and_set_bit_lock() and
> clear_bit_unlock().

Thanks, applied.

-- 
Jens Axboe

