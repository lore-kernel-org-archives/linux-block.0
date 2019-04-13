Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ADBC10F11
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 22:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285D32147A
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 22:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uxl+DutH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfDMWXO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 18:23:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45716 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfDMWXO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 18:23:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so6747721plb.12
        for <linux-block@vger.kernel.org>; Sat, 13 Apr 2019 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yokci/AQP16VdFm7affIC+XoV3djYBCjUKDXQwSvN0Y=;
        b=uxl+DutHKyyEoOmML8WovRrKZaTdC4i+RHYmMOl7fDygxqmXRIRn9McSwGUHCgvlOn
         UyJtQn0JXOHgW4r9OztWfr9+589GIq+Eua++DFF0LLZPs0q0mVTyEaOb+oGzjpje4EYy
         u4Xzlu+C8RTjdIWF6rtSEgeOAFfQ4q9BXydwx5mT9VARW1DN9s90ZDYeGjIJRP3mmUXa
         dBhDRiXyl4+iOMVM3fva8PT7lLAD0NjFAe9fWkeyBPMgdn36eaGbInn+2ihq0oBvHVPS
         Oc7SDTIxupwXzOq9tL7UYyZwBcnR2t67MnT5WCb6ulAfbiwv5O0MJUR2F3fGuKT4MYqq
         /ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yokci/AQP16VdFm7affIC+XoV3djYBCjUKDXQwSvN0Y=;
        b=ZT4L4/Xs4AFBQ/Dwyu16dGzbVdFx6/bLtwx36cBC3Fw9D8bC1Rz0Ryn8LtR7X97nkG
         zvARzzlcOhJSnhDycpszIGwUnlKoht1kNSTVUULws0mAvB8EFLYGPTAJrx/EnnYOp+w8
         F+9YNQg4s7NKfWKA0WmsDs21kTBYB/UJiGX1Xov45mXUzOI5oIKVwwxl4aKM2ha3f0/E
         IHAHQiWXHc57qrevrBHyr2BzrZZN0kXLFGiTfbmhv5rSBigxxqAN0djaQDKTGpSa8lNh
         qQX9xKoypG+nXWgEFmWU79DO84wwXDkOBVruErl29WVTrmJHJEorFSEnOTkA7a2jb9YO
         9idw==
X-Gm-Message-State: APjAAAV1E5aOhXuhSmTz4n2kxGqGnR69nNfwCuc2NMMYNAzbW7Dh/9AN
        6p74jYa1F773ZvwvEqtHqB6U/hPFkTQjBg==
X-Google-Smtp-Source: APXvYqxPL8PxhnpcSwdoVVjxrkuwQtwKYUo3DUa5lDTnK7h8y6/W7NmfwfCExvtQvTC5S2SBIPT5ew==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr64446237pla.306.1555194193027;
        Sat, 13 Apr 2019 15:23:13 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b13sm41972130pfd.12.2019.04.13.15.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 15:23:11 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.1-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <79665835-13af-ad47-14a0-2b377bc356dd@kernel.dk>
 <CAHk-=wgZHvghu6iZYkPCUxZ-g5b4xREdAU6zWSfPs7M7P4hKdw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36e59cf7-e7af-12a2-c8bd-7f48e0d73d67@kernel.dk>
Date:   Sat, 13 Apr 2019 16:23:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgZHvghu6iZYkPCUxZ-g5b4xREdAU6zWSfPs7M7P4hKdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/19 3:33 PM, Linus Torvalds wrote:
> On Fri, Apr 12, 2019 at 12:04 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>   git://git.kernel.dk/linux-block.git for-linus-20190412
> 
> That tag does not exist. There's a for-linus-20190407, but not a 20190412..

Gah, forgot to push out that tag. Pushed now, should be there.

-- 
Jens Axboe

