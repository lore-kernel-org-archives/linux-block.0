Return-Path: <SRS0=r6We=DC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8A6C4727D
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 13:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A879C2086A
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 13:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qICzxIAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgIYNzQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Sep 2020 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgIYNzQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 09:55:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93295C0613CE
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 06:55:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so1881899pjh.5
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P36RwM9tD7shaw953llfpr55GDhwzzE/X72ycTeGESg=;
        b=qICzxIAGlVJUHS2ECnBhHdm21lcwtqHu0d0GXN2/NyLtuwQLCGKUeGw4Qsduf0cbI6
         Yr9FFFiG/ABS0lC/jlUFNXxCJPo5BR21Ay/z/pskG4ded+qpaduJOLlBxkM4GD2S3xpU
         iOVsTX5Sd0sLsHUfaexpkOqmmq0RU51zTZVYviUvv+SaTtqQIWS6rIaOHTqg1c365frb
         RHRSe9xxA8jHP1U4v7Ns0ij0gXmdXz29d7rENRsVzx7vGwPO19VkCl2nEdIt+2/GX/I+
         h9RYzoATS/aWve44glDonB14ILG5XiQkdoLjSP5GCJynt6ah4IyWJ4WyNrZGdNJPaP1x
         xxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P36RwM9tD7shaw953llfpr55GDhwzzE/X72ycTeGESg=;
        b=DEZu8YttGK0ffMFrtQ8okHI6LGtnewai4d/kE7STgsi208/pwlZudGLL2ZzyPWMZvH
         cLAHm75IUG3x4y0RgfPJsUPwhIklNwpGhb/HvZs4jmysKhsXKeD7hqrqKvv1Vx4dOYcW
         Luq8NMNnNW0Fy/ozfdzlZC5tRL5bSWzKEh7P2FNX5wxtTaj5FygoBSvAXtA1pslkhbTU
         yhm7mgI6HglgwVW0eRZLeicJqSUw2/JKO8WbkUfuAZfFRAhTGPKiRoydB8mz5q2uY/Nl
         zUgZfzBQV3HcNmQ0hxA03sbppWXuhFzgEij9be2EdEEYgdeysXHj8ZO+gkDtoCpwvtBZ
         6L2Q==
X-Gm-Message-State: AOAM530FtgSxqUScQ2TPbG0yw12pjg52G/e5J6gIyE4lE6KoZO1Ei+pb
        kFCR/Nzj/1pnPqgfHfKyqMPhD3QSA9B9+A==
X-Google-Smtp-Source: ABdhPJzBupA7Vmb+hxIEOFu7Wj6UsqBCUya3ZPPnMvHMqLuPM0RayePSTWV7uNpRVPyBqGkCtjgiJw==
X-Received: by 2002:a17:90a:5588:: with SMTP id c8mr426794pji.224.1601042115996;
        Fri, 25 Sep 2020 06:55:15 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 25sm2264170pgo.34.2020.09.25.06.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 06:55:15 -0700 (PDT)
Subject: Re: [PATCH] block: remove unused BLK_QC_T_EAGAIN flag
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <20200925060031.4435-1-jefflexu@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <02fe94f0-142b-db46-bf12-2a6804126fbf@kernel.dk>
Date:   Fri, 25 Sep 2020 07:55:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925060031.4435-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/25/20 12:00 AM, Jeffle Xu wrote:
> commit 7b6620d7db56 ("block: remove REQ_NOWAIT_INLINE") removed the
> REQ_NOWAIT_INLINE related code, but the diff wasn't applied to
> blk_types.h somehow.
> 
> Then commit 2771cefeac49 ("block: remove the REQ_NOWAIT_INLINE flag")
> removed the REQ_NOWAIT_INLINE flag while the BLK_QC_T_EAGAIN flag still
> remains.

Applied, thanks.

-- 
Jens Axboe

