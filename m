Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39222C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D3D20838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GWGdgUmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D3D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbeLFTcB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:32:01 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37928 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeLFTcB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 14:32:01 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so3341898ith.3
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 11:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k7BPUZIIHTk0OKg2eiAbDsvHXc6iqIchla7z01Zn1rM=;
        b=GWGdgUmR6mmKlyKMDDQRZ1VBEIdYxhW/psooyUex8/EMjuySVklibARjrYdaJf+UfD
         s//PkVs8r00TAI1qmXCd2LlZFNDTPTSagukzYc0dM1SejdpepEiLfNGLQNU43B4WIJYc
         qQCnishwgmSMsEohzveAh0tTFOBxNIrizBGG+IHwsxhcxYmc1l3rDW66t1u7EsNKQtIO
         TLhSp9GiUDPWv7fgi6f/R3coG++ZL1Zumz9wBTwwt808aD6S7gvJ9a9XSA/Z/bZlZYUd
         sjvlMKOIGIT2mCMLc6eaRf15GLMw8fLpmo3+UJAarBCsn8Q2h4I4hW/MhFIZbcFR9f1B
         QH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k7BPUZIIHTk0OKg2eiAbDsvHXc6iqIchla7z01Zn1rM=;
        b=DaviK4QiPsG8ZsupzbhOonaVFQloViQ222oABi1niKiWUeo88xVYLwseYK3hJ854gv
         A5dNY0ZnVY1lkGKvrtXIQ2g/+24z5HCB7suNRI0zjTSNlXC9fnQdvdRLGdNSd8ShEp3G
         yz6GPeJTx3befRxz96TAliUIyfuLNyEyjGOeFIXwvst5dWo7yf7j2/6JZhen5QE0Uuzg
         /FUdH7NSYk4pFcBaqJ8Mba4lNK4QhBOBI0x4xcCIdrAv6jY/iP640YzTRaKt+oAhOVXp
         Vlk14K2fpePlt4r+jS5w/X1Fr3zz/hWPfNHBEYSt3+sBU55ZPsY+Crvh5y5bC3K6v22t
         KY2Q==
X-Gm-Message-State: AA+aEWZQ1nT7K9H2k5OKsHoh3XL6ZrTIPsROnI5SaIpv47fs0pFN91Pp
        mmCkverQG1vn9Kw7lR3Sy/fVhw==
X-Google-Smtp-Source: AFSGD/W1/bKy7vSHVaGNHGgzJEDMs1zgOZW8pFedR0pT/EdvFRysTcZV7kRPw9mqE7UJvixwGmOr9w==
X-Received: by 2002:a24:10cb:: with SMTP id 194mr20720369ity.173.1544124720577;
        Thu, 06 Dec 2018 11:32:00 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c68sm784266itd.19.2018.12.06.11.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:31:59 -0800 (PST)
Subject: Re: [PATCH 09/26] aio: only use blk plugs for > 2 depth submissions
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181204233729.26776-1-axboe@kernel.dk>
 <20181204233729.26776-10-axboe@kernel.dk>
 <x49tvjqfo7r.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b7cc48a-9b77-fdd3-633b-185588fe5e62@kernel.dk>
Date:   Thu, 6 Dec 2018 12:31:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49tvjqfo7r.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 12:29 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> Plugging is meant to optimize submission of a string of IOs, if we don't
>> have more than 2 being submitted, don't bother setting up a plug.
> 
> Is there really that much overhead in blk_{start|finish}_plug?

It's not just the overhead of the functions themselves, it's the
pointless work we end up doing for no reason at all. Plugging is, by
defintion, meant to help batch things up, ammortizing the cost of each
individual IO if you have a batch of them. If you don't have a batch,
then there's no point. Normally callers of blk_start_plug() don't
necessarily know how much IO is coming, but in this case we clearly do.

-- 
Jens Axboe

