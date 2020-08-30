Return-Path: <SRS0=wgWW=CI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A531AC433E6
	for <linux-block@archiver.kernel.org>; Sun, 30 Aug 2020 15:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691B320720
	for <linux-block@archiver.kernel.org>; Sun, 30 Aug 2020 15:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nY+zTSni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgH3PJH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Aug 2020 11:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgH3PJF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Aug 2020 11:09:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEFCC061573
        for <linux-block@vger.kernel.org>; Sun, 30 Aug 2020 08:09:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so2874636pgm.7
        for <linux-block@vger.kernel.org>; Sun, 30 Aug 2020 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3kXf8dxzp2Z7kwLz509brrH1xgnZVizmpmlzqhWEq0o=;
        b=nY+zTSniEtIgBCfO/GQS4hMNz80vm+wcxpJF9cCZlsmzfLsz2gOZZalhRH3UrD65Q9
         S7SBKTUx0/kLsg8QmjnXbJ6LSzdi2pSBi1XZFSf6n5t+5KIlN1b7eapuATOGGGOZWLev
         JKw3avBkEQZ5aSt4Wjmjr5qPTkctjQlLkqooJs4N4kVv4lzeyZIPE/uJ7NUBcYDxVFOW
         QKeTzUqK9Eq/TLeyGvhc24oLFCqWon4QqtV29lCoMLVizBXaUUT7b3DKUqfNZP88vzgP
         I3PK5ALhem6m30XA2rT0UOimkI1VjqJLdU/lLFqXN9JX1zys9n/D3OaCFmcKrg8cqTc3
         WmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3kXf8dxzp2Z7kwLz509brrH1xgnZVizmpmlzqhWEq0o=;
        b=G8IztRtM87x5WAexfXd0L0ZmnHRyEftrGIfPTgkbKxITCVKYgTMQz6XRZ+//xr9d/2
         ZoMKu0Z9rf/5w+vWS0Qqj+bUQEuEEZN3gO4t8MAgfvqJLdkaZHkA+OkPl4e/r0MDCEAh
         hMwup3BmyWeT1LccaLxRMZL7GW8De76YTo5jk7v9ANaYu21HeQJdAVW5/diYs1SlfiuQ
         3S3uGckpbN9cMz+DN0BdHAqP68TRqosignQ+2MCw3awk15Q4mWd3awR5Rmmf13nFIxh0
         jbHol55s+zGm09qr4snvmOOeF1TK48BtFOIEvi8ec9Pu9ReYDlQq/GgtlBsfkrFszCrD
         lwFA==
X-Gm-Message-State: AOAM530g9W6s9zepFYYBWSlnTPenTjRDcofriFPnzJ5LPIqAyqrdwlVx
        54du4Y55sG3t0b1ucOvqawfVz+eAkPMGWvZv
X-Google-Smtp-Source: ABdhPJwIPBuolSqtp2rxVMCGUs9ahM7yQEponEoWg1scmCy2hOaoe4X78saeoKVQOPXugVRAi0Nwsw==
X-Received: by 2002:a63:2d0:: with SMTP id 199mr5272758pgc.408.1598800144505;
        Sun, 30 Aug 2020 08:09:04 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f4sm4734395pgi.49.2020.08.30.08.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 08:09:03 -0700 (PDT)
Subject: Re: [PATCH] block: fix -EAGAIN IOPOLL task/vm accounting
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <d27ff6f0-9347-e880-fa9d-514e993014dc@kernel.dk>
 <20200830062624.GA8972@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9681be4b-298d-7fcd-ed72-9599e08a26a9@kernel.dk>
Date:   Sun, 30 Aug 2020 09:09:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200830062624.GA8972@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/30/20 12:26 AM, Christoph Hellwig wrote:
> On Sat, Aug 29, 2020 at 10:51:11AM -0600, Jens Axboe wrote:
>> We currently increment the task/vm counts when we first attempt to queue a
>> bio. But this isn't necessarily correct - if the request allocation fails
>> with -EAGAIN, for example, and the caller retries, then we'll over-account
>> by as many retries as are done.
>>
>> This can happen for polled IO, where we cannot wait for requests. Hence
>> retries can get aggressive, if we're running out of requests. If this
>> happens, then watching the IO rates in vmstat are incorrect as they count
>> every issue attempt as successful and hence the stats are inflated by
>> quite a lot potentially.
>>
>> Add a bio flag to know if we've done accounting or not. This prevents
>> the same bio from being accounted potentially many times, when retried.
> 
> Can't the resubmitter just use submit_bio_noacct?  What is the call
> stack here?

The resubmitter is way higher than that. You could potentially have that
done in the block layer, but not higher up.

The use case is async submissions, going through ->read_iter() again.
Or ->write_iter().

-- 
Jens Axboe

