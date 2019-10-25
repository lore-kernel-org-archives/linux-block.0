Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B780CA9EBD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB2121D82
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0nQZAXIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfJYUSu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:18:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38091 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfJYUSu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 16:18:50 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so3837395iom.5
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NCBR5U51gx0BTu0sLmcRSqq7M5vsvlw0CMPTVtehGiQ=;
        b=0nQZAXIlVAaMPPzGgxQhpfchTqE26pjejpXPTSGSN7CHE0o2ppqAheUHgpP0/Lkiwc
         uzZ1+tPrglbLBheeXZo37Sp+o/Azjk5vB+awBhvtt982W9WxqqpTVXivEvja/SpJMrPw
         W7FednO0xXko+SgBCTyKgSL6Rd/QSo6NPodO7Zv//YALXskWApdR9TKbisfBaZ0y/cXQ
         2d7yT7/i6LYyQuKyzXIxLhUjF90VYOO2G8cuzu2dkJSDbK4Knk2KZS8AKg1lPQfOx9xr
         TvK4GF4xcawobM1OqgTTZ+Ep+dsVRIqHIw0dPPscb16eIQNsWZ899IDDYGSVL2usXd38
         Tr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NCBR5U51gx0BTu0sLmcRSqq7M5vsvlw0CMPTVtehGiQ=;
        b=NUAu2YY7xqJVzM2LVLW+innNlJM9WkmRufdvDFOgD3KvkHQZYwKMVGlyAdG3B3w4Cv
         q50qslzARIRnsnILQFZXRV1YyTWF1w0HP7HpZ92prePSz8BmOwd0VMzmAceELMGsxCNC
         0P2dl5DuptShiKMkGY15rp9YaqOsI4MPz3GAlltzVAbpq8xIf/mr8hObXf0ftEFTexb3
         abj74hGfLE+h3atbuNxb6MmIJTHqsOTidB8YzptiYS3hgPlckZiVdXlC4wI+eSuBUgDw
         qauLMvnuSmZrkrBdkmsrQK7JHwFZy23Dj22NXM3csgiMSLMsWGB2zrXVZgC6KZn4x9if
         LuwA==
X-Gm-Message-State: APjAAAVlhAZ3lPhjhyjvryOxyCgqGh7ZBKFUXzNlqx8hlbNVBa0ELiY1
        3voWx/KFapm+aDYgOsQX86LW0A==
X-Google-Smtp-Source: APXvYqzDQfuwNIymKXRFdVnTtyxH/JBiiT9sPS2lDsn1w4inXNY9A2HUaR3nUZNWJQcQyvmwOGVlmA==
X-Received: by 2002:a02:a414:: with SMTP id c20mr5770951jal.91.1572034728986;
        Fri, 25 Oct 2019 13:18:48 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c73sm384696ila.9.2019.10.25.13.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:18:48 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] blk-mq: fill header with kernel-doc
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
References: <20191022000724.32746-1-andrealmeid@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <199aef1f-1956-afbc-9ccb-e9d057ea2d27@kernel.dk>
Date:   Fri, 25 Oct 2019 14:18:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022000724.32746-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/19 6:07 PM, André Almeida wrote:
> Insert documentation for structs, enums and functions at header file.
> Format existing and new comments at struct blk_mq_ops as
> kernel-doc comments.

Applied, thanks.

-- 
Jens Axboe

