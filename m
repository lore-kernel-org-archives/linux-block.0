Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161BCEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 14:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbjFOORc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbjFOORb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 10:17:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32350297E
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 07:16:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b3c5631476so7683145ad.1
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686838611; x=1689430611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lE0pdGx06OpdGpfzPvLrE8wOl3J8Bk7JiHJ6Qf6Lsy4=;
        b=GzFc86cgrUl2Qr43jw8LYdqsuKeRR4Nt6KjnEZGBUCZn3w+rdoOUNC/eJX2q1bplM3
         c/68mrlc1rH9x4pckC+sgcJmyiapPDiCXx9cP1P+bBjoHq9y51xzWICsr9UEl+QcXnn4
         fYJbGntlSYQ4bf5HioAYB20yCsXJiGz1JqrzD0gLO0JFf5e3NuLAW4e+HN7NSqfRYD83
         XvZ+60TYXtD14wfHOTEC/v4bPU0T7SeANrnLz0kA0JPkiX+Wq0XZeQAcui1Rz9/FFakN
         oWaTmkwzqUcNeyH30Q3eHZFaAPqZxGrycbVC1CBXvN4WfR7MWhuIoiSCvSxnOMol79Ax
         U3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686838611; x=1689430611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lE0pdGx06OpdGpfzPvLrE8wOl3J8Bk7JiHJ6Qf6Lsy4=;
        b=iiNSl+DytEuUdigMdff/Cb2bgdp9TCQE4zWoBgY/yvw9gbGpwDJwjstSnKjYekRwov
         M+qV8UrdgUprwr3KL+RKgpCZJC33fJVFILgObiBYIwoJg2RFkhJvVAenpm/SrVOGH7uC
         AvBwR4q7lzZO7PXLJjAXCXSWBPiQYvOqpLhLCM4QPim/qyhoa8f8OD9IUxR22cUxA58J
         DkpsJw0E+Z9PcYNfAYnJLLALUAYYMLH8EjovK+W0Rifvg+GW18DZqJ0YFvI6p1XgXFRx
         UFC1l2A7jYKklR4+FTDKG6z3jsW6Md2cxIvgY8pjI8796K3v7DiDFIN4mFetragGdap6
         b+Qg==
X-Gm-Message-State: AC+VfDxw+YQWeWvot84y7Tvniaf2jK5EoffddDRUwLMO88lci7IleC83
        e3ffzQYqYR8HfUZRZ468uNpEDJJyfN50GlqHqvs=
X-Google-Smtp-Source: ACHHUZ75vqY5++wbPGei6yo4iCcsTaocCY7XsXfOH/zjpUe84fpLhFfN1aNMASwHP7T84/uQs1apzw==
X-Received: by 2002:a17:902:e748:b0:1a9:6467:aa8d with SMTP id p8-20020a170902e74800b001a96467aa8dmr21703539plf.1.1686838611623;
        Thu, 15 Jun 2023 07:16:51 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b016313b1dsm8813446plb.86.2023.06.15.07.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 07:16:51 -0700 (PDT)
Message-ID: <5ee1b21d-1c2d-d532-7f50-ace504c82e84@kernel.dk>
Date:   Thu, 15 Jun 2023 08:16:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/8] Support limits below the page size
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>
References: <20230612203314.17820-1-bvanassche@acm.org>
 <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk>
 <20230615041537.GB4281@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230615041537.GB4281@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/23 10:15?PM, Christoph Hellwig wrote:
> On Wed, Jun 14, 2023 at 08:22:31PM -0600, Jens Axboe wrote:
>> I'm usually a fan of putting code in the core so we don't have to in
>> drivers, that's how most of the block layer is designed. But this seems
>> niche enough that perhaps it's worth considering just remapping these in
>> the driver? It's peppering changes all over delicate parts of the core
>> for cases that 99.9% don't need to worry about or should worry about.
>> I will say that I do think the patches do look better than they did in
>> earlier versions, however.
>>
>> Maybe we've already discussed this before, but let's please have the
>> discussion again. Because I'd really love to avoid this code, if at all
>> possible.
> 
> I really hate having this core complexity, but I suspect trying to driver
> hacks would be even worse than that, especially as this goes through
> the SCSI midlayer.  I think the answer is simply that if Google keeps
> buying broken hardware for their products from Samsung they just need
> to stick to a 4k page size instead of moving to a larger one.

I would tend to agree with that. Vendors buy cheaper things all the time
to cut cost, and then have to deal with the fallout of that. I see quite
a bit of that on the storage front.

-- 
Jens Axboe

