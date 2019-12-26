Return-Path: <SRS0=USsu=2Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB10DC2D0C8
	for <linux-block@archiver.kernel.org>; Thu, 26 Dec 2019 03:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648442080D
	for <linux-block@archiver.kernel.org>; Thu, 26 Dec 2019 03:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="06/uzh3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLZDje (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Dec 2019 22:39:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34825 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLZDje (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Dec 2019 22:39:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so12273566pgk.2
        for <linux-block@vger.kernel.org>; Wed, 25 Dec 2019 19:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2LoNnrg8/MyU7ECXfmG6IB7BzK3+XYl9Hp6H8NLt4zM=;
        b=06/uzh3FNHZ73GGwKi0y/+9z5AlflDyf/bnCPO81hytsOKHWWLzyf0GfQ/LkCthGvU
         eAJsYCUeGfOO55GZbld5E9OzKBMGt/6zOTqsa6AKle4axSerM0R3kgSk1Hnxtm5bq4ZK
         inKAj4NtEsgrXxrn1IhGT0eewjcjtznSILKy9G57MkTpMcqLCFBKKEcFyIB4mzv457na
         FKyzGN+/F/EfM2VmgT9L+4wk3nz9ghBud/l5OUNnpsin+VSXmmULizET1olmaMNIFM+O
         JfHQRhtpAGSgT0DJ+8Sx8WLgYCb+xNfIkfhgSP4gJeFsPKOhW+ryuw2wvB8WSChojGBr
         THSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2LoNnrg8/MyU7ECXfmG6IB7BzK3+XYl9Hp6H8NLt4zM=;
        b=XVfq5ixacohLNyno8TUd5xG90pikKAIeEYoV83xgl4LVwPoGlGKwvfE4achxLr0YIA
         mXUFxrzykDQdzyxP4jXokHhcqHk2hNEktMnF6vXLte09TW+YoONBK7nxZIYwo4EvXTpd
         FCACtww9y25uLumk8q2sEgnHjgdwSvm06WiXNaffQXYNqiO91CDuWUIxjqdX8qtLIODX
         9RI2iW1Z2TSc8LANzNKAHd8yaTxlor0nWIhpn6rP2Qa0eyYG+5bQQYcPtW4sn05t8ROT
         K5Vv/9XbPMjTw9wMPaSEzmkpzx7jVtpoF2qyj9rwxhLWhY0AeCLqwtZXD5qIEmSSjtcQ
         7Fzw==
X-Gm-Message-State: APjAAAVqWxD36mjpcmjrowKb66IhnoyeIX49dQpPaMfhQQ7Sgt3B2TvQ
        2uA/BOEc5OqHf3kCCsg8AkY+tp3+WSqRug==
X-Google-Smtp-Source: APXvYqzM3gpiLAHHkcvCuSoGqVQCTNz1IrNcjQoG+esM7Ab+m7Nh0bFXUYFDus8hzhROo5BUIeM2jg==
X-Received: by 2002:a63:4e0e:: with SMTP id c14mr46160249pgb.237.1577331573938;
        Wed, 25 Dec 2019 19:39:33 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o134sm29031425pfg.137.2019.12.25.19.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Dec 2019 19:39:33 -0800 (PST)
Subject: Re: [PATCH v2] block: make the io_ticks counter more accurate
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, xlpang@linux.alibaba.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191226031014.58970-1-wenyang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41175786-8a02-62e0-fc79-955ec0e74aeb@kernel.dk>
Date:   Wed, 25 Dec 2019 20:39:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191226031014.58970-1-wenyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/25/19 8:10 PM, Wen Yang wrote:
> Instead of the jiffies, we should update the io_ticks counter
> with the passed in parameter 'now'.

I'm still missing some justification for this. What exactly is this
patch trying to solve or improve? Your commit message says "we should",
but why?

-- 
Jens Axboe

