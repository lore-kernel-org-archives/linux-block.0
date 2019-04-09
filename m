Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80C2C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A487F21473
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 16:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bI1ji4ZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDIQPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:15:10 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46129 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIQPK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 12:15:10 -0400
Received: by mail-pf1-f178.google.com with SMTP id 9so9975889pfj.13
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fpdjjvW4la6k58eSuxd+6eY3Qu21ELSXE4AJeXZFzKU=;
        b=bI1ji4ZGSTMGXcNt4SC5n0lAArxjbeam2cg00u9fb3o64oidFXGb2EGTkj65oIJQuk
         tsNXzkSQ0iOlpLsxErIfJ0Sk1j8lmjQTVm9EmB8IWuDu/gAXIQn3d5qZWWd6Om5iMGGu
         rUpuHdrx++sQf2vH47AMkaXwokYKU9Kj9SAaAWDMmkS6WSsrKmyArAtBNExY4LqGpMtI
         PWH7CwcbDyvu0OZ66teVHNsm0L8J9iK8QE2b9lovYHkLoa/YhIdkgbnenjTNg8KJ8xal
         gZILE/6aqSZj41solTTBxZbIbC0iiQDoqXYXVeDMpDfwEtdXOK4FtGThNgXg8Y7pGmgI
         M4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fpdjjvW4la6k58eSuxd+6eY3Qu21ELSXE4AJeXZFzKU=;
        b=dDYgF6xHq2KSPbpLwt8BfOqJud+P6fLyvrbX56a6i0Mbge2p81MmeukYYKFARBsiq9
         IAKu3GQWeVPRWgQKSzbxSpZgxb48h45HznDrxo1NYitxxZ4zJhpXMB5qLZ7JTmN1vmtN
         lWDFIqJchvKft+B9bX9h/fXg+t5nLKw/cwEeyGyXd/z08H76plX0POFefmsq5P8A20yC
         kaWeSX4gGyNPvZ9Qo1ywmoWnCiWzQPnRa5Ewovw6bbeJIzakeyAhoamasGMAWV1Oksk4
         ePHeIyR391I8acNWQ7HVpIVevVXePdL7VAsWx5t2P0CAbxjkozC6aPhxnQG2lV6+Plug
         If7Q==
X-Gm-Message-State: APjAAAXjko03qgg0yDW+Bvyg6JA+0ox3ptBWhChmBrE61TyocpDojdlY
        PiVaX6OygWvsXK50YzFvdZYK554J29N1hg==
X-Google-Smtp-Source: APXvYqxf08bf1pvb+A4SrG3uzL1mXm2UQDE5MXGigc07DPzxoGKhIzskmohA592n/7myp6XapYbY3Q==
X-Received: by 2002:a65:408b:: with SMTP id t11mr33551854pgp.372.1554826509343;
        Tue, 09 Apr 2019 09:15:09 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a3sm54890474pfn.182.2019.04.09.09.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:15:08 -0700 (PDT)
Subject: Re: avoid calling nth_page in the block I/O path
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20190408104641.4905-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <17afcbd4-f661-fd09-1a94-2ad7db04f243@kernel.dk>
Date:   Tue, 9 Apr 2019 10:15:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408104641.4905-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/19 4:46 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> you complained about the overhead of calling nth_page in the multipage
> bio_vec enabled I/O path a while ago.  While I can't really reproduce
> the numbers on my (slower) hardware we could avoid the nth_page calls
> pretty easily with a few tweaks.  Can you take a look at this series?

While I haven't had a chance to bench this yet, I like this series
just as an improvement/cleanup.

-- 
Jens Axboe

