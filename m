Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95532C282DD
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D7621019
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 14:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfEWOgH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 10:36:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51937 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbfEWOgH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 10:36:07 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hTomd-0004cB-Ok
        for linux-block@vger.kernel.org; Thu, 23 May 2019 14:33:27 +0000
Received: by mail-qk1-f200.google.com with SMTP id a64so5571156qkf.8
        for <linux-block@vger.kernel.org>; Thu, 23 May 2019 07:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+W0ZBRDPuAaLAeSp2LgbinBlDum/QNL/K+lovUbkcD4=;
        b=p8ABqIn2I7T7ia8LQQeA+/9JoVSW3M8zbwoMsSt4jgkT+dNteI3o5XhXFFrkTQGTIr
         YJH+HnUIVBUseEbsLmXqT/+p7tRBZTxDW4T7TyEMTteoPDp0httUiTTGdIFgk3TwJvSM
         wqhkRB+aIM3I4CAcJLiiIXZaZhMEl0SopvrCwzkb0bsOGBc0uPvCHIfhqgRzhYxioBvZ
         7A/yT018VHBr5NYfT3Tt+sDxxfaTEisIum8WugUatnUvbpkwZbeP65NnddLuA1tfWHFx
         nXfxv92cFuxE3I045wXxAcvNiq5nG76S5zEwcvsmGmKT7nmdc3Lf7OCHGmXCwetiamqc
         37uA==
X-Gm-Message-State: APjAAAUg7SaAxQPNMoISkPhlCrQLjvpwwOKegfydOxhUeIP7/oWiKg5G
        7Sj1kb2WAHk377QhN3KxsqtHd+XF7pv4R9dafMXlSXiHAWjwqMj3+hVxL/BsTN2mZhO3f5TlRY9
        knMM2pu1LQg5CUtWFFqFgau4cyojjtbV9CnPTHK0V
X-Received: by 2002:a05:620a:158d:: with SMTP id d13mr16893965qkk.271.1558622007011;
        Thu, 23 May 2019 07:33:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz4fx9yFrXtTha0kc9WnfvL/SpBlMkzsC3W/wxnbxEkRyUOM5BUYVF5f7rIG11P0f6vMljE7g==
X-Received: by 2002:a05:620a:158d:: with SMTP id d13mr16893950qkk.271.1558622006798;
        Thu, 23 May 2019 07:33:26 -0700 (PDT)
Received: from [192.168.1.205] (189-47-79-212.dsl.telesp.net.br. [189.47.79.212])
        by smtp.gmail.com with ESMTPSA id m8sm17911949qta.10.2019.05.23.07.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 07:33:26 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] block: Fix a NULL pointer dereference in
 generic_make_request()
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        axboe@kernel.dk, Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>, hch@infradead.org
References: <20190520220911.25192-1-gpiccoli@canonical.com>
 <CAPhsuW6KayaNR-0eFHpvPG-LVuPFL_1OFjvZpOcnapVFe2vC9Q@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Message-ID: <3e583b2d-742a-3238-69ed-7a2e6cce417b@canonical.com>
Date:   Thu, 23 May 2019 11:33:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6KayaNR-0eFHpvPG-LVuPFL_1OFjvZpOcnapVFe2vC9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21/05/2019 02:59, Song Liu wrote:
> 
> Applied both patches! Thanks for the fix!

Hi Song, sorry for the annoyance, but the situation of both patches is a
bit confused for me heheh

You mention you've applied both patches - I couldn't find your tree.
Also, Christoph noticed Ming's series fixes both issues and suggested to
drop both my patches in favor of Ming's clean-up, or at least make them
-stable only.

So, what is the current status of the patches? Can we have them on
-stable trees at least? If so, how should I proceed?

Thanks in advance for the clarification!
Cheers,


Guilherme
