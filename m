Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D71C47088
	for <linux-block@archiver.kernel.org>; Thu,  1 Dec 2022 14:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiLAOpN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Dec 2022 09:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiLAOpM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 09:45:12 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E18FA9CDF
        for <linux-block@vger.kernel.org>; Thu,  1 Dec 2022 06:45:11 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 135so1145453iou.7
        for <linux-block@vger.kernel.org>; Thu, 01 Dec 2022 06:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Myk/frs+/PELrl6SJ0tjbXBv1A0UiyxiM57+8qkIPRQ=;
        b=1ECiSr8xkZdZ3I3qIBsqirwG1tY438zDjWMz+rcqOhOrQuIsHCG5dqU7kqNh6TeQSB
         oL2kLPhOk4vJCGLYgdT6XTKtlRlcKnStUKqXpkdx4VxlW00GVDbp/PnM16fCHGUB2Drc
         FEgseG7EChDvXXcNU/DiPKEpyYUu8TuWl0/nCygoIzPyrQ+cXup8ieVQrGl6k8Gqngrg
         xm8CoZNYAv3uqncmLDhZNg1rLGqGLeAajZiZHOHvQtZ7YxM/KWLr+XfR7TXLoBGz98SQ
         mgtVWuRQKFZDIcy72KpI+Z+mVkLzhgxl70EmcBKi7FIX2aGVvEgvFUkUOYIHz4ms0l9F
         s4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Myk/frs+/PELrl6SJ0tjbXBv1A0UiyxiM57+8qkIPRQ=;
        b=ezx7WBoQwlgbthF0HkQoNmGFkoSeTZC+uy8arHoTgaQchfn6UBk5u880BIIaRjJgE/
         wEm8/mwOriCX1x75kdPx0/an7TgshprzdVo5TZ35pFykTlUzR7zb5+5DOP9ALvV5GIkn
         ED0QVFhvR78ryQF12PoPyvOGmixOF+j/lRyGG/237xB/0UH55YofCnLWmI5RQODSfh5G
         4Rk01VNY1C7Lhr/9nTHqINHXl4rJd0ajLEqOEzBBlJd3DFKoCJ0mS9N0hO1dxjwr2vMA
         rWa2jkJUIwtHs7oVabPKkCM03oB5hE752ZyR4U4hjF1srAizRBpaxm1VJtFB7YEH7kBC
         M2dw==
X-Gm-Message-State: ANoB5pklVDWU2CW31ss84JUOY8WYLP3GO7eTi7CIDPPpOj5s1UgOBC4X
        lMjKzASb7J9qEeY0M3EMVbMvHw==
X-Google-Smtp-Source: AA0mqf6PS1vyKImmIJ+s988DaGJbXthqY5i4AUmTUIw7FcXoWmIpIz2g4Iwm7mhSnDK9kB6uKcNmHg==
X-Received: by 2002:a02:c881:0:b0:38a:f6b:76f9 with SMTP id m1-20020a02c881000000b0038a0f6b76f9mr1836013jao.180.1669905910873;
        Thu, 01 Dec 2022 06:45:10 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y17-20020a056e02119100b00300d3c0e33dsm1589519ili.4.2022.12.01.06.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:45:10 -0800 (PST)
Message-ID: <a3c9044e-d7ab-8130-76ea-a09152eacaea@kernel.dk>
Date:   Thu, 1 Dec 2022 07:45:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] block: Fixup condition detecting exclusive opener during
 partition rescan
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        stable@vger.kernel.org
References: <20221201114442.6829-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221201114442.6829-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/22 4:44 AM, Jan Kara wrote:
> The condition detecting whether somebody else has the device exclusively
> open in disk_scan_partitions() has a brownpaper bag bug. It triggers also
> when nobody has the device exclusively open and we are coming from
> BLKRRPART path. Interestingly this didn't have any adverse effects
> during testing because tools update kernel's notion of the partition
> table using ioctls and don't rely on BLKRRPART. Fix the bug before
> somebody trips over it.

I folded this in. It's funny because I did consider this when reviewing
it, but then convinced myself it was fine...

-- 
Jens Axboe


