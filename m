Return-Path: <SRS0=7JbN=AR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEB1C433E1
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 14:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2761C20715
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 14:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gcBTsmhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgGFOH1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbgGFOH1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jul 2020 10:07:27 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4583BC061794
        for <linux-block@vger.kernel.org>; Mon,  6 Jul 2020 07:07:27 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a11so24737340ilk.0
        for <linux-block@vger.kernel.org>; Mon, 06 Jul 2020 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uDa1WZzszGxgb8+nG2q1huh3jGqDIOiOnkJHCYDItb4=;
        b=gcBTsmhcoVvIv0cNdRs3kSrXVOfekloOGZF3yyDE7UGilGPfqXquSQAZNKpdAzW50B
         kD6c0hxrAV14Suy9u9o+mia+tSTqNqXTMQMTqj34boAyNrzwRIHefVqabU9UbDpdaXi5
         L9R4Mh7H84089CRCNy32nk/H7zWsj8qdC3ZgfUTZVKKI/eN37shfo29arFPBKu0j8Pu3
         pwqAelA4GZuXPcdxfnI5bgDDk6vrNoDCc5qv76bEgiQAAbE3cczYCK2ET1il9nIalNjR
         HnJuQXkIOy7ru+BK2eoK7/Y3hESNkWfsZ3XkxV0EdUIeH1o7LOblGI/b+pV63x48VPNc
         v/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uDa1WZzszGxgb8+nG2q1huh3jGqDIOiOnkJHCYDItb4=;
        b=FC7mK49aXl4fH8dptIAtnd4VULSWV6YmhmOZKz5u+LAYD//aNyQI3iU8eTX1+5a3HY
         IavBDNDcW/aNKW3YtJV62qDfrF+WALDKlQqGJI+yAZOw5z9B48dzetXB047ELfVGhb/7
         XtMseLTbdfzAg32+MVV2MLYyb3qwkCQGaLKKuNwdYl+CSOKsLjmxPwxfNTV06fAQ/iE1
         +/zAxwBhXyB9fZiMJGS2L3uPctjhk1sJO712G7rZ8CcM4YijqMrxtBuCQ28WVDuPapfI
         1pYhfuqaXcwl7oR14X9PdFfgqwjp8kyGD8C5fSVqie8NIbh5IL9HlzjdDNyiSLMTUftF
         U2CA==
X-Gm-Message-State: AOAM533WKLU7Dh81fIEYMlL/9xFQ5Bu1nImUka5T8mIMCNOP9eL+lLsr
        1WEa6Az/W2XUDl3KY9hvP0bAhxKn7A8/vg==
X-Google-Smtp-Source: ABdhPJyWZUzeSe0dqL37z0ZdPjr6f9SRMpVFBay/Ef6q//w75y80pvTAvKEcUn9pYSQe7frLM9MFGQ==
X-Received: by 2002:a92:d6d2:: with SMTP id z18mr29469475ilp.272.1594044446414;
        Mon, 06 Jul 2020 07:07:26 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w21sm10484676ioa.48.2020.07.06.07.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 07:07:25 -0700 (PDT)
Subject: Re: [PATCH] docs: block: update and fix tiny error for bfq
To:     Yufen Yu <yuyufen@huawei.com>, paolo.valente@linaro.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org
References: <20200703061323.959519-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d60beed2-066d-0908-5fa6-caee16eb73fd@kernel.dk>
Date:   Mon, 6 Jul 2020 08:07:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703061323.959519-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/3/20 12:13 AM, Yufen Yu wrote:
> The max value of blkio.bfq.weight is 1000, rather than 10000.
> And 'weights' have been remove from /sys/block/XXX/queue/iosched.

Applied, thanks.-- 
Jens Axboe

