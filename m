Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E34C10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCCB20650
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C6A07HZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgCLNkN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:40:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40292 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgCLNkN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 09:40:13 -0400
Received: by mail-io1-f65.google.com with SMTP id d8so5678955ion.7
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VY6qF23CN+ctcOxT8JPOuxTXxCaxGAO4SxPnHgp9E14=;
        b=C6A07HZ+GsGXpVbIIOyDPfEH+UFtDj2sLTvwaYz+iKbkNGmw/bB1d3QMcuXdTQ7aHs
         /ZTVoI2hPljv5FNANV8Fz4r/GpHH8YgDGq4NBSL3gYLw3ozoTSdCnui5CHnuOewv6ZdB
         Je++9xTFF0SREbrvrXHbvo/vn9XD1snr7iUJMNoNppyr8s3UPhEv7i1JkETFvEYm9EyG
         0oVtZ4MjGmAKSYPjDAFutmwSPu6rqkFx0nFXfI/uAZrI70t2J32O2e5OUvzGvXE3MIhO
         l40jPEenYkeE6IPLWBzlXiptkxX4Ru/bHJilzhtKxr200uUc2FtK+6pSwEtccc+LyqWs
         hLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VY6qF23CN+ctcOxT8JPOuxTXxCaxGAO4SxPnHgp9E14=;
        b=ZtvNkXwp3KTYSIatBoVYywg1FlvO6ZeA7qt215Zb6UhMKJClx5rc42sPWN7e4VOIXv
         ZDp1EMXJ8lsTt2EgBIA8jWe5vFNqb4QGjnQZcdlwSjd67ISx4tFcEiqecUw4bvp0BUBq
         OXLrOjHuKlOhDDahFZFyBXVFMgUGxFm5vpkkK3JP5YU8R6VBMYdmFoiIT1mb5UiVOk5r
         AeSBbOzGDdPoqb5xF3IYNX+0GDu2747hzf+ND8e4lYe8+JGW4LxWsdW+4KqF6CGzDQID
         +kgPuFgDw60TxK0e5IKu7GynpJjRgJskvwUIwRdbTVjJyF37LqcUla92E/q2Y39IY9Cr
         6zVA==
X-Gm-Message-State: ANhLgQ1uB3k56qu7489LJj3ksrX4sYXiWNOQ3WS7Xr/fYY/xiXC2ccn7
        tHwTaO6jxbko23ylyURG/f53MPx6uAfCSg==
X-Google-Smtp-Source: ADFU+vsfzSralYCEv51ZjftUwvFH9TxcfBmYOX3PcAhtv3oNqjcOdNPq0t7zGZhjVz0wetLESLA4Qg==
X-Received: by 2002:a5e:8204:: with SMTP id l4mr7801367iom.31.1584020409818;
        Thu, 12 Mar 2020 06:40:09 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w17sm2168606ilo.30.2020.03.12.06.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:40:09 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: Use scnprintf() for avoiding potential
 buffer overflow
To:     Takashi Iwai <tiwai@suse.de>, Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org
References: <20200311074439.8191-1-tiwai@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <094d3d7f-0389-b58f-ba36-8a6a6f91f361@kernel.dk>
Date:   Thu, 12 Mar 2020 07:40:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311074439.8191-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/20 1:44 AM, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().

Applied for 5.7, thanks.

-- 
Jens Axboe

