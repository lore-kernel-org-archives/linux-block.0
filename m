Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8319C10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 14:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C1120685
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 14:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fcTH1VfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfDVOh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:37:26 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40241 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDVOh0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 10:37:26 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so18474517itb.5
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8DzvcEfUpC0InwEqRFXqEPgc1/Zvi3D4guz08oELezc=;
        b=fcTH1VfOoxB7zDoNHN5KZofP7zh1FDottFfundbWKbGRqvIhOqMase2dBYzNTGXQNi
         ifkOFf2VA+0Duia6boMm8gxisZ0vXWAu8VALRnYpT5okqlqbk8ra8FRY+KdsiNPbfwmK
         hllxOi4sXO8S30CMHV8ul3zvzGiBJsTsQWAf4KyF00Edq4qS09oqRxyl3TB255mJ4Rbk
         C6lposoBnMPy2LkZZGqJkGv7nIIUsgC7N4hsr33ddX0Rue5pA+tc3VGQt87yl3n47EeG
         ZBLa91OycccXGDqii3WoW4+qjOUAEMHAV8ObX/6SlDz/MypbvQD88GlD2DLJ8Bx8Z2Kk
         djhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8DzvcEfUpC0InwEqRFXqEPgc1/Zvi3D4guz08oELezc=;
        b=e4ZNe8Np3NNPAVVthO+ABDfJEnkez5UDIFIaf6xZjNGv0JKy37bW9BAXw2jqF/R2iO
         kJE+AK2gr+R2pyOUDZa3PXzHGquHGbzWnTyZ/4EDKQcXE6mvk/1nNyB6Bh39rtb0GwyS
         H/IaM6ynYgBgANvO6pXeJHTZtQji6Reihb3jaAa8OEji4avv+LC7nWlvPo0HRbACgWZg
         G98In51EmVYUfG32vNGBu93MMWvLzZMIs7TKGgnhmXMNjbc8yxu0Eg9Ik3iiBh8B1dcB
         qPECZ0ztSDnESiqHAuKpBkhumAVntrHZJJjP+Srs3x6lUbdiem9xANbmlvAGyQQTA7rc
         nJCQ==
X-Gm-Message-State: APjAAAU4difg2PUwzgxzYLgcIXIz9ggk4LqQH9iBhv6L/duQqTBGc264
        Od/K27wUGjruhJwnjCgbK3BfVWloNcCgww==
X-Google-Smtp-Source: APXvYqzuafVd9cF/VknHZoI6b3X1b96+XZyuEJI5ecWcyG8LUS/pwal/QQAgkm+OWs75JYyn1o2NKA==
X-Received: by 2002:a02:1a89:: with SMTP id 131mr12630279jai.78.1555943844306;
        Mon, 22 Apr 2019 07:37:24 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 136sm6195241itk.28.2019.04.22.07.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 07:37:22 -0700 (PDT)
Subject: Re: [PATCH v2] block: don't show io_timeout if driver has no timeout
 handler
To:     bvanassche@acm.org, hch@infradead.org, linux-block@vger.kernel.org
References: <20190402131424.GA12935@192.168.3.9>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ce6c2af7-dc4c-7893-8253-5c49105b8ffd@kernel.dk>
Date:   Mon, 22 Apr 2019 08:37:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402131424.GA12935@192.168.3.9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/2/19 7:14 AM, Weiping Zhang wrote:
> If the low level driver has no timeout handler, the
> /sys/block/<disk>/queue/io_timeout will not be displayed.

Applied, thanks.

-- 
Jens Axboe

