Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83477C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3E321773
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IEBws4ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbeLTQ1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:27:25 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:46168 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733024AbeLTQ1Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:27:25 -0500
Received: by mail-io1-f53.google.com with SMTP id v10so1247601ios.13
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gQ4OJQaMJ+IajlKHIwPIP0UBcDeXGlEbc44EtxFtG8c=;
        b=IEBws4ZKfvPG3izpb4FchPe/gAljIRBDWpqcziPEOealDOxX8oocQ/O9CRQ+ikW4dd
         lWNs31tCbxd5PPEE72GTvF2jtHVNKTj71ZHC7Qc+QlrBhfFN6yXDU28I08IzpTXQBYlD
         jaLm6l2kMjhdJ1/7bsy+t1zcToRVrX8R28bS8dlb+zjxXPfei6eCaTOXEvFtiyOzTfwE
         eCRXByDgnYGkMWFSmbdx+gMj8x3Z5DRM8ffz/b+CrgyJLRS8PptZ+mShSURQotOpBXPA
         fAhsChVm2X+sCiqWwoOmhn7veC3ZmMdU9aOi1COCBXpg/XIvBV8F8fuL6UjeJKHVN+tW
         c+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQ4OJQaMJ+IajlKHIwPIP0UBcDeXGlEbc44EtxFtG8c=;
        b=itra/ahZg0QyeX01yMhJCCPTusfERwl7SfhUHNgnQuqRfSH/jGLefj97vL2GGHDCDE
         ZQU3jxM8QUoe5t2w/+s8sq/IJP5JgoibDXw9hOw7pVfdiAlPvwks9rW2Etn2RNxTQ0BI
         W7A7qYNhFjSNWGCSRePTMRTFoybyCbCittzN1WBu2NJX/KY62mtWJWOudbpJrKuc036r
         ezDUA6yjjxd6qW+NTZ9fWnwThHMAEjjqDZTs7QiV3kv6lwmVaeRhdJHJwlJbaODmYdVJ
         Umm+mpMCTKH6+twq1G5+u0jSwr1JXGagv7EipLeq6JUPwOAjZHpPxoY75FGUNKT8rHIK
         oBRg==
X-Gm-Message-State: AA+aEWZyg2496RdUu0oG49SeXxq8MHaATTHLrVSVPGdR/RTQbAZw6Jg+
        j/LGH7e5SWUqBE0+rPArLF+ZhLoGX+CtqA==
X-Google-Smtp-Source: AFSGD/V6rvTAgRy0rbqDs1AbIddkiWUktFbC4OoOkg0ajG8lWM2BEw0bBqnLb/v2plpD6Nw7qWe8XQ==
X-Received: by 2002:a6b:bdc4:: with SMTP id n187mr19766863iof.226.1545323244426;
        Thu, 20 Dec 2018 08:27:24 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k64sm5312994itb.7.2018.12.20.08.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 08:27:23 -0800 (PST)
Subject: Re: [PATCH 00/17] DRBD updates for 4.21
To:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     drbd-dev@lists.linbit.com
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <84bdf9f3-c5f5-6192-703b-c1608f725ba3@kernel.dk>
Date:   Thu, 20 Dec 2018 09:27:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 9:23 AM, Lars Ellenberg wrote:
> Hi Jens,
> 
> I hope this is not too late for your for-4.21 branch.
> 
> These are all from last April or even older,
> I was convinced we sent these for 4.19 already.
> But we didn't :-(

It is very late - even for a normal merge window, I should have had this
at least a week ago. This one is going to be earlier, so...

I'm going to take a look at these and queue them up for later inclusion
in the merge window, they are not going to make the first pull.

-- 
Jens Axboe

