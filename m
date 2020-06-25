Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4116C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 14:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD528206C0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 14:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="XvJ4hl3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405497AbgFYOsr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405495AbgFYOsq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 10:48:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9923C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 07:48:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y10so6241094eje.1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GMY9x/C2jjwza6jdaPO0YKBVYFxcc9e+Li/ACoK6FL4=;
        b=XvJ4hl3wv5/RLzG5VsmH0eDsMbvTCl+U/dU2EYUWl6Cf/Lq2L6Kie/dHLfTGMrVPjJ
         L0BFVnc8QvmHmADYs65nI7jE9Hu2ITX9DluCNdCGMNX8eU6+eed9nqEBrxQ2c3dX5tyV
         J7KaVEjOts1wfbDOQInyKusN3V5SLRac4sr+QHyZaAyhKbpBQLGaVgJvlVqji1vsep+N
         oS1nULGkuqVVwcogJwmX45kV6SiRNnA7Cum6j97ARQOrNW30Wcq13v6JNkA/xLN5EHSD
         Z1ukQN78qZFGcEpWvKCv4NrgNZw3KLqNTBFnOAbKtHZm+Ts0BUcqBiZSXwc0YE4HSOWK
         8D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GMY9x/C2jjwza6jdaPO0YKBVYFxcc9e+Li/ACoK6FL4=;
        b=q60PoGgGIOkACaeYtVXW4VCTYbKUNV0EvVbxeSVw2oyB/MRuibn00DqQ9Ey3gHl5Ld
         BubSnsUYLQ/EUbMG8f/6s3g98iWRgIjQLgodZE+Cd4xHHjiHNuy8UNws5vg4V3TmJ7tY
         phIwg6dXlgzAgMwjboSt/I7TclZ7FDnmNYBbmrEShqyBBGWR/y2CmRlbHMaOHR3Pwf/k
         a0WFebRK0zDv2RCjimlgkVEgHcC10K5pvQ0U5DMyMyYq2CJZp8JTNP0KyaTgQt30yj8Z
         HZs1FXxqy2jgHYx2R6oeDXpwyRO2aAsRJ61dZLjl6bc3Z6fl4JNLcnDbFMuMyYgo6jJN
         lA+Q==
X-Gm-Message-State: AOAM532pDOAc81jGQeVrY40IHEbxVYpWJBuRHnwJgJCVyo2Zp95EkniC
        uIBK/tNN67rcjUEZIjJ/5s570w==
X-Google-Smtp-Source: ABdhPJz/4DDwtuKtzRE/yvutiwlnjG9lON75Dx1PBLPhgyFFJYVcmAeqTuyDIX9oCC65Ck9WxTcGCQ==
X-Received: by 2002:a17:907:1002:: with SMTP id ox2mr16141549ejb.358.1593096524553;
        Thu, 25 Jun 2020 07:48:44 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id z20sm507300edq.97.2020.06.25.07.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 07:48:43 -0700 (PDT)
Subject: Re: [PATCH 0/6] ZNS: Extra features for current patches
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
Message-ID: <d7b3dc5f-a10c-bcf2-8d13-26301d7736df@lightnvm.io>
Date:   Thu, 25 Jun 2020 16:48:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/06/2020 15.04, Matias Bjørling wrote:
> On 25/06/2020 14.21, Javier González wrote:
>> From: Javier González <javier.gonz@samsung.com>
>>
>> This patchset extends zoned device functionality on top of the existing
>> v3 ZNS patchset that Keith sent last week.
>>
>> Patches 1-5 are zoned block interface and IOCTL additions to expose ZNS
>> values to user-space. One major change is the addition of a new zone
>> management IOCTL that allows to extend zone management commands with
>> flags. I recall a conversation in the mailing list from early this year
>> where a similar approach was proposed by Matias, but never made it
>> upstream. We extended the IOCTL here to align with the comments in that
>> thread. Here, we are happy to get sign-offs by anyone that contributed
>> to the thread - just comment here or on the patch.
>
> The original patchset is available here: 
> https://lkml.org/lkml/2019/6/21/419
>
> We wanted to wait posting our updated patches until the base patches 
> were upstream. I guess the cat is out of the bag. :)
>
> For the open/finish/reset patch, you'll want to take a look at the 
> original patchset, and apply the feedback from that thread to your 
> patch. Please also consider the users of these operations, e.g., dm, 
> scsi, null_blk, etc. The original patchset has patches for that.
>
Please disregard the above - I forgot that the original patchset 
actually went upstream.

You're right that we discussed (I at least discussed it internally with 
Damien, but I can't find the mail) having one mgmt issuing the commands. 
We didn't go ahead and added it at that point due to ZNS still being in 
a fluffy state.

