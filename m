Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC34DC433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 12:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D9620775
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 12:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mP1S9u/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgFZMRi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgFZMRi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 08:17:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B931C08C5DB
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 05:17:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h22so4879864pjf.1
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=978wLGVs1UC0lJ8/UvI6dYC0JDFg86w7Psh56SEUsW4=;
        b=mP1S9u/ZP5t6Z5fMrN3Ihm2rY4U6g4Q26beF94BXeqc8ZJwRS+ddvwFowrq8K9mTyw
         qhS2Wlgq9pWgcAXLYgEF4EgVYV148MF3JpO9fcvczi/2drR00Ua0LEKV7Dyz472qCJuC
         xu7pEg7dMqW+xDdMP5FoSb6H/SAe6gYw34gWpjRoVFMR1HAmL92sSj7IUjP+pX817TY+
         oTByj/mz+mnUz1ZmRiSGOCiOZo9zeoFynymOkbhKLKErVe4MyfaHltJZrHuiKjDRYQ69
         65vUQtHiYkBLUKDz7UQ0tg07MK5nhgdiJg11JacdKZyZxvn8cVxaSArgzoHQN59ArS7X
         Ip/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=978wLGVs1UC0lJ8/UvI6dYC0JDFg86w7Psh56SEUsW4=;
        b=OHBTDJvsN8OY8KliLctdtl9zE95NcFbd4ws9HJUWCqH5becf4rUSWbn1Yj8USO1RcK
         JGCV+2IWaowdBe/P4FQb9sBYZZZKbBzn9RfXfNX0/3fIKYFXUjEsfeUgnXNJ9Y7FhhXZ
         YaSbzWQDgcIp6TB4dgqfvXgh28WfQ6eju/RxvMRP0FVBrOBp4wPRYY2aCF0TMOd/daPi
         8sYA2/J58H9013MvaIEvcZaOfqp1pFEVdKse8OIgwPnRm5uW+caKZCW4sPswbk7S+7eb
         PHq+Ug6qfoKbpf5nOrs0Ggdx6/npQFjbfeyAje8XusfEbBsncxzNNlKD9oVKjtF4Jbbq
         HjFQ==
X-Gm-Message-State: AOAM533mu6izXG1tIsJTFpLTTqP18OHQuVdOaX6VVkPl4+3w3B/1Pa9c
        hGVAAk1TfNwEMMGZrUFAHKFPpw==
X-Google-Smtp-Source: ABdhPJyAmSzV3UZfOD2Vf6pE6gjQKxRa7NlRNPAajR7KgCaVgF0iQhcU2RM6EorPKlaqFNy8cRcMjw==
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr2944021pja.7.1593173857993;
        Fri, 26 Jun 2020 05:17:37 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j21sm4858445pfa.133.2020.06.26.05.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 05:17:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv3 1/5] block: add capacity field to zone descriptors
To:     Keith Busch <kbusch@kernel.org>
Cc:     Linux NVMe <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>, sagig <sagi@grimberg.me>,
        linux-block <linux-block@vger.kernel.org>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Daniel Wagner <dwagner@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-2-kbusch@kernel.org>
Message-ID: <1a272c03-050c-8a59-f767-cc2170f4c377@kernel.dk>
Date:   Fri, 26 Jun 2020 06:17:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-2-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 22, 2020 at 10:25 AM Keith Busch <kbusch@kernel.org> wrote:
>
> From: Matias Bjørling <matias.bjorling@wdc.com>
>
> In the zoned storage model, the sectors within a zone are typically all
> writeable. With the introduction of the Zoned Namespace (ZNS) Command
> Set in the NVM Express organization, the model was extended to have a
> specific writeable capacity.
>
> Extend the zone descriptor data structure with a zone capacity field to
> indicate to the user how many sectors in a zone are writeable.
>
> Introduce backward compatibility in the zone report ioctl by extending
> the zone report header data structure with a flags field to indicate if
> the capacity field is available.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

