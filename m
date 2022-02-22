Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C5C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 20:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiBVUB2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 15:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiBVUB1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 15:01:27 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065B6EA74E
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 12:01:01 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d187so13173716pfa.10
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=4h9kf9VqoPCNtulp0ojgIX7wOSrB7YtOTmYGEUjWqL0=;
        b=cjyLUHV6S+8p9TfT7Micy7LWl7ctXo0lpeqDUJuhjQfHutQSkbuFYRVxgNDsFzXj8X
         /mXx4Sda7iU8O/NHqU74omam8yOhdh8msdWRrHKJc/aqdtpbXwUfZFz2AZ15CzZeqrqW
         1ntJcYVypE4L65sUABgeQ/33M84H9Jy7iIs2AdtK0dw3MLYT3/2HIKHqxTSEwx/auNC5
         CYznqE61v7kLxrmVnUvxU6QO69pDTzovJxsXi1djki690t3sc130eEtYguTvEZ19pg8U
         /Pgtfe1U3xK15cEffzfT0QipmR2hNqexSrqV8lbjAdbZ38gH1W55Axy9LpCsRV29+rcY
         TyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=4h9kf9VqoPCNtulp0ojgIX7wOSrB7YtOTmYGEUjWqL0=;
        b=muhGbsso1YBn6TzLhxMHcJuxeMY8p8sgewEsjjLT83uHZ0IUq3jAa0sVM/MGntKk5J
         J1MWsle+0/pW7MCRZwAvlS8tJ4T9QTca/eazTs+cBaoHFWP9L8x9cl8XKFI5hZiUi1W+
         t8bClejzOlu5UhdSQXoosTmfE8fnSUq0NOPzZnV7rQJ643hL24EfW8/nDQ8qHJXJHhYK
         gzBdklNmiIMfgsU5C6jUKLdS6i2lkWIbxmQKQ9m+6fUO+f2aHaEOjwhI1tHLAYy0bRrc
         DYLxsLeUyY4Oi/I5Gf2uLumRSpkbTZKg8tIFm9FGY4VQjSInLdm67tBhWB3BmrPaN0W9
         hkeA==
X-Gm-Message-State: AOAM532hqpJSAtSL3Jhrkgh+h+hcQ9PAbo0O2KLLs4JXuI46Z7IKGyhj
        x7Ndy8FXoJbTv2PG04IkLrabzQ==
X-Google-Smtp-Source: ABdhPJz9B+VNfVlGOdY8+lNM/fmfOn+oAHq2HMh3zbs60IcgtE3gwlV++5FBfZf5CPofITBZ6HS7Sg==
X-Received: by 2002:aa7:9911:0:b0:4e1:3a76:96f8 with SMTP id z17-20020aa79911000000b004e13a7696f8mr26060983pff.28.1645560060461;
        Tue, 22 Feb 2022 12:01:00 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b13sm10207949pfl.75.2022.02.22.12.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:01:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Cc:     damien.lemoal@wdc.com, shinichiro.kawasaki@wdc.com,
        ming.lei@redhat.com
In-Reply-To: <20220222152852.26043-1-kch@nvidia.com>
References: <20220222152852.26043-1-kch@nvidia.com>
Subject: Re: [PATCH 0/2] null_blk: null_alloc_page() cleanup
Message-Id: <164556005938.133381.110434333749525761.b4-ty@kernel.dk>
Date:   Tue, 22 Feb 2022 13:00:59 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Feb 2022 07:28:50 -0800, Chaitanya Kulkarni wrote:
> This has null_alloc_page() cleanup to remvoe the unwanted function
> parameter and remove function goto labels where we can return easily.
> 
> Below is the test log of memory backed null_blk with fio verify job and
> blktests output.
> 
> -ck
> 
> [...]

Applied, thanks!

[1/2] null_blk: remove hardcoded null_alloc_page() param
      commit: 4a330a241a41e4f2a9d752dea41be70803a66a94
[2/2] null_blk: null_alloc_page() cleanup
      commit: 2ff4ec783f4c635289384398d14b241f21bce269

Best regards,
-- 
Jens Axboe


