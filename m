Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C24DC433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E366761263
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbhDLMoz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbhDLMoz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 08:44:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0743C061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:44:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c17so9131789pfn.6
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VQ4EMzxTNtWtOhPTcPjWcjOIN2KmKoa38LgBq5VTcNc=;
        b=s1lUvl4ZJGF1WdCvYEPTg8BXSm60U6el6Aid15VCypfIuXIqYaXnftoh2H8CEO9tnM
         SEPHPkh8yVTdLmGzVLv+hq7UfC3gvsKOeuQgseKlnqCzq+LDlOaRRzmns4TiMIpLSslC
         99qI2go/jQvnlx0xXJOzM8av/J6ACbPWMBke+P5ZaUzVHW/tmHxsuwN7yA7SaQQlqku4
         YO6HoK3SUfvCZd+tZxVBsuJ9TCH7rKE+ouTUceIRs8wswpjavs1JuxssAev6BcI1W0Xl
         Mv/j4hyFCEAdGRqq9rf3C7Yv91kwxPEehJHoMrOqPMHe9PwOWYqBWGNv5blMYQT6BaWa
         hiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VQ4EMzxTNtWtOhPTcPjWcjOIN2KmKoa38LgBq5VTcNc=;
        b=oDKBQDgIN7v9GXsyUwOYwFYhxwq705OvmRGcEwJxAOrrhioCNwFKNsLh52jRYPdmHg
         8MTiPGACWplI1blpwkcLb51aFnh8hczjPL+395rlcLyit1Nlj5P3lF3BQsC+7O2PZb/T
         X7uEGIHxJljprYhCtGY/H7HNdj0opXABps3rMF+DwmHuKz1gFwLES6Ax6u8+/nfyrMbZ
         P90OwozBBsByi7Gt+m1nEzqz/Aa70AprvihdYtXLSzjNj/BA9LJWQh3ughCWFG/7k0oH
         pHn0Qwjzw4UHJydod4mJaSYmI7sTxopevZlrzJ4WaI1tx1ED+QYlpg0iZFuEHhWYbQFE
         WCdA==
X-Gm-Message-State: AOAM5325TWvj3NRz1MK7LIGpQQemUJ8BxZYBMMqlruBDVImzrqYZTbDL
        cFlHc0brk7ecLgzCtkF/9ofHoFaV5UDFeQ==
X-Google-Smtp-Source: ABdhPJxUAhdxP19Xzk45L3CJlv1yTIshjChBBvbuLuCZoJe7A1yOsk0xuctpqiPXFSO6ZAPjwFQpBA==
X-Received: by 2002:a65:57cd:: with SMTP id q13mr21155529pgr.295.1618231477286;
        Mon, 12 Apr 2021 05:44:37 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j20sm10940970pjn.27.2021.04.12.05.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 05:44:36 -0700 (PDT)
Subject: Re: [PATCH] block: initialize ret in bdev_disk_changed
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20210408194140.1816537-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82914a89-80a3-e338-b60f-15107c84161c@kernel.dk>
Date:   Mon, 12 Apr 2021 06:44:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210408194140.1816537-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/21 1:41 PM, Christoph Hellwig wrote:
> Avoid a potentially initialized variabe in the invalidate case.

Applied, thanks.

-- 
Jens Axboe

