Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF297C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 14:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A352820866
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 14:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0pY3EkPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfAOOcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:32:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35752 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAOOcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 09:32:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so1328233pgs.2
        for <linux-block@vger.kernel.org>; Tue, 15 Jan 2019 06:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HOv8Y6UkAW8LENTOcy14lTHquzkdzvSE/Kl0BjajS6w=;
        b=0pY3EkPFVFZ6XdtC0lNtFrq1VOS37nEZ/8Ni4j7wQze313J56/CLpEWv0yc+5Hjjr2
         97TKo8m8LgV+ys4m5rDoaGpCyZqLKLWYNdB+uZt9VarAPrq4vfCjhYJmmsA07njPBQjd
         VgOli0RYGAing0pRPL2SqZjSJ7p0kn8tF4t/rSzhoN+igAkYXQoibpMVpKJQHkArcnox
         bnLz5tkGpuEX278QC47MvMhGOynmeAAzOHKijCPGK2P4D0sOdSOW39mk/cvr9U8IeIEK
         yciTKxD/OS8/8ERNoZdHSDCwL+UcCj8z9unshJr5rwmuqMfngG9BfvkST6VWZJ8pG97g
         XCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HOv8Y6UkAW8LENTOcy14lTHquzkdzvSE/Kl0BjajS6w=;
        b=AhTCdtH9Ny69u3z2CfLWBOqo/E4Q/dfcYE+pxIGniWB3e3pVn858xZfSYI9I1Gc4Wa
         pbNPHuyEBlHfytbCOKhQYPHMjm+jAWlWsHb1p0GoJvIji3QXOikxqvhm1RQqRwe5VpHK
         tIHlyglcIr4QonxkI7LMIj5UGn7lgx2uYZyt45MYuIjFTiz6MIAd60ZgKWI+5kLTOqc7
         PEnP11ERNRiXX2SEfZeyIcbfBCUh4ChzDEcoLKLvY/8CvdTi4ocV1v59kAJzFA7WQUvh
         Hs7UYOsOuHH8zY1+8Dur7Qnkc0LBMkVU6JnmortQ9ky7AcNXp47j6vs1NHkBwaWZrmcJ
         XV+A==
X-Gm-Message-State: AJcUukfZ6u0j87eo7k8Jp7r2AI0JC+xSNdiO68h+W244Fe5HzzQgC1sV
        8RwAdmINqGHcwLTL9InUxWvEYDt+r+1rlA==
X-Google-Smtp-Source: ALg8bN5+nQ9f01AXjAp6S5XPd4rkYT1aevmMXaH/izhBNhjwMafmmELf6sJSdkx6wA5GGthaD5sSfg==
X-Received: by 2002:a65:4946:: with SMTP id q6mr3994868pgs.201.1547562770772;
        Tue, 15 Jan 2019 06:32:50 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e24sm4481539pfi.153.2019.01.15.06.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 06:32:49 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_mtip32xx=3a_=d1=95top_abusing_the_manag?=
 =?UTF-8?Q?ed_resource_APIs?=
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20190114202330.12597-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <92bafaf0-97e0-c075-fc6a-1cb7b6f075d4@kernel.dk>
Date:   Tue, 15 Jan 2019 07:32:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114202330.12597-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/14/19 1:23 PM, Christoph Hellwig wrote:
> The mtip32xx driver uses managed resources for DMA coherent memory
> and irqs, but then always pairs them with free calls anyway, making
> the resource tracking rather pointless.  Given some DMA allocations
> are transient anyway, the irq freeing seems to require ordering vs
> other hardware access the best solution seems to be to stop using
> the managed resurce API entirely.

Applied for 5.1, thanks.

-- 
Jens Axboe

