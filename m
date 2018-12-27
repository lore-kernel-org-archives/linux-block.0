Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD89C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 15:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F04A2148D
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 15:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ptdhfMod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbeL0P5I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 10:57:08 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:33685 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeL0P5I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 10:57:08 -0500
Received: by mail-pl1-f171.google.com with SMTP id z23so8926242plo.0
        for <linux-block@vger.kernel.org>; Thu, 27 Dec 2018 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uzlgkfw+162P1bf2yXJkLGSeyixUxY3J3l252dKJpfM=;
        b=ptdhfModkSJ3J9wBXDjVOl43qxbnDyiFLnjUhnFpbMk1G6L6yv5BZK5gNhfwwo7c3C
         hRhwGAjBft6po85qs4WYOf1bgQIFeUHp3ZNqTNk2ZpQe4V/K3/PXqPBSxbs7HIh9bmv3
         ppUNmtxVBV1hJeN58bQYYXXlmPVDrdogBUVfIGyHtAw3pls3FHdtyefgVyhMmPQ9CvE3
         aCSIPYvB88bLPbQ2MVvmLHRO64v+kHg61MbKuV5g8qbvVbYEEtfTQwc2UW8Evf6OgNIf
         5TFPwYoAPL1fsR3JoVnWDJWdcpVXBLZZEKcCYVSIDrwYTWBJjYSubCoe9aejOWTZC3yu
         mmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uzlgkfw+162P1bf2yXJkLGSeyixUxY3J3l252dKJpfM=;
        b=dCjoDv0trxku3ded0jRxZ9LzE9IA+jn0LgNAfeM+kOwC5XwyjaKGmXaGePlFk+6jzp
         HJXdjPku9iBGYkyPLX47wWSvDKM+eS64E8FZvFUkMhFZs41LoeZthRJlDT4sWxuOxi9c
         8JxjBZobSllvv754WkOrAuc3WAs+G1gvJO/OS65vM+ThQLKC2+LF5R/cNwB705SwycV8
         93QQchvJhW5gLD+GyX6tV1DpmCMAne7uOFyB313Bu/m4i6jZ0BLQckkZ9cs+1QrYqYtW
         wuZ6zd5HbAZTeGrc3moQFwtIle1GVdvtQLAZgveTAPkQs/gttx4ynqIkPS36zy+j055O
         BkMQ==
X-Gm-Message-State: AJcUukeq1Rm0sdK9ajYo0pj634pPSxElrtIw6CcJTVsToD72x1eY5/zL
        RhqW8QlR7bL/evC1CRtl6mmmbws6MS7NYw==
X-Google-Smtp-Source: ALg8bN5x6JG3F2FHJASvhcaEGnRVbbBsMUYMfm04qTsIbQA7FxV8HNWc858FNdT/GQqUFAfxZdZulA==
X-Received: by 2002:a17:902:bc44:: with SMTP id t4mr23947423plz.260.1545926227250;
        Thu, 27 Dec 2018 07:57:07 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v191sm98767807pgb.77.2018.12.27.07.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 07:57:06 -0800 (PST)
Subject: Re: [PATCH] block: add prio data check for IOPRIO_CLASS_IDLE
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     linux-block@vger.kernel.org
References: <20181227001910.3343-1-cgxu519@gmx.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74d9169e-4cfc-0361-6417-a63df52bb668@kernel.dk>
Date:   Thu, 27 Dec 2018 08:57:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181227001910.3343-1-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/26/18 5:19 PM, Chengguang Xu wrote:
> The idle class does not have class data, so let's
> fall through to case IOPRIO_CLASS_NONE to check
> the specification of data field.

I'm not going to apply this, as it's potentially changing app
behavior. We arguably should have had this check with it was
added originally, we can't add it after the fact as it could
break applications that never cleared the data field for
the idle class.

-- 
Jens Axboe

