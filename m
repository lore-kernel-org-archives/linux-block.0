Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050F4C2D0A8
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 16:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA30208E4
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 16:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="appXkNzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWQi3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWQi2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 12:38:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA46AC0613CE
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 09:38:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z18so28561pfg.0
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vq5QEJTZb/1RH43/N7JqAL2lDhT92d3iZlvsTjPK+o4=;
        b=appXkNzPIJlso3EN8c3hpX3MeyK8Zn5VFyYdIQNPfJy8P7MYfheVC0wfTbOTCoCp5k
         MpfDm+0UVvSJkhQbs5IctYhMsf7UCGjDRlKu4SOpzSEa5RXh+0Je3oSptmc70I12ZAqA
         XUzPBS5OHBftVtb+/ZJ16Gh9u4g9x7vprK7W3aphD223UGcFwkpkMoZ51tyj4qPdbwmo
         bITG9cJQfKiHfSe6e/ebGNuLuM1AHkw+MUCIMyB4Jt9OjfX2d/bd/yS/44WrRzUUTvOm
         jQ08fRAXX5BS18BXaxYS6gV2GeAs7fVG+buPKwmYAA3TjbgKawMhi5aeYzd1X22wR0ZG
         7feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vq5QEJTZb/1RH43/N7JqAL2lDhT92d3iZlvsTjPK+o4=;
        b=S8IWKgLhdtzRB5jKcxFfRtCNSowswvuCluEjYK2BsPkYWowzTGFv2LgoiQw6hB994M
         w6c+NL3LFF6C9XvMY6VNs+0xRsWws2N9qPrIqj2Og0d3j4+aEZ8eezXxegMdHds6K+NY
         sEc8baiD20NgSb4guWKZUeU6gYZF3QLMYoxrCLtTRcbjCher0uqr27uSTCBbBj4LA0Uf
         r5f3bvo1QYLKA1rhKny2RFbQpD/rxQOKhRAmqaK7IYC/rrV36ivJvNbZKz8POOJ/MI7t
         EE2fvlyVCDuJloNDVklrZNIX8vAInAeLLpmZ9Se52VAg6qFwjBGuEOZ55vzGql54YVvn
         dP1Q==
X-Gm-Message-State: AOAM533mfKEcpZdxxTe5bi8CStA+rdmDOTigyGJCjds0de/dcP6W2S0E
        +FWmgz5UuvehSb48qMgni6RLqbBHSGhmvQ==
X-Google-Smtp-Source: ABdhPJzPyvcRrFapP4Pc8Inl/z95tkGtouO+7e2AlRhXiuH9O8dzDK2TbVvj6LfzAtXmHQyrSwJWLQ==
X-Received: by 2002:a62:6044:0:b029:151:1a04:895 with SMTP id u65-20020a6260440000b02901511a040895mr721835pfb.34.1600879107970;
        Wed, 23 Sep 2020 09:38:27 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y6sm120224pjl.9.2020.09.23.09.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 09:38:27 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] dm: fix then improve bio splitting
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
References: <20200922023251.47712-1-snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc988bfa-5f81-3d04-82e8-489943143355@kernel.dk>
Date:   Wed, 23 Sep 2020 10:38:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922023251.47712-1-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/20 8:32 PM, Mike Snitzer wrote:
> Hi,
> 
> Patches 1 and 2 are queued for me to send to Linus later this week.
> 
> Patches 3 and 4 are block core and should get picked up for 5.10.
> Jens, please pick them up. I revised the header for patch 4 to give
> better context for use-case where non power-of-2 chunk_sectors
> occurs. Patch 4 enables DM to switch to using blk_max_size_offset() in
> Patch 6.
> 
> Patches 5 and 6 just show how DM will be enhanced for 5.10 once
> patches 3 and 4 land in the block tree.

Applied 3-4 for 5.10, thanks.

-- 
Jens Axboe

