Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EBAC433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 14:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiBVOBo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiBVOBm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 09:01:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD710128585
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 06:01:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m13-20020a17090aab0d00b001bbe267d4d1so1802573pjq.0
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 06:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1EuJPg3zDH+553oumLIiCfwPqy2DMhgvL7xVVgemWXs=;
        b=oA5HSbFdUn8MlHqwBhEfHVekBTUbyw5s+8q6W+GJ5rK4yLcFNJ1BWXLZNmzw64hWLg
         sz1Ra30efTFu+RTJuMU/DJj978AbDve9xVx5kXt9Xv9toiumahNKEEmlLjQelTO5SoPS
         kuz2PVQDYTj3S/6jztGDzbdEf7tBBFdy3Xi3IFyAdcYRlrNqvHeyZm33n0FKSiPsXx6s
         yuOU6Y5pcdrcNNggDuScpuF+DZS1qh5Z8bcBcayw/RggZd/3/mLa8XrLGhj2Z3qqhSpV
         adXIHU6SL/b2ULcZYxcuvqOQVCGtBk1XBrXMMTNvyuNSNyFNuuiaTp/D69Hx382D8xsR
         w3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1EuJPg3zDH+553oumLIiCfwPqy2DMhgvL7xVVgemWXs=;
        b=MCfxpn8RyukLn52ZQMZYKEqdvdX/5oZzhLuTbdwoIwFbP3HQ2MF5bH3d17hRArTl3y
         OpxBHF+QTi4AhGKYl5WLhVtfLCW6yp/eM/vRyIeoEl0o5HjOZEl5XlPkj7GkubLuTnWL
         pBv/MfD5sfiokGMk/UbwDlOFPF7TakNYVvFpYeafJ1z+946YmCOq31V47ngQPBoxpbTj
         ZlahSbY/+idDOaY7iVCDTieeJGSQf+sI+dm4q21nSQCbmMxCbP55q81oM1oh8BqyH5mv
         gaH4FO+pTmutcFm11sUGVTF17b/5gIXf0Rk/RW9nl4CpvXGkkT3UEca2AtzNkOB22svU
         t1ug==
X-Gm-Message-State: AOAM533oVsAGNFXDPy2I7loHSnnWG9TxZsNYEhOuOZsM7jbNP9UHFH0L
        X5IKXoTQvDKQUJh8qaPXKI59fA==
X-Google-Smtp-Source: ABdhPJxXio6mghvZZVs2OD+URAyurggbN97AdXL/5x06qMLGqHXHiFntXchiDlhukcWRtvIRzagfEA==
X-Received: by 2002:a17:90a:8581:b0:1b2:7541:af6c with SMTP id m1-20020a17090a858100b001b27541af6cmr4299890pjn.48.1645538476207;
        Tue, 22 Feb 2022 06:01:16 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id fz21-20020a17090b025500b001b9cd847ef0sm2951474pjb.35.2022.02.22.06.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 06:01:15 -0800 (PST)
Message-ID: <be020330-5b67-ad0d-0214-b89f97f8d3e3@kernel.dk>
Date:   Tue, 22 Feb 2022 07:01:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] Documentation: block/diskstats: update function names
Content-Language: en-US
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-block@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <20220222012751.1933194-1-naohiro.aota@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220222012751.1933194-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/22 6:27 PM, Naohiro Aota wrote:
> __make_request() and end_that_request_last() do no longer exist. Replace
> them with the current call-site.

Reviwed-by: Jens Axboe <axboe@kernel.dk>

Jon, will you pick this one up?

-- 
Jens Axboe

