Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6595AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 18:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A5B6113D
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 18:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhJMSrJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSrF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 14:47:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24FFC061570;
        Wed, 13 Oct 2021 11:45:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y3so11592058wrl.1;
        Wed, 13 Oct 2021 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=j9rOFLr09wfwjFoaWXR0mmDKmaON+pqQWXtctji3kCE=;
        b=nDOJLYtOwhBHUo/BBCDwExeaXTYlazn1TBXSb/rnKfcFVm1BvTIxYwdxM6+BH4ZahX
         UHFaGLVVLVYYx30+CLaluYsKUeV3tBiJ+kZvcU5hWAUq9n6EsupXIRPnHirgqa8xIJfX
         5zrIN3kzisXvXpjXk/kKC5YrcVT+JDePHqIlPnJtX7isfLNMKsKsLp+QjZqfb900Hkjc
         wqHTVcIIucPeHpcAC86vT1wcAKysMK0BeSWtu2Xvnj81rkuqh9QMM+OL0EGj4glyyYrh
         nSacVCNcn5gupbXuK5s0zRKi68MeKLVAq5S4FLbnPhxCCmQwjQfWwTPneKsd+keEMORa
         dwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=j9rOFLr09wfwjFoaWXR0mmDKmaON+pqQWXtctji3kCE=;
        b=HyJxJPvOYG70ABmyt1SjudUlLDlnGyQrkepv4gisJuex6pU/qHcS2PWLdTlYS8pV8k
         VpcLn3uV5SrKyj+s1UL6KrmysHuuTVfPZ54WzcmNQkK4FoLC61dYU4WvshZEF4B5axc/
         wNNe27Cr5rDaK/OFGLFoHET1PQqp5IxUJR0cogRfZFAibx25azgX1ewyhh/DaIfMIOze
         3fbX5Bxecm5vwkPdW4nailbpDQLoexeGUey5fYC6sllwSCd9eAjdiDcxhlTGnt5IkqD0
         TuNrTFwa4uI0LkJZrT0n0teaqr3QHvqjkmfXj47rA50HD6DoTdloWab3TtohCLPq9o2w
         NI8Q==
X-Gm-Message-State: AOAM533OuIdzhzu9KpCoBjb2K5jWg1iUcWljZ8Q60IxxKAPzECJW2bCV
        tNl0S/6J+BMHGCJKCUQFjTkujsJCK/0=
X-Google-Smtp-Source: ABdhPJypGEa18LmiY8iravUe3ji7EFkduHHKlwVmxBPVvdrJCGRNqz6tfZL3CcInZuIzA0OdUxf4AQ==
X-Received: by 2002:adf:9c02:: with SMTP id f2mr928377wrc.329.1634150700627;
        Wed, 13 Oct 2021 11:45:00 -0700 (PDT)
Received: from [192.168.8.197] ([185.69.145.214])
        by smtp.gmail.com with ESMTPSA id l17sm343484wrx.24.2021.10.13.11.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 11:45:00 -0700 (PDT)
Message-ID: <194577df-0402-6e3c-3534-af289b5494e0@gmail.com>
Date:   Wed, 13 Oct 2021 19:44:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1634115360.git.asml.silence@gmail.com>
 <2b8c84834a304871d78f91d4ebe153fac2192fd5.1634115360.git.asml.silence@gmail.com>
 <YWb6VgEjEZFexiV0@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v2 2/3] block: don't hide inode from block_device users
In-Reply-To: <YWb6VgEjEZFexiV0@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 16:25, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 09:57:12AM +0100, Pavel Begunkov wrote:
>> Instead of tricks with struct bdev_inode, just openly place the inode
>> inside struct block_device. First, it allows us to inline I_BDEV, which
>> is simple but non-inline nature of it impacts performance. Also, make it
>> possible to get rid of ->bd_inode pointer and hooping with extra
>> indirection, the amount of which became a noticeable problem for the
>> block layer.
> 
> What fast path outside of bdev.c cares about an inlined I_BDEV?

Mildly hot in io_uring w/o fixed files, but that's not peak perf,
but would also be great to get rid of bdev->bd_inode dereference,
e.g. lots of in fops.c.

Are you going to just hid the dereference in helpers or kill it
with some offseting magic?


> I have dusted off patches to reduce (and hopefully eventually kill)
> accesses to bd_inode outside of bdev.c, so this goes into the wrong
> direction.
> 
> If needed I'd rather figure out a way to fix any smoking gun without
> this change.
> 

-- 
Pavel Begunkov
