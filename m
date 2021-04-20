Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D59C433B4
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 21:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EF6613D3
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 21:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhDTVmZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:42:25 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:43734 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhDTVmY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 17:42:24 -0400
Received: by mail-pg1-f169.google.com with SMTP id p12so27708410pgj.10
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 14:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/3UcJ7RIFm9nO6wTCu/FqtovMlza2RHO4l4O8sKRVcs=;
        b=BFA0lc2BR3Og8Mv3FIHW8U+fdwU7lm/0uecGIiw+RDgkQcHQP8BPwA1ZTKMw3l6Cc5
         lLTdcnvVzPAJsa9F5vsA5Mxkx2nSbUJRjHm+4q5rluOSh7kUKnapG5LwJ0n7rw3kojk+
         gn6aYT9ThcHbh4J+hAQgDrQZfPgGG6bFBkV97eeiEwSUBVGqJcr353Mn6AlcFq2OweIi
         fj0dZdceQGLCErBsVDUHTBx1MPWNwn62DmTD93CJNM/cqmtRNub2bayU37IZEC8s4D20
         iwqpq7sRfj7J7aum7pBOfIzPdfcEUizpxGUUVotXncYBOgCHS3b75TyapGdHi8RhXM47
         eXBw==
X-Gm-Message-State: AOAM530hntKqxzy6L4aEisd6g7LiSlUNwJKtDdazOaNIOWQJzXMXN6eH
        kizZBFO4L4f7LQYaAaMHjdbRIjLGSr43AQ==
X-Google-Smtp-Source: ABdhPJwbvlPgPbEYgs2YZg+Nh27R5wXs8LfepoIWbmRcsP0BQyp+/LAFxtIjgYZ8j8giiWVvJusWCA==
X-Received: by 2002:a17:90a:f298:: with SMTP id fs24mr7289287pjb.129.1618954911968;
        Tue, 20 Apr 2021 14:41:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6cb:4566:9005:c2af? ([2601:647:4000:d7:6cb:4566:9005:c2af])
        by smtp.gmail.com with ESMTPSA id n85sm19907pfd.170.2021.04.20.14.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 14:41:51 -0700 (PDT)
Subject: Re: [PATCH v6 3/5] blk-mq: Fix races between iterating over requests
 and freeing requests
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-4-bvanassche@acm.org>
 <CACGdZYKALg4GiXza+hnhay=XbBif3v5fV7Q=AJNUE-imw=t2yQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5e08ed24-bec7-b49e-eca4-dca7c6c2d989@acm.org>
Date:   Tue, 20 Apr 2021 14:41:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CACGdZYKALg4GiXza+hnhay=XbBif3v5fV7Q=AJNUE-imw=t2yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/21 5:02 PM, Khazhy Kumykov wrote:
> On Tue, Apr 6, 2021 at 2:49 PM Bart Van Assche <bvanassche@acm.org> wrote:
[ ... ]
>> +       /*
>> +        * The request 'rq' points at is protected by an RCU read lock until
>> +        * its queue pointer has been verified and by q_usage_count while the
>> +        * callback function is being invoked. an See also the
> extra "an"?

Indeed. I will remove it.

Thanks,

Bart.
