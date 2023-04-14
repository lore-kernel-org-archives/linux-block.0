Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A73C77B72
	for <linux-block@archiver.kernel.org>; Fri, 14 Apr 2023 12:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjDNM3y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDNM3x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2023 08:29:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59A6E42
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 05:29:51 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5180ad24653so139984a12.1
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681475391; x=1684067391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+uMcgY8IieE8gzKMG5aAaijf4mzx7w11YJMnCEozMk0=;
        b=rTws7UXnVHXf5IQb75IfwnnhNyvcXbUas/gAE01YFc0VaQKYXxMsLDE/uSz7wXWFOD
         b3HKl13+q3zXVUcqPWnYiJVj7a7oJ7LVdTH/qCZ/c2RSOmJfkYNn/mz9k5tUeNLMcZxt
         48r3r+s0ZSPJ/ezc5uZ18nm26ERXoiDmhQaU1mYhO2ZWHK2Ib+fppO4AgUwIp0nLbqH+
         svF2ff2JlEG4/AUj9BXLC39e0Jm/W7kv4PVIZDiIlJxGrQp9ZGo1CbTVQn5Wbx+5pax/
         I/7MGN02AaFf9sv7sLXwIrkui/6Ts9Br2NK5SRWIKLmeRvGNKrj6ex8CTQgTF8v4Obhu
         oGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475391; x=1684067391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+uMcgY8IieE8gzKMG5aAaijf4mzx7w11YJMnCEozMk0=;
        b=QKZeQu9pwwTmaKQ45p9kd74BthYT2l66W32ewlJjrnZeRnFhhKrBuh8F3oQw/KKXf4
         BC+IMwnP7zdtMpsPeeyyrhSH9AM9b5beWHKGeSTYmKIz+9TF6oOd2Cxxj+hXtLEOWRtn
         fv45BIx/T622rw8tHXOuXfZD3tHfGRMO6ZUROflLC1wtHy+v1envT/nofJuxTTMwg4eb
         YSYKlA9Igld2NyyjvToYfDsWPhvXODc3vH3E9EgR7ofmbwqpDditrP4UFGHbycZy7qiz
         wq+LURh26fGOjMaSdIX2SRO+K8EIr5CiIxU/NMM9Bawf52qbdtxDlH7ZlwTmaoc4xzrc
         TbBA==
X-Gm-Message-State: AAQBX9e39Z96JiujnmuiJTs3D6Ts078aRRat9akfrnSLY7ASlWAIVhEA
        c83sO5j0fW7vohl8CxZUoyTBIUpcRxP+n6Nlxzc=
X-Google-Smtp-Source: AKy350Z72TYK6r1hISc329zOFsu2NE/qye7h4d1EJ/ieZ1R8Wg/uw74xsKZlKNds5jn3I7xgwOkn0Q==
X-Received: by 2002:a05:6a00:1f0d:b0:5e2:3086:f977 with SMTP id be13-20020a056a001f0d00b005e23086f977mr2459653pfb.2.1681475391191;
        Fri, 14 Apr 2023 05:29:51 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id c10-20020aa78c0a000000b0063b63303bf8sm1390561pfd.22.2023.04.14.05.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 05:29:50 -0700 (PDT)
Message-ID: <46930d77-7c4d-25d6-7211-183de9deb74c@kernel.dk>
Date:   Fri, 14 Apr 2023 06:29:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] nvme fix for Linux 6.3
To:     Christoph Hellwig <hch@infradead.org>
Cc:     ith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <ZDjhyQfNnHzyvKAm@infradead.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZDjhyQfNnHzyvKAm@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/23 11:16 PM, Christoph Hellwig wrote:
> The following changes since commit 3723091ea1884d599cc8b8bf719d6f42e8d4d8b1:
> 
>   block: don't set GD_NEED_PART_SCAN if scan partition failed (2023-04-06 20:41:53 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-6.3

You forgot to create a signed tag. It's trivial enough so I'll just pull
it, just a heads up.

-- 
Jens Axboe


