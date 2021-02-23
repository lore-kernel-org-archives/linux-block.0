Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E98C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 16:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 079F9600EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 16:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhBWQzR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 11:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbhBWQzO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 11:55:14 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F25C061786
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 08:54:34 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n14so17852641iog.3
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 08:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pbT6n+Cs8DvJhjtVRgCmgAyw2SwurC0A19vm/mcxTXs=;
        b=0BywCyjPKgbYOCAL+E4oS+FiNd2Hb9hogrqEqxrgVzm5JxPXbTjjP/KwbIO0NyQSi3
         bnDSFeIaALNY/yhR3csXEaL0VcARSVFYUh657NpmrKUQjKG8wza32RvREyDgROeqsBJo
         5SmQo/jRz+LSh3MsclxcZ+1nWgmQpjDW6+rU5f8gBewxqIUiBjoTlPHOALnnVqtgH6hQ
         oomeTM/BJKLgxZi5Z9SEnFrBDoe8kT4SQsXDqyX0UzP3wKirD46qQsMCiPvzc5zyqj2o
         xtzLM2CjPmWAhhOw4KKfdLpX3Jx+9qs2y5b0CYlyLnVgjahuSXzEmTVwIlNNdnflBSH5
         H2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pbT6n+Cs8DvJhjtVRgCmgAyw2SwurC0A19vm/mcxTXs=;
        b=qHwOEizM/E3fnKI4bPDn20S5gNnjq/XbTYQeOocSxxlI6/USnU981Lnft93SiLiYGw
         grqti1Rwg0BTsfhTE8tavQaCwm8D+aEU6yHpkIxqwGUuJOry32O1BLVKCViPQ9SCFs4A
         s2LrGWdprxTUXf6nXXqvj+AlpEcz8UQV9oBABJpfJQU7JNhYp3rlppkaKWFnJHscY3K6
         TO053wGo1onjm/t2bPAur0HE4GbjBRplZLzgHkAiBJyKV7PX3GCqNGoOCLUcC4c60yom
         p8e/kJdTKFq3XO9FnzdkouR3nMKgCDnxSB8rbi2fpSn+jKTxl8KvKm8VNBPdCyO0DGup
         RQeQ==
X-Gm-Message-State: AOAM532/RLu7U5b9wvMPL9Vaxu1Y/eXodAYVVcJOtmFYBr1kxgyyPks1
        rEBBHUxLRfXnmooM88QvK+Pf4w==
X-Google-Smtp-Source: ABdhPJywb0iRBLlpthFDinP6/WvOUXEm+Pi6TulrLjWAPzdeOhx5yNT21EsQqp0T+7vf0z4WTUcp9w==
X-Received: by 2002:a02:3b29:: with SMTP id c41mr28187000jaa.4.1614099273754;
        Tue, 23 Feb 2021 08:54:33 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r21sm17984292ioa.24.2021.02.23.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 08:54:33 -0800 (PST)
Subject: Re: [PATCH] blktrace: remove debugfs file dentries from struct
 blk_trace
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210216155247.1015870-1-gregkh@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea239ce4-9a7d-fe6a-d41a-8af8f85e3fd5@kernel.dk>
Date:   Tue, 23 Feb 2021 09:54:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210216155247.1015870-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/16/21 8:52 AM, Greg Kroah-Hartman wrote:
> These debugfs dentries do not need to be saved for anything as the whole
> directory and everything in it is properly cleaned up when the parent
> directory is removed.  So remove them from struct blk_trace and don't
> save them when created as it's not necessary.

Applied, thanks.

-- 
Jens Axboe

