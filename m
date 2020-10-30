Return-Path: <SRS0=TFq0=EF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3B1C4363A
	for <linux-block@archiver.kernel.org>; Fri, 30 Oct 2020 14:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F61D20679
	for <linux-block@archiver.kernel.org>; Fri, 30 Oct 2020 14:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C0Q0LUTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgJ3Ods (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3Ods (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Oct 2020 10:33:48 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771D6C0613D4
        for <linux-block@vger.kernel.org>; Fri, 30 Oct 2020 07:33:46 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z5so7746012iob.1
        for <linux-block@vger.kernel.org>; Fri, 30 Oct 2020 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0txINu85P5EP/okxvGPBm98OdrqPqKMzQZaV43V6EUE=;
        b=C0Q0LUTW/BwBiePFPr7nkXUetDKbWELm1AhwcxKVzqOfSfie/PTmkjtWBuxBITexE8
         EoUi7oXJJpG88pxeaNOk2LsIMXFI+D6RM23U5FaUvO7E2IJi9Ib1gvJ7UFlhDmOJCgsB
         Cz/WZePzeL2Iql/3O6ql1Ogiz5i/RnbcnmcV+UOmbGtXvr6yhWwW09D/OXKUo5C7ybRI
         jab1c5vilJkJkToFmg6uNzgNQaeGl7i2AhLBzlKsVtyLxMPpKwqlh+E+F0ssmHUQq6/n
         bhnoUnUk79hh1/XseE5qbBK5Dip93Aq/Yr5VucBlQ70LJh4NV09n/cRVoRTszvrTRFDi
         8Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0txINu85P5EP/okxvGPBm98OdrqPqKMzQZaV43V6EUE=;
        b=cqbl/K7v6PhEigxPjPkCFFEpZloeCA2Gf28NPv7gcF2EAcMHLeKfYvuHvvHUAGrSn8
         j5aFRBAKWJMA88mBE59+ti6E2VXxds5SrEwzqcv9Iryy8RAtbZF/+IHU8et6ICiHuRe8
         rI+GmG7fsOgngAJhDWxDb0hyxSdQpilNT0HzBWeJxBPfErP65/aapO78RxNqb27bEJAs
         VIPdz6Ya1XlSa6U1oVKM2uvy/CHL3sK0HnQUixKrKbwe5gGRZ77JVzQx2NakvAInnOOO
         HKM+a1BkvvR9Ok3W1DuZlO99rSI1TwBwgpXmwK2yZicXa4AGwhsGTBFCCwvXFONTraca
         kfGg==
X-Gm-Message-State: AOAM532bSecon7JEtHiNm1xG/XWZXKoBR82T4DnWMQCsyokxPZ9I12Pc
        n6taEnW7Ey3RU/It662E5i0cpg==
X-Google-Smtp-Source: ABdhPJy+YNAPePDXfkzW0N9iJHcyOGjGi2770xSo04qLMwRWr9pOUEoW63a8w2dgz0/gbZa0njoYxg==
X-Received: by 2002:a05:6638:d0c:: with SMTP id q12mr2215828jaj.95.1604068425533;
        Fri, 30 Oct 2020 07:33:45 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o20sm4791759ill.59.2020.10.30.07.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 07:33:44 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: mark flush request as IDLE in flush_end_io()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20201030024253.2025932-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <72c6af99-88cf-deea-ffbf-253fd68d4553@kernel.dk>
Date:   Fri, 30 Oct 2020 08:33:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030024253.2025932-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/20 8:42 PM, Ming Lei wrote:
> Mark flush request as IDLE in its .end_io() for aligning to normal request since
> flush request stays in in-flight tags in case of !elevator, so we need to change
> its state into IDLE. Otherwise, we will hang in blk_mq_tagset_wait_completed_request()
> during error recovery because flush request's state is kept as COMPLETE.

Applied, thanks.

-- 
Jens Axboe

