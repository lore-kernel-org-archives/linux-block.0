Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAFDC432BE
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 17:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7454761163
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 17:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhHXRPO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 13:15:14 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:46648 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbhHXRNx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 13:13:53 -0400
Received: by mail-pj1-f47.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so2795306pjx.5
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 10:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JLsXW80R5s/b/XBuoXwCBKtFWGeQvVpfknUWAYg6KLM=;
        b=USWn8nGn0ZOgbyz43MbH1tpSG5G55WnSPIXZ9EpxKFRF74LP4vnfMHEcdTdIj9L/hP
         l/E47isAa9mufNkc6eXwYOVSP5jSbYGk1AgScbaiXe8osDs0fAx6u94rij/tGdcDte8M
         z8Jyp3kHN4zZ8Byzem/6fFKNDTN3V2wy5ktxXtPZ2+XdpRFNHv0+N93w/sWi2VIxoCkG
         PPjL+/cYF1WtfVEVm5KmombeECPmhtvUiWYfyhEywK24nyR/fQwIcOtwJb5aP5xe5LEr
         w4RIfPrcjrnz99nJVjGVSlquyWTN/1Sn60Wu7pzAYTVvnTEffJPNbMog+9tk7clvTj+S
         ZdjA==
X-Gm-Message-State: AOAM5313UR87kOgJmr7K5XA+RFIZyWiB50BM2BvFdix+cUc9T5VyAhY4
        aVqWe6fkUweytkjkc2JP6gA=
X-Google-Smtp-Source: ABdhPJyrVAIihzXJcwSEgaDw8lRaDmG1MFjXfKssWRvR6K3aan7JgEndPrlVXCwDJ1ZWzC31CEkFmg==
X-Received: by 2002:a17:90a:3d0d:: with SMTP id h13mr5581596pjc.20.1629825189155;
        Tue, 24 Aug 2021 10:13:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3f6e:b7f7:7ad7:acb7])
        by smtp.gmail.com with ESMTPSA id w8sm2968930pjd.55.2021.08.24.10.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:13:08 -0700 (PDT)
Subject: Re: [PATCH] mq-deadline: Fix request accounting
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210824170520.1659173-1-bvanassche@acm.org>
 <412b4df5-aa1c-c95b-7b71-c0fc61ae3d06@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <349f4277-4370-482d-ab4d-a1ed652e1c29@acm.org>
Date:   Tue, 24 Aug 2021 10:13:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <412b4df5-aa1c-c95b-7b71-c0fc61ae3d06@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/21 10:09 AM, Jens Axboe wrote:
> Shouldn't it be:
> 
> Fixes: 38ba64d12d4c ("block/mq-deadline: Track I/O statistics")

Right, that's what the Fixes line should look like. Do you want me to
resend this patch?

Thanks,

Bart.
