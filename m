Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3188FC2BBCA
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 14:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E100123976
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 14:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgLQO4q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 09:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgLQO4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 09:56:45 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB65C061794
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 06:56:05 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id o6so14642398iob.10
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yQMMQRJfHmfoxJzCu4koSF5OsXDJ3Q26oRNE3NT4X98=;
        b=lh49v0AnBoU3gkPUY1YwcxziE2KyIshv1oxK0pox9tUBjs9FYok4TuPCtyCAkB+AHL
         7aHSFYnDZQlHTpf5l0DGn4z9b2SiYGAkgmmHh7Xpwf1lz37MFdgm2zIJMyObl/LNV1D1
         6aXiyeL9GNS+FMXQ9sIYEg1adkvh+d529mCIGocEOo3uiX0fWeGf8MnHD7MY5a0RD/Fn
         oDI9Ww+b4qu8QJmXsH5DQ96JWENgz6TM9iZQGmkN9y7Hb2Eyc/x6uAON7U88MacjvPRX
         gMdpzIykit1KeDi4QDQ/TKdwh0yyacBP2jtY3OYXksLxgy9l0JiWZ18PMT8wv/PyLKoX
         wReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yQMMQRJfHmfoxJzCu4koSF5OsXDJ3Q26oRNE3NT4X98=;
        b=rEA5QdLNG5uUy/3nuhO9TqT8wXfj3ZwaIMOboa4CmKQigjI863kZanBDKq76KPFj+N
         ln12tDnda1uxCB9MeSZW0laXUzF624jVMbQBj8OOsiGiXTxqw1spJD1DuP+WmVJ9xDjh
         4gghmXeG512ZYQqvfT41NNBwVUhFhnuUPlMUH3YDrP7lhgLr3N9Gjh51xTmUL/z2/3A7
         b6PK2/krBX7+WiDluDfkZvgq7VnrBqELnzdOXGk5NGWKMHTAeX+7M6jimpuyc3vJj17o
         RKywDjWHNMqo0OLC9QaQYv84ZxdBEDpHq71AGTv+dwq00nrFQKhXMc63bu3LB8+zClxH
         kbQA==
X-Gm-Message-State: AOAM532HLvMel3eup/CNwWmtbfvylKE2PcO2W5bnCSlbFAad7v+4vWpj
        VyccRbd3X5FbWMbR+A0TKzJRAiFQn392zg==
X-Google-Smtp-Source: ABdhPJxpDKcFkxqVdPahjyRDt+cOtXnVa3b03yAOSiOuL4iYnR1H9k/WYbU59F0oLCPBLZBBgVXufg==
X-Received: by 2002:a02:3e86:: with SMTP id s128mr48089048jas.131.1608216964967;
        Thu, 17 Dec 2020 06:56:04 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r10sm3312303ilo.34.2020.12.17.06.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:56:04 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-iocost: Add iocg idle state tracepoint
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
 <3aa9c1a1-5640-b60c-4fab-22ee7de40539@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe7435d3-a167-f7f1-54d7-d97c38453c0a@kernel.dk>
Date:   Thu, 17 Dec 2020 07:56:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3aa9c1a1-5640-b60c-4fab-22ee7de40539@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 12:57 AM, Baolin Wang wrote:
> Hi Jens,
> 
>> It will be helpful to trace the iocg's whole state, including active and
>> idle state. And we can easily expand the original iocost_iocg_activate
>> trace event to support a state trace class, including active and idle
>> state tracing.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Could you pick up patch 1 which was already acked by Tejun. Thanks.

Done, thanks.

-- 
Jens Axboe

