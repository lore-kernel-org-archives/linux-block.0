Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1621AC2BB48
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 14:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09CB23998
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 14:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgLQOzt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 09:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQOzt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 09:55:49 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8102C0617A7
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 06:55:08 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p187so27763383iod.4
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 06:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AppbOyrBaJen3npr6us/u+3s8pRHAJIQTjC/7eMkWrY=;
        b=qIsNU8MNaXfORjHakfIhVA6M0I+jhauT8ujQjdTh9pltOmusTdjtS6vAZtGFqUKa+h
         1djBuHsK4XxRHHLJzWI3bGidYfLa3CWko/3FVyNpI3oJJYnYAVLWJBKKhi3VfLGOs7dX
         W1X16QmHGd/vEu/IxDQxMe5iJvYn1J/20qdKaMkr/uFQe1EDwdejrAd911mA6PbqjulD
         PwkyKPXO0j4zqejFvZzCV51KA5NnIcxg87o90ufkWZY8neAizIwC0A8kiIdXUb/QGyGo
         MEmaiaZzG/uVrv4jVgLnAQ8QYEJYDHAUzeoVUvCp4fNKcqWiBLD1fxGUdXNsbjG0Keqx
         ZY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AppbOyrBaJen3npr6us/u+3s8pRHAJIQTjC/7eMkWrY=;
        b=iW72mtjhPLY0pnL5WicIm6kFjb7d0DcVYIhZc+bH/BaaKZqQb1gqWog+nP+psixL9Y
         m0aM9KZS76zsvWVZT8k8CmLKjvOtAx+02F/d3G6np3YZ/Y6Wq5qoBx39FJaPSst35SWS
         QReT2hd+3k6FGTFaMkhVp9Z5rNbun+1g26tQ/0g/ICcIpDBtE1JPi5rf7GZh9LZl9IMH
         yFJE1+U032wF4AAxfh5o8uHyheiBnG7PNMfEQfl+w/JFOmI2/XS9oIggSFcdB8g9Z56y
         w9VuuFjrjIuyaR4s51Lqe8+pZ+XbFKMcUjvvqT0ya+14GeRVZ0WpYRoS6Y0K751Hm2l2
         1fgw==
X-Gm-Message-State: AOAM533dN/mB+B+OeSBC5S8VxXlyQ9/b8XLvoaPxva9ZCjFsA5pw9nKz
        qkfHklGGfGT3h7JhMHaAXMoc4g==
X-Google-Smtp-Source: ABdhPJwfMNgZvVnqWHpCY0jEbFdtpsS2a0qvoidjGtaw1ygKCvI5Uzf8bManknMBHDhGm/ob4gK8MA==
X-Received: by 2002:a05:6602:2e81:: with SMTP id m1mr45693684iow.131.1608216908061;
        Thu, 17 Dec 2020 06:55:08 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p11sm1762461ilb.13.2020.12.17.06.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:55:07 -0800 (PST)
Subject: Re: [PATCH] nbd: Respect max_part for all partition scans
To:     Josh Triplett <josh@joshtriplett.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <86d03378210ddac44eb07ebb78c9b0f32c56fe96.1608195087.git.josh@joshtriplett.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a3c0b4b-52d0-b4e0-182e-c15f2a80d348@kernel.dk>
Date:   Thu, 17 Dec 2020 07:55:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <86d03378210ddac44eb07ebb78c9b0f32c56fe96.1608195087.git.josh@joshtriplett.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 1:58 AM, Josh Triplett wrote:
> The creation path of the NBD device respects max_part and only scans for
> partitions if max_part is not 0. However, some other code paths ignore
> max_part, and unconditionally scan for partitions. Add a check for
> max_part on each partition scan.

Applied, thanks.

-- 
Jens Axboe

