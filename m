Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1517CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 18:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiF2Svb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 14:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiF2Sva (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 14:51:30 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FB31D304
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 11:51:29 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id d129so16141815pgc.9
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 11:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=T+oozTQlQ42ccub3rMo4I+T7tGXFbD0SrcDYsujPpEE=;
        b=N2H5vjIyNIuZLDvsYI60IzvwiCYuBwFz/TylN15KBzeFK4+HCGN+IWRWrZR+VAUizP
         GYuOeBXWCMiEuSVymnpyqdcHV8s9YpbjJ9VUVeBeWszUryg8Bl2+9og/1kWKpPY1u5tg
         qeEFlqL36aeI5Usjftpej7x4+NCKrNIdWeTTHHAAGiUTl+PM/tyaWrj0A56JZCanMFxT
         EmIDUE673DmZNw3Jn+tg91h5PF6WWn3eAgDy3jL5DfgVDm42PF4vfaXSXUp6uLE/ulTd
         bian9lBiwS3u8YremScdDuJVPak2rdQjuINMwDGhc9u5oGOVKtO2jsvS+qSnNws0jU8+
         1uCg==
X-Gm-Message-State: AJIora9ojzo1FUgEnXhuEy3iU6uVs6ghJGAUFvwIA598HY4Mdlok/RR4
        6S6b7aEIH6pLKv7BuciTRa8=
X-Google-Smtp-Source: AGRyM1tezh0Yi6yXeVRNuhvBo6IeNw8LHBMmcTK9z18nYaQP+iUSik7xJLRjTMluK1bxx7HBGbBvRA==
X-Received: by 2002:a05:6a00:23d2:b0:525:951a:edf1 with SMTP id g18-20020a056a0023d200b00525951aedf1mr11598228pfc.62.1656528689342;
        Wed, 29 Jun 2022 11:51:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e57f:78b4:1672:b207? ([2620:15c:211:201:e57f:78b4:1672:b207])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b0016a61e965f0sm4151865plh.280.2022.06.29.11.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:51:28 -0700 (PDT)
Message-ID: <486ec9e2-d34d-abd5-8667-f58a07f5efad@acm.org>
Date:   Wed, 29 Jun 2022 11:51:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan> <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
 <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
 <20220628183247.bcaqvmnav34kp5zd@moria.home.lan>
 <6f8db146-d4b3-d17b-4e58-08adc0010cba@kernel.dk>
 <20220629184001.b66bt4jnppjquzia@moria.home.lan>
Content-Language: en-US
In-Reply-To: <20220629184001.b66bt4jnppjquzia@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/22 11:40, Kent Overstreet wrote:
> But Jens, to be blunt - I know we have different priorities in the way we write code.

Please stay professional in your communication and focus on the 
technical issues instead of on the people involved.

BTW, I remember that some time ago I bisected a kernel bug to one of 
your commits and that you refused to fix the bug introduced by that 
commit. I had to spend my time on root-causing it and sending a fix 
upstream.

Bart.
