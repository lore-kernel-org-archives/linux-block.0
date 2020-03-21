Return-Path: <SRS0=o1BL=5G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A02C4332B
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 20:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FF420775
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 20:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MQxHRuAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgCUUbT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Mar 2020 16:31:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45740 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgCUUbT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Mar 2020 16:31:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id j10so5252645pfi.12
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2020 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KtHEUeqpEQFTh0Lhcg4n5H6JIosCRRgpxD4fsra1T24=;
        b=MQxHRuAN9tzpFIqfnlglw/uACONg2ZcBhmEd99Vp5/2qkqO9rinxrfuqXDoAu28mpF
         fW+JqkBkRh/RCoKx2c63yeyGbs//OXts5nwquD5iw+gixTOyY+EaaULzCsbyVwnFbLJJ
         jfRk8BGF88aKh4il9KT8vssDj7kEApngp55+wseBfqRuRC666ZJ3cCKBTvV/3OZ+zr4C
         HmJsrto+r2iVf6j3pi6SJIJIulIxOTlGXYYVH2MsQ9nLYv/lyU16SER+4DRvsBrhfe6c
         7VU+vvkHLUxUZUh7QKBlftWhUYFFLMdTLycnauvnSILyuWoX1w1qY4+pKHE1+BaFWL8Q
         EYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KtHEUeqpEQFTh0Lhcg4n5H6JIosCRRgpxD4fsra1T24=;
        b=L2oouOX3tYeQUpaPXfbX+y3sCFyKi7Qye3Q3JKr2dWrPWZ56R96/Zqb4tMZyOwJpCy
         Hqtqdcd1UQaYCe7IGlxYiRdP6xfqRAzL75x5m3hxp5ctTBG7eBY07D05zWBbRyCtzpV8
         uoDz15ad4b7LgoKaQFPn6HU9XWkcZACK+F5fyOnx5UgTUOXnlP9UJQUpk8kQw7b9ZRkf
         3Xm55Uw/zMZ+RO3A49Np8aILpg3fmw5lON8ZqjgspkHuhZnM/UmoZ/ue63X0Tyi+eOli
         NGzewFbO7zAgQ6uBt/ES5u01gOIDGRZc3iHRl1bZiZjskIpWXvUSIqbYNa3iuWcW1pJb
         p9qg==
X-Gm-Message-State: ANhLgQ0QEhTeN2iN2KcpNSsQ+OaFcaOk/suZnHgb0q//srow/7S/6r8n
        wx4Un0Ty5y/DvQ5q7HeW2c8SAA==
X-Google-Smtp-Source: ADFU+vtkMgIvvqtkf5AO3P+JUquBgDfkgt0cwYNph/foYs8bN4hSKJW1JCzh/ITalvv430YzMkUDkQ==
X-Received: by 2002:a63:7e52:: with SMTP id o18mr15282915pgn.46.1584822677898;
        Sat, 21 Mar 2020 13:31:17 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 5sm9131565pfw.98.2020.03.21.13.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 13:31:17 -0700 (PDT)
Subject: Re: [PATCH BUGFIX 0/4] block, bfq: series of cgroups-related fix
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        rasibley@redhat.com, vkabatov@redhat.com, xzhou@redhat.com,
        jstancek@redhat.com
References: <20200321094521.85986-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1c1e5f7d-14f8-1092-a777-a7ac457e9d0a@kernel.dk>
Date:   Sat, 21 Mar 2020 14:31:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200321094521.85986-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/20 3:45 AM, Paolo Valente wrote:
> Hi,
> this is a series of four fixes. The first patch fixes the issue
> reported in [1], while the following patches fix a few extra issues
> found while testing the first fix.

Applied for 5.7, thanks.

-- 
Jens Axboe

