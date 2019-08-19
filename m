Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A7BC3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 14:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC062070D
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 14:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uIEkLumQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfHSOqa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:46:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36843 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSOqa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 10:46:30 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so4833544iom.3
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2019 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N6wj/wP3scwBd0+K7wCt8+W+F9nzPetVCKQ0oCnAcTk=;
        b=uIEkLumQ87ywLsyLZg0i6c1luemlbqTY3f8HReibF7MGnTLMXfOhckFC9hiU0MJsWn
         w8BiF3ft4xpYWKWBHrJaQyyHI3MuVIhjgQczZyCG3BnamJVlMpbsiBIYB0sko/ckBnUU
         7LY9Fo02YMbLb4W63aOyyLht8tmmT5H2Ia5IXFdaqbduN9iDAG2dXNBdpo/RQdCTKK38
         JrRxORNZED5fveUoC0OSy5tXh6cc4YBvpTcdfeEhruz2jagXy5GIux5kPFvoht5qJkBe
         M6yGGqP5zvDz4Hccaw2dBmmMzidh614JngU3tWmE1rq7B0wWLd7DwhO3JHMrd7G1jbQt
         hwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N6wj/wP3scwBd0+K7wCt8+W+F9nzPetVCKQ0oCnAcTk=;
        b=S1KUnT16CCDMaxc63LkmH2ZzSwep+xgnTPX+N0g+tKw3RhXBcUx89/nUlIfnn5pBKU
         la0wVrwRA2V8/Fpc1LxaXsxveglmecPD2jCUQ56u96kE7uyRev/Kz4BJC9l+NbbKZpwK
         P9odtmBlVkO4UrV5o6vOrI7I2BW9eIEn3kRUAd62lYq25roqqmPw5msr6Ci2ROCx/zgS
         9seReBgk4v7LhDN9yqc+m0wOXdh+VXYJNb4KnxZCNfRUtx1kBekX1g0IDLnolLdYr7aF
         avit17M8ftpcRB/WeftacdCAl6EnHZ+10TI22BRZWRfFFGKu194D2hKxR8QxwDv4nWbC
         PtOA==
X-Gm-Message-State: APjAAAWRnicmdVlRIb1PquwBLrYlg0bVK0q1/Uf9i8OOk1Tqc15yCS9X
        0SKwuZNgd1pXwIp6fHkTCbXAOA==
X-Google-Smtp-Source: APXvYqw8nCz/tog0ylPygiGmfnyflsT2Iu5TZG/EfbXGzhPbNvGO9Lv9Uz1zhKe94CX8e9sBT6TCDA==
X-Received: by 2002:a5d:9403:: with SMTP id v3mr10040035ion.281.1566225989616;
        Mon, 19 Aug 2019 07:46:29 -0700 (PDT)
Received: from ?IPv6:2603:3026:406:3000:70aa:6052:7aba:c7b? ([2603:3026:406:3000:70aa:6052:7aba:c7b])
        by smtp.gmail.com with ESMTPSA id q22sm11071144ioj.56.2019.08.19.07.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 07:46:28 -0700 (PDT)
Subject: Re: [PATCH] liburing/barrier.h: Add prefix io_uring to barriers
To:     Julia Suvorova <jusual@redhat.com>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>
References: <20190812123933.24814-1-jusual@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <201e7900-1b3a-b1ce-fe49-d9fa4c3b8cb3@kernel.dk>
Date:   Mon, 19 Aug 2019 08:46:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812123933.24814-1-jusual@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/19 6:39 AM, Julia Suvorova wrote:
> The names of the barriers conflict with the namespaces of other projects
> when trying to directly include liburing.h. Avoid using popular global
> names.

I have applied this now. I don't think we can avoid having the
barriers in the namespace, as we do need them in various macros.

-- 
Jens Axboe

