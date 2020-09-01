Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD67CC433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9092078B
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SzeKF46A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgIAOgH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgIAOf6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 10:35:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0458FC061245
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 07:35:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so702420pjb.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Poct+gqI2x/C/NmSs4D1nAQ4J6OrYDa+XLEpOa8gRQA=;
        b=SzeKF46AucuzoqBS9Z+50IhVU0w3omrmweSSfSd4fpGSr3m2gpp7G+yVPMLUXtHQpA
         Rxcdn4b5VCuyHmFw1gIj1L1laiadkzu7d0OwxYe5jF4WBaY/QmjT37CM0X6tbb3p666F
         OogJBH4VIpHn59RRnpftCMbYXvkVpC56HU5W/ZAIxJoC3LwWi38lnvXNshDjdoyMpaw8
         A5AQCerQ75WVEevURAXGKPiZtvt7T2koVFkq/HX73H2OT64nf4dzUiT7E3LXpL4QmNJ4
         hCKzAtWRSeIYYWAIfgfTw9wxLYR7HHr2R87O+YEsKVbaVGXqIgEdgzKXok9RoL/b9nfv
         uX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Poct+gqI2x/C/NmSs4D1nAQ4J6OrYDa+XLEpOa8gRQA=;
        b=gvu4Oys0rNEk1eAq4E65pBeZw9/QsRi9a7zAA3B0jhH3r5i8GCTqmA5xkCXHGl7bwo
         a7M1Pk7KzQQYmIVaagWg5sB2Nzm6Os2YaXqGe9rAvd1oJUhymW1TSDh5dUJ8tjAGWIQu
         QklwEdFjQqi77YHz6qwiJSrQIKBlZOwLDD+7DCfwxqsWtsJRAg6TS+9JvG1aIcTIjdbJ
         AbtjDyQKtwrKzfXPpj0UksonHb7ikTDmLUzHZXBaMNI41f7WlX15KNZ2bnExDKnly1HJ
         /hi9PSWDpgtBc0zh0ReVLrPWOSVYuzwWS0yAtqpwWpqFYVKbS4Htvtwt1Fn72JoV5nmL
         X1mQ==
X-Gm-Message-State: AOAM532YGKaUFG3tk/qIoW7Davmj9xQOgvu6u9ZIp+jbUaXRKs89vo6E
        gV6a98vZWbSjKKD7SVrS8U2OAQ==
X-Google-Smtp-Source: ABdhPJzA2cPaf12QKUMVWx6FNrKAXvCffvDss5MGlDii1a27n2f/SfOajnfTno7+NWrw3GVRU4hDjQ==
X-Received: by 2002:a17:90b:282:: with SMTP id az2mr1932065pjb.66.1598970957464;
        Tue, 01 Sep 2020 07:35:57 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v18sm2059969pfu.15.2020.09.01.07.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:35:56 -0700 (PDT)
Subject: Re: [PATCH] block: fix locking in bdev_del_partition
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        syzbot+6448f3c229bc52b82f69@syzkaller.appspotmail.com
References: <20200901095941.2626957-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82949f33-65b4-4cd6-92be-5c44fe4f4d9c@kernel.dk>
Date:   Tue, 1 Sep 2020 08:35:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901095941.2626957-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/20 3:59 AM, Christoph Hellwig wrote:
> We need to hold the whole device bd_mutex to protect against
> other thread concurrently deleting out partition before we get
> to it, and thus causing a use after free.

Applied, fixed up an extra space while doing so.

-- 
Jens Axboe

