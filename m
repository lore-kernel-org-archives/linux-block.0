Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3286C4332F
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 20:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5A0600EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 20:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhKAUyh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 16:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhKAUye (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 16:54:34 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B37C061766
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 13:52:00 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b203so7833660iof.1
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IRU4Z2xriuoQgD604RO9is0EGLUaklqHlotccA9A6iE=;
        b=8ByB/iElhTLkclQsnrNIowA1//89qoViaN/EH4ukJxsNXhij83csIOaL7hjthiM+9s
         x9QR3spucYZtRfwp5j3lEww/Ru363gpNRyJL0lrrG6HtQmUXl1rhs7KMYd5ezqknjrsB
         Bww5FzrggV1X2vezWAT1b+l/OqqylX5kZ1oFBYYHoq9bw/CLhi90eBMsykT5ishErZix
         dUULBc6hS6N3JvrovU2ERxRIQGSv9Dpkj7Qu9VIPCJtLYpdy1E/Yhdy5tiFA9gmWPH9k
         dovYOox+cdcaM9R20AwgzV0MEzfjcUNhhL8758tKYjfNr/Bdi7qNx8uPdo4/DB2FH60t
         b/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IRU4Z2xriuoQgD604RO9is0EGLUaklqHlotccA9A6iE=;
        b=25muMRXymfSxKMqdQZPz6IS2Cp+O25Yw7BPKywfloMdsWfwcIEFWxgj7JDvvzx/Jyi
         H5VRUApXZVSNNp8iLe1/H87n4MyesYcUTQXd541tmQ3qk68/kNf5w9J3aIUWxGaXh73l
         d7Mbr4003TVBXwC1svWKEUW0OBnOnX6TT2Ur9KqCuJQUWiarNLFMlT23f6TTZTnrN1iZ
         iIzBvhXiZnjQCcmuWiXhxr5nY2yCB9xUE5TMbblcr9itia+M77s2/Tl/M5BQ2Gw1qlAf
         DYP0frbteSUN3w4++bGDCalhvfVjeuAyWkiITn7KCkXlpmQOfthGlE+DBelPQEOVziTS
         VcFg==
X-Gm-Message-State: AOAM531eZABWJnCP8o8bA7/+2UvWYfKhORTlGJ9MV8USt1HjtQqrGJ6r
        52tsL0h8OxO/ieR7Dw20e1p3rw==
X-Google-Smtp-Source: ABdhPJyfBAZ8A31TF7HBRXzm1jDAkKBXsQCg7F27GSkwEtsBBhA6yJ7BkEG7xRtx66YY4cF2b5yFPQ==
X-Received: by 2002:a05:6602:3d3:: with SMTP id g19mr23505098iov.42.1635799920114;
        Mon, 01 Nov 2021 13:52:00 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b69sm3653495iof.43.2021.11.01.13.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 13:51:59 -0700 (PDT)
Subject: Re: [PATCH 03/21] block: Add bio_for_each_folio_all()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-4-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <13b57818-5e11-7797-86b7-fd7bd6c66504@kernel.dk>
Date:   Mon, 1 Nov 2021 14:51:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211101203929.954622-4-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/21 2:39 PM, Matthew Wilcox (Oracle) wrote:
> Allow callers to iterate over each folio instead of each page.  The
> bio need not have been constructed using folios originally.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

