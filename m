Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30D0C43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 18:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiF3SDi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiF3SDe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 14:03:34 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1431E39BAF
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:03:33 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id g7so221496pjj.2
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eNVKKvwmCx7w3JRivWrKA01PyX/m9ussZwTqjP+8O44=;
        b=D8J0AG7vsKJzB/Y9ErusYO9GCQkvbdFiqpBlWX5ptE8Km8rGtiUBPlO6Q/kPty83Yu
         EB8BLOKN+5yw9mW5LC6xLOuXr/n8ZusjeNfK+BkFBURVA95B/ZanghRn1y1THaijs20d
         1ehw334n8xTWuF1Wx1gUY5KMeIArFVOqZR5dL7qT0vtvvXiQrve57fKysr9l8+MFhJiP
         S35g+re+l74NJ0Kg4zewg309BU0iz0VOyRecXthwBHLmTFmpUKWeVt9eec1WDnBHR3Qw
         e6bRWLQ9OPxyoiQQzJZtoOWcAaSXr4oCujNrPVMh4KY+9pEskPtz19yb8zfy85ReONy+
         toMg==
X-Gm-Message-State: AJIora/5ih27DNNeJyKwMwKCR951rDwNQHoP73y9Vc5Q/A/MydEnnAAa
        Q/LxzSms0z7jlFUCrp2s3wE=
X-Google-Smtp-Source: AGRyM1vioYvmSNtVrB/vR/BqpojUCbR0H2VC6VBa3gZ3hqlXLZesxxY5/+PaEvl7YbUULPh2+JcGlA==
X-Received: by 2002:a17:903:32c6:b0:16a:124c:9df with SMTP id i6-20020a17090332c600b0016a124c09dfmr16708001plr.126.1656612213288;
        Thu, 30 Jun 2022 11:03:33 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id y17-20020a1709027c9100b0016648412514sm13780642pll.188.2022.06.30.11.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:03:32 -0700 (PDT)
Message-ID: <9a9e6a5f-d03d-fbb5-71df-c4e2e35e898d@acm.org>
Date:   Thu, 30 Jun 2022 11:03:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/2] blk-cgroup: duplicated code refactor
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Jason Yan <yanaijie@huawei.com>, tj@kernel.org, jack@suse.cz,
        hch@lst.de
Cc:     linux-block@vger.kernel.org
References: <20220629070917.3113016-1-yanaijie@huawei.com>
 <2ba24ea6-df8f-3afb-1526-bfb5916f2fcf@kernel.dk>
 <da262064-3952-0ded-03e3-9c0246960603@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <da262064-3952-0ded-03e3-9c0246960603@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/22 01:16, John Garry wrote:
> Just wondering - are there any of my mails in your spam folder?

This morning I found the following email from you in my spam folder:

https://lore.kernel.org/linux-scsi/82e30007-1ffc-92e4-38b5-eaf7dd2e316d@huawei.com/

I'm going to reinstall my email filter that keeps Huawei emails out of 
the spam folder.

If the following information has not yet been shared with your IT 
department, please share it: https://support.google.com/a/answer/174124

Bart.
