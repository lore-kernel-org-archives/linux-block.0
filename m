Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E10C32771
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 04:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202E92073A
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 04:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1w9VJZMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgAIEmG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 23:42:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41377 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgAIEmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 23:42:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id w62so2719132pfw.8
        for <linux-block@vger.kernel.org>; Wed, 08 Jan 2020 20:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s5QjIKOhRIRXPIaPhZrtm/yDj2eELl+qf7HXUlHEugk=;
        b=1w9VJZMl7k8ujTcAkcskzBXiqyuBdukwV7M7doYPg5C+wMu/ba1vFpXYl3+YBwgdnE
         SMKZoL8f/ZIb2muYROtXdEsGve+hKTOSFOGpqvScu7fH43Kbj1nriF1wsj2flNnf88Uh
         Tp9IT5DkYjfY99cYk2L83i+mnM1guq/DJODgY1tS7q/QhFGN5oRD85oqBWw/inXomm0p
         pzLk/LERQlhHRCsRdd2pETxi8AJJv4n8G1dMBMecm5q2ib30jG9k+FJo6/vh2ftwA0X6
         KVlB/dHs8xtZDt7YO7uxNcSjFIHhrZCj2qnTZ3XwKlBDe+QJltoTtRuw43pNwsy1Osgw
         xhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s5QjIKOhRIRXPIaPhZrtm/yDj2eELl+qf7HXUlHEugk=;
        b=mlWPfST+TEiFrTl5+RPjQvPypH8a9MBJ+yBsVGGzdQmYPkTOBIR6P2iPVYjl3AA6Lx
         BOcNkudddAvbRWA19DfAFJVMZglKVDD4jXBvskXjRq18IF6W2iRK9tNTBxaFmhMRoUIb
         DkGhepPQX7EET6exY5tiPBo22szlpQ9Xg50MkdGgbUJ6b030/UM2pw2O2hm52zlvBP28
         6H043NrZtub1oQuqo6crdvkvLHWx9LpbKXjP+tW9GJuP0rEnfdyILg4kvLZ6dt4or8cV
         dy1/Dz714p1BrFcyAHbFdJdvcoO2zCd2hL9VtqK4oqLBDlX2r9QGPdFzSooEDBvuMnZH
         KMJg==
X-Gm-Message-State: APjAAAX1TiW38rxBEld7peZFIHDz2FbhqPwqyf0XgS231p5Jk3WSQD4x
        2XNLp4GdAAasBLOtNfwMJlqeuw==
X-Google-Smtp-Source: APXvYqyvP0Gop8iD0cvQWgX3Pr/AOXmNchGP3b12BUrZttMKts3Ukk+019sahTLxMiFatU6CiT0iLQ==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr8951787pfp.97.1578544925531;
        Wed, 08 Jan 2020 20:42:05 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 7sm5554572pfx.52.2020.01.08.20.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 20:42:04 -0800 (PST)
Subject: Re: [PATCH V3] block: mark zone-mgmt bios with REQ_SYNC
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Bob Liu <bob.liu@oracle.com>
References: <20200107215817.2162-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c4615aa5-bb48-6479-56c9-aa0254515c62@kernel.dk>
Date:   Wed, 8 Jan 2020 21:42:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107215817.2162-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/7/20 2:58 PM, Chaitanya Kulkarni wrote:
> In the current implementation, final zone-mgmt request is issued with
> submit_bio_wait() which marks the bio REQ_SYNC. This is needed since
> immediate action is expected for zone-mgmt requests as these are
> blocking operations. This also bypasses the scheduler in the
> blk_mq_make_request() and dispatches the request directly into the
> hw ctx.
> 
> This patch marks all the chained bios REQ_SYNC so that we can have
> above-mentioned behavior for non-final bios also.

Applied, thanks.

-- 
Jens Axboe

