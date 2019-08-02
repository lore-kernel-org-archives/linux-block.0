Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF7AC32750
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A753221773
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 14:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="k6b4D+oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394952AbfHBOch (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:32:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39391 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389189AbfHBOcg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Aug 2019 10:32:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so32151054pfn.6
        for <linux-block@vger.kernel.org>; Fri, 02 Aug 2019 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A27eyn7fv8+87QCGwvjGeuh58DzMZREuqk7dBBhRC7M=;
        b=k6b4D+oAskRKA2IOhSIr4jtOxHHPieA4fsfMXbUnhPbSeiIya5KycFpVIXPlm4yRM3
         2vXqNEv6x7AHEZRhkK0u7jqibHROFQ537Z8xwo0obqs9uLv5mWVXCmIAUFfxGD45IKDs
         C8/HhWky+gos9UjoGJLY2E78qMasSIXew/dwFeK2f++LqWZ/G5bjoOwPy0EtVt9OenSl
         ME6WU5E8NUui98Xbx+IsIYaoPGpbJWalf1R1MYfrtslWaM8qdRMnrp3aTSaN5c5tpbkX
         kCXIf6j9oyR64ldOISFeBUl8qlg4QaAUgeZG68GJ9F8eVjNUlO0pg2yBHNt97Fj7DBw6
         P4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A27eyn7fv8+87QCGwvjGeuh58DzMZREuqk7dBBhRC7M=;
        b=KOWuhbpTBRTwXwWacWxCPbY9z8uOYBkUliCIp456UqW5CXObbjXnVRr0jjuK7pqogE
         c0S015CREYNwIyWeaok/bCrnHc/v6HEGpu/xSSQyMw531Wt34LKzn083X0HrO0/z+yOz
         ZwZ71n2mdc1RsS9ntUbqs66+TzSjL2EMajawftVRNnAIybhjcCnvoMXyuD0j/ME0xnrK
         Xdq6g7UXJPN/yw4AyjXKZzfFehBmLGYmBjdKfl1dreYH5oldAM07hoha9+IevXryeoMx
         XsvFU5edJ3etvConnOmmClOnFACdPT2q7mPXFhdPEXAU0kEbZjMMuHOM7wLbhVOAUF3w
         NM/Q==
X-Gm-Message-State: APjAAAUS5ZjKwCPoqzCau9Lb5euayRqDj1pZF3zSK11n02/VSra9HBQd
        KnkJ+9mXZTSsyL6i0C5TQEM=
X-Google-Smtp-Source: APXvYqz/GeqeGCtVNZutn4ZyH/Uwt3zoVVgkPPZcSDyGdG47OrHBP/uyvRRqJ0ygnyfCyfMeKDHdEQ==
X-Received: by 2002:aa7:9197:: with SMTP id x23mr59494402pfa.95.1564756356024;
        Fri, 02 Aug 2019 07:32:36 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id m6sm75804562pfb.151.2019.08.02.07.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:32:35 -0700 (PDT)
Subject: Re: [PATCH V2 0/4] block: introduce REQ_OP_ZONE_RESET_ALL
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, dennis@kernel.org, hare@suse.com,
        damien.lemoal@wdc.com, sagi@grimberg.me, dennisszhou@gmail.com,
        jthumshirn@suse.de, osandov@fb.com, ming.lei@redhat.com,
        tj@kernel.org, bvanassche@acm.org
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
 <0c30519f-2829-ec2c-8fb4-ccddd2580321@kernel.dk> <yq1r263irfa.fsf@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a471e444-0cdc-b1a9-2870-bf12d8e39da1@kernel.dk>
Date:   Fri, 2 Aug 2019 08:32:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <yq1r263irfa.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/19 8:16 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> Martin, I'd like someone to vet/review the SCSI side of it before I
>> apply it.
> 
> Looks good to me.

Great thanks, applied with your acked-by.

-- 
Jens Axboe

