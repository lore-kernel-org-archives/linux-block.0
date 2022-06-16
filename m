Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB7C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 15:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377905AbiFPP1y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 11:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377917AbiFPP1t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 11:27:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E012248C2
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 08:27:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p128so1841790iof.1
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=upatriLmkO3sefxdPr9OKsvWnO7y75tD7XP4VtTCKA8=;
        b=0aISl+G8eIq7A8ZAxYGuTONwi911a0KTDFYa2Ba8tjGlempPy0Y4GLQevVM+uagLOX
         1gYBr1pxdL0s3ClG29zPK2GSBRghvvpsO/o30CbhqAiiNyD72PS8p44xSQs2xNla7lu8
         qf8ER/gUPEE1BJmDXSAbO4PXt4YCeVREGUJFpq4wt3s8oPooz0BTxBdbNXlKkAKSQyzs
         h8JR4CsShfdQ5iFlwWoTCVU+9mqKaJeycRZx0x47n/4EtIlNZ51Sh4PVAeYSPzsFd+5Z
         KgmLJz90llUBVYTYMbE1xXoDqf+N43mRiQs2YrJidVhV2vXTENPQjxrWqqvpyuPVufpl
         E3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=upatriLmkO3sefxdPr9OKsvWnO7y75tD7XP4VtTCKA8=;
        b=sQo1GZWHFGpyVTuR61ydt0pRD5L20OuqxhYhLA6QJf5uDVplHD8BvAdblATkHJ/fOo
         O158jVMTHgdzrAixBa+j2AqsAvAkghdjNZSmbSrvcyfJceiCpnFtw6nOt0vYnoOcjUCl
         1qlEjjkyvvsaxD5ToGWVT8xHKDpp0Oaia5RJmU+AYhKYtTEdKK2RXJ5xSRRAvDa3N/rE
         bjzJkIm5In0NY2r0B3UtFtokTfPkS8tUB/d0IhbCJXwJDJBTqOh/iQKGvOCOWt6qRC4U
         ElCFRGmO121krQ6jRuVKXR8/GXTGR9wEQW6soFyy5nzrkXAgcoPkSyNmSDjLujp3mvgE
         GczA==
X-Gm-Message-State: AJIora+qwa++jF+8ZuA2egHGaiyrnhwyUlCA7MR3rK22UaWH1eR0rLZn
        lolBsGXQ8/ibQXkYf9OAi+6e6Q==
X-Google-Smtp-Source: AGRyM1sWGtz2ujc9bODZa2fJQWRkvHASOIH+uKiPq4diLwYftOeavGtp/uolR+hwk0xMV+9lt7sgYA==
X-Received: by 2002:a05:6638:2053:b0:331:6410:1e6d with SMTP id t19-20020a056638205300b0033164101e6dmr3099100jaj.98.1655393266404;
        Thu, 16 Jun 2022 08:27:46 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z4-20020a926504000000b002d11c598e12sm1116480ilb.61.2022.06.16.08.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 08:27:46 -0700 (PDT)
Message-ID: <281b7645-5ce3-0339-78d9-bbc737e4c50e@kernel.dk>
Date:   Thu, 16 Jun 2022 09:27:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCHv2] block: set bdi congested when no tag available
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com
References: <1655382631-3037-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1655382631-3037-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/22 6:30 AM, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> In previous version, block layer will set bdi to be congested when
> get_request fail, which may throttle direct_reclaim. Move them back
> under current blk-mq design.

bdi congestion doesn't exist anymore, not sure what this patch is
against?

-- 
Jens Axboe

