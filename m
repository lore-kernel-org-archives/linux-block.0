Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B869AC3F2D1
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 14:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855F924676
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 14:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KT22H+M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCBORx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:17:53 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39906 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgCBORv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 09:17:51 -0500
Received: by mail-io1-f66.google.com with SMTP id h3so11651244ioj.6
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a0tBhZvtllQvUWUp6ZQPztoGNFVwtv7YcFVARrMmvDg=;
        b=KT22H+M9A+/N+EaDP0Po6iV8/MsUrppvM/g1dXtkaygzEgRudsTB+xHOuiVBrQ6+ym
         EZImuro2nvNgQvxmb2YrX3Xq1AvLyAzZtTD+M2cBIUl6sddpsm5iDrMgO/IrNFnsz81k
         acDPEGwkloN1LhVw9h2hvB5loaBWm/2aisCK7XEvFaoZmgzINFPYkwyXVbQ7aK9939mU
         kX08pOawvjJUVbTiTpO9hFLefonqdROKfrPomv+r+kvIHvt+aR5qTkY2Tur0Fdf+7YX+
         XHH95Ob16H4KfCW9Sy6Q9WzLIOWbnODpWh61JNBmj71bk+Ap6vC0owQ1JSTwgF4EvTiI
         /0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a0tBhZvtllQvUWUp6ZQPztoGNFVwtv7YcFVARrMmvDg=;
        b=JvmR5a3J/r+A5aY/K2eYfW1difoR5/cj6ImXt3fnxx5vHoFQeDUvLcKQbWUPRzWCus
         Uk0hv1f8WyBGeXfrG37aNCGEhqtfNXpe2NEUqg84L7jMpJza7eK6n3D5IRxWlAvHIxRq
         UQGI5xO1rvOG/7Km7PgOUw7nb2wshVKUQQpmIBnDAaBvJlbeSLJP+jClY3gf+O8YSs2I
         6Wc76TmBjc8ad/5BvPYUhdlzqaNquyGg1J41Uhk8vB21UCWWJt6hy4zExsHOggeuDL7x
         SY+Lu1A9gPa1Rwgfe234IOSHaJIWMHathMVAwdweIy+OPZgbjjKQbsVKv1x9/DmpueXB
         6Egw==
X-Gm-Message-State: APjAAAUtA/79OrvoGMGV8XH/Q6QhvavBhQGBT9wnQNrFD8QuBUPZh/my
        +K6s0xPKiG5eZzks9rzwHyWozg==
X-Google-Smtp-Source: APXvYqx3YVHyUAM1aPAByzs4DZtc1emIuOG1m7mpL/Ib4m6txxnpN5VXkKNSeh1FSb5OckpPmF/y1A==
X-Received: by 2002:a5e:8e46:: with SMTP id r6mr7092279ioo.50.1583158669229;
        Mon, 02 Mar 2020 06:17:49 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n81sm3879057ili.28.2020.03.02.06.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 06:17:48 -0800 (PST)
Subject: Re: [PATCH] block: Remove used kblockd_schedule_work_on()
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200302132408.15954-1-dwagner@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <843612ae-c5ae-39af-63eb-dc861948a7e7@kernel.dk>
Date:   Mon, 2 Mar 2020 07:17:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302132408.15954-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/2/20 6:24 AM, Daniel Wagner wrote:
> Commit ee63cfa7fc19 ("block: add kblockd_schedule_work_on()")
> introduced the helper in 2016. Remove it because since then no caller
> was added.

Applied, thanks.

-- 
Jens Axboe

