Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234C5C0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 14:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4A62183E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 14:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="STYngXIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfGAOOL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:14:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42411 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAOOL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 10:14:11 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so20605153ior.9
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sE1BaPOe4JxsMC6t4atlvq+xkIKYRLuwGnGyC71KtEM=;
        b=STYngXIOIWKNHJ2jMySf2qSCUM//ofiG/rsvVIsYU+D0KQJE55HII83CXBYLYqUFg1
         zl4DF/v3VEIJjXJ0asgD7zpxUU1+XlupBmVcqSc7u5nypPPrr/Su8qEGgmKfgx/iPdAd
         DRlT7ekn8rbGQ/Yj/Tr7kEe7lYFbe/B4yCmza58qJIEx22kz/fE49Zd4SFC3wj1o6SlQ
         TYp69EQt7IwnhzPwScg8PtI08F5t0D4/fM0MpzvvmwQ35LxGcdSGwwS2P9Lh5WOlw3Ej
         /IDghkTI1HNiK6VqMdisKjsmUgtBvBXLe2w2JmTiAYRvrFTYWMd37GoxyldaO6w1Vvyk
         vh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sE1BaPOe4JxsMC6t4atlvq+xkIKYRLuwGnGyC71KtEM=;
        b=XgmSj412wfKSnA1pmFKqksG5HVcTxJVrKTr57FFCbbt4/gi9xuPCQBj0Ff35/bRRAd
         aiWzrrU2Miufg1Z57INalAX0Rh3FgA5Ta/ho0LLlHlJv7quf6wTWzUwl5dtbaUHClCMo
         gqCMIe8h5+/7Whj8k0SG/M126bL/52H0HmcMWv4Uy/ewI0c+K7NdFtuH6g1w0tIq73Nj
         TF+DjT77ydv7WmXLae6m40mRZcZOQv8qB1us4aQ14i10UWrB2n9hPnoOw/6V7+4iqYRo
         tEyCU/8tbeMVAWqCb7qBgqoiIj4wJePcvbFAvMmOYxdNXC+DqN94aj4dtfy0BkVuGUZA
         qsgA==
X-Gm-Message-State: APjAAAUVl3MkOUQ9/HSP2sFwHErfdE4DUq+Xk+zTpoGJwui0MHFqEzLS
        vjdD9Z4+b7MnrflCNaV7jJtLDg==
X-Google-Smtp-Source: APXvYqyiFniEOwLHu/uz2qamMaeQ68Nmd9RxmwgztEmEW9yzJG/mQ4oLQyuoUplS8jc71Mfce1pzxA==
X-Received: by 2002:a02:b016:: with SMTP id p22mr20064925jah.121.1561990450147;
        Mon, 01 Jul 2019 07:14:10 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t5sm8756673iol.55.2019.07.01.07.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:14:09 -0700 (PDT)
Subject: Re: [PATCH V2] block: fix .bi_size overflow
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>,
        kernel test robot <rong.a.chen@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
References: <20190701071446.22028-1-ming.lei@redhat.com>
 <8db73c5d-a0e2-00c9-59ab-64314097db26@kernel.dk>
Message-ID: <bd45842a-e0fd-28a7-ac79-96f7cb9b66e4@kernel.dk>
Date:   Mon, 1 Jul 2019 08:14:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <8db73c5d-a0e2-00c9-59ab-64314097db26@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/19 8:05 AM, Jens Axboe wrote:
> On 7/1/19 1:14 AM, Ming Lei wrote:
>> 'bio->bi_iter.bi_size' is 'unsigned int', which at most hold 4G - 1
>> bytes.
>>
>> Before 07173c3ec276 ("block: enable multipage bvecs"), one bio can
>> include very limited pages, and usually at most 256, so the fs bio
>> size won't be bigger than 1M bytes most of times.
>>
>> Since we support multi-page bvec, in theory one fs bio really can
>> be added > 1M pages, especially in case of hugepage, or big writeback
>> with too many dirty pages. Then there is chance in which .bi_size
>> is overflowed.
>>
>> Fixes this issue by using bio_full() to check if the added segment may
>> overflow .bi_size.
> 
> Any objections to queuing this up for 5.3? It's not a new regression
> this series.

I took a closer look, and applied for 5.3 and removed the stable tag.
We'll need to apply your patch for stable, and I added an adapted
one for 5.3. I don't want a huge merge hassle because of this.

-- 
Jens Axboe

