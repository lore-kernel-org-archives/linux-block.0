Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B5CC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423F0218AE
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nPc8XWPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfB1VGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:06:54 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:37714 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfB1VGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 16:06:54 -0500
Received: by mail-it1-f178.google.com with SMTP id z124so18016177itc.2
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 13:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GmgAX2FBu4+5e83IBgo1nTgNBsR4MscP1dyLIQ95L1M=;
        b=nPc8XWPwy0ixhWRSaovQlTNYhMHty71DltjVOlJ3fcHXQzAjCY7U7NV0B8jXHUkrHF
         Q2/588yUvxdPZUMQC+n7st5DxEAf1SrAtuRqB+3GlIVpxrZTea9dpgOmIDLAlE2DAI5U
         JJYiHST/OPUj4JFAkx2SHYCHAtfBxZcz7DNwu2kyIh7IAtmwlIkOtM4AVXDdy5e+eatQ
         6pD9qru/qYD+c+NKl562pjujcNZP3x08zLTBBjmmGiRvzIEhd5b6CVf5TKCCnpAYcWes
         L8mJQwNxRD68/kyRqFmbWTF5/UnSu/dd+d3Zf+zR+P3ljz0nKMbTvmPXg5K6hgp74nGU
         CwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GmgAX2FBu4+5e83IBgo1nTgNBsR4MscP1dyLIQ95L1M=;
        b=GoBCpU63MjRrFdyjbMWjVguLKD1fJGg63muSL3lyzDhcuugvkH3bZeY+audW0ZNADK
         YDnVpGaK1u1IuXeAhZeOUvjb1pR7IHydA7yK0OP+fNK+EHydcaSWYnFOib1f79lLJ51E
         diNH2NJpKA20iCIG/m1H9YiC/Pv2MGEC7uDS6zG3jsmjUauFhi0Z/uUkCywbw01JLAuO
         qYyFWBmiFyDOK9wyVu6oesh09mNyrqipcN8s8OuQF5ujOf3WgRD/xuHG/9gyhsqCm5IE
         0BMRbMy25rDqRGjahueF1yTA/53cwg77sfDEq2cs6AbWYZS5haG6lYjpIpH4bF1mGeCC
         jrlg==
X-Gm-Message-State: APjAAAX/rcz1NlX9e4KlFVmaYNzOEtJh8F6OC3JDGDx0G0zQvQH08+RG
        DZB/2XHmrTLGBxeZWqjpvu3zSA==
X-Google-Smtp-Source: APXvYqyf6P3JfcpARiloC5qZoKCQZh70NwREKyhqR6yG97dK+ENC71Yr9zRoWdSCjTKzsMFGDUyqQw==
X-Received: by 2002:a24:22c5:: with SMTP id o188mr1365686ito.68.1551388013514;
        Thu, 28 Feb 2019 13:06:53 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id g10sm7633175ioa.67.2019.02.28.13.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:06:52 -0800 (PST)
Subject: Re: [PATCH] nbd: propagate genlmsg_reply return code
To:     Li RongQing <lirongqing@baidu.com>, linux-block@vger.kernel.org,
        josef@toxicpanda.com
References: <1550553247-28077-1-git-send-email-lirongqing@baidu.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df61141f-e618-be27-9402-be3ec3508d65@kernel.dk>
Date:   Thu, 28 Feb 2019 14:06:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550553247-28077-1-git-send-email-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/18/19 10:14 PM, Li RongQing wrote:
> genlmsg_reply can fail, so propagate its return code

Applied, thanks.

-- 
Jens Axboe

