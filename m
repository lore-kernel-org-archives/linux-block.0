Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA0C76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5542253D
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbfGWUyz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:54:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40663 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbfGWUyz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 16:54:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so20008975pgj.7
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 13:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a8iFh5BbQND0J1Dwrc0Vos5lZnrpVUYNNsd3hBJPA34=;
        b=mZdYpm25fvamHrw1ttODa9o+UZc5Fs9+UHWovU5oqofKbJVNNVdTxlVtouBRZtXngy
         SmxduLsKUlLuAmvnSG3RycQAJfMRVEHRoUCbrpLItkhhqqPPPSoHbwLuWWtYWS9hv7S0
         HWCa0yuhcBCxQFmf6/WNZCb3mAEDCJ5xVzmKMbs46Lzv0sBVcTvRLQzw/OGfeNmVDf6j
         8cs4yrBhIgBFpiZR/OoAFCThJSfFqTy+72twnvIdjr2kwPMZVtDQq/+Usuq5/F04lmBP
         RQtPSApI7bqxN0tQIZH5Yg4INkUbRorjkb7swspHejCFan6N5Obm2CuCW8eLi8s3MPYt
         Bh/A==
X-Gm-Message-State: APjAAAUIyOoUUpqUQQTVlqclqqfvfFAyTBHoIZ/Y6VgmhYSO+j2POu5p
        FCbJRgKFPp4VRn98Flhl1Bs=
X-Google-Smtp-Source: APXvYqz9vS3CD0YxxS6FLT0olRRoiZHe2LxKsuIwSjFixP+MX3waHzzb/CVdoRCsXYheYJYEQ6JRjw==
X-Received: by 2002:a17:90a:24ac:: with SMTP id i41mr83137777pje.124.1563915294648;
        Tue, 23 Jul 2019 13:54:54 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t7sm36935088pfh.101.2019.07.23.13.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 13:54:53 -0700 (PDT)
Subject: Re: [PATCH 2/5] blk-mq: introduce
 blk_mq_tagset_wait_completed_request()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-3-ming.lei@redhat.com>
 <c2722892-9cbf-0747-58a8-91a99b72bc53@acm.org>
 <20190723010616.GC30776@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d4d3ded9-0012-68c1-7511-f5ac3aa7b1fb@acm.org>
Date:   Tue, 23 Jul 2019 13:54:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723010616.GC30776@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/22/19 6:06 PM, Ming Lei wrote:
> On Mon, Jul 22, 2019 at 08:25:07AM -0700, Bart Van Assche wrote:
>> On 7/21/19 10:39 PM, Ming Lei wrote:
>>> blk-mq may schedule to call queue's complete function on remote CPU via
>>> IPI, but doesn't provide any way to synchronize the request's complete
>>> fn.
>>>
>>> In some driver's EH(such as NVMe), hardware queue's resource may be freed &
>>> re-allocated. If the completed request's complete fn is run finally after the
>>> hardware queue's resource is released, kernel crash will be triggered.
>>>
>>> Prepare for fixing this kind of issue by introducing
>>> blk_mq_tagset_wait_completed_request().
>>
>> An explanation is missing of why the block layer is modified to fix this
>> instead of the NVMe driver.
> 
> The above commit log has explained that there isn't sync mechanism in
> blk-mq wrt. request completion, and there might be similar issue in other
> future drivers.

That is not sufficient as a motivation to modify the block layer because 
there is already a way to wait until request completions have finished, 
namely the request queue freeze mechanism. Have you considered to use 
that mechanism instead of introducing 
blk_mq_tagset_wait_completed_request()?

Thanks,

Bart.
