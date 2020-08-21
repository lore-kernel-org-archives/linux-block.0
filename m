Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DF5C433E3
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 14:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFC4207C3
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 14:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EbAFootx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHUOoZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgHUOoX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 10:44:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEBBC061755
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 07:44:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s1so1931933iot.10
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=07SNuZIZMdj+HlfU700eUufMj6wvWrIT0da9X3XmX84=;
        b=EbAFootxi+AvtIXv6g2P8hGW8dI4z3XcWtgPoLhDUq5WeIitkRXCdcFYtNJugKeLRw
         lxS3M811Y/tkNOQ4kiX5aR0gnI2hQ0LfRDErRMLYiSuw11hXAFbJfzjkw5p8ODKYz8RF
         M4QKJyTgGz/1mHsEVAxmeoKgoCSd85VjEArlFDpS5OZB19Yf9Mmlsq+OsguwcNUeFTVO
         7ZBdq5QSYQgcIc6Pw5rJbnbNaEwCnhPH7vuUy3guUHVgf/iUyq/6Cr5kuhZna2MgjjaA
         C6/nOpQBwH4l1rzKrng1ZHl89V0C/HHclqjSJM9Ak+LBul2oByWdhm3OJEp4sk/Bn3IL
         qn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=07SNuZIZMdj+HlfU700eUufMj6wvWrIT0da9X3XmX84=;
        b=mfrlEGFTV+Hn3AbUzaJaG1uVHYiYK34lIEaCvWuixyAmOxnAt1FlZ4h4NazpzJrE84
         VTOjLr7mCfA4BzRH3+x3csze2CwKDE9O0EVGUB+xq7zheUv/bBzROyt78rTIzhQHS2yt
         qvReNSKv0mQA3lSkfou51FAcjsEKGtWpu+7Zty1h44/GD/kSJh/Rj6jxiYDOZ8QBbq3k
         goYR9zQ1n5mdT9xKl/+ogTV8mtv45p5U1o702FnMlPc1+RReUxM08qAno9lLY25iVUbY
         EzzaYMu7+HeEDCrNfPu1IofaaJ/vwsRvP7iAPpgAJpGXlPIF5UzfLA5MeHdR0NrbrlR7
         sezQ==
X-Gm-Message-State: AOAM532ICwtITzhj5ZNIQZcWgkXNmvWQtH6siM6YOAbnMFSZCR1shi4M
        upzhp1KPYkVzkL0UE2TimzSfWtyZXBD4LpTu
X-Google-Smtp-Source: ABdhPJw/vRunmrSPtzSvcmhJsOZy4CK4OQgF70nGz18ij1v47XISbNFeYur2Bu/X+InVEMu4ET5cqg==
X-Received: by 2002:a5d:9a86:: with SMTP id c6mr2708812iom.27.1598021061372;
        Fri, 21 Aug 2020 07:44:21 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z9sm1348406ioq.52.2020.08.21.07.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:44:20 -0700 (PDT)
Subject: Re: [PATCH] null_blk: fix passing of REQ_FUA flag in null_handle_rq
To:     Hou Pu <houpu@bytedance.com>
Cc:     linux-block@vger.kernel.org
References: <20200821083442.10268-1-houpu@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <78f21793-99d6-796e-50f6-da7fd8f350f4@kernel.dk>
Date:   Fri, 21 Aug 2020 08:44:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821083442.10268-1-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/20 2:34 AM, Hou Pu wrote:
> REQ_FUA should be checked using rq->cmd_flags instead of req_op().

Applied, thanks.

-- 
Jens Axboe

