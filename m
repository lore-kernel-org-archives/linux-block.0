Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86DDC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 18:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8359F218FE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 18:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbfDXS6Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:58:24 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34327 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfDXS6Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 14:58:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id v10so15197264oib.1
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2019 11:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DG9SI/QPhCMsh1O+lgTghRKnRtWbPGDiNL89ZJugopk=;
        b=IaeMR5Fk68PPVYG2f6czuLkK+dvkgVrfAWafNlmStY5HxNCOxxoCymv8XpC5AUhBa1
         Pu+6JU1EVsBVUr8W9eIncaTatwwHy+Bxzoh/zwyAn5mhHJTXUBDjnByiyThLWggaej0m
         LWH3A30Bb8aPWddE/Ys5MFHe20Yt90uasMzIIecJhQPArcORweyWPvPXFTOKk+Y945cF
         lRLNlj6t8YVk9lkki8ADz3RFcyySdhxJu0o0HfDRPmITXj9VdU9RcCK9m2GEtyA2RsWk
         oGlwGaGXvjXH3JrVK/TzGDxuojMSmcgphCR8Wn9a9+n168Su9s3dIIo4hg6L073Jm6rc
         j5xw==
X-Gm-Message-State: APjAAAW7xXPDYrVhtlgxhMzD3ZtOjtYcrFU+ea3HuVPPsasNzhJc5uyV
        o28lHkoGheWzXDL1MIeoqn654fC1
X-Google-Smtp-Source: APXvYqzJL9WyKuQDsEJ7vxEEtE4du+naqmGWnJvuHziPLFiqXaU5oPPRAZiQfvyUBRhxQhnFCjaijQ==
X-Received: by 2002:aca:ab06:: with SMTP id u6mr387377oie.68.1556132303990;
        Wed, 24 Apr 2019 11:58:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id q23sm9061286oic.45.2019.04.24.11.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 11:58:23 -0700 (PDT)
Subject: Re: [PATCH] block: use static bio_set for bio_split() calls
To:     Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Bart van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@gmail.com>, neilb@suse.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
 <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
 <69845bdb-cfc6-58d4-4fea-b06c2dd44872@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7588161e-deea-0009-0f53-7f0cd7295fc2@grimberg.me>
Date:   Wed, 24 Apr 2019 11:58:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <69845bdb-cfc6-58d4-4fea-b06c2dd44872@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Phew. I was wondering whether I'd been too stupid to find it.
> And having looked at it a bit closer, moving the bioset into the holding 
> structure would induce more churn, as we'd need to pass the bioset into
> blk_queue_split(), which would mean to update all drivers (11 in total) 
> for no real gain IMO; bio splitting shouldn't really be a regular 
> occurrence and hence the bioset should only be used infrequently.
> 
> However, I really would like to get feedback to the actual patch, as 
> this solves a real customer issues we've had (or still have, depending 
> on the view :-)

I think that the patch is good, which is why I asked Ming to provide
more info...
