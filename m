Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20982C4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E768421848
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jMKJ/QVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfIRClx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:41:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44231 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfIRClx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 22:41:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so3345022pfn.11
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 19:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XLH+QDfucuonGTHbjiPB3QV6rBa5Rb9Ayh4on+IFuuM=;
        b=jMKJ/QVNJeitmnq5PqC3cmngVTenmvy+LoQf/pr1gbpSdWMblWSQOumwj68MbI5vae
         t5ZagEYLtptyuqL0f/vl/S8CK/mTl1C2nnZXwazI/vfLKhdUNsY9UOIbvieoWGzD8HVv
         HyOw1EMY2rHcwLCgP+pFMWKm8IKseeTGArniVDsHVMNvyHjS74rDlLco5C1pX5mOgxrM
         e0WoVsmopdRrb+1P7NUlpXMqzM5XPw77Xn8HHcZ5uObmyt3wWlyjF9dBfWmytyw5kRyX
         6VzUK+pnQUUxOlrYV96g7ED1RoberixrhjSQYfIdMcUJxHEij7stmo//GvuJDS1Ujr9c
         rDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XLH+QDfucuonGTHbjiPB3QV6rBa5Rb9Ayh4on+IFuuM=;
        b=RIGzpUHPmNze2zdA5A45VAphM/4jcPvb6fY8c+gERrOWkuL4yUhYspdAkqqHdpVLRi
         CDHLbaGCp4zMHjPtSC+pkWB60bjIbLjkQQoL4AxtN6Z69tIEzOQDLMLBb80qfBy3S6w6
         7Hh74JSJlGhQB73z5K/2YlbdXCH5OGFNRDW1ror9WRyVWec5R/0uAs/f8G7zrlYg3za0
         vLWpI9YKW6eaLF4EZf5IcdWMz+Q0FjBu7sH2CBeh7cCHYoq/TKWI12PvJDYb9fO6N3Hw
         AsIMO5dKjhK8CZP6/BEAjYiiL3SQJLZSsM5hLL3cYIIUOx1rm9st17+abmKzWoO8hrOg
         JAiw==
X-Gm-Message-State: APjAAAWGygN9pq1nwAtpqH6cUSoEZyxzOQji6IQBMopuCpVgaL7aESye
        Gwhc/DC6k2t1iFsWfJpwl5+mM/qsueLfUw==
X-Google-Smtp-Source: APXvYqx1jERbjRy9813h1D1lEV/HgB+Ni8p+YqWhf+s+dtC7pCa4XnpCNFATvNd3+E1kyztshcEY1A==
X-Received: by 2002:a62:76d1:: with SMTP id r200mr1738446pfc.27.1568774511817;
        Tue, 17 Sep 2019 19:41:51 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id u5sm5201472pfl.25.2019.09.17.19.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 19:41:50 -0700 (PDT)
Subject: Re: [PATCH RESEND 1/2] io_uring: use kmemdup instead of kmalloc and
 memcpy
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1568774273-19434-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a5c8378-72f2-5196-c421-40b1fbc4a26a@kernel.dk>
Date:   Tue, 17 Sep 2019 20:41:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568774273-19434-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/19 8:37 PM, Jackie Liu wrote:
> Just clean up the code, no function changes.

Thanks, sorry for missing these. Applied both.

-- 
Jens Axboe

