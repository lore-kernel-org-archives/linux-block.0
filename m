Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4CCC432C3
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58709205ED
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a35jPxts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLCOhH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:37:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42460 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLCOhH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 09:37:07 -0500
Received: by mail-io1-f66.google.com with SMTP id f82so3919388ioa.9
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2019 06:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qGRbXUbqd8Z04mtkdXBEuHQg2LkRCVP7LlXsnOJdoYc=;
        b=a35jPxtshV8+pMg3W3CCCGSqlVGoB1OuQXVQZIKX5SfRQ/C6xoX3NgNI/KLPHUoz/+
         frqVxdDd3L1rWzUg9Xsl4MbHtvgc6ts2mfVf38VPaGTBbusI4xrxHkxAP9kEjVCE9Q/3
         nB/uItPGJVSLLETsjYO6iTi3UZrVPnFYzSG3iqJM7/qgb/lBYdm6DrrT79c14qRz7KC5
         bolEx/oZAaESAAVP91g8jC6gLJUfJF0JK7Z2Y1U25ThPi7atVlWTVFy8//i68yx/LZAH
         lCYEYn689f9WMK4hWVOQd/T4l7AcCjc8/BNr4inDpiUYCmTijK2PQ3Z9KiyscdgoI/bk
         IiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qGRbXUbqd8Z04mtkdXBEuHQg2LkRCVP7LlXsnOJdoYc=;
        b=Ak8AsTQ2R0oFQqDsOTXmBACg4T152+9zTPmdymF4P/PDY0JzA05AcsAwpj0A5zVXSh
         J+rtVTTUsZ5h9M+XQ4f00roDCOy7Cd07R82tEZpOSSn8nMnAFuQ/8XvcsIxj5+Sgx01f
         Zq6QNfzhq63Op4GjbxqBSUsKvkhNScyS9yIjkJ6RSNZIVfc4bIbMIUJkOSrRbZzhJRJ5
         cKr/Hdv7hM9Jv+SnfNzQbLzt+mcFUTNKfkJrw+TqlXY9Viey3qTm17bwAf1tobBzLenZ
         mfYDHnC2S1SMzytYH+GppYU9+/Vh3BVSRQO5jvcJGC1kWOtaE9/XTQK6tlBqfAgXKl01
         aTNg==
X-Gm-Message-State: APjAAAXmWsKNjUlqNZZEgOH6aU8SA+pAco9NLl/OI6ZFs5TXptKTyL6k
        FY0QFUkq6U7XQqfuQ0CgLwjbGQ==
X-Google-Smtp-Source: APXvYqx7Se/ijQfs6J2k9GORA/0UsUMppOuD8JOSqRuCsVgQeEecviXe/bYZtk/e5A5YYZ3jIOqGnw==
X-Received: by 2002:a6b:4e1a:: with SMTP id c26mr2364220iob.122.1575383826510;
        Tue, 03 Dec 2019 06:37:06 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 3sm712249iow.71.2019.12.03.06.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:37:05 -0800 (PST)
Subject: Re: [PATCH v2] block: optimise bvec_iter_advance()
To:     Pavel Begunkov <asml.silence@gmail.com>, nivedita@alum.mit.edu,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1575144884.git.asml.silence@gmail.com>
 <b1408bd6cc3f04fe22ce64f97174b6fbf9ffea40.1575144884.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4eb4a426-8180-ec2a-974b-2b8cdd5f285c@kernel.dk>
Date:   Tue, 3 Dec 2019 07:37:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <b1408bd6cc3f04fe22ce64f97174b6fbf9ffea40.1575144884.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/19 1:23 PM, Pavel Begunkov wrote:
> bvec_iter_advance() is quite popular, but compilers fail to do proper
> alias analysis and optimise it good enough. The assembly is checked
> for gcc 9.2, x86-64.
> 
> - remove @iter->bi_size from min(...), as it's always less than @bytes.
> Modify at the beginning and forget about it.
> 
> - the compiler isn't able to collapse memory dependencies and remove
> writes in the loop. Help it by explicitely using local vars.

Applied, thanks.

-- 
Jens Axboe

