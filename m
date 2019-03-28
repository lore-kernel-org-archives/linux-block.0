Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80DEC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C32420811
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SrQOVqt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfC1RWI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:22:08 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:51714 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1RWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 13:22:07 -0400
Received: by mail-it1-f176.google.com with SMTP id e24so7305583itl.1
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2019 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IbwVPtiWDLlzC3qBZ5MVPRWUR4M+CYMlQy6n909pgqQ=;
        b=SrQOVqt64EcOhodqO35IQACPVPePH/lVSzNUOil261RTrTMRTpb7aVzBKiWCxMadWd
         +NhNKy3AJNbHfeFXMlQiQaDOcaiLql87d+e9XUkqTFgH/gIEBXesdqfxj1bsf27i5JJs
         d3adrM/h03GtXtf9bK0/OAPdLT0VYWGr/cHAS6vE7BvoTxRnDgeF1xoJoLx1UxWYhG5S
         4QNwh0Df3byH6R+gIWsbJIA7pisUqV5EhBQoafFCwWaAiWJNN0jSNvpjOZb3Y+5Dvyi+
         X7yYtkZhnMbfD742ooe8Y8g7xXgaCoCC+syeDIRRrsNRwNpx0NAFtyBp1C7ywploodYm
         4DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IbwVPtiWDLlzC3qBZ5MVPRWUR4M+CYMlQy6n909pgqQ=;
        b=ulPOXcZVsuKkQLCcnX3WfKnQCRl2jHKqvjodYuqSO3MDC6fiR+i6Ws+m4fuHtg1dHG
         iAXv1gxlu9lPO1SFfUAYN3xnDKeC7mmTlvMnroETWUfcNLuL7j/QP1NE+qAB6qBAFIRW
         PoMF2tRxxZlU4VKCaNc7d8kEs2UA2M1EErWObx0NGltgBym3Qtbej6NuU6/2J2DbTgdS
         z2dAF0ruqGOolWgdL8m4ZrAwfe6o43scWQ6SgT0ZLzfSIY1SWppPcb5zwW9KUZ6RjqPD
         fsask7+R6zAWfc+VkChIXUPT/3FsWC8bUvbSs1SHi1U0Y3fT5cIZTSaqCYVD/9urdGBq
         EZxw==
X-Gm-Message-State: APjAAAXGdsLMhIO6I4srKMbnQlzlQpvPjGJiqgHq/AX1eOrLfhliPskr
        e6/0Ik4bBI7vDgM7gX06zlGFNABER4unyg==
X-Google-Smtp-Source: APXvYqw/VPd6ZS3SWX9r1egUQN+hLJGwwa1N1eNPYIfz0pfB9S0Y03ctCtINfjp4TQmywREbA3PBBQ==
X-Received: by 2002:a24:b643:: with SMTP id d3mr1025317itj.146.1553793727048;
        Thu, 28 Mar 2019 10:22:07 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m6sm10741892ioj.36.2019.03.28.10.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:22:05 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190328171928.GA26641@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <12ed0279-03f1-91ad-c69c-d97f57642134@kernel.dk>
Date:   Thu, 28 Mar 2019 11:22:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328171928.GA26641@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/28/19 11:19 AM, Christoph Hellwig wrote:
> A few accumulated small fixes:
> 
>  - fix an endianess misannotation that sneaked in this merge window in
>    nvme-tcp (me)
>  - fix nvme-loop to handle multi-page segments (Ming)
>  - fix error handling in the nvmet configfs code (Max)
>  - add a missing requeue point in the multipath code (Martin George)

Pulled, thanks.

-- 
Jens Axboe

