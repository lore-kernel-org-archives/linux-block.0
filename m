Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021FAC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D2620823
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 14:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ePSzBdKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfC1OV6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:21:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44129 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfC1OV6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 10:21:58 -0400
Received: by mail-io1-f68.google.com with SMTP id u12so17351943iop.11
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2019 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=117c4vpS2rkW0qX57HS1NSRAbEMjl/P3FHXWihFP1Qs=;
        b=ePSzBdKTirzfyQHkcAjMbLQeGh8pKSPp7UqEKR3M/3WLK4VmJdmKnLOJx3lC/EnOG+
         AXj7RBOmytBsE+3Zi8xj1KWnWQMbMSSFYq5X9nhwtZbI44bl0nLjyrD2GGI9zLdXJV1s
         99XK21RmAglRdx7zwlf1/Z83cWfEtc0CYd6VHVN8YO6/NBYFzQPH3+/T0P+gLL5vC6sg
         lgwcPEvAkefgSl28YwcoYBecb1zpDpZPEnxu2rknCsnw7SQ40FVBDfBhHUMSA/K6WYbF
         jHtOwsVi6LxRFW6wdkoS9NI3D3LPICJVfvh2wsdnk4Sas1ZiRfW2aTs1vZUFPtfAxY/j
         L2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=117c4vpS2rkW0qX57HS1NSRAbEMjl/P3FHXWihFP1Qs=;
        b=crzTj8lJjhmhhHtXKL6zhLWaRX7G2Z5re8Do48yVlQ87m1kBX0leMVEAxeSsLPOtyS
         Xxo9HTlTJEnYiNv+zlGj2nq9Xob+1udDSTK94Fl1Pabtjk/t425Eqr40oMh/RyCoOQ7M
         UGXmo65STmmm2z4yX1pCXwhVlxHgInrYdimrQC9iGH09TPfzvOWN3pTMvzev9irFw34P
         pFdwBv5+Iw8yOrvIOGeHPU1r9wx7VZ4Sss7JdMlRWIet8D08GEsBbBM/BQrghIW4LKkK
         x9fl1HboJbLBkZ5xGWQhYCnH0+q+zCjuWKjIizQKZ7xmGSqjYWgKoOtrR1NtggEFE4ju
         Hzlw==
X-Gm-Message-State: APjAAAUrV1EZ3Ryf7+cKDc9hRXXxwK2aq61HsZTi2dkN3gerG2pSQalJ
        9ve2SPOYUYdTZWWpo27ljR58ew==
X-Google-Smtp-Source: APXvYqx2aMDXD1HDzszIzbOBecMmMuoxuwPxSfoJsI4OcU1wIBtCkPIO+3KhBGxx/lIXps32Vw1k5Q==
X-Received: by 2002:a6b:7401:: with SMTP id s1mr24733630iog.55.1553782917116;
        Thu, 28 Mar 2019 07:21:57 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m25sm1867950iti.24.2019.03.28.07.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 07:21:56 -0700 (PDT)
Subject: Re: [PATCH] block: clarify that bio_add_page() and related helpers
 can add multi pages
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <20190328035001.26276-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5258cad3-b324-660f-589f-73eb7fb8fa04@kernel.dk>
Date:   Thu, 28 Mar 2019 08:21:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328035001.26276-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/19 9:50 PM, Ming Lei wrote:
> bio_add_page() and __bio_add_page() are capable of adding pages into
> bio, and now we have at least two such usages alreay:
> 
> 	- __bio_iov_bvec_add_pages()
> 	- nvmet_bdev_execute_rw().
> 
> So update comments on these two helpers.
> 
> The thing is a bit special for __bio_try_merge_page(), given the caller
> needs to know if the new added page is same with the last added page,
> then it isn't safe to pass multi-page in case that 'same_page' is true,
> so adds warning on potential misuse, and updates comment on
> __bio_try_merge_page().

This is going to create a needless conflict between 5.1 and the 5.2
block tree. I haven't pushed the 5.2 tree out yet, plan to do so
this week after I've pushed the current 5.1 patches. Can you respin
this one on top of for-5.2/block when it comes out?

-- 
Jens Axboe

