Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C398C4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 14:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579FA2396D
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 14:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLQOkn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 09:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLQOkm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 09:40:42 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E1CC061794
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 06:40:02 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id h16so8937123qvu.8
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogKrrKV+TtPAoHoe1fNFHNXZOViO5iz6ZfC2TYW45N8=;
        b=Pl7wuENL1WXAOmI3oAr7e3G0ftZOy0UJnMXLzfBoNOITEZzYSlo7aERwxA/EeUKoMz
         ti6yCuHQjAwzdyfBChT6twoLznkaOBtJc8ujEeQcajovGNu7WTg8lAIy9Z78uqz2NNxY
         OiOV/xXpG8DPNetyLNzAEWR3RTfD/RPacp9D1TJ+Wn8NuM2vyMsMQ2oa692slXzuIGmy
         nzUIXg6Tg/LUzkwjvQHX8mIsTJ473mj4KnDzrL/IYCXQoGKlVsJO/4tdICs6pjj1IwJz
         r1qAs/UQDJWlepedS+oOkGCUKRrD34J/9oce1WJo+hnrsPPaoRbhlenp0mhm1F6CV4H0
         68BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogKrrKV+TtPAoHoe1fNFHNXZOViO5iz6ZfC2TYW45N8=;
        b=qZgnQvBgvzBxbP3zDBc4nu4Np/mwO725kWgTGUuNm1NT1/tL4Op3R3eCwcWSfDr+BS
         6i4INyXSr8yPjG4hMC4+YFrtf3vm4fLGIWI7mlZFPyoZvk/QJJ09xAVwMZdTwxj1IJZB
         YDJVuWB7xY7tsmS7Czr78d1qYCqIYHnQGYaG1v8iqK6PU8YHnLSl68w5rW7f8+8Sdwld
         KlqVj1uNEGSLMhuc3hrBRq7j+08dhuXI/lpPGvU4vISGBApJ5p5uLxb5MyO0EcrOBzJo
         +V+G6uRt6svb0Y+4FH625UnpsYXA3/WkuDtkWZ1jWxlY/j72CEqaEBXLOJ+qe551Qys8
         hOXA==
X-Gm-Message-State: AOAM533VErB9DZlNx6HVu1FA5ove6zNR9XslSMBQqYp/uA/97Tp9KMS6
        uskCRhSX2irqoASgEE1hFxKZcg==
X-Google-Smtp-Source: ABdhPJyhCQrkFX8vgTpp80PgQQn0FKyq4tiJRCeZN0aCSqHYvGuPdcnGrVYPnsRFStx29qWurmvMgg==
X-Received: by 2002:a0c:fd89:: with SMTP id p9mr22656398qvr.8.1608216001461;
        Thu, 17 Dec 2020 06:40:01 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c28sm3248644qtv.2.2020.12.17.06.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:40:00 -0800 (PST)
Subject: Re: [PATCH] nbd: Respect max_part for all partition scans
To:     Josh Triplett <josh@joshtriplett.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <86d03378210ddac44eb07ebb78c9b0f32c56fe96.1608195087.git.josh@joshtriplett.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <33c35aa8-b698-7141-6adb-ac0b76edf758@toxicpanda.com>
Date:   Thu, 17 Dec 2020 09:39:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <86d03378210ddac44eb07ebb78c9b0f32c56fe96.1608195087.git.josh@joshtriplett.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 3:58 AM, Josh Triplett wrote:
> The creation path of the NBD device respects max_part and only scans for
> partitions if max_part is not 0. However, some other code paths ignore
> max_part, and unconditionally scan for partitions. Add a check for
> max_part on each partition scan.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
