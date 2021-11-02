Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5C2C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F4361105
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 16:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhKBQDZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhKBQDZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 12:03:25 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6DDC061714
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 09:00:50 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f9so25978530ioo.11
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nx2yvOkoTXWKL9gRpw7tfzN9m97VHL2Fof+iAC0xJ78=;
        b=sPOS6KNUaJa1Eo8MQjzwSv5m7gg9UT7yh6ZPuXd6ys+eV8rKrFzztA68cMNqB8AG2f
         iPs4hnonSULywcFUanmO5XCr/mEbJwAi7uveE2QXAFq1Gy04lkqfK5QoUdQdNRAN0fTy
         tx4WqOBWLtg7DFvKQvuRTu+MMhudCmFpN8FmLFGo+KYECoMs6HSkaHPzJKaAPkq79PUG
         d3Rq+yxsreB7QBr0RmCPfQ2+HjfVz9ECRAh4ZTeIOniPHZ/xCsh1cGi+YWhxKE8lmGY6
         aiB2JGML6gGOLBtV00JBagGBW8IqKjbm+Yv55ZrjEx0BMJK/tS28SA5U+QFrJUnbuN7t
         PymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nx2yvOkoTXWKL9gRpw7tfzN9m97VHL2Fof+iAC0xJ78=;
        b=YEeS8RnHB+aPUUoznT/7jvjVbEK1uyrJ2A2Eb9yPW+wbihCUJ8BdkKtDHBJ5k7XwOk
         mBwVqyZyxp0icbvc9PSsyhNf0DOeLYqTRqeMboGJfVYKRHDEbG1DIe01hheW4m1BiirD
         JoLh3awDpvtgTbPQKXZ0QuwLppB1UAs9sku1xGHUOqGoxFso1ph0DEvu+t2rRp0VuT/3
         HjQXSOEohaIKrSn98lVi11j1CGj6TcEv7SiJjuX8/FAhywiutOIncLu4vmowRMzeVp9r
         nPcApe/+yEjL3jyQ+s9g+oFmEURAT0gE4jZ9zDD6YwPMk0SnI0pUWVIcDuBAmBLqTnxI
         0CGg==
X-Gm-Message-State: AOAM5302Rte0Q5W1OKl8a6sS1QPvA1nZhYhXXoVBH/AXSleYN9/VPw1B
        j7W6ZXXEOpAUx/Vx7he3HuXq97Z0ETppag==
X-Google-Smtp-Source: ABdhPJxK9L5H23CwxGWR+TCiaro2Ap9WL40rfOdLQZ+9gWAaln6m2n3r8+1vpNurR07btmaMBnl0iA==
X-Received: by 2002:a05:6638:598:: with SMTP id a24mr15405515jar.101.1635868849311;
        Tue, 02 Nov 2021 09:00:49 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i16sm9527885ioh.54.2021.11.02.09.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 09:00:48 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] blk-mq: misc fixes
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20211102153619.3627505-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1dc15a1e-5e0b-6fff-6e64-7c7964cef915@kernel.dk>
Date:   Tue, 2 Nov 2021 10:00:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211102153619.3627505-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/21 9:36 AM, Ming Lei wrote:
> Hello,
> 
> Here are 3 small fixes against latest linus tree.
> 
> V2:
> 	- move batched update into blk_mq_flush_tag_batch() as suggested by
> 	  Jens, 3/3

Thanks Ming, applied.

-- 
Jens Axboe

