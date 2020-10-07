Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9535C4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A262076C
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 14:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OzqWDak9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgJGOWq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgJGOWq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 10:22:46 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D085C0613D2
        for <linux-block@vger.kernel.org>; Wed,  7 Oct 2020 07:22:46 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t7so1204727ilf.10
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2020 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X+XR8nLP/SHif9yX+6VmnxScjBmsc+OLRr+vKJ/RlDw=;
        b=OzqWDak9+whQkyjA7BPo3Olv8aPsOIUaLyFhgtBHxstJHppwYREpYcggBpTfvDphUf
         dYAs7T97DoauvUCJkjjFV56vUpKz/aCOsDcjE/EY24xjLvDIMC0KK4kX8QzINkOHUGWE
         gYWsXimHO92fjmdXYdt7Rp/hW+0nEeg2mn4llwBnPpalRm6IlqzbzI3LPnmYwYfi2CGi
         IvvxLQho9vVFJatK1HSnfCnET25g4KSXzr6BeWC69Gnaw0gZ1YrbJC4/5WhpmRs/L+v3
         UpGd6ZTyDI6a9WjjuaEaEiCB/XvxyKWaLMbzSKWYe9JpbL4gQuGjXNH4/eUQOAZqtCLr
         xZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X+XR8nLP/SHif9yX+6VmnxScjBmsc+OLRr+vKJ/RlDw=;
        b=GkCbnTkw8xRmJFYjyfzoA5quCmvVyzFB/OOd2SXgc9Q8UURi/5GXT7GLHbeHaJVug8
         nRW4ktcFZ4QKSxfVqseYoSW66rxGJr2COUe2akSm3b0sWyrRDwcJ3ZmJ6mze4yhpID56
         u9J7EOqm34R+kObNlRP78nRQluF/LAjkcmYnCH/fd660RIpwTL0xV5jTE1EbohqWzA98
         LjWMR1QzhLsg3wleql0M6iQ8RTQ6sEIetZE+9BRYEtb7PIelGmJcrv2xGwDbXR0z3xsD
         fAOE4wOpRMplyE/VXTWclp+Vtsm1WDB7A+vV3NP4KhbeEgzPL2snseQMuP5tljah8vFM
         iKOg==
X-Gm-Message-State: AOAM531uo5jzm5roHcJMtN+buGcw5/1UD//QIEHnEkf1Jdq5InMSe58H
        wzP7i0AUWv4Oww3F7BNCgu6xUw==
X-Google-Smtp-Source: ABdhPJxWf1YkFbWbiJqDwxAUvh18D0JdL0DrjsUyh2kedAYuPc7gjSODfD1lWLBESACHQZ1H26lLNw==
X-Received: by 2002:a92:c20e:: with SMTP id j14mr2999967ilo.164.1602080565248;
        Wed, 07 Oct 2020 07:22:45 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 69sm928314iou.42.2020.10.07.07.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 07:22:44 -0700 (PDT)
Subject: Re: [PATCH v2] block: soft limit zone-append sectors as well
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <628d87042f902553d0f27028801f857393ae225b.1602074038.git.johannes.thumshirn@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1aa6105c-423a-7400-a3a2-d0c701bec09f@kernel.dk>
Date:   Wed, 7 Oct 2020 08:22:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <628d87042f902553d0f27028801f857393ae225b.1602074038.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/20 6:35 AM, Johannes Thumshirn wrote:
> Martin rightfully noted that for normal filesystem IO we have soft limits
> in place, to prevent them from getting too big and not lead to
> unpredictable latencies. For zone append we only have the hardware limit
> in place.
> 
> Cap the max sectors we submit via zone-append to the maximal number of
> sectors if the second limit is lower.

Applied, thanks.

-- 
Jens Axboe

