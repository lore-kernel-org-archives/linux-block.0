Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3B5C742A5
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A7721019
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZRxqi0+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfGLCFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 22:05:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46758 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfGLCFJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 22:05:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id c73so3576521pfb.13
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2019 19:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zYr8UzDI7biFQnbTpSDLCT68yuvF3CA/Is+C1xTs8Kw=;
        b=ZRxqi0+uwfd/EXs2qS0gTss24yOP3a/nHPkifQtAcCm58w79HcGNu4EWv0NbxYawku
         AK1T8FHFgDxt/JZli9NM3Qa96jOu7ZgESJVqYzzOP6+/XCRrSitHAMIwLrcDeL5gyS3r
         xbLsolmvHSvDmwetd/a0I/ZoztCE7EXCtMp69KTXt1DSL0nQHHZiRJJnpuE007cl1B8S
         KwOInMzsJJTYqUCVuYlEzk3L1PRoDm0osjnYi427GGq8yc3jBvsYP/bBDi3/zip7I21/
         83G5Md5fG62b2qkvYzE0T4YCqEoqZ/kNEIeLFNgXTRiuL0SEPdzM8kda2EvGJfPUaMU6
         xYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zYr8UzDI7biFQnbTpSDLCT68yuvF3CA/Is+C1xTs8Kw=;
        b=VH4ccRKBVcec7WtVRm4/IauepVQunVYUDP1jtB5COCztZc2PxHCcBqwtHZ/ttqNniy
         NblEzNFTrxgLQvS6VtIBW/EvR0PKlcULxlxb0qmlnvK2Ie5Ka3MUpc2zQYcz2XFua6yN
         4ekaHRqmWhn299X28VUSbF38Gaee9+yc7JR4CS0I47d6GmJledmy4Yo8jIKCjVZr2mfw
         eau/XHpF6xRb3oD2uOuD8lMPrJ86N/OQCxxR5bLfwE/Jh9GFm9P8ZY8ezFORQdgKQuWu
         Otu4ESvx2H3FEA4h0rR8l7FF9Cz4SBW+93z5mPW8OsOnbGFs0WuFkFsgXlGRFg2NN7I9
         AYrQ==
X-Gm-Message-State: APjAAAX7zknyqFqKOnz5dNUVWylMFS8T/ksXtltwo5pIjrdlT8T2+gQe
        CzFidtrvSqJtH05nEPDxPd0=
X-Google-Smtp-Source: APXvYqwkoCxRxL6Tt/icdrxjvdW2QNNKuKiS5OHCXOb/WcWrbo2VzUJyQBzxCpp8z9PfHbsATpR+9g==
X-Received: by 2002:a65:6401:: with SMTP id a1mr7839009pgv.42.1562897108820;
        Thu, 11 Jul 2019 19:05:08 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id j15sm6611298pfe.3.2019.07.11.19.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 19:05:06 -0700 (PDT)
Subject: Re: [PATCH V6 0/4] Fix zone revalidation memory allocation failures
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
 <BYAPR04MB5816BC7EC358F5785AEE1EA9E7F60@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb26f686-ce7e-9d1a-4735-2375d65c0ea5@kernel.dk>
Date:   Thu, 11 Jul 2019 20:05:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816BC7EC358F5785AEE1EA9E7F60@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/19 8:02 PM, Damien Le Moal wrote:
> On 2019/07/01 14:09, Damien Le Moal wrote:
>> This series addresses a recuring problem with zone revalidation
>> failures observed during extensive testing with memory constrained
>> system and device hot-plugging.
> 
> Jens, Martin,
> 
> Any comment regarding this series ?

LGTM, I'll queue it up for this release.

-- 
Jens Axboe

