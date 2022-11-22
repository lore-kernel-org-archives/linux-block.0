Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D691CC433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 09:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiKVJom (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 04:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiKVJol (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 04:44:41 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E28C47
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 01:44:32 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5so10296447wmo.1
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 01:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHUnXg9I101OoRpDNYpbN9cYOK6pnknopVeWJ5Vc3lI=;
        b=CXQ905TM6axfA2EJD2M2qn6cR1Bbkue2+SFobaHeGpY6+Uu2PFj/QgY8tjM7MRzhDm
         8QSLqMJd3GxU5hoF5O7xZx3MNmz19JEU+GThC6+1dETE6sUCbkZ56x20GWcsP2W2fAu5
         lT9YAebVoq9YVLIFo3tGvLG/6cUGy07KyXld01xzw2sYUE1uleHkJ7agZvZdFltqVq0G
         P5NV6yJ/cK6Gsp/oHCtw6yD2gajnaZ/ceL4D3xF44CKoBhA2mR+RiAYFWN9rJ+uE0WEC
         2YKVrag+4dozyManYeyeHCZD1DcPXNrUoyfoNss8myop34+IfMbbEoSWOU16yKTGtpMR
         f1KQ==
X-Gm-Message-State: ANoB5pk2N6x1+QhcDMAGflJ7hJenJ+xeGUoaxN9+9kFPukIFfVosc/Oz
        6OD3qJGBkLUU9zNeKtFbgjg=
X-Google-Smtp-Source: AA0mqf68lX1An2XrP+1o3hmoEaCok9cbOkhKPv7Z+c/8c0rL+GUBKWPZwUUIwI/K5aqcWChCM2x7ww==
X-Received: by 2002:a1c:6a13:0:b0:3cf:7801:c780 with SMTP id f19-20020a1c6a13000000b003cf7801c780mr15870531wmc.29.1669110270908;
        Tue, 22 Nov 2022 01:44:30 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id a5-20020adfe5c5000000b00241bc209ae0sm13118860wrn.32.2022.11.22.01.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 01:44:30 -0800 (PST)
Message-ID: <8b9cbaeb-1366-0c0e-356a-8d7ed5ebea04@grimberg.me>
Date:   Tue, 22 Nov 2022 11:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 14/14] nvme: use blk_mq_[un]quiesce_tagset
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-15-hch@lst.de>
 <20221121204450.6vyg6gixsz4unpaz@google.com>
 <a8e3d7a4-c5f6-13d0-a517-72097daa2a7b@huawei.com>
 <20221122060855.GA14111@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221122060855.GA14111@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> This patch is causing the following crash at the boot and reverting it
>>> fixes the issue. This is next-20221121 kernel.
>> This patch can fix it.
>> https://lore.kernel.org/linux-nvme/20221116072711.1903536-1-hch@lst.de/
> 
> Yes,  But I'm a little curious how it happened.  Shakeel, do you
> have a genuine admin controller that does not have any I/O queues
> to start with, or did we have other setup time errors?  Can youpost the
> full dmesg?

Is this after splitting reset from probe?

If not, I think that probe schedules nvme_reset, which first
disables the controller, calling nvme_stop_queues unconditionally,
i.e. before the tagset was allocated.
