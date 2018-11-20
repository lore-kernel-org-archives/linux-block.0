Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AA3C43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 02:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8B02080C
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 02:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kuftRTE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8B02080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbeKTMbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:31:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36939 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTMbP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 07:31:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so186864plr.4
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 18:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=liv8S+pJIQrIoDYrfBhRW/9oSN62DT5lxnh5GePu8lE=;
        b=kuftRTE2jVMs4h7UMBTT85t7WIQ5REM6A7XIcCPJi/awc/zuQoP2cZQHzq1eCMTbnd
         QWgZqoCCPk6TvpFKBJIBzUGcZnHEUhIiv4GwQBlowR0eUMJgeRchhFYTLn9oMwOPzYUK
         7danjKeYymW99pYtWvML4HHntNlysUz/lHkzn5X/MXbo9nAdh2UUR9pQgUa1OVUBaNGD
         oEAFTsuV6j95HZd50afmQEp5OJ28WugJ1KoDbd+P9lbxzfK8dd1NZ0w59rRgfGfUKL3t
         KWPcplImdlb/D3OV3+9Vupc70uqwtzAgKGf9ceSgO12dyyvgGfkRg5OXjnVOvbSqRWdn
         6JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=liv8S+pJIQrIoDYrfBhRW/9oSN62DT5lxnh5GePu8lE=;
        b=UybCtq+w96ubbNTE8kVAjnxfxCs9rfI+1CLQaERv3PRUlrpvIfvk9JnsF7dtH85rOv
         sSEp3vJq82I/4gy24ZlusPP0bQM0VGkBiVRUQnOMJq2FpCJi20eKGJOQZbVDYMa142Db
         5dFy650jvaRjtovqyRJKAj/522ypTAB+2HGLWMtcAFR5B8KWRgwtrSclqbENrZrPqB+s
         S2hQJGqoyFBLWeSAe3Ld4W6YXAUeBVY+4IeghKKyy0asry3+74KOS26sRFN1ct27FjAZ
         J56c1T7MHGG/UKwa14zqq9xNwwrVPIM+uAb8I62PaTH9teWuOhI/U7EUPlgqG+F4gDyk
         Ab0g==
X-Gm-Message-State: AA+aEWbPHev121ldwG3dKGC4S4j71AYlNmbNFknjgclmCC+TmlVJkEXV
        A1YISmdUlx6OymHv6NDN5Sd/gk/Ya0g=
X-Google-Smtp-Source: AFSGD/Xp2xS9S/eywyF4266+lvyuV3DglWpPg1vJAbGnPcj5NEsPlTwoGIblL2tB0KLEtyXqes/CRA==
X-Received: by 2002:a17:902:9897:: with SMTP id s23mr135512plp.69.1542679475274;
        Mon, 19 Nov 2018 18:04:35 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j64-v6sm15368251pfc.43.2018.11.19.18.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 18:04:34 -0800 (PST)
Subject: Re: [PATCH v2 0/6] Improve I/O priority handling
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20181120015238.26467-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0bcd98c8-3730-a733-10b2-402c42a576ff@kernel.dk>
Date:   Mon, 19 Nov 2018 19:04:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120015238.26467-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/18 6:52 PM, Damien Le Moal wrote:
> This small series based on for-4.21/block brings improvements to I/O priority
> hanlding. The main fixes are in patches 5, 6 and 7. These fix BIO and request
> I/O priority initialization for both the synchronous and asynchronous pathes.

Applied, thanks..

-- 
Jens Axboe

