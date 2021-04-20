Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E1C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 21:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE01613F1
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 21:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhDTVg1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:36:27 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:41742 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhDTVg1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 17:36:27 -0400
Received: by mail-pg1-f171.google.com with SMTP id f29so27670155pgm.8
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 14:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J9G0LpEDF6eRkv9eN8AR5FXgx78VCKDxBBN9RlwnCZs=;
        b=snb0BNK03OJTI7yUTJVz+hQk3YdkuMuN6TzAUc+iLoamGnwHWNbEfxOitGh50bjhuB
         qxoeqL1d+gMiNAe9UPDkarD4b38RMG1xXl+A92qwzW0Z929NtlQsjvmR77t6LsOn7aCJ
         0gjFYQUMBdNsw66jGC2bhu9uNLjFw+BA8M6buMBUQlWD4OF+Prq9jiBIb1kmyjGiqqrF
         avsDw4xxtjpuUXe97GVkT0gwOrF4HAkNz9WlGDqNmDvYpoDgPs91rf/63RVEarziGfYE
         OsJ/ldzDW+QGCyxfNWUMDTEEuNmfQ4n6ENkOHIRGETJcRl/zWCIqlvYtZqz7TP7jAp7/
         z3iQ==
X-Gm-Message-State: AOAM5317n7EgW4bCVcMy2cewufyshuti6n3sIUn7KikG//cmYOLzRKRV
        ssEN7tXMYLKQKaE8ZHmwDyzMPY/1Du286A==
X-Google-Smtp-Source: ABdhPJxsKACbNW0rzIa0ImbW/H0aEKwuqo13Putbx6wfDuuD1LZUhrnHJA49h1MV//TPwkGeB7WaXA==
X-Received: by 2002:a17:90a:39cb:: with SMTP id k11mr809905pjf.59.1618954555082;
        Tue, 20 Apr 2021 14:35:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6cb:4566:9005:c2af? ([2601:647:4000:d7:6cb:4566:9005:c2af])
        by smtp.gmail.com with ESMTPSA id t23sm67679pju.15.2021.04.20.14.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 14:35:54 -0700 (PDT)
Subject: Re: [PATCH v6 2/5] blk-mq: Introduce atomic variants of
 blk_mq_(all_tag|tagset_busy)_iter
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-3-bvanassche@acm.org>
 <20210413075024.xivnj3jy6olaqglc@beryllium.lan>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3a7d44c5-cf67-3d74-49e9-93f83e6eba3c@acm.org>
Date:   Tue, 20 Apr 2021 14:35:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413075024.xivnj3jy6olaqglc@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/21 12:50 AM, Daniel Wagner wrote:
> Maybe you could also annotate blk_mq_all_tag_iter() with a
> might_sleep(). This would help to find API abusers more easily.

Hmm ... my understanding is that blk_mq_all_tag_iter() does not sleep
since that function does not sleep itself and since the only caller of
blk_mq_all_tag_iter() callers passes a callback function that does not
sleep?

Thanks,

Bart.
