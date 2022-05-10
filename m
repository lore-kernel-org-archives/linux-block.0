Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF29EC4332F
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 12:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiEJMtg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 08:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbiEJMte (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 08:49:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C165522F
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 05:45:34 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k14so14574568pga.0
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=81CmoXK8W2fMc2E/XpNylErNEPWG7PeFWSGfTvENHek=;
        b=BuizLo0eMVf1CFKzq5z5mJXXTCdmsbZnthwaSpGZvyOinz0zK1oVrwY+RjDSbz0lsj
         W4/gcD2GsatA2CltDPm42940C9Zx8OlEiXWEDruJeUP+scX4B4Dn/BR45LSBkgx0ha/1
         1lof9Sxe/0+TSOSmg+ZbSpzVPPfdI8D1n/IK23ovFovWMObnth4tWgSXWT44+EFOD5cw
         YRdLOnhCKKUDhjj1PBpvvrU/SLEYIvonvF8JuhoBcVkVWvziCCxnA6XbN07WU1oTTJuX
         9N9BICkQtsDiH2S5IvrqAAzmp2SqDTXhUfx7lB75VtVwJ+wJsJW+JGZukF4rewQyhJ7E
         HF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=81CmoXK8W2fMc2E/XpNylErNEPWG7PeFWSGfTvENHek=;
        b=gcbINwJUSKvVsJoPUV+MfIJqcC6GylHKUR7Z5y9EnPCLc+BJV8e9AkXDJ6oJ1f3vxY
         aJRKjlCB+bmIrugkbjSyYQAPoLf59iBLoixXxEBG/rsB4mWl26AdWWrBeyAs+snk+jOt
         bLI/5B3QkZDkeNI4xAHXK2lFr6eks77oq2qqjsvSUCZaym+SMOqSJw9UPbu6a52xCjvg
         Y9a7hw0Vq12HMXaHUk6EeWCw+DYJm4VTb1VzaDa21nQGRLClbbZYSDZlMp7aTO5CUtK4
         RUwBFMmaV88dRz+C58+CWSIc2heouZupKYWx0XZvm78BLdtg6gbb+SPL4l00Ha3djhTl
         cu4Q==
X-Gm-Message-State: AOAM531rZuzwcpXbSpdUKhRf76MA6Yktv4nTYiZW/IfmTxlngB8cA/5k
        8FrCUVi71nqgUUAcHdj7h+m/jw==
X-Google-Smtp-Source: ABdhPJww7Eg4/Zxst2GZrQrVNwauUtpxNCsfNjZ19FUR133ytWOXTk+q1xGx0v1s2BhN+B7mV7yS+A==
X-Received: by 2002:a63:2c8a:0:b0:3aa:86ea:f2c9 with SMTP id s132-20020a632c8a000000b003aa86eaf2c9mr16916062pgs.46.1652186733527;
        Tue, 10 May 2022 05:45:33 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q187-20020a632ac4000000b003c14af5063fsm10345438pgq.87.2022.05.10.05.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 05:45:32 -0700 (PDT)
Message-ID: <0e1b3d10-ae79-f987-187e-58109441ccee@kernel.dk>
Date:   Tue, 10 May 2022 06:45:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [syzbot] KASAN: use-after-free Read in bio_poll
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     syzbot <syzbot+99938118dfd9e1b0741a@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
References: <00000000000029572505de968021@google.com>
 <a72282ef-650c-143b-4b88-5185009c3ec2@kernel.dk> <YnmuRuO4yplt8p/p@T590>
 <20220510055039.GA10576@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220510055039.GA10576@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/9/22 11:50 PM, Christoph Hellwig wrote:
> On Tue, May 10, 2022 at 08:13:58AM +0800, Ming Lei wrote:
>>> Guys, should we just queue:
>>>
>>> ommit 9650b453a3d4b1b8ed4ea8bcb9b40109608d1faf
>>> Author: Ming Lei <ming.lei@redhat.com>
>>> Date:   Wed Apr 20 22:31:10 2022 +0800
>>>
>>>     block: ignore RWF_HIPRI hint for sync dio
>>>
>>> up for 5.18 and stable?
>>
>> I am fine with merging to 5.18 & stable.
> 
> I'm fine, too.  But are we sure this actually is one and the same
> issue?  Otherwise I'll try to find some time to feed it to syzbot
> first.

I re-wrote the reproducer a bit and can reproduce it, so I can certainly
test a backport. But yes, I was skeptical on this being the same issue
too. My initial reaction was that this is likely due to the bio being
"downgraded" from polled to IRQ driven, and hence completes without an
extra reference before the bio_poll() is done on it. Which is not the
issue described in the referenced commit.

-- 
Jens Axboe

