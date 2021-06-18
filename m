Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E4DC48BE8
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 14:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D43361004
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 14:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhFROzK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbhFROzG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 10:55:06 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967DFC061574
        for <linux-block@vger.kernel.org>; Fri, 18 Jun 2021 07:52:57 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w127so10820431oig.12
        for <linux-block@vger.kernel.org>; Fri, 18 Jun 2021 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lfcsRgFy2xq8rFyaA8Nz5ZAiMzCPmlUUdOOARhZaZCQ=;
        b=gsoQ9aEfUO7Xvs0FyVDIHEU7u9CS+WcWA/IyOVjbcfTH6pgLtYG8n2K/qgdFFkFmRf
         CXTr/rOKIp7UANm9ovr65iZDf2vHLmZXO0NOcG2mXmkgoSworF25MLAOtYU6BaU6Ichi
         GOlS7y1zLqEGJ9rFASZT+JtZpp7+ECxoZiEAIP1DCUfxe7nPbSyGxqSvowpB/q6Yvykp
         9TLWjo5CE+48kh9XOMzUniF9/K92pN4OF45voWnFAQ28XOrkbcz1cWim2QhVcOj65y0G
         pnGfcfxt92pZ42v4BaXBzEZCgklA785C01Zo5obJPxYqQCFfnBYPpNC0uBD8JWsZEFc+
         ybWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lfcsRgFy2xq8rFyaA8Nz5ZAiMzCPmlUUdOOARhZaZCQ=;
        b=M71DZzQems9hGwQ66zdmjizpbpP2poEQy69zUH76O6L0TugOlJal+3yjIqgZLN3Nsx
         1hMtg3ELPnjEuaQEettkRHjAUKuG36FayNIBnVQcyqzTKCyGsZ3FWmeOKRKMURNgQE0H
         o5OGin4ASw0qgIsuy74VpcMt64Zs54uf8AY7mG/aaaREBYDnuZm/XG+WttwRkaIY3DC+
         MW+/lmXIKfOd1n4M3iSZ2cxOiXKFCkpaLT6DnlaAFA2LKhQYCc/MaL0AEZWFGWLiJvAt
         W3cIbq+HWuuPZXTO7sbjRDynhw/0FYhYcK07DE6RA6uNcoHRICe4m0cy3+WP0aHXF9bJ
         3jgA==
X-Gm-Message-State: AOAM533ajq1j0ZxtG9dhVIzxltSTd2WMnNMSF3aWEbSCv9e4TgIjkr80
        qDAME1+BJQeq5VuBZTIW5Ut+Mw==
X-Google-Smtp-Source: ABdhPJye1eow3zDlcW8WFc5WqtQz3JnuGxiQji+GYWeMI7kL1izOVo3QAosH6I6TqQTmqa+mXYdt2A==
X-Received: by 2002:aca:4fcc:: with SMTP id d195mr14553893oib.88.1624027976941;
        Fri, 18 Jun 2021 07:52:56 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 3sm1856148oob.1.2021.06.18.07.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 07:52:56 -0700 (PDT)
Subject: Re: [PATCH v2] loop: Fix missing discard support when using
 LOOP_CONFIGURE
To:     Kristian Klausen <kristian@klausen.dk>, linux-block@vger.kernel.org
Cc:     stable@vger.kernel.org, Martijn Coenen <maco@android.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210618115157.31452-1-kristian@klausen.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <64494b7d-01b3-8da3-e10c-d346746758ea@kernel.dk>
Date:   Fri, 18 Jun 2021 08:52:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210618115157.31452-1-kristian@klausen.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/21 5:51 AM, Kristian Klausen wrote:
> Without calling loop_config_discard() the discard flag and parameters
> aren't set/updated for the loop device and worst-case they could
> indicate discard support when it isn't the case (ex: if the
> LOOP_SET_STATUS ioctl was used with a different file prior to
> LOOP_CONFIGURE).

Applied, thanks.

-- 
Jens Axboe

