Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5872C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbhKWQMl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbhKWQMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:12:40 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4B1C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:09:32 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id w4so11077297ilv.12
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wbq1wdAD5orHC86D/BsHRhBIQAuwYNMeNPz9gn+UzTg=;
        b=XR+4SSCbKkjQDcPAiN8w3+nrK3ChSyNPVLegz1WyyaXkrSmwMTJL+eTaAMOg0Fj549
         sHy6Wo9lhmAxD9iv+hZGouMxZheNP0LhW+mUREitDW5kAjOzXivCVRWH856T/xlB5MSj
         Cci0OnH/eoeU+uPNJtuuJlirj22/PTLGch4LNy29Mx92Rby4gai+gEvfbNHdsA0PLgA7
         3k/uCazZa5QPGMQA4zE6bYDEW5X0WLWE5PkFfdp+k5xY9C7btWV1wvG3VFPNjtKTbeu0
         SCF/oeZgA6dVKCHoKzkb+pGeRxo3KhZLIQ+aAc5Dbuu30ZioJZpiRz3JzxiN9SA3ZTuG
         rH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wbq1wdAD5orHC86D/BsHRhBIQAuwYNMeNPz9gn+UzTg=;
        b=j+NNA8aJsFMDyHWsY2hWvchMLWCldfwyB4c0ETvNBgTQsLiYGDcaFiczOZbeCaEdRZ
         FDhkQUQxlRDbaqCYo2Qomhpym5BP1mUo5n++Mkd+vPNA+fh39ise9m3/WKmS9JgmV5Ju
         3SVy9vA5Rw1Hrm3cFXGaAAAFj2V5MTekLzcc2fQnzg1lHjFEteW8TFzZt3w8qFOym6LM
         kYZ4W7hLWM7xgemzO/lN9u6qEUgUTwEfEyX/weA+4PNj0YZXPcljT3R5iLoaY0iYYOzX
         KanRMO3klXpI/A30JqvrsZIVzcHeWU/9nBGFZljtJvcZnkLB109Y10Oe+4D0bd6LQYkU
         c6kQ==
X-Gm-Message-State: AOAM531LsP6IUsYWpYnSb40AtCxJdreIijdJl2tT/qygFae+YEl/qDDd
        J0mqGF9h1nQThU1cUGKqxsoIXS1yOyOwSana
X-Google-Smtp-Source: ABdhPJzJOidZFp1eBzxKqykKluSpwAM61xPE3hn7PKfI5mAVYTCfl2hT9obhr2fDfKKTezHvMLoG9Q==
X-Received: by 2002:a05:6e02:1e02:: with SMTP id g2mr7024904ila.290.1637683771774;
        Tue, 23 Nov 2021 08:09:31 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f15sm7398862ila.68.2021.11.23.08.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 08:09:31 -0800 (PST)
Subject: Re: [PATCH 3/3] blk-mq: cleanup request allocation
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20211123160443.1315598-1-hch@lst.de>
 <20211123160443.1315598-4-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ec32c2f-1f08-b09a-d36a-5da4327026b9@kernel.dk>
Date:   Tue, 23 Nov 2021 09:09:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211123160443.1315598-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 9:04 AM, Christoph Hellwig wrote:
> Refactor the request alloction so that blk_mq_get_cached_request tries
> to find a cached request first, and the entirely separate and now
> self contained blk_mq_get_new_requests allocates one or more requests
> if that is not possible.
> 
> There is a small change in behavior as submit_bio_checks is called
> twice now if a cached request is present but can't be used, but that
> is a small price to pay for unwinding this code.

I don't think that's an issue, the only side effect that matters here
is the remap which is tracked in the bio anyway.

-- 
Jens Axboe

