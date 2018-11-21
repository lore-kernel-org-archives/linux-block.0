Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63192C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 12:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EA9214C1
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 12:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UvjCvRys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EA9214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbeKUXbO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:31:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44329 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeKUXbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 18:31:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so5447295plq.11
        for <linux-block@vger.kernel.org>; Wed, 21 Nov 2018 04:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zFpJcUIAAmtPhbWqB7ckuBeoHcYSkYG4BuauRb7i3R4=;
        b=UvjCvRysD7ZGi31vJ/Nahx9K7WYxNDywn8brCNN6byYY6GSHRncbIjyDmupUgmWweS
         TdMBAn4QoPdFqsgE4c5WT47dBXfTY5IZBiRTzMv216w8uPE+2sObfPQAokq6Da1Ms8Ub
         toYVLdxaoEJbpWiYcHnzavG2Gk/ReK6V/EIAyNxv8dmoTQeOWk16wGNx2KewWyOKmhEy
         pyAqku5yGksoWiv7Yu+Sw+Te/Qb8iU8g3oKUXyROiW14pjiO5OQNl4B9nKIPpDel7OtN
         b9LNQs2LiEpa939iERnbZeXf8HwrQrWAw9oOWTyX2L+iaA1bN3SNeiC4cOgAM7pY64If
         Hh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zFpJcUIAAmtPhbWqB7ckuBeoHcYSkYG4BuauRb7i3R4=;
        b=RKNrBvR9s29CyRxbYiB0gQ85imbTYFCGH+J6x6XyKUAHJR8aJp7xKyKK9RxpMbwTEO
         8HnXNPDGO9HSzVTVVpmZlj7xLC7DPXEK2bEAe4QOr+ohWc6YNA0WOWndXsQ4nZ6XnZno
         HZ09/3rVdhvYM+fXxfz2h3L9GaPbiY/0u6XWsscrKYpR8ez1mjKf6IOqA1hmAZlUhZkT
         lxIhIEcWOT78SEpXHXHq0y3RjKQyslNgGTRy6sSzMC1GqAH6N7OYGub8IQIGhPyz4am7
         OdRy4edRz7OCoXfQrbEAypyVCUwBfCaEKzRVOUQn8+zJBKl6+hBBqt8SnUz5/jR83MAu
         aRhw==
X-Gm-Message-State: AA+aEWa5LOUcMcJWVv6yOtEzQykZwBchu9TD1pjBtKOE2LkBH+BUetrC
        Amd+CvkC58hxjE/bdwwI/ZFeWQ==
X-Google-Smtp-Source: AFSGD/V4+FHXakXUKONB+s5RGf2VAnmou144WymoPPSURqEP1qhoX/CFUOs3EXYy31QZ/lqKsuHMSA==
X-Received: by 2002:a63:9a52:: with SMTP id e18mr5844982pgo.14.1542805017640;
        Wed, 21 Nov 2018 04:56:57 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 139sm37821545pfb.127.2018.11.21.04.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 04:56:56 -0800 (PST)
Subject: Re: [GIT PULL] nvme fix for 4.20
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20181120161411.GA1367@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53d91a0a-73eb-53dd-195e-4c3786104009@kernel.dk>
Date:   Wed, 21 Nov 2018 05:56:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120161411.GA1367@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/20/18 9:14 AM, Christoph Hellwig wrote:
> The following changes since commit 8dc765d438f1e42b3e8227b3b09fad7d73f4ec9a:
> 
>   SCSI: fix queue cleanup race before queue initialization is done (2018-11-14 08:19:10 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.20
> 
> for you to fetch changes up to 4cff280a5fccf6513ed9e895bb3a4e7ad8b0cedc:
> 
>   nvme-fc: resolve io failures during connect (2018-11-15 11:37:55 +0100)
> 
> ----------------------------------------------------------------
> James Smart (1):
>       nvme-fc: resolve io failures during connect
> 
>  drivers/nvme/host/fc.c | 73 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 63 insertions(+), 10 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

