Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72183C4360F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 13:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBE721852
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 13:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="RTLSdM4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfDENkW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:40:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42211 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDENkW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 09:40:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id x61so5525785edc.9
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r6XjzeU2nk+K1FE4uYEgJ3r/wgjl+zsqdRRh624nRpM=;
        b=RTLSdM4YL34uxq2K2smCIFjLGeT5CHgTGM+pTfHGrsss63AJAa/Aawqa+N3G6cOwWu
         eLE2iraBdQZxxKgsNnVc0SkDONbTApH87tbm+vI8GVVxIPo/r74q9/pjQJjwdfyVi9pJ
         wobrIsoLI9gQoPaIs4ikCRTa8WY6j23pojHqrWWPvcSARdU+wEfneNMW/UP/jQd4vQ1e
         UZpp2Kdf4EoyMPfQdNHS0ayFwqFaENE92KPB17VaU6fjGVKfs0eG/45cQUY+NUJhGI2z
         NGgEvmuEwh74egYUheJ/ZDUDWcnw5FgWN2wy71vH4NkFtyeYgZ3cWoY9WYycW1TRV0AR
         mQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r6XjzeU2nk+K1FE4uYEgJ3r/wgjl+zsqdRRh624nRpM=;
        b=qHLq9W4Jg/Q0g4g+iZr+74h4lQFX+GDUQArZY9wMeP6cE+12fyUNdaZCJCXg+89tBT
         IIixcS5nQifkjbw+9zenI8J9BOSNoLSLWZ6B1SjKtjJfeTQbhghyre34FW657tWORegx
         YUTTwTv4mZI5+tQKepHfRW+YiAtbPYsZ7AH5s9hEtgwdNZNtzKQYI8cuV6cMS4ABM0FB
         9K1tSHspO2PKhglhQNGLEBWs0munDncTKxxP6q/BDyFDs+A7yzybuldNsyUVAiRHjcj8
         CYMt7PSk7o/41Gen7anx2Yqd6pAynvAExiEn3lLE2opr7sDAOjNtBWr7vuiqH+wXkRCt
         1lgA==
X-Gm-Message-State: APjAAAVcX8mK61W8mYmjkHViVSYFqEZtJD5su2r1mFJ45awx2edxia5g
        CXxhBeAa2rFHyxgsUzcMkzILulUoDKg=
X-Google-Smtp-Source: APXvYqwMzy3Twcxak003frHImK2lEZl3Y9Y8JhKpEtoHsQ/6oJn6wQYO13kA45pQrFh2fBePLro7Ww==
X-Received: by 2002:a50:ba24:: with SMTP id g33mr8327884edc.164.1554471620509;
        Fri, 05 Apr 2019 06:40:20 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id e45sm6471945edd.3.2019.04.05.06.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 06:40:19 -0700 (PDT)
Subject: Re: [PATCH v3 00/10] lightnvm: next set of improvements for 5.2
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190327123901.12323-1-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <07552030-a552-a528-f350-60d253118f0e@lightnvm.io>
Date:   Fri, 5 Apr 2019 15:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190327123901.12323-1-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/19 1:38 PM, Igor Konopko wrote:
> This is another set of fixes and improvements to both pblk and lightnvm
> core.
> 
> First & second patches are the most crutial, since they changes the approach
> to the partial read path, so detailed review is needed especially here.
> 
> Other patches are my other findings related to some bugs or potential
> improvements, mostly related to some corner cases.
> 
> Changes v2 -> v3;
> -dropped some not needed patches
> -dropped patches which were already pulled into for-5.2/core branch
> -commit messages cleanup
> 
> Changes v1 -> v2:
> -dropped some not needed patches
> -review feedback incorporated for some of the patches
> -partial read path changes patch splitted into two patches
> 
> Igor Konopko (10):
>    lightnvm: pblk: IO path reorganization
>    lightnvm: pblk: simplify partial read path
>    lightnvm: pblk: propagate errors when reading meta
>    lightnvm: pblk: recover only written metadata
>    lightnvm: pblk: wait for inflight IOs in recovery
>    lightnvm: pblk: remove internal IO timeout
>    lightnvm: pblk: store multiple copies of smeta
>    lightnvm: pblk: GC error handling
>    lightnvm: pblk: use nvm_rq_to_ppa_list()
>    lightnvm: track inflight target creations
> 
>   drivers/lightnvm/core.c          |  19 ++-
>   drivers/lightnvm/pblk-cache.c    |   8 +-
>   drivers/lightnvm/pblk-core.c     | 179 +++++++++++++++++----
>   drivers/lightnvm/pblk-gc.c       |   5 +-
>   drivers/lightnvm/pblk-init.c     |  37 +++--
>   drivers/lightnvm/pblk-read.c     | 336 +++++++++++----------------------------
>   drivers/lightnvm/pblk-recovery.c |  69 ++++----
>   drivers/lightnvm/pblk-rl.c       |   3 +-
>   drivers/lightnvm/pblk.h          |  31 ++--
>   include/linux/lightnvm.h         |   2 +
>   10 files changed, 343 insertions(+), 346 deletions(-)
> 

Thanks Igor. I've picked up 5,6, and 8.

Hans will be resend his previous patch to fix the bvec bug. Then we have 
time to get to the right solution without the stress of the -rc window.
