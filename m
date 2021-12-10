Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6401AC433FE
	for <linux-block@archiver.kernel.org>; Fri, 10 Dec 2021 13:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbhLJNsh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Dec 2021 08:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhLJNsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Dec 2021 08:48:36 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B676C061746
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 05:45:02 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i12so8512383pfd.6
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 05:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zocsZqbIpXZdqvpCYwUWFrEIkd60Xqe+FQJzj1rvev4=;
        b=AbQhCDpQ0Ehd4y6VRCU9Xp+w2iQGThwL+NrLq8mt0bnUP2hycyjxRZBLqD3ukR45J5
         qpwkggjvZhxJ/8D9Ohs4B8DQxubXC1f9fecars+MacsJzSKZo4J5BbwFhDliV9Xv+ppM
         y7xSOYpUxM+tdGoQr1obbDGMz8eCwBpgHqkgSnM9UB4O4ZM8zrx8rWVAXQE6Dr5ydL5i
         cpltsrsYQiBtptl3QfPCJtsq6xUkhMAwEh3eUkeEciXfdg2xlkZXNGTNkC6SB30pbu0r
         R4wpD0Mfm8YH/tJdRbebkzuWhXZYaxdYkvOP664IIZxelc43tMFReJp/K2GlUVZsJQGg
         eq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zocsZqbIpXZdqvpCYwUWFrEIkd60Xqe+FQJzj1rvev4=;
        b=eWPblUzGLBIndmkq3rER34pRNzO+e/NHtqjShYxQioJFJ7lJMVN3z7B6HM3/NQJsFK
         DxCxdjcpXbO6p/kaTLa1KVwT1xyxHpJr0KAHLslL/qSAbQZ9IEDcHo62JuSSSYQLo4SB
         PATBmIH3jswo2lIPaO7cXdVGHljfHRZYVJVflfHXTp68+tbwTvzGV3Z1d8k6VNjv8uRt
         wX6bHPxi0Eue0fKHLEd2lAyTI844iMUtPS7nuqVkmdQ8H4A/wk079ple77qpGd2/lsk2
         7zTLmvBghROZmzIb0BkedWFHRHxcLQ+vz9dAuM/Do4X+2Ff4VENz8LJORKDLjHkTWXMj
         uidw==
X-Gm-Message-State: AOAM532Ked0tDOc8oYyy/G3/jXaaGQhgVPxbOGjgYaTau4IaoG4DvoOd
        EU/QwVOpzTLe5IYrHvo0Yq1uAw==
X-Google-Smtp-Source: ABdhPJwlCLpg1648Cq9/sjohU1cgq2MOES4F7USfuo1J6BYOQRwajmcZVxBHWuHjb7DNs9Um6rzvFQ==
X-Received: by 2002:a63:d04:: with SMTP id c4mr35264634pgl.472.1639143901579;
        Fri, 10 Dec 2021 05:45:01 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id ot7sm13827753pjb.21.2021.12.10.05.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 05:45:00 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.16
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YbLwmaLqilKEW0Q/@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <97bdd109-4854-459c-ca05-8c5c7c4ac9b0@kernel.dk>
Date:   Fri, 10 Dec 2021 06:44:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YbLwmaLqilKEW0Q/@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/21 11:15 PM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.16-2021-12-10

Pulled, thanks.

-- 
Jens Axboe

