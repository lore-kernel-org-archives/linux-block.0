Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D56C65BB3
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 15:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED242081F
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 15:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DjlKtl9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED242081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeLJPgo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:36:44 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43957 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJPgn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 10:36:43 -0500
Received: by mail-io1-f68.google.com with SMTP id f10so9040365iop.10
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 07:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s0O3q8NJAFEb/kj24P2ZRPRhLDWMaTBQ+M8TN+W3Ft0=;
        b=DjlKtl9K30RaifXGF8feXHhMKfMWjeAELaF5o7lWbtVzN0grcFpmqjkxidn5X/hMjJ
         KxbTCbjrbJXds4cp/+neX+fRWpzUY8Q0kys+lhRu3aTRy4rRFM80H8YFoICVtJ3Xvo/I
         TiJc+h4QbQYf+jyzES3P1rq3KzknxopoFQLxKTOwpT6IGvxAUITPyNnSn54S8/gsW7yi
         5kyEPc7vvfLc6RZbGQ02lwtgcnCIAIn7l/o3jwVaHxaqnRXhBi1IOrfXTwEWxHJ5BSLB
         a4icQa64N3NDokFhFrdVm9dMZFe64LkvHitQIsHT9iorfHnqba5EFPA3ularl9X94lVq
         SXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s0O3q8NJAFEb/kj24P2ZRPRhLDWMaTBQ+M8TN+W3Ft0=;
        b=rUPA23scH93SONGQB/1XFwa96f8+hE40SVDo2f6bto7/zfNxwUY6W2PlNXF0ErR9Gj
         pB+pL4ePDZxOG5uzOwF7ADIE8OjTqEzmk5LbRvPNZ3Um8mcTnaNdpcvMItXXCWyGJD5n
         o0G7G5gI54d4XR6Vea4iW7lHnwQG00KlBqs6GfgaUdbn/hNryFEKnBPeHw7ZxNiH2KfT
         eSZYqqPb7oGthNh4tE6y5oHF6Qrt/Dq5zWIvTHJBqWhyNQWJw43q/lp+6zpFSrZW82RD
         TwD4Nr39SayWTZBSnutsm131I4aAVicbNMewbvc2balMm1P8cI3D8SIzDcFn0n11DFQT
         XesQ==
X-Gm-Message-State: AA+aEWYvdPDXwWCVWFMdH/u6lY42Ydz7F0hufBAAAm79U6+XjMPJO0xf
        jg6Snq4XkZSmqxj/gGDiFsIcAQ==
X-Google-Smtp-Source: AFSGD/UZUe/yzWvrO/kGfHJCmV8k3LIr3v6QRepNiNZVRxw0/6dVduMob5VHcfy+wUjqwPLUzkyb1A==
X-Received: by 2002:a6b:4e14:: with SMTP id c20mr9511580iob.65.1544456203081;
        Mon, 10 Dec 2018 07:36:43 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t64sm11039111itb.5.2018.12.10.07.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:36:42 -0800 (PST)
Subject: Re: [PATCH] block: Restore tape support
To:     Keith Busch <keith.busch@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Todd Aiken <taiken@mvtech.ca>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
References: <20181210030814.13235-1-bvanassche@acm.org>
 <20181210153230.GB25206@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <93112026-a6b3-6db4-0c74-afbbbf6ca493@kernel.dk>
Date:   Mon, 10 Dec 2018 08:36:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210153230.GB25206@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/18 8:32 AM, Keith Busch wrote:
> On Sun, Dec 09, 2018 at 07:08:14PM -0800, Bart Van Assche wrote:
>> According to what I found in
>> https://bugzilla.kernel.org/show_bug.cgi?id=201935 patch "block: Clear
>> kernel memory before copying to user" broke tape access. Hence revert
>> that patch.
> 
> Instead of reverting back to the leaking arbitrary kernel memory, why
> not just make a fix on top of it? This should do it:
> 
> ---
> diff --git a/block/bio.c b/block/bio.c
> index c4ef8aa46452..55a5386fd431 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1262,7 +1262,8 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
>  		if (ret)
>  			goto cleanup;
>  	} else {
> -		zero_fill_bio(bio);
> +		if (bmd->is_our_pages)
> +			zero_fill_bio(bio);
>  		iov_iter_advance(iter, bio->bi_iter.bi_size);
>  	}
>  

That should be fine, the other case is user mapped memory anyway.

-- 
Jens Axboe

