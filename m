Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DEFC00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 23:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbiHBXIy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 19:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiHBXIk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 19:08:40 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2135354AE1
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 16:08:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so13617744pgb.4
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a2FHYG10ECB6dzDqRgSbkN2KxB6TTyRCqhBkif0/ZS4=;
        b=5haLiU/PYWbHjr80idRyfQz/XHq8Lkx1Hr1sqYsH1eoSR21MIHGTc9DwWhV8wJwqnR
         sbn1xl5rTn8dYQpsZhFxLQNpChy84S8lb8il5NrViRbFE/gyV9GT87HMAHt7nLrcOn78
         S3du8JRBQraYGuhPWrROGD97ewlZuc8rZOeN/R1vKrLxPoSrMVBAxa113vyQWahRojAu
         Mir4mI7CRg+xu4uKeCc/44BN2s4wjBkbMB/BqglDfJu64EsikT+jPbdqVwLWutYu92kN
         2NrUXsgHprLnS5huWLqwHcnaT5bFiDyn8jy1bsOOq1VDiJ9NpfqlbgBMmfNjx8cDMjZv
         vH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a2FHYG10ECB6dzDqRgSbkN2KxB6TTyRCqhBkif0/ZS4=;
        b=IIcXSqe/khDvu6abj9n1HnpzqrpDAtDfYO/3goerTbPb3QPe2nWChznss9f0aiipeP
         GpMMkopnY9xtsdhoBQK0Z7j89OD2fTeTHGKxJusm52+uT4rBsHlaUE//sW9LosehCJev
         zAtZ3iXiBmstmH2BUyyzN1H2KzHb5peOd9dfecLRCiV0TXdAMM79Xn7tnwRic1a0nUoP
         wNwHhe/mtZqnvk1tkeXFTs0T4yb9jQUMLRHZGGzDejn35d1ny18Gc67L1dW5MaKuLPAc
         Vasr6OVlBnXgUU61IwZDfyQoq3EuLeFH6xQth7HFYaF8x0fv1AAlEtCto6LYVzfdL+AA
         f9bg==
X-Gm-Message-State: AJIora/uHBmR6/g648F82Tpc8KIzpo6dC4/k1yK5GG9eQaPHXXMO99Bx
        i/Z88VimyanWZoFmx3qsbTnQJg==
X-Google-Smtp-Source: AGRyM1uoYHLWqnYIKXy+SyhTAHbggUe4MMiSPOuUsImu1K3NXVSNRivtzVVJVFRvCdydTJxckK7diQ==
X-Received: by 2002:a05:6a00:23d4:b0:52a:e5c1:caa7 with SMTP id g20-20020a056a0023d400b0052ae5c1caa7mr23196874pfc.62.1659481708550;
        Tue, 02 Aug 2022 16:08:28 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016dd0242e22sm233228plr.156.2022.08.02.16.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 16:08:28 -0700 (PDT)
Message-ID: <c1b1b619-9142-9818-0536-ce4b97d3e979@kernel.dk>
Date:   Tue, 2 Aug 2022 17:08:26 -0600
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
 <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk>
 <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/22 5:03 PM, Linus Torvalds wrote:
> On Tue, Aug 2, 2022 at 3:59 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Actually, I'm mistaken, on the build box it's running 11.3. So that
>> might explain it? I use 12.1 elsewhere.
> 
> It's possible this -Waddress error is new to gcc-12.
> 
> I try to keep most of my machines in sync just to avoid the pain of
> different distro details, so I don't have gcc-11 around any more.

I'll get gcc-12 back on it - I originally swapped back to 11 for
building kernels to avoid spurious warnings with the new release.

-- 
Jens Axboe

