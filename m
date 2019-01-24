Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7392BC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 16:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382A4218AF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 16:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EPboUebX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfAXQVW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:21:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46127 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfAXQVW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 11:21:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so3205196pfe.13
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 08:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TxPZXPKfoiWkt2T5Ek6uKUZEXK2bZCbTeFFe0iERMsM=;
        b=EPboUebXkRdmGw/jBReQtacFZO4A/wRdQGgsS2RT60IzpHb1VOGqeYxZngL/9jC8Is
         9TJmknnp28CqqAYyeQ0MZMTGkDhXWSe3YeDzCZBWZLGj0gYh12VkXo3XMxTEc11/4YFL
         DdT/kHvmnd5jizQMS0vAXrmktGyNlp/6D0c6jDuzgNzd/XUlo6fYCdGcSz/IeE1hIzdG
         aEZhHzFl6ZzSkG6tYQnTxlnOYY58i04oXLrHP93YznJOQmh1gIU3F9nOncZZBat2l1HD
         j+X6/E4EZDMFEiV/oIYNBd9nxpoVMtKjfVGCVFwCxujUe3AoFGwuUhZKX3rm+bmNoDX8
         0P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TxPZXPKfoiWkt2T5Ek6uKUZEXK2bZCbTeFFe0iERMsM=;
        b=ffKISwUgYhf6I+lyWZRdBZWoJu4EWYNDKoC+8VPrH/M+wzEoZnG4rQ/hRm70Rs8AUm
         OaRfHY61KqQQG9k7XxmeSrVkuQmQU1Ivucw5Jnt8L51bNXcR55qSySG3E8UPPWOY9dM2
         VPm8cWzT8MWHjBUh9VZY5nSPrDDwk5g62ZdsrknweAAB1VYGUJN5sZw4ZDAQEumHlqQ2
         mHtGhoHJYJuZjwTRq/+iflB55WQsXM7weNSWJIOJPY4SzNh5eQqhz72ejtxuRGP+FK24
         4xJKBPP31eFgNPWrzcfdIEWOXkwFoARPCVXcyqAMhBEx4sERhK7TvErL6Tl5oR0HCuNr
         0Q1g==
X-Gm-Message-State: AJcUukezVU1qJhjvmsStnUnXI5hEn6LZzH5nx1O2YTeQ+6qSjD3OAjE7
        8TM1SpprsPFcjAjqfidaLO6ETcmKHwM=
X-Google-Smtp-Source: ALg8bN4X3a80TUzjkMEU3NJQLVV0MugRDnS+OFi4iR334m2EZKdfWe7ENGuFCxVMJTavLm+Dj9R0AA==
X-Received: by 2002:a65:6094:: with SMTP id t20mr6424543pgu.285.1548346881549;
        Thu, 24 Jan 2019 08:21:21 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d68sm31474232pfa.64.2019.01.24.08.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 08:21:20 -0800 (PST)
Subject: Re: [PATCH] blk-mq: fix the cmd_flag_name array
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1548325735-1760-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0a00164e-e523-a5eb-ca9d-907664c456f1@kernel.dk>
Date:   Thu, 24 Jan 2019 09:21:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548325735-1760-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/19 3:28 AM, Jianchao Wang wrote:
> Swap REQ_NOWAIT and REQ_NOUNMAP and add REQ_HIPRI.

Applied, thanks.

-- 
Jens Axboe

