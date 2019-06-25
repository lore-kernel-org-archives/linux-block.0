Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA932C48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 15:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FC02133F
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 15:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbfFYP7L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:59:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39963 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfFYP7L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 11:59:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so9162950pgj.7;
        Tue, 25 Jun 2019 08:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wcZ4fBG9NeZpTK3uYdZwLaowSCssiEZDYa5gltsOLE8=;
        b=T6cb7PwrOoBJ3xc22KrEkvza3R51XVUm+S1/an3wB3U3m411s7w8shyREVnd2NTeHo
         nBB52mdeqN8eZfTTAVTKRZQDe7ETMwsUXd7G4buRuyr0M7M9I252h+yrOlZu8MfQAet0
         kR6MkGmDiqOZfqenlf0rwakgmUVmxVfArzsZgblHlzvbf2f/t10VH7Tjjxsl3hWbV+hj
         FJlKO2ACoAFb97emlwhoXkZ5SxhBjrl2iHN8yTWlXdfzlF/7Pk6nUOlobiNbSenkXxLK
         Ps0/JaYBwV7s9yQfjEx1kvQI7lo2vBOIuJMXI0o2P+etI3V1SrGIORHxMYpI0q2dll35
         TRwg==
X-Gm-Message-State: APjAAAVh6sFTwezfznx8PUa5wfKsrVjM5mEUbxnXDegkQoANFx1lBFB2
        MZHbnP/Ozv2MdEU9UCa5zcA=
X-Google-Smtp-Source: APXvYqzK5Wob4kRvUauwcem7uvspmf/Q4N5OQ2XvFrYFmIIrZ79oLGa1FZHPfMlFiesN9n3RFQEnfA==
X-Received: by 2002:a17:90a:2ec2:: with SMTP id h2mr7265236pjs.119.1561478350370;
        Tue, 25 Jun 2019 08:59:10 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p15sm9472110pjf.27.2019.06.25.08.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 08:59:09 -0700 (PDT)
Subject: Re: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>
References: <20190625024625.23976-1-damien.lemoal@wdc.com>
 <20190625024625.23976-2-damien.lemoal@wdc.com>
 <BYAPR04MB5749C9178CB54B4A488408A986E30@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <47ab2698-9767-b080-59b7-2c4b3afaa6d3@acm.org>
Date:   Tue, 25 Jun 2019 08:59:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749C9178CB54B4A488408A986E30@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/19 8:24 PM, Chaitanya Kulkarni wrote:
> nit:- Can we use is_vmalloc_addr() call directly so that
> "if (is_vmalloc)" ->  "if (is_vmalloc_addr(data))" and remove is_vmalloc
> variable.
That would change a single call of is_vmalloc_addr() into multiple?

Bart.
