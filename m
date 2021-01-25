Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1923FC433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 01:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE4F22571
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 01:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbhAYBZo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 20:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbhAYBVl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 20:21:41 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235E1C061756
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 17:21:01 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id my11so8401472pjb.1
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 17:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f7QtsZwPr4U46GTFuhzyc8M7URNXvRStxFGcvYKpg4Y=;
        b=dxPJSW7sJXGk9Z7ugYcaWLjVSvz/6xTcnLwO41v+nGxxOXbAL9YFZ/+kaBrUc1qHoq
         3dyBBwxb7cvbUb2FKL/DgAaxk84qalOL+k4XKdHGcSEcEE3krqSHKIH/9wIPmQPWcBjl
         jgXDdNWnC7lnHPQnl13UuM6y0DoBRZs2QJOZwEI3swKbKBJ/evd/4wQOiWtgmkYTfgWU
         mFFsUmCFSb5E5S5yXOb3r5noySr0/+PAyvdsSABWBCra37B8cGWZlOJM+pmijybOyYe9
         0WLwDW5O5P/ynxM58WpNyQsf6iZfIGLNPHNExuWZEXuRFc7LwALQAh9HskjCarBMi7ai
         +wCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f7QtsZwPr4U46GTFuhzyc8M7URNXvRStxFGcvYKpg4Y=;
        b=Z6rjcXYt1vc2+LI+OsPgiR//nfD2X/7vFurySW/Ynyds0/PC/h2sy852wnbU45xWsm
         8oU6j6aZjfFmtB0O3SgqSrGtY+yI4XCtC7xGHr0gPYPXheUtPaMnjARjVDx17wAIdM7M
         ICKkkrwL56aHLNMpFinYO3RJgs+Y+jE403DBx9vxv04VxaCA5VI/CLqw71gBt/U79hYF
         LaOPFYLf4cTPfdG216RNfBVJDhzBYWC6U/3ppglwMnY1adMyBoA0h0e+V/NMTIDp4PnW
         zE9k2zoZ9NlQpnQh/m0nb9bYrQCgqWYXwUpM7xA/mIaVQk7zf4EUmElnnriBZNhIEvjF
         GXQw==
X-Gm-Message-State: AOAM532Yb2+AJdac12B0ojXAN20rInTdcEI2ucvYKmFOLNv0JbV5+vjZ
        NsJrEROMwprZZojbJl2agPSu9nl5fYVw5A==
X-Google-Smtp-Source: ABdhPJxMYBoliHQRb+yB0y+wU/ln9B7DO7VcnUWGxF9Arwj8gp7wLjnxVFvUK2H3IemOuchDHyHDsA==
X-Received: by 2002:a17:90a:eb13:: with SMTP id j19mr4708041pjz.219.1611537660417;
        Sun, 24 Jan 2021 17:21:00 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id j3sm16147773pjs.50.2021.01.24.17.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 17:20:59 -0800 (PST)
Subject: Re: [PATCH] bfq: don't duplicate code for different paths
To:     huhai <huhai@tj.kylinos.cn>, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org
References: <20201225130016.20485-1-huhai@tj.kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <508c8e85-908b-573e-289d-796c6cd254a7@kernel.dk>
Date:   Sun, 24 Jan 2021 18:20:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201225130016.20485-1-huhai@tj.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/25/20 6:00 AM, huhai wrote:
> As we can see, returns parent_sched_may_change whether
> sd->next_in_service changes or not, so remove this judgment.

Applied, thanks.

-- 
Jens Axboe

