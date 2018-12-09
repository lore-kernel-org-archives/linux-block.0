Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35004C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 14:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8B520837
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 14:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g9vzLfjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8B520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeLIOg2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:36:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44039 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLIOg2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 09:36:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so3759442pgr.11
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 06:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HW2INGhN1tc6NzAwcpMbF2PEbFL/bPk7Ndexwvweg0E=;
        b=g9vzLfjwwxQVL/PAQ0WC0hmHd9CQZ5W1/0HohPVwzQzfTLOzgcspAiOZI/dxm/bxBa
         nPqQplhgLUEHI7T/rab18fTXIGj8IGxlTDDsP9BGPEPbELJZ1m5ZoL5JDlNhJuzG3YBh
         pDnRAhC20ukCxflLPb5TqA94ExAfdSNsrF1Spj/ugvp17TFDezCvQWsVKzZYX9NC3uL1
         pKDIMszLjeBmXuunc8C5xuzEgnXhamq2R89W6DG5fdiINU1oVXS9c9L/aH2XR44K4uQL
         bgNysEkuNSvCEjC2t1X+nuLSYPkfvaphm5CfzkiuZMFAQglFUOlTmas+/eCS5TDD3aGD
         8eTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HW2INGhN1tc6NzAwcpMbF2PEbFL/bPk7Ndexwvweg0E=;
        b=R1Ux36HASAtQLRH/6Hfq96l41bQNrt2AmjaaO/vpUZtlTskQZzk2a0wePam0V/jTa5
         Zqmszx/i+F8WLUHKOAr3uVxhTMP3rF9801ZCs2/DRLAIGtrBtkrjRgQw3xWcn+V5iyrS
         6R8FllOvrUSssgsNf4+IcPBfdPLkwa8K3Af+HfX/DeLeHr+DoPmigsM6lXlu7+CHMT1J
         /1vddKFssUL57FlXNECjQHgWGKdu4YdedTTK/YitIvsGaJ2o6O+ESoXmLJ6JqxIPZu3r
         /tiYRI8VfWFa3LJleFlc0Lx51/ns6fmbScSGdbx6rDIbvxIXBlf9d0LhYxlv1uokbl0R
         9vKg==
X-Gm-Message-State: AA+aEWZ1odbJmLggEMkhz3HpBhi/ebTbfrVL0btXB5+iDRS8wJta/ioZ
        2YoxB7JU59XH/y0oXz++x1KhxQ==
X-Google-Smtp-Source: AFSGD/VcgqZG4b/1IhvF9wiTyiyamVOjU9uBOGQCcd0hv/1RvOUw0oUWTUiINd4n7DFp0c+4aLcXjw==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr7721303pgh.394.1544366187561;
        Sun, 09 Dec 2018 06:36:27 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p24sm16864882pfk.155.2018.12.09.06.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 06:36:26 -0800 (PST)
Subject: Re: [PATCH 15/26] aio: support for IO polling
To:     Benny Halevy <bhalevy@scylladb.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
References: <20181207222016.29387-1-axboe@kernel.dk>
 <20181207222016.29387-16-axboe@kernel.dk>
 <e0494161918d30787fbc759f9d2b77953249ab8b.camel@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad13ccdd-cdc5-adc9-35ca-958a30a9477d@kernel.dk>
Date:   Sun, 9 Dec 2018 07:36:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e0494161918d30787fbc759f9d2b77953249ab8b.camel@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/18 3:02 AM, Benny Halevy wrote:
>> +static int __aio_iopoll_check(struct kioctx *ctx, struct io_event __user *event,
>> +			      unsigned int *nr_events, long min_nr, long max_nr)
>> +{
>> +	int ret = 0;
>> +
>> +	while (!*nr_events || !need_resched()) {
> 
> Hmm, it doesn't make sense to spin in this loop
> if the user got _all_ the events he requested, even
> if !need_resched().  How about:
> 
> 	while (!*nr_events || (!need_resched() && *nr_events < max_nr)) {

That checking is done io aio_iopoll_getevents(), there are other
conditions where we don't want to spin, like nr_events >= min_nr for
instance. But all that logic is in aio_iopoll_getevents(), from here we
just know that we probably need to continue if nr_events == 0.

I don't think there's an issue here, and no spinning when we don't need
it.

-- 
Jens Axboe

