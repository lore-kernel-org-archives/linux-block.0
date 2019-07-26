Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CDEC7618F
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 18:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB24322BEF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 18:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oPjQ972u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbfGZSuq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:50:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36874 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388222AbfGZSup (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 14:50:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so24922908pfa.4
        for <linux-block@vger.kernel.org>; Fri, 26 Jul 2019 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IWCCsJnsYcXEd7yUJalmzXt4GW1/JNI/8nAR7akhNRk=;
        b=oPjQ972uVgvPKzUIqDRlGsiAc0/9gvw2GDbeNacYrmbjScOAUEBPuTUNl7pFe655Xb
         YyaRrc//PJxvoYodmh83rThp6STABIOnL+Pz5XPXdf3Fp5BMNQ1lCtj7u6CfVPGcXr+1
         HdjDMa5hSIUmPlX4AJw7OJb4/9SLdDb8qqIbZULMhu6P195K8nEIZiY0shtrXTWsghiD
         Ufifey2lmwTySuyUvmbO8VzqJXdJjun9jrA4ymwJZ40oyHKPNZCg3U8jguTZkwINjTht
         ZexOQv3ZXPB8NwvwhmSnTLQSsGxG0fsGpC4ZvPA1bJNoiPkU6fl6gIiL+vqFaXKMrXTp
         RY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IWCCsJnsYcXEd7yUJalmzXt4GW1/JNI/8nAR7akhNRk=;
        b=rXK2vwHyNEA5SxwOJ5xg7L1nmYM8PqW/GCtUmmryPVyS600BSE0DzdHR04bw3oh9UR
         lxKlwmzoxePkOh0EVPrWXOrFfkRjifNSMDlU/5MiElFgRDOlNjtdr8gEnU702OZy+hp9
         0qCetCpgNCu0HeLKAm+H0ibDDpcgmB+HFOXUB7sXNLvY8yrmXskSMlnNc6cs1SuBXBPc
         VvPrKjxoae2lqgO62FWJehypg0MISg5juB7G9WCUVTPpjZZEulWrPCG+e6c0bCNUMBt0
         9z0JUxWVIgzai/VcpM1P61jyrdupDq/0sYn+OpjgBHD7SSMzRRD0SSBKg8pzRgnC1vx5
         wtlQ==
X-Gm-Message-State: APjAAAXuIorDjz8fvjzDEhqdoKjHpcEfD8ttLVZj6d/rgqXp5ThArS1c
        E3zCojc9j0vMHejVY92BWTzPYhMhSDw=
X-Google-Smtp-Source: APXvYqzVyB3KyO7NAbwvssCnnh+7gXvM3l82tqEl0spXgrfzNllanY/zCKodktXNylRXvJjkY+a6Pw==
X-Received: by 2002:a62:7890:: with SMTP id t138mr15264201pfc.238.1564167044757;
        Fri, 26 Jul 2019 11:50:44 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id l189sm66617588pfl.7.2019.07.26.11.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 11:50:43 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.3-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
 <CAHk-=wjV1cykm1UYSVR1KzwV4ZF0QtU9rOTsThVJj8qSX6hKgQ@mail.gmail.com>
 <34bce605-51c0-b1b7-1d1d-f64f0e24b6c6@kernel.dk>
 <CAHk-=wiZzBkwOmYT3XC7u1tvrSk9AhCOxV+1S3ocAdLh4fA5cA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <61f40b97-303f-6f4c-8c10-62cb2f91cc3b@kernel.dk>
Date:   Fri, 26 Jul 2019 12:50:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiZzBkwOmYT3XC7u1tvrSk9AhCOxV+1S3ocAdLh4fA5cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/19 12:44 PM, Linus Torvalds wrote:
> On Fri, Jul 26, 2019 at 11:39 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> The fix is sitting in the SCSI tree:
> 
> You clearly didn't follow the links.
> 
> That's *one* of the fixes.
> 
> Not the one that possibly should be fixed in block/blk-settings.c and
> that I expected to come through your tree.

I did, but didn't look closely enough. Looks I totally missed the other
side of this, Christoph did send a patch for it two days ago.

I'll get this queued up and send in later today.

-- 
Jens Axboe

