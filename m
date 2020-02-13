Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BE5C2BA83
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 15:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBCF20675
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 15:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yfTDxgF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbgBMPyM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:54:12 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41502 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbgBMPyM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 10:54:12 -0500
Received: by mail-io1-f68.google.com with SMTP id m25so6983997ioo.8
        for <linux-block@vger.kernel.org>; Thu, 13 Feb 2020 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eIvReTS3Qjoh0tXO0AZKe1IM/rIuvGtF5twfce7QiCo=;
        b=yfTDxgF5SWS1YF/UN8zpFCafDUZ34uo7IijCnGOq7x+ywJ6GYoR0yEgM9N0bBZh779
         6vCbOxS9Rcaj64jVYUhxsx+DJc0rNF/Ux7L+QxyNe9tD8OpRzknH2xFIaxzBUjoyRBOc
         Lsj0JMiDGvIFJ+W5IOr0cuv2kc8oizSmIOorW8Hsnmr/4NtdvB6Sz0oUIoMRzpM+5ELG
         Gox5JRXyCYcdhJX/tkLK3JSW21B0DVlRbbgZv0250D7zNWzVjkJmhjeyYsxnj2dkWYYB
         19qQOa7wlTyJ9REuObU1HR6Bt0hEDlJhhKF9+ogoXAoj/WhQZ2vVX22ifNWgBTlkuKLS
         pLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eIvReTS3Qjoh0tXO0AZKe1IM/rIuvGtF5twfce7QiCo=;
        b=ZPGNWtnv91y4v1wi4RQ7otd+0FebB6f+RpLpMxbVlw1g85vOy/03JOSGiXyiWYeJH2
         9MxFRjeTzvFtnu8FfQj2d8VmM8n7SGBxM1PHAWC8oUBkbbBXJbaNUVTReYEOWxP5vo0S
         SzDmjOrzedip3Nfv88DdLfYZXxy/ksi+UYzQJ9al2piV08798VhrHdKEeEUOq/vjaueM
         B7zAPALDD70LWLp2e3tfqcRbB838W+RVA8g51R60fPv75AGtcz1do0+lgwelULT42Zrr
         cYW0HxnKm5rglS34M7uJYpP9Ilp3WshuhQX+lT9x0iUyrNKcfqVdH4g1fTIjVnvJlesv
         z5rg==
X-Gm-Message-State: APjAAAWyL5oRfHL/qTIy7FQaaZNr9CpdGZsR+iwU4zMFZ+mFHzFMGNJr
        VYIXtmJCbp8cQT0FrO0G0CWEZNVChcs=
X-Google-Smtp-Source: APXvYqwGZfN4lk7ulX6F2FpaVGaM0d9VzIWAe4IBRaj+EZElMpyCZOm5zkJxHU69QZ5e4rG89Wqelg==
X-Received: by 2002:a5d:878c:: with SMTP id f12mr22741292ion.164.1581609250827;
        Thu, 13 Feb 2020 07:54:10 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f16sm987752ilq.16.2020.02.13.07.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 07:54:10 -0800 (PST)
Subject: Re: [PATCH 0/3] bcache patches for Linux v5.6-rc2
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20200213141207.77219-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d724bf95-31f5-ae94-9774-d978c00ca544@kernel.dk>
Date:   Thu, 13 Feb 2020 08:54:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213141207.77219-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/13/20 7:12 AM, Coly Li wrote:
> Hi Jens,
> 
> Here are 3 minor fixes Linux v5.6-rc2. The first 2 patches fix
> kthread creating failure during bcache cache set starts up. The
> last patch is a code clean up.
> 
> Please take them. Thanks in advance.

Applied, thanks.

-- 
Jens Axboe

