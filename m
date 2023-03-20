Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71930C6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 23:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCTXdC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 19:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCTXdB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 19:33:01 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E066A7E
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:32:59 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id j13so13826240pjd.1
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JKAet99ZO0tnzwzzgD4Jc/rZ2gIJY+KJ7u03e+oWV0=;
        b=JpCXE8pUFOQZI7eLlAPNXiab9hWN9T2TOFgycQlYFgUnTq1b7gnrVlxzC1y30l+084
         G5RvG2+T4eI8GdC/DNWrRWbjD+wISyhv9EI1V61vG2MimiPUvscu5adfOTJ8GSPisfG3
         zO5Jeqt6vSA86mCM7BT07IPzmoMp3nBv9vxuOiGUUF2nYx3SY/z14rpoh8AimR1diKLQ
         mlO/eLhFpRhpNFDYOgdOwbbFNLOfgGGK89D8xT7kRfSTAnTZDrOUUmPL/87Xf1ZCR5VH
         Q4zJ1WuEdUY/k6ydJ7aLaMqLhxnOqoBU/dW5026fwRJo1zQfbHoSOWq8CfzkPaiznZT8
         IogA==
X-Gm-Message-State: AO0yUKVRKbTjcuopDXho5jY96xqJl9E2AtqQkH69jLIQK4Ol6+JyV+vW
        zUw1g71dVaNPYoBQ0Oaq86o=
X-Google-Smtp-Source: AK7set/PDqdv7dCv7TuJtUO5qAC4RsawyB8AvR0rN+AJ7bnnNsSBJePXW4l91d7Nv+Yc/bwq6rg2xg==
X-Received: by 2002:a17:902:fa87:b0:1a1:bede:5e4c with SMTP id lc7-20020a170902fa8700b001a1bede5e4cmr107505plb.64.1679355179136;
        Mon, 20 Mar 2023 16:32:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ad26:bef0:6406:d659? ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902728100b0019a7f427b79sm7277933pll.119.2023.03.20.16.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 16:32:58 -0700 (PDT)
Message-ID: <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
Date:   Mon, 20 Mar 2023 16:32:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/23 16:28, Ming Lei wrote:
> On Fri, Mar 17, 2023 at 04:45:46PM -0700, Bart Van Assche wrote:
>> Thanks for having taken a look. This patch series is intended for
>> REQ_OP_WRITE requests and not for REQ_OP_ZONE_APPEND requests.
> 
> But you are talking about host-managed zoned device, and the write
> should have to be zone append, right?

Hi Ming,

The use case I'm looking at is Android devices with UFS storage. UFS is 
based on SCSI and hence only REQ_OP_WRITE is supported natively. There 
is a REQ_OP_ZONE_APPEND emulation in drivers/scsi/sd_zbc.c but it 
restricts the queue depth to one.

Thanks,

Bart.

