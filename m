Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C08EC28CF5
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 14:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbiAZOBL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241869AbiAZOBL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 09:01:11 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A2C06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 06:01:10 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id r144so5411414iod.9
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 06:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Y53qxsCo4solTvnTSnoGZXGVlBGrMeQOvLhWcI4XWD0=;
        b=jBCF92XeVH6rkyRbsGbY9To9SPPG9HrF8Y5/yA86sJpVJ9U+xqnGFMpcZ5SfKas9a2
         bgTWXQThucrJ9bqSB7KYs0rOIWSNTH6J38iWdZTtiILu3PHBFNjwbnw/7GSJ98p+0xyW
         f1bvzY/AF+Am2r01Tt8zU0VPa0KVUTLqbVNMZScWCjDKHKWaMN/4ZWN9mofclgP9XyYh
         bgv/y+v0LDpCDLxY0re5BGxRkuKLtvt26Uqe9tqWvNLL3qjwehnDltISqnoj9O0OzBMf
         mmkDw3+KBfEsqyXBua4UrmlufsC198HNrKQV0OWR13qUJixgsAxJmIl4nIaczJ6Yft4V
         mr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Y53qxsCo4solTvnTSnoGZXGVlBGrMeQOvLhWcI4XWD0=;
        b=ZAs1+AjkgCLFMhW0idziexXZ7XvbiyXkgY9EnbWxhNExa7tEGSg4cMfadQe8AqvQl8
         e+o+06uZqa7HTl/TJRdWC/OCWnE1bpEByr1ogMK0IDsk4D6SWcjxkPzYMfQDrJWWCHph
         yLG9z2I03vMuKvJ8qQdNAQV7T9Oxu437dk2y3hGdEXVAV4fsyaM/JEQLJuZrHsi29qp8
         5fjy4o3dyUJ0ldI95RI59aMhAFfP1mIKENa1MEj64ml0hJYS4rHNgIooDHH+K966AFJt
         mKpNRU6R2HlRocWjby1L1EV9/isnegpLyuTGWi3w5pXwBsAVYN+bqU47ofxZu8kxEowu
         O3tg==
X-Gm-Message-State: AOAM530d+8RVEgcc7ZIbwPvObUBeP7awbloXMm82byEwkRuqjCcR6rxE
        bUTgM/95ByxBJnA4aNkxZAmknQ==
X-Google-Smtp-Source: ABdhPJzpPngofjYwlp5BhheLcijW9HHnwzPeB+KKxvodSfIKWxWzF4HqLxMKgvbAmIdsM9c2TPM8pQ==
X-Received: by 2002:a02:5b44:: with SMTP id g65mr12436624jab.214.1643205670323;
        Wed, 26 Jan 2022 06:01:10 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j14sm10457498ilc.62.2022.01.26.06.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:01:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>, linux-block@vger.kernel.org
Cc:     hch@infradead.org, jinpu.wang@ionos.com, bvanassche@acm.org,
        sagi@grimberg.me
In-Reply-To: <20220114155855.984144-1-haris.iqbal@ionos.com>
References: <20220114155855.984144-1-haris.iqbal@ionos.com>
Subject: Re: [PATCH for-next 0/2] Misc RNBD update
Message-Id: <164320566734.128521.6880129358020047420.b4-ty@kernel.dk>
Date:   Wed, 26 Jan 2022 07:01:07 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 14 Jan 2022 16:58:53 +0100, Md Haris Iqbal wrote:
> Please consider to include following change for next merge window.
>  - fixes warning generated from checkpatch
>  - removes rotational param from RNBD device
> 
> Gioh Kim (2):
>   block/rnbd-clt: fix CHECK:BRACES warning
>   block/rnbd: client device does not care queue/rotational
> 
> [...]

Applied, thanks!

[1/2] block/rnbd-clt: fix CHECK:BRACES warning
      commit: 7cb0c32efbae2a7000f74243d8b4cab35d669cbd
[2/2] block/rnbd: client device does not care queue/rotational
      commit: de53a6a82aad3010d7e9c3151cba5e4e46b6ec32

Best regards,
-- 
Jens Axboe


