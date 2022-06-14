Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C42C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 23:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiFNXzE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFNXzD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 19:55:03 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF29047392
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 16:55:02 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id v17-20020a17090a899100b001ead067eaf9so540603pjn.0
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 16:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8b1A58WBMXOzNpcFvqh06IYLxhPqSj4z8lN8NLCYTBg=;
        b=vQonYQ0hJNo8uMdsVTyGfnDAwW0eIp+APoqAGG/KVmbiL4+wXCSkeJaBd/hRoRzflD
         mRBwRXt/H1mzdO+3J2djxTVBpLVUX0RRqGuETmOhkzYgIoaJ044jCsTl23g7eVN231/z
         jKMRu8csncGURSxZtZOoO067Nqwzn+OcHOGwTZVGArKElWnd+CmGO68OUWGz4ub0DPPG
         dH+eCTJS7QlucOievqJDGZxagIB4XvVrV307zCZQERsz7DpRXThGPDG1+63XZYjt6x8+
         /0AgOAfxoEYUBFdIuMd0zsMFEAwTn/7Iwb4sWn4Cp/9iYHw8p24AXVnnS6tLfzk1RwdW
         GRIQ==
X-Gm-Message-State: AJIora/w8ulchKAR7x1GNnXocH2h7/9oQdr7+K/vRecxEjGKwErC9wry
        tNT8hnHKyz+wxdEnt6Xi5iVYQWhaeiQ=
X-Google-Smtp-Source: AGRyM1tG6kMQ2ngZAjeEpNf5X9tkX2f3NHDehfiaqcRsNYsx2yXbpZ9cAcD3CWtiBVLiOM7ZeOh3Hw==
X-Received: by 2002:a17:90b:3e88:b0:1e8:8d83:8782 with SMTP id rj8-20020a17090b3e8800b001e88d838782mr7096084pjb.0.1655250901888;
        Tue, 14 Jun 2022 16:55:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903004c00b00163e459be9asm7783795pla.136.2022.06.14.16.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 16:55:01 -0700 (PDT)
Message-ID: <576762e9-eb93-0411-890e-0ed0764559ef@acm.org>
Date:   Tue, 14 Jun 2022 16:54:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Khazhy Kumykov <khazhy@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-3-bvanassche@acm.org>
 <CACGdZYJ7HfykzbgiPpT7Ymd0h39qQE3qfz90QCNeoBjK04-HSw@mail.gmail.com>
 <186833db-bb36-e3c3-5670-ac8ff0b2906b@acm.org>
 <c8e55085-4b7d-ef11-a22a-39ac71e63227@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c8e55085-4b7d-ef11-a22a-39ac71e63227@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 16:50, Damien Le Moal wrote:
> We try that "fix" with the work for zoned btrfs. It does not work. Even
> adding a delay to wait for out of order requests (if there is a hole in a
> write sequence) does not reliably work as FSes may sometimes take 10s of
> seconds to issue all write requests that can be all ordered into a nice
> write stream. Even with that delay increased to minutes, we were still
> seeing unaligned write errors.

Please clarify. Doesn't BTRFS use REQ_OP_ZONE_APPEND for zoned storage? 
REQ_OP_ZONE_APPEND requests do not trigger write errors if reordered.

Additionally, our tests with F2FS on top of this patch series pass.

Thanks,

Bart.
