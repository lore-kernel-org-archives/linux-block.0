Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271E5C432C3
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 15:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F287D206D8
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 15:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="p9f61F2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUP4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:56:23 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40316 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfKUP4S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 10:56:18 -0500
Received: by mail-il1-f195.google.com with SMTP id d83so3748557ilk.7
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2019 07:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i6XZTTQSHJKM+KBZCHJbpNr3leYiOU/zZyc4Kt/q1ls=;
        b=p9f61F2qEE4/QwqhzVpQxRpsxX+tV3SxRebeynsmRfBNHvoMnRcPAeQBMJ4vetLpDz
         shfSAjNsSLR8/AyOjsQjN2cfgMUQmKjudar8cuqkQT4utDF/Fg0xyKUILGxfQL2m4ykC
         v2dKDPfCeTVXelv8ErH8wWKv+orr2ysEDzISJsEE+qs4wfsyfactwDmLH8MnBWJzVSmY
         XCTDegH0huTSluHvW6LcnV5C2iycu99pwuw2Q/YxucMfTo227eo59/I8ZMNVpzMswrI3
         2Efr4431bVIGY+4pWPJ+b3TiJoIazJewBg9vmPs5YlVPxg8N869vnJ+tezxnZ3CO4XTi
         5d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i6XZTTQSHJKM+KBZCHJbpNr3leYiOU/zZyc4Kt/q1ls=;
        b=BJ7JyaLyUH+RspclNlVID3uRX9biz4E9BzOgp+U+C4D7PP9eHwUFiUfx8k5btrHeR3
         v1lM4L1rQQevikSobrlgJyumVZGUQC3AkHTA8h4ZZRiIr/4OYKLdawnU/m3u1lxJw0o0
         oG5BkXWbDWjMS0hBfaMIhnlhqRAgofkRc6OZSRlDHHdMuKkd/LThvCLszHfL3IoEJLFF
         +nBY6+Sw4ME0oIwqB8VtvLgGUmfo2+H7mpoQ54nURTGdOEelAUwjH6HAPwYdVb7WgL8j
         QwRdyTJTBVWDrb9XT3pjg9DpfJvEgMcrjW69YZh+pKyd9mTw8NMZwFO/RyT+WImr+nWm
         i8OQ==
X-Gm-Message-State: APjAAAUTsS9/oZ7xdyJEN43g2yRjvM17Z1qbRs/RwgErt0QcPPaEqGwA
        q7Wek4+lZpmJzLflnOv9duetNg==
X-Google-Smtp-Source: APXvYqyBx1nTqGMRn9GsWSj0/giOcMCoKn/OjZ4stbz+xyyRba03IeYJrruyiFFcHRXe1jGKDNx4oA==
X-Received: by 2002:a05:6e02:100b:: with SMTP id n11mr10655778ilj.212.1574351776819;
        Thu, 21 Nov 2019 07:56:16 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 133sm1342001ila.25.2019.11.21.07.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:56:15 -0800 (PST)
Subject: Re: [PATCH] block: add iostat counters for flush requests
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <157433282607.7928.5202409984272248322.stgit@buzz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff971ff6-9a10-c3f1-107d-4f7d378e8755@kernel.dk>
Date:   Thu, 21 Nov 2019 08:56:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157433282607.7928.5202409984272248322.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/21/19 3:40 AM, Konstantin Khlebnikov wrote:
> Requests that triggers flushing volatile writeback cache to disk (barriers)
> have significant effect to overall performance.
> 
> Block layer has sophisticated engine for combining several flush requests
> into one. But there is no statistics for actual flushes executed by disk.
> Requests which trigger flushes usually are barriers - zero-size writes.
> 
> This patch adds two iostat counters into /sys/class/block/$dev/stat and
> /proc/diskstats - count of completed flush requests and their total time.

This makes sense to me, and the "recent" discard addition already proved
that we're fine extending with more fields. Unless folks object, I'd be
happy to queue this up for 5.5.

-- 
Jens Axboe

