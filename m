Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF19C433EF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 14:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiAQOUC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 09:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiAQOUB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 09:20:01 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C6AC061574
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 06:20:01 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id v6so21708512iom.6
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 06:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=USwLjm+IXEsJlAmAT3Be3s37L6KGvv0g9XXI5ckjlHk=;
        b=MBTMEILUk99D5eh09ygboJdb1Gpjhk6OFGlhyjHZLSh4nmcQY3mMUIDyLvDrm5Xf7Q
         Z7lJXkivNugvCZzZRN8zm6Wez4JDiHZGWxPzlc/8lOKQ6onXN5FmuDwrCPCZRWlBJKoL
         1xDwe7FdxYaHHw+vEi4XQ6p5rdFgtctkOYjXutPyTZAEw26GxYTOng+87xt/pB30Ojau
         G1Ws1b82f4TgAfE4XvgAC3CU5hGiAmQMQbUvsl/AZlBBCeM6oasCPafEEkWAX1pu5M8F
         7XI4dv7+CL/6ck3venKxevDe9QPNNBDnYBw8zGOpUJZZrLJcsRL8rp2mn4FRy7SIZvxL
         mMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=USwLjm+IXEsJlAmAT3Be3s37L6KGvv0g9XXI5ckjlHk=;
        b=zSnDNQY5MK91vR8yjER/koYaVcS3yQr5C3dYxwfEV8jLX0ftHv8kSexksS/hk84Zd4
         BXH+vRIbsT/rIdabguD1B4Bflr5ekUbgWRQpG4ZGlo+I4uWb0JDtsPyG/mcXF/to5g8s
         Mmebz2j8dkYObmZOQhxX3K7eyq9W2o2kr7Fb5eG7T2X+t9Yo1za73EHIk9Q3ikvWBVYA
         HdjUg99n9BCXo8Trw5wjoJ1/LOdEKDFd53LfuQYxVh3whzNpe9kRveUwYUJ1cykHt7Zq
         w8QT3S+tNGKcraItjQw6u9moMaHmXr/kSiVAL3ImPbQtfT1IFjbD/0pcolXF5YARMQwN
         AMXw==
X-Gm-Message-State: AOAM531qfqB6u3bGVwlfMtdR9IoKnqJMfSihrJ+0uWUUIQ3VKnj+KPrj
        5xcyFJTKfeku+8fgCItdcrZJJ7dhbM/fZA==
X-Google-Smtp-Source: ABdhPJw3frgJiGAr8saFkWEbPOqTJpItzweFld/v9MAWTXMwuW72+McZZh5WfVbuueArUwOGJeZqcQ==
X-Received: by 2002:a6b:4107:: with SMTP id n7mr7849624ioa.30.1642429200646;
        Mon, 17 Jan 2022 06:20:00 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id p13sm2513726ilc.59.2022.01.17.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 06:20:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-block <linux-block@vger.kernel.org>
In-Reply-To: <6b074af7-c165-4fab-b7da-8270a4f6f6cd@i-love.sakura.ne.jp>
References: <6b074af7-c165-4fab-b7da-8270a4f6f6cd@i-love.sakura.ne.jp>
Subject: Re: [PATCH] brd: remove brd_devices_mutex mutex
Message-Id: <164242919732.334137.13008736939366341267.b4-ty@kernel.dk>
Date:   Mon, 17 Jan 2022 07:19:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 6 Jan 2022 18:53:16 +0900, Tetsuo Handa wrote:
> If brd_alloc() from brd_probe() is called before brd_alloc() from
> brd_init() is called, module loading will fail with -EEXIST error.
> To close this race, call __register_blkdev() just before leaving
> brd_init().
> 
> Then, we can remove brd_devices_mutex mutex, for brd_device list
> will no longer be accessed concurrently.
> 
> [...]

Applied, thanks!

[1/1] brd: remove brd_devices_mutex mutex
      commit: 00358933f66c44d511368a57eb421e172447cfb9

Best regards,
-- 
Jens Axboe


