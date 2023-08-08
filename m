Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F280C41513
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 21:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjHHVWw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbjHHVWl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 17:22:41 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AD94688
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 14:20:01 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc76cdf0cbso3035865ad.1
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691529600; x=1692134400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDdZwF9KguBzQP6YmKiwPQ6frVPgr7pc2pSejY7e/Uo=;
        b=uqcKD5Tha5HBmA3ZFYTgrsuYMh7XeSxyy0fq/7EMm7Gp5udXTZPdzZmP1SMthmVFE1
         F0iL/7RH6inx52TyO+kkbdJjFhD4MF3RypaFh+cJRfv3wyKWWV8UQFr4c/nmfpZqF+3E
         6o6UMImlWhHrWlDVIZoNqdVse4OSbMzCOWzSY2d3mejXLR7Miwc6HgXMBLg9Ryk80rqt
         41ZyOZ0/h8WJlSh7f22OG2Y9kzfZDhyct7ZxZESgLJfhl1YbuXUilLQUdWHNqE746lO8
         BRb6+UQlcQ2SAcPVZquACYqbFbos3cKUujXdFM953Jo8tk0+gNAEHkSc3x14z17wrehl
         TdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691529600; x=1692134400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDdZwF9KguBzQP6YmKiwPQ6frVPgr7pc2pSejY7e/Uo=;
        b=AKNzSG0Q377QdFg7nrHg/yH4kkmph31qEpgWZA+NKrG9Wj1nCe2VyDrRjpMqg4IKbr
         xDRmbxdNbJNB+du7QavlErRJJu+tHU6B5tmNWPiQo7uclRF7Tm+Q3A5GzJPgll/PAAar
         IOQfHHb2UvXbmObwU65GHskQYP1yq6QkoblQ16E1pIUBKkT2u2DRC0PG4Lm3kZP0xkeQ
         UkWcAjOfv2YLylfagg+QvmykXP1PFNr5f0LwM0tMyBLpQGbwh8f3EM85VIxArX5kitdJ
         FHX+grYKEM/9TfgwsTHG06lR1dLPN0zRnFe34oAyJUecdry91G2f5+kied4umPBUsZGL
         y4AA==
X-Gm-Message-State: AOJu0YxgP+qlLLWBOYl+ysxm6gFoSSwRFRekCa3nlKnEkMtlLGqTkbqX
        E92Ua2oJQEhS0EQS25Mi9+eGFw==
X-Google-Smtp-Source: AGHT+IF6Ya/5Z2xIEjHri4UBBp25Q+eun6ODOIaHNh23yLls0vl3ZjAhoczBMVM2lXWY38O5+wso1Q==
X-Received: by 2002:a17:902:e88f:b0:1bb:d7d4:e2b with SMTP id w15-20020a170902e88f00b001bbd7d40e2bmr1025181plg.0.1691529600567;
        Tue, 08 Aug 2023 14:20:00 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j24-20020a170902759800b001bc4737cc9fsm9431034pll.254.2023.08.08.14.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 14:19:59 -0700 (PDT)
Message-ID: <dd230762-804c-bb8a-24e0-123afd81e26c@kernel.dk>
Date:   Tue, 8 Aug 2023 15:19:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v6 1/7] block: Introduce the flag
 QUEUE_FLAG_NO_ZONE_WRITE_LOCK
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230804154821.3232094-1-bvanassche@acm.org>
 <20230804154821.3232094-2-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230804154821.3232094-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/23 9:47?AM, Bart Van Assche wrote:
> Writes in sequential write required zones must happen at the write
> pointer. Even if the submitter of the write commands (e.g. a filesystem)
> submits writes for sequential write required zones in order, the block
> layer or the storage controller may reorder these write commands.
> 
> The zone locking mechanism in the mq-deadline I/O scheduler serializes
> write commands for sequential zones. Some but not all storage controllers
> require this serialization. Introduce a new request queue flag to allow
> block drivers to indicate that they preserve the order of write commands
> and thus do not require serialization of writes per zone.

Looking at how this is used, why not call it QUEUE_FLAG_ZONE_WRITE_LOCK
instead? That'd make the code easier to immediately grok, rather than
deal with double negations.

-- 
Jens Axboe

