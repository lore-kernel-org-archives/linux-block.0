Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D528C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 00:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiDNAxF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 20:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238451AbiDNAxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 20:53:04 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5C17073
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 17:50:41 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id bd13so2754352pfb.7
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 17:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1F+QMmgmqNsz0P/+D1DEIlkzPJIhGt55nqdOHiLZhaY=;
        b=0Jd+BpS16HN7SmPDWJ5g5VFDbdsB9YHCHOBU1dZOTgbW4TM3ftqH/jaVvE+VFAK0KN
         oRANUrNkmzHZjRirA4AM+Ij4Pq72fn/Lrr1lfpsKxsdmijf7DiEuYBiyWvBpsQUK72De
         GCvk0jWbKyfMh+3dORSXyjhwb8hKqAAU57bM58nKRcFUvM5CShg8fGu4KReZH9Uf8D/J
         VUIJ+kYtauI0G84ObmE7NcyhokLmeRAKi0Ogb1EXZ6Wc2c2GrSYN9gtvy8dl+sGweSY7
         JVEtZnu39dNAGLGR16YJq2eBBlMzSd70XtLYjPiQ61XcHFjSpedeYBvCDtMFLbejM7+C
         dioQ==
X-Gm-Message-State: AOAM533PIToXX/xr5BgJQ3PpXL16F1mm1s0VOoPxlAypcVfMAcEUiRSJ
        +i/OkbwBwt08f2QrRAF9sI94+hdvZ5c=
X-Google-Smtp-Source: ABdhPJwZxO7RkLH2KxAHOIERISnN9gERyFMXO46JGCPbIYDx/1WVe0QawlNtybOzsQdI9Hh2lMX7yg==
X-Received: by 2002:a63:5115:0:b0:39c:d48d:1b87 with SMTP id f21-20020a635115000000b0039cd48d1b87mr216417pgb.107.1649897441065;
        Wed, 13 Apr 2022 17:50:41 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090a670c00b001cbb7fdb9e4sm4123870pjj.53.2022.04.13.17.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 17:50:40 -0700 (PDT)
Message-ID: <8db9ded3-ae12-3c56-5ac6-35ee9b9117bc@acm.org>
Date:   Wed, 13 Apr 2022 17:50:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: blktests srp failures with a guest with kdevops on v5.17-rc7
 removal
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org
References: <YldoSh6o5sbifsJf@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YldoSh6o5sbifsJf@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/22 17:18, Luis Chamberlain wrote:
> I've started to work on expanding coverage of testing with blktests
> on kdevops [0] to other test groups. srp was one of them. But the amount
> of failures I'm seeing seems to tell me I'm probably doing something
> really stupid, so please help me review the setup. The baseline for
> srp is listed below, each of these is a failure. I've used v5.17-rc7
> as a starting point.

Do the SRP tests pass when using the Soft-iWARP driver instead of 
rdma_rxe? I'm asking this because there are known issues with the 
rdma_rxe driver in kernel versions v5.17 and also in v5.18-rc1. An 
example of how to select the Soft-iWARP driver:

cd blktests && use_siw=1 ./check -q srp/001

Bart.
