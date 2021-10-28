Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B352EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942E2600CC
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhJ1PXP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhJ1PXP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 11:23:15 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A8C061570
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 08:20:48 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w10so7225351ilc.13
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kouwHowXenbqw11L90UObJeDxRXc5NgyPnykfl5rk0k=;
        b=6KNjeCre8Ou2Zivo5OV+M357g+eWl3ir/kRLhgUbetDnER3ej2BLjinEPpGCz1Jq+W
         r778QJ2BP/IwSY8c2PlD3+PyzSoPdjPCAqABd8uX0X+M9P60YAtOdCz1DTFnqQ/6IT3j
         H0UF4+OgFwOhe0LMRhzM6rzokhlOJ+PIoT21pGnZnYPa49zPbNiog2uZwKJvx2uC1gy/
         Wv0v3AUpBT6FR3gvJw9vDdQtxx2GhmWVyRP9XfRpC1P2h+FW/5x94JfgQdgA5o51CuoI
         NwerVLaeR1tuiHmu9Otom/qnlPDpU4Qx/V24O1zvZu4zypaeP0CrxJkqNCgKjjWwnnKl
         AyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kouwHowXenbqw11L90UObJeDxRXc5NgyPnykfl5rk0k=;
        b=d7GBIYAwG6hmoRr+sRahTZDTr2H3NAadpqC87AeZpdCIAkVcIKfPae4PWVnNom6++V
         HtM5ZZpluoQOjMjh3+dMF93uz6FJzJMir9AIVkDzxBtBr8z0kzrvqNs+mhx6cyLpuZ6R
         Q/aOEEl3nd5arpURPzq7vYsiHVME066Z860WJxyyfwIaQ+4Zokof5XJrPPVuStZ7tuY6
         4kBLsORrXn0CQqLIqnirQrx+JXoYpb2iP2LCNiCJIyIfMGk2IjRXvUMv30KhUV8UGp0Y
         lQDpzxUusxtwxWp9PdPC5uWvKQREYU8A5l6xSwLjNHGlQq3ReEhT5MxDY9vD1XRP+6x/
         5Xfg==
X-Gm-Message-State: AOAM530P2+maIkHYr1QEcVrvMXM8l4ahnZfKVKDPs9QCaHAZv0KCTsih
        jCRgxsFdSxsM9ouWLgpdbEq2yA==
X-Google-Smtp-Source: ABdhPJwY/CegWW5MSR26tAUlEOVN4YNw2AhSzqlzs6VqYLkvvOCAFRTh3grnhm39GuRnBSbR6DYNOQ==
X-Received: by 2002:a05:6e02:1a42:: with SMTP id u2mr3973672ilv.97.1635434447640;
        Thu, 28 Oct 2021 08:20:47 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g13sm1727089ile.73.2021.10.28.08.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 08:20:46 -0700 (PDT)
Subject: Re: [PATCH 0/3] implement direct IO with integrity
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Alexander V. Buev" <a.buev@yadro.com>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
References: <20211028112406.101314-1-a.buev@yadro.com>
 <bc336e90-378e-6016-ea1c-d519290dce5f@kernel.dk>
 <20211028151851.GC9468@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <85a4c250-c189-db5f-0625-2aa4bd1305f8@kernel.dk>
Date:   Thu, 28 Oct 2021 09:20:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211028151851.GC9468@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 9:18 AM, Christoph Hellwig wrote:
> On Thu, Oct 28, 2021 at 09:13:07AM -0600, Jens Axboe wrote:
>> A couple of suggestions on this:
>>
>> 1) Don't think we need an IOSQE flag, those are mostly reserved for
>>    modifiers that apply to (mostly) all kinds of requests
>> 2) I think this would be cleaner as a separate command, rather than
>>    need odd adjustments and iov assumptions. That also gets it out
>>    of the fast path.
>>
>> I'd add IORING_OP_READV_PI and IORING_OP_WRITEV_PI for this, I think
>> you'd end up with a much cleaner implementation that way.
> 
> Agreed.  I also wonder if we could do saner paramter passing.
> E.g. pass a separate pointer to the PI data if we find space for
> that somewhere in the SQE.

Yeah, the whole "put PI in the last iovec" makes the code really ugly
dealing with it. Would be a lot cleaner to separate the two. IMHO this
is largely a work-around that you'd apply to syscall interfaces that
only take the iovec, but we don't need to work around it here if we can
define a clean command upfront.

And if we don't need vectored requests for the data part, then even
better. That one might not be feasible, but figured I'd toss it out
there.

-- 
Jens Axboe

