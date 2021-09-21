Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF401C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 03:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B6160E05
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 03:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhIUDkP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:40:15 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:44805 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhIUDkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 23:40:01 -0400
Received: by mail-pj1-f44.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso1522732pjb.3
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 20:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dWWi5QL0S2t5Xpyg2SuTo780nLJp3alX00qkaEWXjzM=;
        b=AuPuTZhElQEB2kJevULvik2APTGUMNRMLg1Efsb/EiVNg9bPbhnGRrcjzFOfcdcIBS
         +u4Tf/8nbGrjQxM6nBH7vUuC62WQo1hP2Sj4J5spFUjdNNQDj+gRP47PpnTqjJw+fF/+
         djTyVi/7Dj3uI7sayk08Ma+AH+JWBogZ4Ewrs2ziV5PmJES92naJUm+xqIGVe/V1QI0y
         I8ct9bJpWQ4Pz5a3YG+/VQwZy+A4XqL8Slt26k1pRQ08FD7/SPom8/206hZbWbG0EKpX
         5DXBM1wI7rNMlWmOF7d9ZYdb7l7Zkv5fX7IYDgrYB5sgv4SB5tgrePPsp5ayAqZBLzzH
         mTrQ==
X-Gm-Message-State: AOAM533gakjHpQbvRHscYSvFfnDx9BUKwWZH99V9ePRDK5wfwROw01dY
        32Av3xkN7jH0DAXAjHqXfX4=
X-Google-Smtp-Source: ABdhPJyzaLAb2mFpDHCF40OiHAH1xBd9yFYVQPKm71NRTgTXONMz2dh22YFuSeKWupD1F0rDq4BmtQ==
X-Received: by 2002:a17:902:7e82:b0:13c:a612:4712 with SMTP id z2-20020a1709027e8200b0013ca6124712mr22077195pla.29.1632195513356;
        Mon, 20 Sep 2021 20:38:33 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:2c03:4c32:d511:41a6? ([2601:647:4000:d7:2c03:4c32:d511:41a6])
        by smtp.gmail.com with ESMTPSA id u9sm16834224pgp.83.2021.09.20.20.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 20:38:32 -0700 (PDT)
Message-ID: <89982489-a063-0536-2a35-7420d71fc939@acm.org>
Date:   Mon, 20 Sep 2021 20:38:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: tear down file system I/O in del_gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20210920112405.1299667-1-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20210920112405.1299667-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/21 04:24, Christoph Hellwig wrote:
> Ming reported that for SCSI we have a lifetime problem now that
> the BDI moved from the request_queue to the disk as del_gendisk
> doesn't finish all outstanding file system I/O.  It turns out
> this actually is an older problem, although the case where it could
> be hit before was very unusual (unbinding of a SCSI upper driver
> while the scsi_device stays around).  This series fixes this by
> draining all I/O in del_gendisk.

Several failures are reported when running blktests against Jens' for-next
branch if KASAN and lockdep are enabled. Is this patch series sufficient
to make blktests pass again?

Thanks,

Bart.


