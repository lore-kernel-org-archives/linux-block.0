Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C7C48BD1
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 17:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914ED613DE
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhFKR5K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFKR5J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jun 2021 13:57:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EA9C061574
        for <linux-block@vger.kernel.org>; Fri, 11 Jun 2021 10:55:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id go18-20020a17090b03d2b029016e4ae973f7so5316014pjb.0
        for <linux-block@vger.kernel.org>; Fri, 11 Jun 2021 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FiCqgV8kjys+3xuqiyCwJtcf1Wj53LQ5ch2SqyLytgY=;
        b=SD6IZ6g/PQccK+DJj47BNWbjBcu51Hoxg75XX8W0NsqQBg0ABF+hnuOUc/UFnpm8im
         oNVX3uykvZuuO5Y8ikPd3y+WsvzDFhqLGs4yWHQFnc8RzIYufWCIOXqn3AApkjH4Q2eg
         xQaVfA+BsocsKdfD6NHf1Rfl2fMGnqoxNR3DdZP0eXDcQ/vjXZbD88x8d17C79EnssGA
         MaA3XiWo9+AFyaOrA1MdfYif3vi99movLQHJefeIj5rihTG1TSe1D2qp8+37dXVxo+jK
         juNRW5LpLgfCfOOUxjWz+2zHY1TAZQqD4FUpZkK9KYz4TPA/VoJTiiPZCp8OQM00GFzi
         g76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FiCqgV8kjys+3xuqiyCwJtcf1Wj53LQ5ch2SqyLytgY=;
        b=VJweIYYq0uVw/8o4zb/t+koAsGLG4oQT7t55w8OYEKXFItWKQ/evPOREOOk1MFyo7b
         xCNjl9qyn8UWU8Xeh8aH/q9Bs3bXZY2Rr8rLioqN3gWZVIlnLMpTGd5maRGcpZPqa8YR
         EW2QMQ/9t32wv4l26OpyNAv7+Nseohw187vlEfdsfTvGojpTg2ob+ys25aJrS3P/iJDt
         f9iQRhp85YQrRWl/Wnu89+YQH48GyFwjW844tlYN2jkTbpqk8dmRVV4b4XvMMiAOB+NX
         4Ias4wthLJOJ2giiXynr/qCna1J87ZqbU5TUV+zsDAXro3L4ZbsTHvKTeJGW9z+RuM+8
         AkWQ==
X-Gm-Message-State: AOAM531AVt0blpZMSfLzMZhugTPBHeKBEZOQFZ5Tw1+8aIng/HBcMeAE
        2ZWEcz6YioX1BBN5SWkJ8SIQLA==
X-Google-Smtp-Source: ABdhPJxMGSnZ9kJAsN6p7k0McSncvftPUJip5kVUuOxTF3REguFHe02Lgz4i9/8fJhn7M2nOfjp+aA==
X-Received: by 2002:a17:90a:9481:: with SMTP id s1mr5656508pjo.48.1623434110978;
        Fri, 11 Jun 2021 10:55:10 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x3sm6384950pgx.8.2021.06.11.10.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:55:10 -0700 (PDT)
Subject: Re: simplify gendisk and request_queue allocation for blk-mq based
 drivers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Justin Sanders <justin@coraid.com>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Tim Waugh <tim@cyberelk.net>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
References: <20210602065345.355274-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa9590e3-20eb-5215-d2f7-6489169c232c@kernel.dk>
Date:   Fri, 11 Jun 2021 11:55:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210602065345.355274-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/2/21 12:53 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series is the scond part of cleaning up lifetimes and allocation of
> the gendisk and request_queue structure.  It adds a new interface to
> allocate the disk and queue together for blk based drivers, and uses that
> in all drivers that do not have any caveats in their gendisk and
> request_queue lifetime rules.

Applied, thanks.

-- 
Jens Axboe

