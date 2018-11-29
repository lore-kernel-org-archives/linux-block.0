Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD712C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC1420868
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VRic4o3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC1420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeK3CXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:23:04 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45311 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbeK3CXE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 21:23:04 -0500
Received: by mail-io1-f68.google.com with SMTP id w7so1824420iom.12
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 07:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7YzDmLbFHoKAbw7TtmM4dqrXJxeYdqlpEzgJ/7mo1E0=;
        b=VRic4o3I9qGpHMIqE1+IsBoGu5tpA3N9KqzrrEo7W8H1mg1dT2ycBXgzfP59eyO88r
         4PgbiiKk5WS+kyfGF6TF4RXzpk6R5dY2a1TDvmvJWXt2V5gvrb+P4b/sKDIbitGCGcco
         A7SbY7D0cCKZ/qFOJZcLkndsBkR5NsSasMbXJKoope78gMfTsXtaMSp04JYA48huDktG
         P0byRO9p8Ujh0jZHLb59hUkp16yzpgHn5kb8zfxbnineAfMPYGj54R41bgYgsU/qnJGH
         6XxVvHLSI41q4dat8ordehtmZ4Fz7dHTvktBLpKGAuHLAReMHzGHeGNX+IFkudkdOwq5
         uMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7YzDmLbFHoKAbw7TtmM4dqrXJxeYdqlpEzgJ/7mo1E0=;
        b=Z7T9SJYoyGG1mSZvVzdfWIRgk2yaf1Ey1oD1d7cJ8o0a8OxCD3wGjQJRbhSVC74pzA
         EohZg3e4aTWhIQg/CltiDK0vXmyZWms1uR417CQzSaZzMnSkzOzicoH3YUkrR4eiP8rF
         j+LeN6SiB2uzNB+YB36hFxwXzp+dyvUF6MQkTyoC4U3IqaHpbHp/m/zsGPmw7Dss8vXk
         fVXgabJQohfx0IorlAWOySH4yCA95NYGaNwo3KckZ9HU2jjcLgYCni96Ib1b8Dkb32yO
         Wzcbhrd+4jp6ivpLfGYhkGUPQID+RtE3755acV3xr745uQ0E33lCATZxOJbbry5lOu0z
         oa1w==
X-Gm-Message-State: AA+aEWYS4XoGaa0ZRWkPuzufCEoR+Dnd+54ZhFvpEcXoNUcUI57T9Ngm
        0BAkj9KVAjX2QLQyjUr0tylB5Q==
X-Google-Smtp-Source: AFSGD/Un8kc2Lnrx3pHrGQsD2CGvp9TBKYoW/cbLkurwaxfzaRHWE/Wn14sinU9aVB+2Lpmf9jBNRQ==
X-Received: by 2002:a6b:1741:: with SMTP id 62mr1559626iox.251.1543504641976;
        Thu, 29 Nov 2018 07:17:21 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e10sm841183ioa.65.2018.11.29.07.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 07:17:21 -0800 (PST)
Subject: Re: [PATCH 2/2] blk-mq: Add a NULL check in
 blk_mq_free_map_and_requests()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20181129105654.5icpvxx7p2kq257c@kili.mountain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6224d24a-a04c-ccdc-6adc-23da4d10eaa7@kernel.dk>
Date:   Thu, 29 Nov 2018 08:17:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129105654.5icpvxx7p2kq257c@kili.mountain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 3:56 AM, Dan Carpenter wrote:
> I recently found some code which called blk_mq_free_map_and_requests()
> with a NULL set->tags pointer.  I fixed the caller, but it seems like a
> good idea to add a NULL check here as well.  Now we can call:
> 
> 	blk_mq_free_tag_set(set);
> 	blk_mq_free_tag_set(set);
> 
> twice in a row and it's harmless.

Applied, thanks.

-- 
Jens Axboe

