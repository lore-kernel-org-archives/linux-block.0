Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F872C4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 09:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBF221855
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 09:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpjBVUwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfI3JUX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:20:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44347 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfI3JUX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 05:20:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id q11so6435596lfc.11;
        Mon, 30 Sep 2019 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kdnzn0WNSmL6++6Rls+QgBKInuNxmVCJP2RucyIQe4g=;
        b=XpjBVUwCY82RHb11yRMVfN+csUZwMGRamq8xY4dNdcZsTHjwiT+G7jhvi7AriT4myd
         J3LQGGSLGnKbVSSTjDnWNUFMlE87Z6p6JqzHyjmQjiowKB0kIWMpeorsGQSF+vnmth0G
         CtWa5x9QknSVx+UftCbcmI36aKAozljWgDkEs/s9WhECL5gOL6FF5Wrgh909FTkL81Q+
         m5U6nTPth3jSPNcp7N5jv9Y1K9pEJai9NycLSUOJJsa6yDTxRmmxA17VLfmAvZXEwULc
         V9UpnpCfAxcnuVW9p0OSZavRhjL4sSA3ymIHIFuHuc6AIQC7Gke82EIuMTbsxQVWXyAs
         rUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kdnzn0WNSmL6++6Rls+QgBKInuNxmVCJP2RucyIQe4g=;
        b=uPgqrVOYcVk1gfM262olly9aUK5E/AA2yQYyWVJG1f1eQIO9MZRfRijABrwMX0J93v
         TP1x0eHyN4XuUTKaxH2GmzbcGNHG5froIkWUo3EC3DS1CJTwSEpzrt9UV3NuXESaZoga
         6njSkEcf9Sk2mMZi8Q26y9Gl4KuoQEbXKYlSrF0pGI37j9dG05HwXyjeozIF2XKRChLU
         XHsYYVdQ+TZ0+Z7lTu/dwZSMK20VjD4za+HGKzeQQ7bQl9zlXm5cubiu+foFBGNAhDtc
         ZQki0rmFkMfs26Gqma0hHwyTJhrj4ADgNfnRs8nsy7LFaWGITljcru/HeAmPvdho8I2n
         h3og==
X-Gm-Message-State: APjAAAVjxLiLCaoCisUIinpj00ro7mTghAzRg+K0CURIAXx45vFl+7rn
        PpgD30Nx9l55vu9gpG8BQyCjiay8rqQ=
X-Google-Smtp-Source: APXvYqwfvtwMv55fxzgK/QzZWF47pMokhrIop+AuLH33tqI+rn2riwwvcmVrgzmNPkaMIr2bVBTmFA==
X-Received: by 2002:a19:f111:: with SMTP id p17mr10874635lfh.187.1569835220507;
        Mon, 30 Sep 2019 02:20:20 -0700 (PDT)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id 202sm3189547ljf.75.2019.09.30.02.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:20:20 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: reuse code in blk_mq_check_inflight*()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <11ebb046bf422facf6e438672799306b80038173.1569830385.git.asml.silence@gmail.com>
 <20190930083324.GA24152@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <97498865-bb36-7367-4cf3-de6d812b23cb@gmail.com>
Date:   Mon, 30 Sep 2019 12:20:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190930083324.GA24152@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/2019 11:33 AM, Christoph Hellwig wrote:
> On Mon, Sep 30, 2019 at 11:27:32AM +0300, Pavel Begunkov (Silence) wrote:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> 1. Reuse the same walker callback for both blk_mq_in_flight() and
>> blk_mq_in_flight_rw().
>>
>> 2. Store inflight counters immediately in struct mq_inflight.
>> It's type-safer and removes extra indirection.
> 
> You really want to split this into two patches.  Part 2 looks very

Good point, diff is peculiarly aligned indeed. I will resend it.

> sensible to me, but I don't really see how 1 is qn equivalent
> transformation right now.  Splitting it out and writing a non-trivial
> changelog might help understanding it if you think it really is
> equivalent as-is.
> 

blk_mq_check_inflight() increments only inflight[0].
blk_mq_check_inflight_rw() increments inflight[0] or inflight[1]
depending on a flag, so summing them gives what the first function returns.

-- 
Yours sincerely,
Pavel Begunkov
