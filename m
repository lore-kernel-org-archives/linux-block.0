Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175A5FC6195
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 13:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4ABA21924
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 13:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SlnJ0kzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKHNys (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:54:48 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37161 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfKHNys (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 08:54:48 -0500
Received: by mail-io1-f66.google.com with SMTP id 1so6439678iou.4
        for <linux-block@vger.kernel.org>; Fri, 08 Nov 2019 05:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qhj0pYG/xfb9ZXayAFQZBmgKNwxw6I0CpoVt3iCpB1E=;
        b=SlnJ0kzDnF+zUVdem+qMS9wPqFOmE4StE78W5pCkwNeQbv3pcDv/6wbvF9Wzsyej6a
         mVp7dDiaYBiGAGozWrA6DxU2eqJdpfSno8KXt6N44vL8mUfNvXdzzYobLagSEhGYPhrs
         mzyYec6kzQhLmNdjY3HpzPswzummUVIV45W7ewSXze6ksqYRjkIb1DF+8/l6g8hTmj2v
         fIX6tTXrTKWoCMPy1kBumphFKsg9wM5PQsZUGEbNAeOy7ZCati+IAS6/F2UO+ZcMlhPY
         PGiFXKKj/j2YC08ktmwhITccWfmu87EX9XndOE3MVtY2nXzWQpsFSPja6+o5cvtUHFrd
         VSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qhj0pYG/xfb9ZXayAFQZBmgKNwxw6I0CpoVt3iCpB1E=;
        b=YsQqQCVyDws7O1CgD7KTnYlpak+cgNtR1e2AMON3ZT3vidsYMwEAnVsPQblqhJG/dD
         j60NK0ztAxGKoITWz326Yzu6MPevP8HpBXMvaWox5qNxxpolJ5spQnC2v57st8/Td1dT
         NTbMdGuWAJrmxz4SoHFJ+fWSeS+rCnHUIYBmR2nTIdJAYgypJMp3tMl/GcQhut34Kpqw
         iTYTr8CuvmS3pufqcjNRoZ4gf5Z1Mnb7Ekw3fWseFJn3S1oZC1TSn5VDFTVAdeYFKbXD
         xXWstIC84fq3N1f2kZ8BLFr6RD6wS5bHS6afjIJsy4cvPjnxytx3LBUz2W3oyyhWi+eR
         ZkKw==
X-Gm-Message-State: APjAAAXF0Js36ggD0HJrtU+LN1ieNFy0n2ulZT/EJJHiyzeDMBskcp6X
        X2MZp+7Fq+i4ALGZkZax+Tre1Q==
X-Google-Smtp-Source: APXvYqxT7wKu6Rb3KLuV8PJsLUA7DGTaBKo+K+FqKHR5/THatlVz8nZOFOdzmcrdjerSlYdgOa+70A==
X-Received: by 2002:a05:6602:198:: with SMTP id m24mr9909819ioo.34.1573221285861;
        Fri, 08 Nov 2019 05:54:45 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p19sm776620ili.56.2019.11.08.05.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 05:54:45 -0800 (PST)
Subject: Re: [PATCH] block: drbd: remove a stay unlock in
 __drbd_send_protocol()
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20191107074847.GA11695@mwanda> <6906816.cRlsrm7Sor@fat-tyre>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <17fea9d1-39f8-1d91-5509-5f520009b9c9@kernel.dk>
Date:   Fri, 8 Nov 2019 06:54:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6906816.cRlsrm7Sor@fat-tyre>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/8/19 3:46 AM, Philipp Reisner wrote:
> Hi Dan,
> 
> yes, your patch it obviously correct. The comment you are
> referring to is badly worded. We will remove it.
> 
> Jens,
> 
> are you taking this patch as it is?

Yep, I'll queue it up.

-- 
Jens Axboe

