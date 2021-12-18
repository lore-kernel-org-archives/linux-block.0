Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6C9C433F5
	for <linux-block@archiver.kernel.org>; Sat, 18 Dec 2021 19:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhLRTCl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Dec 2021 14:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhLRTCk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Dec 2021 14:02:40 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DC6C061574
        for <linux-block@vger.kernel.org>; Sat, 18 Dec 2021 11:02:40 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id k14so4326812ils.12
        for <linux-block@vger.kernel.org>; Sat, 18 Dec 2021 11:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=08t2DeUCHk4vtVzN7q3UXj6PnfGwfhaWK3U8ZxJwbZg=;
        b=tJykmFQa77NckqkiTdtvEyp4YW1CbcuGMo16ti95h/40a2G79hSczfQiAuOEIYyN8c
         6XVQDCTbvmGkI3+E4QiBItZYq4hEKJr3kGsOa/U7dAblfc30ZQnBNJeBt1r3OZChYLZr
         FtSqn45kRgOgQNnHTv4qnBom73h5rcizxLxlG0f3P9KdrtnAv2yiS6VxSY2CRAtt3lax
         RzBApUUc+DZ4wtPmP/2GOPI4Cb2l1EZXtY4R/sldPUDjk4LP5ZijGFISW6H+FH0i3n8v
         Qydua+fKwtqh+5ELE2jyNHNWzQGNNCipL1jZ9L2EhFoWuzcKO7pS8RGB3QTXQyTbYKnY
         zqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=08t2DeUCHk4vtVzN7q3UXj6PnfGwfhaWK3U8ZxJwbZg=;
        b=NwjMS//wbv0QloGb1cyna4YbWwN/Y2GEUCLpIuFzIRqOKdOo+ZT9mgvYPtPd0JDzjX
         NJWsYcJQuwKlhQf9PFx1fyyd0nCH79BIycXltlBX+rfrixAwqA9nfbPVo+pUjY8/7Rs9
         LEDd9++LTr4p5dQQE0VfSPJsdSEemRec5lb/KuMGkPzz2R22i3ZGhG4P+uk4viDb/Ifq
         h4A1ZG9E5hguHkmRfz6JHiUaYIg+7ykFHsnDCJi6t89rAmAfCrVo7cG7rT/IftLcryqY
         NggO00iBAl1+BIhe4eGSJEpP2B3hi515mgYw9833/W0kRdxZk3N+ZVzk1ANfGbVYutc+
         5VrQ==
X-Gm-Message-State: AOAM533GpU98kpSwHDJh1yRS0FzioJ92JclRgejvpyVY8eNxKALVuTAf
        r+Qpuqlajv7NLLIGyoUP+2v8TQ==
X-Google-Smtp-Source: ABdhPJz/rgZ16dYOE3qD585NKK00+wsQqJkQU1fsPMbVXJtCrsuhJqGzXvyyqRxUulUSB4GFNfRCtA==
X-Received: by 2002:a92:cd8b:: with SMTP id r11mr4579612ilb.39.1639854159725;
        Sat, 18 Dec 2021 11:02:39 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t12sm7373820ilu.12.2021.12.18.11.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 11:02:39 -0800 (PST)
Subject: Re: very low IOPS due to "block: reduce kblockd_mod_delayed_work_on()
 CPU consumption"
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        linux-block@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        ming.lei@redhat.com, hch@lst.de, Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org
References: <1639853092.524jxfaem2.none.ref@localhost>
 <1639853092.524jxfaem2.none@localhost>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7d1e4bb8-1a73-9529-3191-66df4ff2d5fe@kernel.dk>
Date:   Sat, 18 Dec 2021 12:02:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1639853092.524jxfaem2.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/21 11:57 AM, Alex Xu (Hello71) wrote:
> Hi,
> 
> I recently noticed that between 6441998e2e and 9eaa88c703, I/O became 
> much slower on my machine using ext4 on dm-crypt on NVMe with bfq 
> scheduler. Checking iostat during heavy usage (find / -xdev and fstrim 
> -v /), maximum IOPS had fallen from ~10000 to ~100. Reverting cb2ac2912a 
> ("block: reduce kblockd_mod_delayed_work_on() CPU consumption") resolves 
> the issue.

Hmm interesting. I'll try and see if I can reproduce this and come up
with a fix.

-- 
Jens Axboe

