Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A58C00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 22:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiHBW7w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiHBW7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 18:59:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216A22533
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 15:59:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u133so8232983pfc.10
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 15:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=adh3DtXIm1WPaDyujP8PdKfzAZgYttn0r0245WyNVTU=;
        b=DDHgWId+TlnVHAovPCpvadpUMmjcIwDEqWKgOqHt0H3UitGsGMfXMbMIeBFnlW7Ttz
         88u/qYhn75IBoMcjYRxwXJV8DAUi20ezYzY+RDelQXuAMU/Wxjhrkb/J7GXl7QGG4xvd
         jc0rvo/aQa0fStU6887G/7wRS8e5zmZr3jubrhAUIucfHAKRnZ0viT/n66KhRFrPoCLJ
         uRRoQRWCn0JrQ4nUWzK20jP6bALJHCO/JZ/5qCk7Z8cGXayVvx/+I6SN35+gPXLAEFT6
         /BO39gYCoXS0uO1jOznh8s7KqWAKAalKWnwSoil+AYlm1wQ/m02l8upioE84ro+r16mq
         o6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=adh3DtXIm1WPaDyujP8PdKfzAZgYttn0r0245WyNVTU=;
        b=yGUsWWyvagwN4PIZUV3jHWnGPuS6lJ2NJaTVldzjLc6JMuIyp9dD/rFTObxncGv5wu
         iAnR+UzAZz2l9KjFcW+gx5AO4UyviDEUhV8icZ3owQ29PtMiFvbt8ru8pl7ORbp4dd/C
         t+pPm/lJRt47Zh2UVTU8PVWjw2BRFPJkfQjUCxBTp+T3NnOHKLtCfIVhbf3ys6toHR7E
         X3cQDoCQ/cKszFfXYaF+8IIW0E3JvR2+W226UsRQU0WBumSj01n5uc9zWZ9yQi0cLb4I
         g00Rd6iRK2fJX4SiYz4ZTcYCXVFMprDWY2rb3JCihimj8nzE8hBHMRaFAJdpw0zMs9Ej
         wGhg==
X-Gm-Message-State: AJIora92aNv6P+u9uDrwIbjcVB7+yIlc6fWAnj9owzqxw9y/7S5lVccF
        4nalCUzRjijb0wy6ih9SwywD6siycBIJ2A==
X-Google-Smtp-Source: AA6agR5f5Roc+sgjVxXf/dAUI6OXLZjIPUM/UI1Eb4Z94SuBjmjHQfSk+/OOfqIlx76ZuwhCe5HFWQ==
X-Received: by 2002:a05:6a00:2446:b0:528:5da9:cc7 with SMTP id d6-20020a056a00244600b005285da90cc7mr23226772pfj.51.1659481189561;
        Tue, 02 Aug 2022 15:59:49 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902d2cd00b0016eda062b13sm235088plc.94.2022.08.02.15.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:59:48 -0700 (PDT)
Message-ID: <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk>
Date:   Tue, 2 Aug 2022 16:59:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com>
 <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk>
 <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
 <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk>
 <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/22 4:48 PM, Linus Torvalds wrote:
> On Tue, Aug 2, 2022 at 3:33 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/2/22 4:27 PM, Linus Torvalds wrote:
>>>
>>> It happens both with clang-14.0 and with gcc-12.1.1.
>>
>> gcc-12.1 is what I use, fwiw.
> 
> Hmm. I think the last ".1" is actually purely a Fedora artifact. The
> gcc people themselves have only released 12.1.0, and looking around
> for the srpm info, it looks like all the final F36 ".1" is for some
> unrelated patches.
> 
> So we may actually be essentially on the same compiler version, and I
> don't know why you wouldn't see the error. It showed up with a plain
> "make allmodconfig" build here.

Actually, I'm mistaken, on the build box it's running 11.3. So that
might explain it? I use 12.1 elsewhere.

-- 
Jens Axboe

