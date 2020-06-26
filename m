Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED1C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 03:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765042070A
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 03:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zFlIritb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgFZDGd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 23:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgFZDGd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 23:06:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD7C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 20:06:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d194so960669pga.13
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 20:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=St48uRc8is0gA2H3TZAFf1eaHqVrzxEoUa61hAZQsF4=;
        b=zFlIritb0moqtHkcocIg4tgv/xxIefsAtgiqVIBFJiU1feTcSJhpH5iDIm/F0GnD8m
         eXYiWfrK1NgR997pYUDNLFkuM9a7GB5PL89InG+ZdZ7fWf6ZJBXQg2TdBwyjvIoq9bz1
         vJOBF+mCUg3L3JTIraOA/Mk7fm0+U6MEV+YsbLWONCXxow8uECPDgRsEeWkX7u5yfQKu
         xd3trHVFjksVXy1jH67FVyDrZxHIjVdO59i4LLowvU5KfqE2OWusPaxQZSwrugg6Yvwc
         fHsH3NXIkewtj4zp3lgtsEqcscJFLpQVQUQ84mWInhuhk1UIHYD1oFqaXOVCbu2jdxUK
         PIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=St48uRc8is0gA2H3TZAFf1eaHqVrzxEoUa61hAZQsF4=;
        b=AeIfBm3cZx2Q63EjWwf7j42/Pi9uQqcGOmTgp9JAU2o/BybPJ3C8JBwZf75CHB4EUI
         uGBSE44ekaYX6kMBRdSkqYnCB7IO8XGuebNoDQXjAsOydke7TJ5R9yH0pp7NpAvyylOl
         5S9xI+DIuO6tc2VMei2wYmW785k7iksZr/HxdKlh0JZ1HLfN4kCv69nmldZ3CEy1sirV
         BAIPYVexdrw2tQ6KCNel5qmbdmb/+DmioONqTAckgf7CRSgdE+jDw7+kmAtx+4rhSH5y
         iITb6NBWPa+frVd7gW8Tq82knhFzRzbbVase7/hzuSmimkRP8kmR706RjhitBnySmTih
         Ohtg==
X-Gm-Message-State: AOAM532/t1XzNJQCEoPv1YaxXGXO5fwumVebiwFvid/ebTf8HcFtTt+S
        ZyqBxvKuHS2pLY4acIuHdEMfmw==
X-Google-Smtp-Source: ABdhPJz517mT5QoeDlByH3q45GyXNzx1YajNx//ondCITi93rgrkYqNYSknuV6E1aElUH3TotVDRtA==
X-Received: by 2002:aa7:9e89:: with SMTP id p9mr812678pfq.110.1593140792216;
        Thu, 25 Jun 2020 20:06:32 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r7sm19868013pfc.183.2020.06.25.20.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 20:06:31 -0700 (PDT)
Subject: Re: [PATCH] blktrace: Provide event for request merging
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20200617135823.980-1-jack@suse.cz>
 <20200625195148.GA24389@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53b6270e-964d-92fc-baa7-b7eb4e060d6b@kernel.dk>
Date:   Thu, 25 Jun 2020 21:06:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625195148.GA24389@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/25/20 1:51 PM, Jan Kara wrote:
> On Wed 17-06-20 15:58:23, Jan Kara wrote:
>> Currently blk-mq does not report any event when two requests get merged
>> in the elevator. This then results in difficult to understand sequence
>> of events like:
>>
>> ...
>>   8,0   34     1579     0.608765271  2718  I  WS 215023504 + 40 [dbench]
>>   8,0   34     1584     0.609184613  2719  A  WS 215023544 + 56 <- (8,4) 2160568
>>   8,0   34     1585     0.609184850  2719  Q  WS 215023544 + 56 [dbench]
>>   8,0   34     1586     0.609188524  2719  G  WS 215023544 + 56 [dbench]
>>   8,0    3      602     0.609684162   773  D  WS 215023504 + 96 [kworker/3:1H]
>>   8,0   34     1591     0.609843593     0  C  WS 215023504 + 96 [0]
>>
>> and you can only guess (after quite some headscratching since the above
>> excerpt is intermixed with a lot of other IO) that request 215023544+56
>> got merged to request 215023504+40. Provide proper event for request
>> merging like we used to do in the legacy block layer.
>>
>> Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Jens, it seems people are fine with this patch in the end. Can you please
> merge it? Thanks!

Applied for 5.9, thanks.

-- 
Jens Axboe

