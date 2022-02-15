Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02927C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 14:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbiBOOy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 09:54:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbiBOOyR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 09:54:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53738237
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 06:54:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i6so33365014pfc.9
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 06:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zvXa8LYz1SnUZqnEoRm4b/Z5YqNE/BEvWWsqqbo297I=;
        b=6CWyklRSUQWlcAghg2J/098xZrAeL+Pp72xEvIrEo4zOsG456zfW4WKSw9E5PnnQ3p
         gUaHWU0uxxO23Xf/EKZPj3uoKVGQgHUtX6Cq+o12KDY/a87cjZwXuSyKWYxOcq3j8fjn
         v3UqmZgAJACRU43teWpVCchlobSSpEbGkbbUCv/MwOMS5Ddt1lcXyPWm/jcSEuzOx9ro
         G7+5fjspc+vzRR2quXwiMkjT0sGlgE4mQbfQQncOQPqqZwDvaxdlNY+QrsHmezoQccaA
         DNF7p6qzcFNHYe6iVfrCRDreuyFjhm1jNshUdoWql1UwWTQIhNjZXOYayRKx8hdCtz9a
         2r4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zvXa8LYz1SnUZqnEoRm4b/Z5YqNE/BEvWWsqqbo297I=;
        b=l+3pL70gH+MRdvXVlA/rGCkUaAArSDARFl6l4lWhP06kFnT1NbfYtHrfm8GOmhfGB3
         Wid+morYm386sxAuojVUD35bWb/aWZosLKYKoBbBnTR51F6SB0HrMv/qKxcWvUB0PdQE
         V9tfr9PqmMF5LtCEhkJGKxo7MRDnXP+IDmiVpgoLoCQwxaGu/wLcv0RYobmnL1mWkIIo
         SkztL1USP3u+5Pvha1EDSTxP261G6PUursB9WV0vzkT1b3GqDTz6T9e4bwYBI4nwEwr6
         tjnL9JicHAw37O6ZMURsW3p34pnJIDskUTugL397vwL1DVPZY/52UxuNL9lyARFHzKMd
         dlDQ==
X-Gm-Message-State: AOAM531FNMT+BUemWn9qsNkfwJLH6RhGGuJJ7mk71Uv5FFgTxhAgkKDA
        diVqZ50ENjeitieW3ArvnFzFdQ==
X-Google-Smtp-Source: ABdhPJyKPZj1au1T+oyq8MxVOQTjf+5e6UXW9/8vfNI5C+K57fny+GnKMI7mHnXmEKtXF44zuX0pKA==
X-Received: by 2002:a62:5383:: with SMTP id h125mr4759335pfb.30.1644936846649;
        Tue, 15 Feb 2022 06:54:06 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id np11sm18477733pjb.25.2022.02.15.06.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 06:54:06 -0800 (PST)
Subject: Re: [PATCH V2 4/4] loop: allow user to set the queue depth
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20220215115104.11429-1-kch@nvidia.com>
 <20220215115104.11429-5-kch@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75d43e3b-e13e-f78c-b120-cb3de5ff0e63@kernel.dk>
Date:   Tue, 15 Feb 2022 07:54:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220215115104.11429-5-kch@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/15/22 4:51 AM, Chaitanya Kulkarni wrote:
> Instead of hardcoding queue depth allow user to set the hw queue depth
> using module parameter. Set default value to 128 to retain the existing
> behavior.

Do we want to ensure that the depth falls within a reasonable range? I
guess we don't if we just ensure that it fails gracefully. Eg have you
tried the usual sanity checks of -1, 0, 1, huge?

-- 
Jens Axboe

