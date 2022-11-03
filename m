Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C564C4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 19:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKCTcz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKCTcy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 15:32:54 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF3E1CA
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 12:32:53 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 128so2558341pga.1
        for <linux-block@vger.kernel.org>; Thu, 03 Nov 2022 12:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlfPxhhLvEQn6lsaScftYKSX3SGTGT53qHnShoVMGMg=;
        b=CSrK7kYy7Yk8pB31ux50J1RQ8a+4wlp6WCoqCPcHKUsRgaUOVuZ+wSz12HTO+wwFZe
         GHklo2fGnCqRRYqgUpexv+5QyudjCzPHQSqeAGgMVbik/BcBwd/g5UqehZGLCIqNVu8+
         IRZzNdQc7jnZ6VOP5cIie3w4ulvQCL/3toraN2z/rFgBns+0cnal4DneDjqhXcyJp02E
         LNoW6OvNdu7q1o+mFjH5JFnQmy4LhubvHcoP3T16hIO23Q5R5d38/b7Xh/5G7x+IMoue
         Z2Z2G53/EkH87i6HgQv9GjCny10SxfXQIys3Xt2ImFAhCK0InnF1qCMkrGG5DGeMUXwI
         Rfgw==
X-Gm-Message-State: ACrzQf0Cax6kBi8B2X6+CsOr2PcdxbS95urXzC4yKx5WEHJJieaZI13L
        nelNH+yzsY0f8UxJeMT6snc=
X-Google-Smtp-Source: AMsMyM4qB4mdwznCQnp+XC/bGXo7knYQLUQ7gsbLuni/AkKQcHDKpyw0aQBhDB/J3si+YusJ82Ue0g==
X-Received: by 2002:a05:6a00:190a:b0:56c:123e:3e61 with SMTP id y10-20020a056a00190a00b0056c123e3e61mr31743311pfi.47.1667503973229;
        Thu, 03 Nov 2022 12:32:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:881a:8a80:fdae:8683? ([2620:15c:211:201:881a:8a80:fdae:8683])
        by smtp.gmail.com with ESMTPSA id f5-20020aa79685000000b0056bb36c047asm1115092pfk.105.2022.11.03.12.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 12:32:52 -0700 (PDT)
Message-ID: <89172337-0698-e3ef-611f-5487f9ef53bb@acm.org>
Date:   Thu, 3 Nov 2022 12:32:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 06/10] block: Fix the number of segment calculations
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20221019222324.362705-1-bvanassche@acm.org>
 <20221019222324.362705-7-bvanassche@acm.org>
 <934d8e30-8629-d598-0214-987580c349b8@acm.org> <Y2HGOj/OCKoZr7ej@T590>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y2HGOj/OCKoZr7ej@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/22 18:22, Ming Lei wrote:
> On Tue, Nov 01, 2022 at 10:23:32AM -0700, Bart Van Assche wrote:
>> On 10/19/22 15:23, Bart Van Assche wrote:
>>> Since multi-page bvecs are supported there can be multiple segments per
>>> bvec (see also bvec_split_segs()). Hence this patch that calculates the
>>> number of segments per bvec instead of assuming that there is only one
>>> segment per bvec.
>>
>> (replying to my own email)
>>
>> Hi Ming,
>>
>> Do you agree that this patch fixes a bug introduced by the multi-page bvec
>> code and also that it is required even if the segment size is larger than
>> the page size?
> 
> No, multi-age bvec is only applied on normal IO bvec, and it isn't used
> in bio_add_pc_page(), so there isn't such issue in blk_rq_append_bio(),
> that is why we needn't to split passthrough bio.

Hi Ming,

Thanks for the feedback. I will fix the description of this patch.

Bart.

