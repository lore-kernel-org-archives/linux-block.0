Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F300DC433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Apr 2022 16:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348632AbiDKQdo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Apr 2022 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348656AbiDKQdn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Apr 2022 12:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1317F31363
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649694686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9npo1nqXaxbPxEQzLk6Betnt1M5YLmZj/dlQsw0KH3E=;
        b=YiHrMYvHInwGeCN3bYuEPlIoiDiJVFb9MVt+VeLTcktAdCuNMwbMiegis3p6SVGNsPwCAv
        5vUEJREkqLSwoCOFuH/+OayrBJT7163N7tjN4yxJhv6w9fmlvXj/vgIEMDDKAHYsFcwWgA
        4IPkTADn56RN2w6+eOU8j+gb1lcUbXA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-izmQ2saFO4SUqcqw9FIdrg-1; Mon, 11 Apr 2022 12:31:24 -0400
X-MC-Unique: izmQ2saFO4SUqcqw9FIdrg-1
Received: by mail-qv1-f72.google.com with SMTP id gh5-20020a05621429c500b004443be8db85so4415866qvb.11
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 09:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9npo1nqXaxbPxEQzLk6Betnt1M5YLmZj/dlQsw0KH3E=;
        b=6tBZC8R31A7mUrVKd8xmDcqM2RqzQ29fUrs+VqJOS54meD+IQa4C1omTylv3shRVfc
         6Uunhzu/48HtVXbYw0k7IcNMR0lvHH/5y0A6Uy4C4cYAqj8tIhTjz2YLL/PG/WkbbOUe
         uGxvq/d9MJ+iAtyJbKkuZ+IsBYAiSmH9gwHup61UmUTdfTQD0nqKwcHP9upijLKk4GGf
         TsoOKS0hNN3NfaCoStCB8IGBx4pnTZlV/C2EN8Lp2MLBlbw2nsGqyKcC1SNEOq3c7tUb
         DGIbbx2RCRuS5XETeyDAatyOipc0H0o5L/FYom/l8nRPP/EV40CAkIy7/MBfKiIeTTc0
         o6zQ==
X-Gm-Message-State: AOAM533R3V88F6342TuScAx/e3SZR0v+Kp1GfFY2+1nArCdCIJ8YtZa1
        WYGnnpkDubS9l/8eDdC/R6vB3DpA3CAl+S1Kn0mlsgsqBmEE0gLAgWyu6wn95K0enqey5FANZIt
        Z/MIfvjHq5O+z4Lpm3i+Zno4=
X-Received: by 2002:a05:620a:1024:b0:69c:2e0f:d020 with SMTP id a4-20020a05620a102400b0069c2e0fd020mr160239qkk.108.1649694684320;
        Mon, 11 Apr 2022 09:31:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIBbuzUKRKdpRu1szbFKkqYCYu3AmHHhLAg8TDSWf8+WPdx1Tx8DzyFwTfgzm1rUwE2RhpZg==
X-Received: by 2002:a05:620a:1024:b0:69c:2e0f:d020 with SMTP id a4-20020a05620a102400b0069c2e0fd020mr160226qkk.108.1649694684121;
        Mon, 11 Apr 2022 09:31:24 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s31-20020a05622a1a9f00b002e1df010316sm26851091qtc.80.2022.04.11.09.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 09:31:23 -0700 (PDT)
Subject: Re: [PATCH] security: do not leak information in ioctl
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tim@cyberelk.net, axboe@kernel.dk, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220409145137.67592-1-trix@redhat.com>
 <YlREKRb/xgAFsi97@infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <eec2efee-1153-8d8e-77c2-96156733a0c6@redhat.com>
Date:   Mon, 11 Apr 2022 09:31:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YlREKRb/xgAFsi97@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/11/22 8:07 AM, Christoph Hellwig wrote:
> Wrong subject prefix, and this really should be split into one patch for
> pcd and one for sr.
ok i will split
> The sr prt looks sensible to me.  But for pcd why can't you just
> initialize buffer using
>
> 	char buffer[32] = { };
>
> and be done with it?

The failure can happen in the transfer loop, so some of the data will 
not be zero.

And checking status should be done.

zero-ing is because i am paranoid.

Tom

>

