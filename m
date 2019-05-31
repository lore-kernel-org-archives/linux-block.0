Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EB0C04AB6
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 15:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7A02564B
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 15:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEaPjH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 May 2019 11:39:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32982 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaPjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 11:39:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id x10so1320727pfi.0;
        Fri, 31 May 2019 08:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5VnAUUPUalBhUQBrM3Ijw7i3z8NfWgtlPpnzszZ306M=;
        b=SuQBf9O/Kbum1hQLYQk91YqZ5ZZWCADQfJWE1C2grrRSLX4Frs7Y7qOWp8Fxq5rImz
         dRHExapKxircHMevHFwCFU5kO95Qj9IZHjVUaqTmJwD96Y0xgeTEo7icK6dtr/KJA8fX
         /7WWJK9N3e7+MPd6rHidRBLut28Vj/HxlSn6kVvSnVKU9NU2SjWNNy0P32G51mpLj2g7
         zqDW4wcpWHypdtwtQMpkV77TSbs8ULUVSHxhr3o/mvMoaA0PKTeVfrpa11RDPV+WHfWX
         LlS/XRtyRry2rmH/rtsWSlXsgn04NjhMtDxG1BHTeAMjCmXNQykvH8qQeY6fH2V304jg
         5vUQ==
X-Gm-Message-State: APjAAAXOKQg+DM3KYRwgtWRJlCILzlwuwqEL205RjtApZavrJplfnz1r
        9zdyuANBHXaFIQTNpijvapA=
X-Google-Smtp-Source: APXvYqwXbYkYip+L0uYbgpELTGTTBrVT3I1WRN5Q6UdyuSZUEeaQr9+4n2t0JgOtZ7bHebh9+LYQ4w==
X-Received: by 2002:a63:480f:: with SMTP id v15mr9908807pga.373.1559317146401;
        Fri, 31 May 2019 08:39:06 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 2sm1919710pfo.41.2019.05.31.08.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 08:39:05 -0700 (PDT)
Subject: Re: [PATCH 2/9] block: null_blk: introduce module parameter of
 'g_host_tags'
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-3-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2f592878-4381-b6bb-2023-200a7df7093c@acm.org>
Date:   Fri, 31 May 2019 08:39:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531022801.10003-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/30/19 7:27 PM, Ming Lei wrote:
> +static int g_host_tags = 0;

Static variables should not be explicitly initialized to zero.

> +module_param_named(host_tags, g_host_tags, int, S_IRUGO);
> +MODULE_PARM_DESC(host_tags, "All submission queues share one tags");
                                                             ^^^^^^^^
Did you perhaps mean "one tagset"?

Bart.
