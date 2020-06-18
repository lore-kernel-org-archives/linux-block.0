Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC40FC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADAEF20890
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GGzTdSY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgFROyV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbgFROyU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 10:54:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC47C06174E
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 07:54:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y18so2536332plr.4
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wEuao5wn8UXQpITMLbI7NpgCyzdB4/2AS+Ysy0CQ4Sg=;
        b=GGzTdSY5m/+RG9/R7F6uhZjZ4Cjccdq4hLYK8CfMO8lq854zI5fOybiL/qphzD2Etx
         GEYYNjyuRD+bbju0mmC0cdBdfebDKnfh64BAUvrjldij8mjooBnyv/KP2fnvu4fJayFE
         tSL9SBK6Kej5XA2+pTMTb1ULJuOjjoNWmRCJqzpfLQ91gkJgHZHCg3502oZa4uOQuW9b
         Wkdo6BvdMXWYpCljTVq0Hm4dY0YkeA0yrIjSn56wrl6a3wWm79j9bJYW1soqab4JWvtV
         am9eAXUrrxITQyeczKb9ljW9HBZY+cbpNA5hqVc5pR1C7RUBc7dsz5XRChvch86hd0et
         2FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wEuao5wn8UXQpITMLbI7NpgCyzdB4/2AS+Ysy0CQ4Sg=;
        b=Et/xTih2yDgYg+9w6V5Cte0o9M7WefiACGxkoQ4t1OkVwtCX0c300Mrme93bwxD8ON
         xovj5Sh0nbbhuEN5KKFkMOYwiFtFTERabtz3dwkmsUFL4fnznA1+TQ8hDJ+Y04UNtfQr
         pbNjZQTUVw8HRdTGVPTbgJ5vK8tEXJNMrpsB7DsR69RINB0v48iJ5FfqdCJePFfhxjWe
         MT34m5SnatrZfv15m71kY7XCVgS6GPqZ4+5bPHIfa7fdm1k++YGLAhYSCpLK+FPdt6nv
         IawBcuewVIxds0cnoT88pCKRBwmtnfEN6PfDTGyk3QcIAvnCVf2ifD7UkmtBN0O0ho3w
         rykQ==
X-Gm-Message-State: AOAM5323j79cEevNZP3bobmRtvXCfl+d1d1vPmxuMVOM5ABdvOpVYOcR
        +u7U1JeKH1B2FvzuO1PuiI2osA==
X-Google-Smtp-Source: ABdhPJwcFOc5Yr92uc93fm7894g1kSKgQZVoOZV5HwWbPNZS46MHJ8WAPgFlOhcLhn8gRP3SnaVudQ==
X-Received: by 2002:a17:902:d902:: with SMTP id c2mr4292295plz.194.1592492059351;
        Thu, 18 Jun 2020 07:54:19 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 8sm3052619pja.0.2020.06.18.07.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 07:54:18 -0700 (PDT)
Subject: Re: blk_mq_complete_request overhaul
To:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20200611064452.12353-1-hch@lst.de>
 <20200618141103.GA16866@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b46ff4dc-45de-0130-d36c-70278f49abb1@kernel.dk>
Date:   Thu, 18 Jun 2020 08:54:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618141103.GA16866@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/20 8:11 AM, Christoph Hellwig wrote:
> Any comments?
> 
> (and yes, I misspelled the nvme list address, but the interested
> parties should be on linux-block anyway)

I've looked over it, and it looks fine to me. Haven't done a full
test pass yet, but assuming that's good, I'll queue this up for
5.9.

-- 
Jens Axboe

