Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22863C00307
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 23:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FA320842
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 23:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405629AbfIFXeh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:34:37 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:46295 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732131AbfIFXeg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 19:34:36 -0400
Received: by mail-oi1-f178.google.com with SMTP id x7so6387302oie.13;
        Fri, 06 Sep 2019 16:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=PQ/K229xL0NwkbQlPZFnpbUjHMcmFnE/sHcCaCY+vyw2IHGIgUK7CFvU0wtxBDsc1i
         Uvy8n09RUSo38/QK6Ep+lSjAGT7OgxjlAzgu/hQskAEGngSWkdBbwaNE3kXnkdsft5fn
         W6/scrjO21QHEh18w9AfbWedlDQ5ysUtMa6esVXiqLEJM7ML2nYH8VuFgBbzbXG/pTtJ
         zz9VltQdsR4h90VIO4ZN74mrpw32d5x+Zu+GMCnjiDHytjOTa/SSOoSEe87XaxHHs7w3
         wDIy4wTiyTRt2SXyO/tlIr5VVhFl+LdVC5f0mwLKyr3YWF0abdkfCXz9DovU/1xR2Ur0
         emIA==
X-Gm-Message-State: APjAAAUsJ7uIrYVK+DobCJiOltCKtj05FGuTH6LZ9bsByr+oV0DoPoQd
        cRyfsX7xGTSDKFkiOuw2RJw=
X-Google-Smtp-Source: APXvYqzifzefx7xQBDvAeraF61Gz2AeK2gogdAA47kIXIDPvYrgYZBG2M0FirwBGWf4fb+mVS7/VuA==
X-Received: by 2002:aca:d602:: with SMTP id n2mr9082105oig.148.1567812875665;
        Fri, 06 Sep 2019 16:34:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 36sm2816041ott.66.2019.09.06.16.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:34:35 -0700 (PDT)
Subject: Re: [PATCH v8 04/13] nvmet: make nvmet_copy_ns_identifier()
 non-static
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-5-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <29d962cd-849a-cd31-1bf2-7fd47d06f116@grimberg.me>
Date:   Fri, 6 Sep 2019 16:34:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
