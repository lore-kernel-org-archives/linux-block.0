Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3800C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 19:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CE320673
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 19:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dyt3a3Eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CE320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLGTf3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:35:29 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36216 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeLGTf2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 14:35:28 -0500
Received: by mail-io1-f68.google.com with SMTP id m19so4188021ioh.3
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 11:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K4l7L3ZNooP4lgmIIi4OTHswBDQz9mJFgir2ZJPB+iI=;
        b=dyt3a3EhJiTu31+BNukr/NdVc1Gr3C9TBQ85XpnxQ/vte31UnCpHoPXOHixiwWQ/5+
         bbTupeXPW1Jb9A2EY8Shn5lLTXNkjW+C+9f6SwtG+ndu+bZHMIC+rKKnsKP5/rGtSC0Q
         r2tjxsn3BGiw+kk3bQXvBlsk51QXroHgwZYuz2ps4EUVNor06r3G9XCd4fmrGCUlq1iM
         EOJ2vME64jogyvIaN7y4EFrQRk5iDlu8uZMT2+VDrRHYC5S8Xdh0VrMsRtg4kNUrTpN3
         fEE8WUcAbOWQ6ALAdoq5T9QukwyR7/g9RpILxy1w+Tp1dvxZCyzXmynviGfyjyFYbKxR
         f+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K4l7L3ZNooP4lgmIIi4OTHswBDQz9mJFgir2ZJPB+iI=;
        b=LudSmHVDadkxdVqiUG+3+uHZsYuSL71IuoA+/dvCbhVCOeAA6+u3oY5Vt+WkfYkwt3
         Ua73e76+1/wVOsMjWbhliTJg4QayopG7wiFsJ+RfIA33opl2sacDFE7YRU56Jkp3cH4c
         ccgzcmwS9qLR1xOAciq/TsFxePlUs831L2iDxWS6wdWd1ubR7sciDz0T6r2J/Ipp0iXY
         6AsSpchTMm30sXTq2WUTiIPAfDmvnp46Wj2Ve+cuxUECCsXl5tW8v9EuXwLbwJC8+NZq
         sXg7WuXe2oT9sIK3G31cdqr/PhxZz4lcesPtBAgduEPGSYoULkesFgeJ5fWRvRMTyD99
         w4ng==
X-Gm-Message-State: AA+aEWZ3SsOkD8T6VkT4S6YEf98CSJwRWEXLCHhAnwIRQ08PqTiPqDhV
        b/M5eazG5b2+1GZ5FF6RMmDVEA==
X-Google-Smtp-Source: AFSGD/VxCWlFG2EbVYmmj/5rTYqbCkqh4TkZq/1pwD4zdSPWhUXc+fU9J1F8u75Apzg5/74NNFWq1w==
X-Received: by 2002:a6b:38c3:: with SMTP id f186mr2703082ioa.186.1544211327407;
        Fri, 07 Dec 2018 11:35:27 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r15sm1674067ioh.12.2018.12.07.11.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 11:35:26 -0800 (PST)
Subject: Re: [PATCHSET v5] Support for polled aio
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181204233729.26776-1-axboe@kernel.dk>
 <x49muphrx4u.fsf@segfault.boston.devel.redhat.com>
 <4bf3dfe4-b157-88b6-f9a3-60ad1f76328a@kernel.dk>
 <9747f14b-8361-08c0-5a1f-d4f26509083e@kernel.dk>
 <x49a7lhrv0x.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <650ef685-0727-aaf4-aff5-adf11c06f3fa@kernel.dk>
Date:   Fri, 7 Dec 2018 12:35:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49a7lhrv0x.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/18 12:34 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> BTW, quick guess is that it doesn't work so well with fixed buffers, as that
>> hasn't been tested. You could try and remove IOCTX_FLAG_FIXEDBUFS from the
>> test program and see if that works.
> 
> That results in a NULL pointer dereference.  I'll stick to block device
> testing for now.  :)

Good plan :-)

-- 
Jens Axboe

