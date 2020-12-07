Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9B5C433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 20:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 293DF23406
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 20:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgLGU03 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 15:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLGU03 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 15:26:29 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D16C061793
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 12:25:49 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id y5so14696034iow.5
        for <linux-block@vger.kernel.org>; Mon, 07 Dec 2020 12:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XSxnIDKWcmc0O/D/BAiNcqMFr/Q1xkYuolO3yfQcKug=;
        b=X0IPKpZt1mMWV5/EmNhHxPVsoaU+asFnzl66rcvKopkXQ+Dr9wEUd7huG5Sxfihn+W
         YsuX2I3+8um7A0f0rqhsBEjdvdGD0ElgqB1De5K13saBLU+697+Dgp82tFuAl9A3iSFM
         cVtbrC/t7L/NXe8OsWznLsdPK4WKLxJkXIhR+f5PMW4UEVT0gO2dp2u2/OynegwklSK0
         LsDimflFkrgTNtCII//nH+/e23F7kJIAl0bl4ZNnwLh92HRKC/K3hyGXmdF5L0mTdef+
         8W/R2n+5qkYzK19EFm2bPX4h6Hdsvm6kG8AOmRnHJb6qHY0oQyFLa12kEv8vB8R3qo5x
         NLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XSxnIDKWcmc0O/D/BAiNcqMFr/Q1xkYuolO3yfQcKug=;
        b=X+UaAYoG0e011GuYh5D2NHWlX33jRf5A7mymPZ92f5lna4l0qgIvblucjJFiLVpx7I
         GP5IHpk7OTR/cGjLWDdJ+ZLQG1yO2QY6UEEFC5HTK7qC2Sxw7ovgZwHFYZlIrSmhmyJ8
         CFOLhHrRALNALo+W14xc7kHpF5mspruSeV4e+GzQ5AL/PQjNc6Eb9AJjQfV6rZjK5NkO
         GgtVdyYczZ0g4Y4nhmfN369qKydSlSXSNevYtdTcIFO5d2mC55VKRYYhiVUFJvd5bdHk
         Tu2GnqD4cE/QkjfCGsJHO2cuwWFTRJTNk+AXS0zO3nbUmyDIq8vNpDvlHXGSdqMHm6Uo
         lEHg==
X-Gm-Message-State: AOAM531CYN3Logo5Ec98mhyBsrixaK0h+aVNzaVxn/68h3DYV8PJ6JOx
        1buBTFceCAYH7M+1aIoNrnWsw0XAqyWVoA==
X-Google-Smtp-Source: ABdhPJwYB3CEe+LJBdyvrDK2hyXvqaMgSG3V8/dDvdhRxLOkWXF5HVD7ENXvS73eYN1zUYVdmSPsUQ==
X-Received: by 2002:a5d:81c1:: with SMTP id t1mr21544034iol.88.1607372748104;
        Mon, 07 Dec 2020 12:25:48 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l78sm8536115ild.30.2020.12.07.12.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 12:25:47 -0800 (PST)
Subject: Re: [PATCH 0/1] bcache: first wave for Linux v5.11
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20201207163915.126877-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8a7d64b2-61a1-353d-cac2-4dc6115edfb6@kernel.dk>
Date:   Mon, 7 Dec 2020 13:25:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207163915.126877-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/20 9:39 AM, Coly Li wrote:
> Hi Jens,
> 
> The first wave bcache change for Linux v5.11 is quite silent. Most of
> the development is not ready for this merge window. The only change in
> this submission is from Dongsheng Yang, this is his second contribution
> which catches a very implict bug and provides a fix. The patch runs on
> his environment for a while and takes effect.

Applied, thanks.

-- 
Jens Axboe

