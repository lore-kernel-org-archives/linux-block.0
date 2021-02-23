Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC735C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 22:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934D964E79
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 22:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhBWWpm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 17:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhBWWmk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 17:42:40 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79571C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 14:42:00 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id k2so5634ili.4
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 14:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=TSVUM/zT7BA44V6HBXT0zpH7TqCwFdeKGgTUPMw/nr1Y2Nq0B9o4FEK0tmf4Pte/5D
         Tc7YEQdOVlrhymfkLb+TVtGFuV0xBjEtueZLXS6u/+zHlqSEP2cWBDJUyi0gBt9QrEq9
         JzWUETk3pdWvV2ZtiHcwTAiwt5e4ApF6Kyr4elT9rZyOzcaa2SA0BYGpUEqbmLeDOIeY
         4x6i/qvAaTa/hDKKdDrFMWkD7ZtEazBppxAnmI77EhcHQFuoIY2RwZQkO+yf7YcAGlSC
         rEoX5IO49rb3mbSrn0ZX6+ISAvuak+0lGci/nfKDTTUVnOcrqmfie7Vb9xUzdOSkjOz1
         2lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=mGzY06S9J5atVMg8O+cFiSJGtNN0VLkYOItCn/QkWjTx1UDIinwF7CS5IwfJ/1T8lf
         /cT54VFDEGE/ebRl4Mnm00fZ+0KR3H5+wonY17RTYMN+luY9myBfizY4EYiAZeP/D3Tp
         JdpTYyM4SdnMZNqvfVVz4nY72YDR4oFmlIdNxD3wUjA4RkFQDe5K0NW9D6ymNT73ZeYa
         I0PPGeJ1lr+1ZGFf4a6kZsNIa7J3aaRLQBhzveeHtk0njeeEw+wHhpiffAhbOuAvV0fT
         sbnH/77Jolcm9M5UgiBpgmGGsOv+OlIlI/XZsLIEO9lFeE/s7+ub1g2Zo8tsf1dImFWD
         wQZw==
X-Gm-Message-State: AOAM531eOnZgkyBp+RX0kBQGfELjKlsvMkq9ROYKm6XblIIFlLSZ6SXT
        SupFGLSp1u9b5NPFg8D8oLST5g==
X-Google-Smtp-Source: ABdhPJzXHFoTuq4AHw4FgnneXIbXW0HvdigmHBt1L83UU7hsh+H7lS3Cyu4aIsOx6BRDPOXbXSKn3Q==
X-Received: by 2002:a92:3f12:: with SMTP id m18mr21853729ila.109.1614120119892;
        Tue, 23 Feb 2021 14:41:59 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a14sm26801ilj.39.2021.02.23.14.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 14:41:59 -0800 (PST)
Subject: Re: [REGRESSION] "add a disk_uevent helper" breaks booting Andorid w/
 dynamic partitions
To:     Christoph Hellwig <hch@lst.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>, David Anderson <dvander@google.com>,
        linux-block@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Alistair Delva <adelva@google.com>
References: <CALAqxLU3B8YcS_MTnr2Lpasvn8oLJvD2qO4hkfkZeEwVNfeHXg@mail.gmail.com>
 <20210223063130.GA16292@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b11afae3-64bb-5ccc-535e-e8c4add4d0f6@kernel.dk>
Date:   Tue, 23 Feb 2021 15:41:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210223063130.GA16292@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Applied, thanks.

-- 
Jens Axboe

