Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0961C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 13:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8935D214D8
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 13:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M3FXIX1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfB1NAT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:00:19 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:37134 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfB1NAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 08:00:18 -0500
Received: by mail-pg1-f176.google.com with SMTP id q206so9699170pgq.4
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 05:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=en/fIALMkBj2thkHUqL8biXAuAcErQEfIeHRbWrXCXE=;
        b=M3FXIX1z+FnatF4MA3zAGATARHrnqiYUJTWXC8kTbFCB0fDsHmla3gOc7FoMdWZeD+
         uXgM6W/BKqKWW5RtSUhv26koGAGqt3IN6RtvqNlvzPluEVUbD+jsuZ3YaXSme1KvZgzu
         X5XzubxxHWMLD83ST694VjhgQmhzykkLrZ39OqAtIc1vUoUaG9Yl2n++uXZ2vJ3Nomjl
         fuxjeK8YWesSGLtcxCHzcqsNv8A2hHYwVfqnndBB9vbXIaUaL6ldlwKUAItaa5Mi4eK1
         hE6ECoYIKF2yLkTFuaJwXgFVm5p+qfG5Qiq9GF1BWk+G4xQCfLwbsAl3/xYEhA+k0bvW
         qdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=en/fIALMkBj2thkHUqL8biXAuAcErQEfIeHRbWrXCXE=;
        b=ql69CJpPY5k4HVL/Q9hodsn3g+LtNCZ7h/6FZ3T/tiBwfTI8QvHdSLEABWwIXnTFGZ
         tk+wG8XMYFuPJI+uVbVW9nlWe7zsXdrOxq3snYY43Tvfqo8OHcT8+cX6aXNGImasDnxS
         fnn0IKEKoLQiEMHWrroIQ0KH1LrsYeslKsUJvtf5fItDhkUtmPRZiRJMvu0EGTukHlsF
         m0L8f+JtQA16w7v0l6efiK/OQiSgT8i9YY2q+UzKhCKN7JMUoekMD8ph2HuRQ+FxNnGl
         Z9aMuDjtDFxL8+xGb7F+uPkX0/SS2PuWgBg1CUfDV2Af4NX3nJag98xd+thAh2lriKoD
         bFQQ==
X-Gm-Message-State: AHQUAuZdPOsyctVYVxjzc5+czOIQD3e/l7mRr08FR5RxG1K3OMtYjX2Q
        s4HTD9SmrWto42bygTGTwBehdw==
X-Google-Smtp-Source: AHgI3IaWdc9eKir9BhtAKellOwZ0V2baUGaMrfjuUaC0BztDkvUHnc359uQW+Z1X9EAAqopvBKHWdQ==
X-Received: by 2002:a63:6184:: with SMTP id v126mr8322375pgb.277.1551358818169;
        Thu, 28 Feb 2019 05:00:18 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o2sm38499262pgq.29.2019.02.28.05.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:00:16 -0800 (PST)
Subject: Re: [PATCH] block: advance by bvec's length for bio_for_each_bvec
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190228032421.23161-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9479ee13-526b-8870-453b-0c8cc3f35df3@kernel.dk>
Date:   Thu, 28 Feb 2019 06:00:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228032421.23161-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/27/19 8:24 PM, Ming Lei wrote:
> bio_for_each_bvec is used in fast path of bio splitting and sg mapping,
> and what we want to do is to iterate over multi-page bvecs, instead of pages.
> However, bvec_iter_advance() is invisble for this requirement, and
> always advance by page size.
> 
> This way isn't efficient for multipage bvec iterator, also bvec_iter_len()
> isn't as fast as mp_bvec_iter_len().
> 
> So advance by multi-page bvec's length instead of page size for bio_for_each_bvec().
> 
> More than 1% IOPS improvement can be observed in io_uring test on null_blk.

Thanks Ming, I tested this last night with good results.

-- 
Jens Axboe

