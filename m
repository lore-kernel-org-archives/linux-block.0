Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F3FC04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E28205C9
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UFXgx9Hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfEFQVu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 12:21:50 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34484 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEFQVu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 12:21:50 -0400
Received: by mail-it1-f193.google.com with SMTP id p18so14869946itm.1
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JM/WZfijWawO0dM75sC9wd0xm0O1e7k2DME12T/WG/Q=;
        b=UFXgx9HuMJqBVirFEYXePbVMPL7ifubbChBpKxZBsozZhVZdUX8Ot96uTiSw/V7CNk
         fSLYzzNvhbUb5hAYmI5Zl6SEyQ2jdbAKtEms3Ypy2pQmMDDum4DOht2B4MltviwdHnoq
         pXa0AIgIt5dGhunS5vhMZ92AiF53tkkXPDPv+0pTedFeqkTRhFOKBfgyTCqxB/Bi1xP2
         dPQnaN2VrGkDeGBjsgm960JmoMz207/11+prKIuW9Ru/8earF5aZf93UhtGUWdlB18Eq
         8yfQOtssex78N19DTIEBJQMWZ9atH8CaNx3iNa+PeisifL3Ff8LW9WaSlUw/DyuxyxS9
         5Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JM/WZfijWawO0dM75sC9wd0xm0O1e7k2DME12T/WG/Q=;
        b=iwpn386dRQLHMIeEhYuZFY1B1sIW994IQzf6AYqii02bIK1YtT7SCUuZQfDiWjDHVv
         Dp8ezjVc4zIqpT2HJ+942MDQeWDd8Tmz/cq0JNie2a/vjGj9HJJVXahYtivSwlC+PiOT
         SwOoRKUW97CAVbEwP2NToP9TGXkAIwOKbd5xWnhMUQ5CDfmAC5jd1IRCRhz1DoGPTWGj
         nqfjQtAT3rh9VjUlqEV6+fAHEUVnS0yF3WH+c0r51lAd2O8s7wdGHENtPSs2mGlhemH9
         GOtwCnUdnsXv4coU0dLdfDnLUVl+PKM7a9hbe9fJL4abGBrPOnLWv5ZIwu6C4+4mZPA4
         mjRA==
X-Gm-Message-State: APjAAAVP18lsXcJ8pLKdhmJqtqO1RyMS5OlZ016sTUjQnH/ggRNOhLYS
        Eo++Um7hWXHOm8oAXgrN6nUpHQ==
X-Google-Smtp-Source: APXvYqx5RyQ8KTZzVdgGtPBddYXhbpfXTeY6xfZ5bVFKqngkFqVvd5/hfJWmx5YQugDGs5G6H8rXIA==
X-Received: by 2002:a24:6987:: with SMTP id e129mr18889644itc.28.1557159709220;
        Mon, 06 May 2019 09:21:49 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d10sm3880686ios.72.2019.05.06.09.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:21:48 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix shadowed variable ret return code being not
 checked
To:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190505220122.5024-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ccacedd-41d9-f33c-25de-ae16bcdb7b08@kernel.dk>
Date:   Mon, 6 May 2019 10:21:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505220122.5024-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/5/19 4:01 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently variable ret is declared in a while-loop code block that
> shadows another variable ret. When an error occurs in the while-loop
> the error return in ret is not being set in the outer code block and
> so the error check on ret is always going to be checking on the wrong
> ret variable resulting in check that is always going to be true and
> a premature return occurs.
> 
> Fix this by removing the declaration of the inner while-loop variable
> ret so that shadowing does not occur.

Thanks, applied.

-- 
Jens Axboe

