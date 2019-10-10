Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B36C47404
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 02:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53BA218AC
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 02:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wGuAwrMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfJJC7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:59:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34941 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfJJC73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Oct 2019 22:59:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so2933762pfw.2
        for <linux-block@vger.kernel.org>; Wed, 09 Oct 2019 19:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0EaF5/8cz79JbfwGKC4mXzxVGyBZQtQs33TlYFqnjTw=;
        b=wGuAwrMNpjH1znD2l2guQjuI8FllOXRp19mwxtrWg6ZCNNCyxE/sC9OS63ccue6Ba8
         ezsFgcHWQ1sJmZAeIxWSKu+bxbbjJ2y3EQR3270xNACSD3xMLgqrGLA68fMcxhk0k/gZ
         3WZy7DeiiCi9PUdjS6ILilyxBiV3kpxlbXwIk58wy5W/t2xf9PxTB5RWAtMaebyH2Gx6
         DBkeWrBJ1Zgh9sH9LIWY3y+mml4VlVnvO/OrxF2SmYf5VFcEcJvNqD3qB7L+yes9YIFW
         jpHq4ddpQZIQNCWPRD5XgQQ34ljKjOU3PV04dH7C+B5OGCMsfDqWvKq7uReIrlY0ODnM
         H7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0EaF5/8cz79JbfwGKC4mXzxVGyBZQtQs33TlYFqnjTw=;
        b=nokDSPKqQwWtne/oOgdYV1BAlVYvtvQlSqcH3HClIw3nj2pWyeBXU1VQi0AsGE1udD
         RFwUubzfU63vzptWcSS+d4GgRpFau2dkUwodJfu3Xs55RS/k8rVAGRVHqxaU3KvG8C2r
         wUop3GpTD0MQUosZdz4ZdS1MSk8mrY0zEKYghC8TyTybQsifncdw5SB3W2RXC5lV3Mk4
         +wDf278WkkYjO0+T2px4FeWdSk7y6+7aKVipCh5Kipah5yo79RgCFa0KCE0rG8WL7zcu
         Gf10dKL5iKD+UJQ1ixRKSvq+uSzKdNF0dKakqsuJ1TBosquTgME1YIDFw27++1bMAOaT
         BD/w==
X-Gm-Message-State: APjAAAWtECzhZj2D0So01MPt6NSNFA5Yy5twKY6rKTQBZf9cNE8rJSXl
        8nFBxQBv44qiVyc7XiWoaGIuwMFIIHqsQA==
X-Google-Smtp-Source: APXvYqx4taUiDTUexORtbmb0xJh0FJnbxarAkRXA3fwyxv7ESE6nw5rLnQ6Z64GkK7VifCJSwJMwHw==
X-Received: by 2002:a63:fa0a:: with SMTP id y10mr7998481pgh.446.1570676368291;
        Wed, 09 Oct 2019 19:59:28 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id g24sm4136519pfi.81.2019.10.09.19.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 19:59:27 -0700 (PDT)
Subject: Re: [PATCH] null_blk: Fix zoned command return code
To:     kbusch@kernel.org, linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20191009153813.4854-1-kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5cde2b4f-3bd5-04b4-3356-1d65a1ca228b@kernel.dk>
Date:   Wed, 9 Oct 2019 20:59:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009153813.4854-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/9/19 9:38 AM, kbusch@kernel.org wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The return code from null_handle_zoned() sets the cmd->error value. Returning
> OK status when an error occured overwrites the intended cmd->error. Return the
> appropriate error code instead of setting the error in the cmd.

Applied, thanks.

-- 
Jens Axboe

