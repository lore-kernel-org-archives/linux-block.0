Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4878C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 16:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344601AbiFNQuI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351151AbiFNQuD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 12:50:03 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68266326D5
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:50:03 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d5so5616553plo.12
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rvC+/Nedl9BjCL7ECC1s6Y7dE729kKFDRLyBn5eLgMM=;
        b=mzH0rbmQsAL0VIqkAAYmM+ak16WLM7uq9zdXzcK0HL59zbNmNc6JVjcE6hRO/q+9xb
         kQkjj4YgUlwSuThlSMO5M7TJk7xsHpM0WZa3QEWbEhT1FBEhIlD8IDUXFLruM4eQc6Lp
         RQHFc/BuNwRh5MmrsgklAoFStz17f5ny65Q1ED1jbVMaBP37+wsipFgwad0g13ZMMjjh
         pGuoyzqRrkUounjefoWDcKllHXpt6JLZZFZE9NMtPIuit4NJHzDhod89oUG+LYGiiW28
         nwYNSbVyvMwsqKywltzVk6R8TVk4sbLHcjg6b3gtUN2H9N1VyZG5zwIyBvPm9WSga6D4
         2jmg==
X-Gm-Message-State: AOAM532lvgiSNQdwsUXr0UvrN11joy+bgCX7OASAY4sU4ItG0llfKZtz
        Vme0Vw5bgI9HYJouh8rBd7A=
X-Google-Smtp-Source: ABdhPJxf83xDgUq/xVfuQbUWGq9naHpl9VkamWa843H3rtpL1WAvJxeaa3kiRQy91HP+pkdeRWUVVw==
X-Received: by 2002:a17:902:f2ca:b0:167:8898:bad0 with SMTP id h10-20020a170902f2ca00b001678898bad0mr5107113plc.170.1655225402791;
        Tue, 14 Jun 2022 09:50:02 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090a170600b001cd4989ff42sm7626942pjd.9.2022.06.14.09.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:50:01 -0700 (PDT)
Message-ID: <4b846753-bb89-c123-2813-bcb587fdcaaf@acm.org>
Date:   Tue, 14 Jun 2022 09:50:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/6] block: cleanup variable naming in get_max_io_size
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220614090934.570632-1-hch@lst.de>
 <20220614090934.570632-5-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220614090934.570632-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 02:09, Christoph Hellwig wrote:
> get_max_io_size has a very odd choice of variables names and
> initialization patterns.  Switch to more descriptive names and more
> clear initialization of them.

Hmm ... what is so odd about the variable names? I have done my best to 
chose clear and descriptive names when I introduced these names.

Bart.
