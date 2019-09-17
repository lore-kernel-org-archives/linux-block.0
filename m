Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36CDC4CECD
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 20:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A6E214AF
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 20:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EskptTkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfIQUwY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:52:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45367 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIQUwY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 16:52:24 -0400
Received: by mail-io1-f66.google.com with SMTP id f12so10871556iog.12
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 13:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kh8aYdesv4KRJUOLLSbFjEpYaMdJ6H+WhCOXlHg9gpM=;
        b=EskptTkGBcrUTeV4EPes5YQq/xlwfcYtAjhiVq0uJd4A4MgUetHwvdE3S553avElxZ
         MEhoJEernui9tqP/7Mxuz1/16n8rc6vd8UnPCyOeJ/GtUDDWUoDoEZu5h2jnOxDbZiho
         1w5ektP/sq3D+GFFYu0U88fQNzEH3DZX/Oqmx1NsaO1iR42aYGr+Gu+b4k5svkVwm7we
         zL/YH2Q2qG3N51pIoxqA/ITqXCF0C5gysrGbDCwMA1jWiMqCgQmpWNMorMh8n8MFO0nf
         gh8yix1ukFtoTm1Mk8RBRK7vyU/M8UMHjIjBxhxGly6PMfV/sHiN5nj3obV59wVVfCdm
         6/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kh8aYdesv4KRJUOLLSbFjEpYaMdJ6H+WhCOXlHg9gpM=;
        b=eSJhrUaLLjOKCIXcfq0cgGVKAv2LA6/RTrraWRHbWeZgolFjz5eE+bFsRrQjUY5IKg
         38N0dh/YjaaTc4UKZdmnLeq+HQ2Sxe1xr9/eWnL3Nthaa649Sy6nwS0Usyya1MA9KVY6
         a6OxSr5kH6hXX/hjC2Qfdu0i/caf5zLj6eNQaottzhLBWvNSz2dvPx6IPSftVE8t++rQ
         J0bdkL1Y37e7hFAak5KHWoTbmqM+6dksqwzzmZdU5pso5IEIAVooWnRYQ6Fpwm9IJw3y
         sDvPE5Hw/FO6rdxnbmfzsX/PAy4Q+z/xmVZTUhpY8iRiAKHtHze+GjCELQ5889aCiNq9
         UFHA==
X-Gm-Message-State: APjAAAVopj7PYsxG93y8EutKfY8Jt3GfC6CGFaTGUguzicgXK1TKsxXZ
        AuFYMSY1qhsiheNiTn41dY/3mB9iaIiYLw==
X-Google-Smtp-Source: APXvYqwG6kf5AyeyJ83j1QmT00pFYinaV46i1tfXAFLlaVIh2Jq/wqRQtUhsTOwb13OWSS1sDzd/Mg==
X-Received: by 2002:a6b:c810:: with SMTP id y16mr925996iof.75.1568753543462;
        Tue, 17 Sep 2019 13:52:23 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c11sm2982124ioi.67.2019.09.17.13.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 13:52:22 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] nbd: fix possible page fault for nbd disk
To:     xiubli@redhat.com, josef@toxicpanda.com
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org
References: <20190917115606.13992-1-xiubli@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3d6a4bd-55ba-a3a9-577e-b98f59610cd5@kernel.dk>
Date:   Tue, 17 Sep 2019 14:52:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917115606.13992-1-xiubli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/19 5:56 AM, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> V3:
> - fix the case that when the NBD_CFLAG_DESTROY_ON_DISCONNECT bit is not set.
> - add "nbd: rename the runtime flags as NBD_RT_ prefixed"
> 
> V4:
> - Address the use after free bug from Mike's comments
> - This has been test for 3 days, works well.
> 
> 
> Xiubo Li (2):
>    nbd: rename the runtime flags as NBD_RT_ prefixed
>    nbd: fix possible page fault for nbd disk
> 
>   drivers/block/nbd.c | 108 +++++++++++++++++++++++++++++---------------
>   1 file changed, 72 insertions(+), 36 deletions(-)

Applied for 5.4, thanks.

-- 
Jens Axboe

