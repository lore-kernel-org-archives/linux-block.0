Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F4DC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107E3214E0
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kMGBgXT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107E3214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbeLFT2k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:28:40 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40826 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFT2k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 14:28:40 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so3323135ita.5
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 11:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=th7PPe45DnRlsJVW4psSdOL+pAPoSanlQ+EHMHsEs5A=;
        b=kMGBgXT9yxw5bc+mlN8d97tV2yGle40vBSZBeI/FZJh67vwk8pu02d5DS1E2wPY88w
         OlNsA7caBqMrtqFjbnu4Y+EC55UmfOrxx+GF0kW1Ee2bHAykNm9l3yxlSBxiVzG/gb+D
         KrvWXA7YoOFfMTMqB6vxH1BHFXLapBQpTfTNXUFNqIj1FDWz6mVtca5aO1N+YFxY1cLd
         xuBsNKvej08xibkbYHgYoFS6GZzZc8UUEneaNLdpJowEG3i4v/wtjACN//I7c7vAT4tB
         P1RkGY59dkZO4wIVfyj5fy7vGKYFfLG95T+DxQG+A0p90MpjiO7z7wti4pMh8dEKKJL9
         5wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=th7PPe45DnRlsJVW4psSdOL+pAPoSanlQ+EHMHsEs5A=;
        b=kHk8FiUX4l1De3LZLOpR0P4PL9paXdyhzhDcEClFyFpCxrMKnxHadQBpNyAU/H0CV2
         8qWiKCC9Y6IRil9uImDDvEtkIARa3gMttpTB4nmqub7daEmrFHTVtzXKjlP8RCuBNg3H
         zjKyAQ7DZV3IGm/hgajmwYJWFfYcGNDuGeAwo6NhsMW/HhT09Y93igpRgM7jjXcTtNpM
         +y0GexigVTixp5dHymcrZuINyDs3FUj0U0ZnqHKeimuoHWQWYWsBgIo1jiTX36k4DlAs
         UTZtk4wYgr06g0iPHZlKcgUOwo5EW2yk7OtCWobRpK6Y6U6WnXGyJ91jLH2gR0VH3GOp
         Ia1g==
X-Gm-Message-State: AA+aEWbP3SIxca0u0UVY2Yhy1kMFmGbn+UwWdDjCqHm7q86nPQxYbhcM
        L0U2P0jzFT+zzhKxyTFA6XLTSg==
X-Google-Smtp-Source: AFSGD/VQ8vX7K/V3IWjJiwX9SYT5NerGSFNoVglaXmlymLU7pwBrSwQsqRnWcuv50zYw7i1hz3KbcQ==
X-Received: by 2002:a24:94f:: with SMTP id 76mr21159050itm.169.1544124519345;
        Thu, 06 Dec 2018 11:28:39 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b91sm673014itd.26.2018.12.06.11.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:28:38 -0800 (PST)
Subject: Re: [PATCH 08/26] aio: don't zero entire aio_kiocb aio_get_req()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181204233729.26776-1-axboe@kernel.dk>
 <20181204233729.26776-9-axboe@kernel.dk>
 <x49y392fobn.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <99b52953-091d-007c-43aa-41198b0ed747@kernel.dk>
Date:   Thu, 6 Dec 2018 12:28:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49y392fobn.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 12:27 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> It's 192 bytes, fairly substantial. Most items don't need to be cleared,
>> especially not upfront. Clear the ones we do need to clear, and leave
>> the other ones for setup when the iocb is prepared and submitted.
> 
> What performance gains do you see from this?

Before this, I had 1% in memset doing high IOPS. With it, that's gone.
1% is a lot, when you have just one thread doing everything from submission
to completion.

-- 
Jens Axboe

