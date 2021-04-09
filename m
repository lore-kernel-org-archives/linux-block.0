Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC3DC43462
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 14:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3864961019
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 14:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhDIOrm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 10:47:42 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:56183 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbhDIOrk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Apr 2021 10:47:40 -0400
Received: by mail-pj1-f47.google.com with SMTP id nh5so2998513pjb.5;
        Fri, 09 Apr 2021 07:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jTLSmAm41oxeAgKBlDAz8ViVnVYi/8ty/DbvglCmKuE=;
        b=nlRc3BkoNlKkbKo9bS3c43j+Ns1GG1pFjMroHVNF6TVp3zGTjMlvHx+BsHNA77rwoW
         8IqQGBB17aM2r9ut6NiwzEUhIOBsnIRNneTbMZOyMjiO4fMEfbq9TQzOzVtnYeirhtRL
         bwema6cA/WNT7R/2D4ru5G+kFdDlDlAHPIwHQXrYT6gQtFN+7RDdDmlnhDrBobQOow3Y
         J4vB/VnI5SMCO20y7zhOIY2Y/LySovyMKss/EAH+GVpib/kmc//1l+FB9sdkP2oGlMYe
         Do7QasSuzLKLg+OzFDNQ9zhK8JXmZTYMY2SHOGDcLsTyRhHYhbFbyCYvKDTZiQ9pxo/E
         PTjQ==
X-Gm-Message-State: AOAM532tk30+0EfQG1gdBQt4WhQqgs+pLFTE5jwLZUPvAqnB2uHgZi0f
        PrkBXPe19Aeq8jEhLoKi3Ds=
X-Google-Smtp-Source: ABdhPJzXDX3qKI5eWH7T2xiUC7daXNprDW48f1xMMTLKXxTrGThczdoMpZrfVo5mzIMriyyXtlPf1g==
X-Received: by 2002:a17:90b:2250:: with SMTP id hk16mr14158721pjb.110.1617979647044;
        Fri, 09 Apr 2021 07:47:27 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id k69sm3172807pga.45.2021.04.09.07.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 07:47:26 -0700 (PDT)
Subject: Re: [RESEND,v5,1/2] bio: limit bio max size
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
References: <YG1iC944hUkBniDM@kroah.com>
 <CGME20210407094610epcas1p472207e8d3ca0e5e697974c993a2a34f7@epcas1p4.samsung.com>
 <20210407092836.13016-1-nanich.lee@samsung.com>
 <BL0PR04MB65146F70831B61CB6B9AFE7CE7759@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cdd26ed3-2013-7edd-b25e-557a56397614@acm.org>
Date:   Fri, 9 Apr 2021 07:47:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BL0PR04MB65146F70831B61CB6B9AFE7CE7759@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/21 3:27 AM, Damien Le Moal wrote:
> On 2021/04/07 18:46, Changheun Lee wrote:
>> I'll prepare new patch as you recommand. It will be added setting of
>> limit_bio_size automatically when queue max sectors is determined.
> 
> Please do that in the driver for the HW that benefits from it. Do not do this
> for all block devices.

Hmm ... is it ever useful to build a bio with a size that exceeds 
max_hw_sectors when submitting a bio directly to a block device, or in 
other words, if no stacked block driver sits between the submitter and 
the block device? Am I perhaps missing something?

Thanks,

Bart.
