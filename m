Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D20C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 07:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796E720872
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 07:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0SY7teu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfI0HN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:13:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53186 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfI0HN5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 03:13:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so5320732wmh.2
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2019 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=auaAueRwN/I6iGqOtnmqwN8sj8ZWN9m7W28t+4P5BsE=;
        b=0SY7teu8BDy8SpZOwfsx9Qf0QxUnTiAqEEMOGKM9FapHKPVaNBSrbmGp+GY5YEONZN
         //O6Ds/JAuAlpDSXE8DeyV6/RjlhfmpGoNgqtBqa+vZQa/zvLN+aPlWaCbIjqElWWnWI
         erO+8OxYPyfrpDqS4cJ4QOBr3oslz4MzbswDE1OKm4CyRKL6EgOx71InIkaG1fHPxWkk
         DUMkzC3RdBZjJZy5a27hv+mMf0vhucmHfdXUZWEG0uFvuN4rmjSkLVp4DtPmulX6AwSh
         28p6bbc0WEZM7L5dV9/xlAjJFbUS3QKXugA0RCgQoEsDQ7ayTaJ3sxb2P9rAKtLnjV1K
         SXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=auaAueRwN/I6iGqOtnmqwN8sj8ZWN9m7W28t+4P5BsE=;
        b=ncM+EPxN6ssVFlGRTO5dK6lj5FJPinLuML1J+SKa9/9lA+cehNIhABWOpchuVUSkH8
         2ySS832SV5gZsHH5R+QUSkQCQTizsLt+GtCggkT48zM440KuW3OV4iE8DwrCnUQQMkE2
         FPvHL2ZCvVynlXQXimEf3w5fgyh4xmczFWJPWgx2G9vtKCJo/AJyM6KyAIovBOyErR+p
         gmfOQ7BteNSEoazB7i//9SaXN0aLbPcAstsrGfnzXsEO/aS/KEkoDQJG7p+Amn5+jE6Q
         0bVj3Hi8QgxXStJuc/WfxK27pVD4oPWhuoaSm86DesWfQwPkBRJcUHyAG7J2T+Yfk5h0
         YT8w==
X-Gm-Message-State: APjAAAVlwB36L6e7EbGPLyzoUcORzzAf5p6D+cV3BOEl2Ckhmt6TqH+K
        PPSZDPpx8o0bEvypacFzAeHe3IA35q/Q/GZd
X-Google-Smtp-Source: APXvYqzfBIooqntDDEvU9bdEIQCFwy2j8yVYa3s43BzQ6uljT6zqag+YixqpSxXtEOC5wv6IlQzPLw==
X-Received: by 2002:a1c:cfc9:: with SMTP id f192mr5624425wmg.85.1569568435064;
        Fri, 27 Sep 2019 00:13:55 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id t1sm1465441wrn.57.2019.09.27.00.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 00:13:53 -0700 (PDT)
Subject: Re: [PATCH] rq-qos: get rid of redundant wbt_update_limits()
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-block@vger.kernel.org
References: <20190917120427.15008-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8fa70d60-c709-7e36-350f-fc149ee63fb2@kernel.dk>
Date:   Fri, 27 Sep 2019 09:13:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917120427.15008-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/19 2:04 PM, Yufen Yu wrote:
> We have updated limits after calling wbt_set_min_lat(). No need to
> update again.

Applied, thanks.

-- 
Jens Axboe

