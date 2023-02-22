Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5CEC61DA4
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 16:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjBVQyF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 11:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBVQyE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 11:54:04 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E162CFC6
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 08:54:04 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 76so3786746iou.9
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 08:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677084843;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VbyC6DBRBNC1fgtn1UZ7A/Chw8cI1rMyN+jMjE9gHQ=;
        b=t74bRHNIPnUlmlbhmvakIxLCA1vgIvSDQ/KhiDnH4BUgIpgHDqRs5nlevhJYDcU3+P
         OPye3cAaWdHb0UaQ5Wvq48saEx+XcTtFZ/o4lmAqxXP+TcHzVBkBH+IThImvM/hFG9TL
         XVlwgkKk7YPCY5JQvtkfle6n/XSi8PHo6i2uLVFHAws6OLkbdf4nR5pWyH5pqRwppNLe
         SJJpbcuvuWp7Zb0XcA6YlHfZ5ItPYEhhU8BTXuxqSTbvVYsiYpThvY7uJCcpLRNzJSBh
         AMfJXa3T2VMv5HXyEbsKhhLTRoahcgOvhrPN2zE8octhswyIenKxMMtTGOJK8wREsqk2
         9cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677084843;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VbyC6DBRBNC1fgtn1UZ7A/Chw8cI1rMyN+jMjE9gHQ=;
        b=d4JdulOkqHmZqQK4Kox4wVLYKQ+VKTh/l0FpZS4aZzDbTb44JKbF6ttQP3XLTaTI60
         huarFV1zQptmWW79kmjLPMF5laSkzC+4fb3keW4WsRReWhF8ckbm48N6C/JOvS7nT83Q
         lOg4781hliFtufz2K80n9tDGasPrKpQWlzWzaLcsKM3S4KMBfNxsQndjF1l991YmwL9D
         ANnseKTcMva82G0jXJvxD4GTdSqOUHksum+5HWzYK/3BU8ClxaTQ2hAbcxnspkPrPLAd
         bKPJmpZjIPlem4gzyo/y5xTeXcbC+TMNZfZD2p1HofTmXi+5sTxU8AK1SmUQprO+wOY6
         V9xQ==
X-Gm-Message-State: AO0yUKWccxMDnrU6u60p0Z/uRMfkhPz8ZDwEbwJ3hJAD7Eob1e1YqwVy
        K5ZSHLmh7sZ7epQxy7UojF52ZQ==
X-Google-Smtp-Source: AK7set9ABLWeT5kJCNrEcfZTnPMC341hX+c58HXuxL4lzfOhzRqDm4LlvDfRCVszGBIDkOs+nIbX7w==
X-Received: by 2002:a5d:9d81:0:b0:719:6a2:99d8 with SMTP id ay1-20020a5d9d81000000b0071906a299d8mr7748173iob.0.1677084843478;
        Wed, 22 Feb 2023 08:54:03 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x17-20020a029711000000b003a7dc5a032csm997371jai.145.2023.02.22.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 08:54:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Juhyung Park <qkrwngud825@gmail.com>
In-Reply-To: <20230203024029.48260-1-qkrwngud825@gmail.com>
References: <20230203024029.48260-1-qkrwngud825@gmail.com>
Subject: Re: [PATCH v2] block: remove more NULL checks after
 bdev_get_queue()
Message-Id: <167708484252.23363.15648406717900315948.b4-ty@kernel.dk>
Date:   Wed, 22 Feb 2023 09:54:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 03 Feb 2023 11:40:29 +0900, Juhyung Park wrote:
> bdev_get_queue() never returns NULL. Several commits [1][2] have been made
> before to remove such superfluous checks, but some still remained.
> 
> For places where bdev_get_queue() is called solely for NULL checks, it is
> removed entirely.
> 
> [1] commit ec9fd2a13d74 ("blk-lib: don't check bdev_get_queue() NULL check")
> [2] commit fea127b36c93 ("block: remove superfluous check for request queue in bdev_is_zoned()")
> 
> [...]

Applied, thanks!

[1/1] block: remove more NULL checks after bdev_get_queue()
      (no commit info)

Best regards,
-- 
Jens Axboe



