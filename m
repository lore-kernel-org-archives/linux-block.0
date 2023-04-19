Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494B0C77B73
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 18:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDSSqm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 14:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDSSql (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 14:46:41 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B328D40C6
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 11:46:40 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1a92369761cso2441485ad.3
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 11:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681930000; x=1684522000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jr825+xjZj7reNNmZec7EdTfJ0FnsLbvWN2zeJa2SJQ=;
        b=UATxEDeMCcm16dY1V0Xz/dQEo/9UhZwMUeuQnQYg7pNpIxKDafP/3lQJpmiWNvfpcY
         4xOMAZHLepAdaCeBmgP5hjgVMlzHvt2vVNd5NCXCJ6xegLX5Y3GTJd1HTgQrLdSBS2lB
         6QAiWFUgcdUeW+HLKh+tT8LpTCw2qIMU51Y9Eis2pqyHkP8LD96poaesijP10s3qEdJi
         GwyeetQiQ5ViI5e6RWkpMEvD2xJaGTQsA3oEc1tOTDpmAjzdzwNKeJNl+tEEAjjcC9Op
         e3mZNuit+0ia3ScL3WZwJPSCUQs1/P3js4EO3iZdnH2cWG/7wKtvGxSLuOXaT4y795Gx
         7BaQ==
X-Gm-Message-State: AAQBX9dfl6H2DT5eJXhkSXFSck6325mdlGpHvWgk17eULSwlvgcbHVh4
        qLy64E73IFijcvB7aMTweqU=
X-Google-Smtp-Source: AKy350aLbZW7NO+nNT5a6fOs8F/YZ1KhUfMxWbIs9xcNGG8m59n6vIL1XWwa5uc9WgMuRXcjQZbhRw==
X-Received: by 2002:a17:902:da87:b0:1a6:ce45:2331 with SMTP id j7-20020a170902da8700b001a6ce452331mr6606705plx.69.1681930000122;
        Wed, 19 Apr 2023 11:46:40 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:d65e:8f40:1b48:5b0b? ([2620:15c:211:201:d65e:8f40:1b48:5b0b])
        by smtp.gmail.com with ESMTPSA id ji6-20020a170903324600b0019abb539cddsm11848083plb.10.2023.04.19.11.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 11:46:39 -0700 (PDT)
Message-ID: <efd020f5-9528-aa5e-ecd6-f0390c41fb02@acm.org>
Date:   Wed, 19 Apr 2023 11:46:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 08/11] block: mq-deadline: Fix a race condition related
 to zoned writes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-9-bvanassche@acm.org> <20230419050706.GC25898@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230419050706.GC25898@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/23 22:07, Christoph Hellwig wrote:
> On Tue, Apr 18, 2023 at 03:39:59PM -0700, Bart Van Assche wrote:
>> Let deadline_next_request() only consider the first zoned write per
>> zone. This patch fixes a race condition between deadline_next_request()
>> and completion of zoned writes.
> 
> Can you explain the condition in a bit more detail?

Hi Christoph,

I'm concerned about the following scenario:
* deadline_next_request() starts iterating over the writes for a
   particular zone.
* blk_req_can_dispatch_to_zone() returns false for the first zoned write
   examined by deadline_next_request().
* A write for the same zone completes.
* deadline_next_request() continues examining zoned writes and
   blk_req_can_dispatch_to_zone() returns true for another write than the
   first write for a zone. This would result in an UNALIGNED WRITE
   COMMAND error for zoned SCSI devices.

Bart.

