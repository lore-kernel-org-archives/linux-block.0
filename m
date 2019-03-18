Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1157AC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C961F2085A
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tSAIpPkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfCROVm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:21:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52350 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCROVl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 10:21:41 -0400
Received: by mail-it1-f195.google.com with SMTP id g17so20689799ita.2
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3+eAWS/Rmc6f7GwRJVmc9nC5CxO0UcnP7Zod6D16lqU=;
        b=tSAIpPkB05uDR+b9SKj/vLk1S5eLFEW6C3+lscD2/hWQRnnyGnJKV8tOgvBccDQs04
         LuMo6kTjA06s17gxwj8At93ZTi3DZUFUAfE+ax9aOCjLgy6VFiS1KUdD+Ssnu4FcEH2D
         wRo2gaNG6GXj5q4IJTsoc9/JwJ4WsqAoEmKKqeyLZmDosq8Rq5AcqdCDST94l11KHRJU
         RjDXY5me8VOVc0uT79cpV8pW4inrGeO7WxgSL+MhbkxEcJpY/GYgffGWq/Zfb70zvm/s
         Jk0LaCH05tP+vlJs2b/WcPS6YZSaE4ZdvtRG9ET9WmyLJA5i0+Yt8NDDksQTT+k2aCwx
         PakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3+eAWS/Rmc6f7GwRJVmc9nC5CxO0UcnP7Zod6D16lqU=;
        b=Xkqlg32u5BenVI5kIMeZ8faPQZD0SRx0F850qVB/QBI70GTy6mPZSmuu1oeQZElAKy
         tspOp2h3OcNWMkBmU+GF0iYvBAcQ9K+5+UYe+mqs7XYE709D6Dh7ELB5yT1C38RbZh2/
         EHe4RyY/FUXJ4GjbN3urFLg33x7rOWEEC29W4rWPFyfOMYO7DupmFGiCk4300NIVm+m0
         3uJcZdw0xR8OSPbFpHeEAcg3KCVYv6a7Hp9W07XBAEVAZZU8kSUKssXW6c4EL0kZUlXn
         U0Tk4ofKCk8qyIaB2C4k/Nn72BS8IBpbIkVYhxvrqYC46zsc/DCQAYYmEH84PCiBrqis
         Vk3A==
X-Gm-Message-State: APjAAAWQsus5e9qgfqdeAm9tKdIsGPneLSl1ZqIBxsM5I8HwnOKhwudn
        nXKaM94qegRBUdoiSK46nRsQ7xbW6wXS2g==
X-Google-Smtp-Source: APXvYqyYuaYDqCSh8xnnjVgv6aCwNdZGp+Qz387KHmKQwg1GeVczfDKJkSVkUVLhkpe50aByitngrg==
X-Received: by 2002:a24:1747:: with SMTP id 68mr8917990ith.62.1552918900809;
        Mon, 18 Mar 2019 07:21:40 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t74sm186626itb.11.2019.03.18.07.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 07:21:39 -0700 (PDT)
Subject: Re: [PATCH 1/1] loop: access lo_backing_file only when the loop
 device is Lo_bound
To:     Dongli Zhang <dongli.zhang@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        penguin-kernel@i-love.sakura.ne.jp
References: <1552911797-20455-1-git-send-email-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2debdd71-c444-a04b-c308-097d8e51ee4c@kernel.dk>
Date:   Mon, 18 Mar 2019 08:21:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552911797-20455-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/18/19 6:23 AM, Dongli Zhang wrote:
> Commit 758a58d0bc67 ("loop: set GENHD_FL_NO_PART_SCAN after
> blkdev_reread_part()") separates "lo->lo_backing_file = NULL" and
> "lo->lo_state = Lo_unbound" into different critical regions protected by
> loop_ctl_mutex.
> 
> However, there is below race that the NULL lo->lo_backing_file would be
> accessed when the backend of a loop is another loop device, e.g., loop0's
> backend is a file, while loop1's backend is loop0.
> 
> loop0's backend is file            loop1's backend is loop0
> 
> __loop_clr_fd()
>   mutex_lock(&loop_ctl_mutex);
>   lo->lo_backing_file = NULL; --> set to NULL
>   mutex_unlock(&loop_ctl_mutex);
>                                    loop_set_fd()
>                                      mutex_lock_killable(&loop_ctl_mutex);
>                                      loop_validate_file()
>                                        f = l->lo_backing_file; --> NULL
>                                          access if loop0 is not Lo_unbound
>   mutex_lock(&loop_ctl_mutex);
>   lo->lo_state = Lo_unbound;
>   mutex_unlock(&loop_ctl_mutex);
> 
> lo->lo_backing_file should be accessed only when the loop device is
> Lo_bound.
> 
> In fact, the problem has been introduced already in commit 7ccd0791d985
> ("loop: Push loop_ctl_mutex down into loop_clr_fd()") after which
> loop_validate_file() could see devices in Lo_rundown state with which it
> did not count. It was harmless at that point but still.

Thanks, applied.

-- 
Jens Axboe

