Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ACBC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 14:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiF1Omz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 10:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346095AbiF1Omx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 10:42:53 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602622E6BB
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 07:42:52 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so7715164wmb.5
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 07:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sRgiTQE3Kf/O2zn9zI4tUobp4J47g0upsarV56Uw538=;
        b=dABgO9wJPqRlyT+EOetnYLZCTCEGLONMxmfvitZszyMUSg9WtMN33NMjSl4bQel7BV
         BFeiA2r3UncVS+UgEQ6SK+AguzDGKRK2KsSUBwS8EfA31g+QHmu8Ks9AFccm46Eh49Hp
         8iPRFWVlMpZT1aQGpQd1upycJWSrdWaw2p6OcNr9x0HiSXiHIb51NddB6Ke0WahC3YPf
         V92GxaufT+6/yNE03FEBHhr3cue86+cPD43rkrBv/+wvTAsqQ1gUePSMRZ91A7x/0b6Y
         /k3/kxWOVKBrPI3hLIs+XumhrVJMIE9U1wnYrFtCRXBYnag/akfG8itRI+vAvyU+jnfm
         YGgQ==
X-Gm-Message-State: AJIora+Bn5Kp9vuxonmDc5f6OB7p5/mFdBqQNUFuPQriEq6mSJ2unThv
        kZrcVDu0vtzCy/ygLRcF3biWzdemjss=
X-Google-Smtp-Source: AGRyM1uy+QSLQiVIO4OASpMa0OjW4C8CBiRSTQiNkPNpbQsRE1YbuH/s2F6OcGEkQJarD0Vs9+mCkw==
X-Received: by 2002:a1c:ed08:0:b0:39c:80b1:b0b3 with SMTP id l8-20020a1ced08000000b0039c80b1b0b3mr22466838wmh.134.1656427370669;
        Tue, 28 Jun 2022 07:42:50 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h2-20020adff4c2000000b0021d221daccfsm1012686wrp.78.2022.06.28.07.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 07:42:50 -0700 (PDT)
Message-ID: <6401e5b6-a964-227e-c661-7557790d918e@grimberg.me>
Date:   Tue, 28 Jun 2022 17:42:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 6/6] block: remove blk_cleanup_disk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <20220619060552.1850436-7-hch@lst.de>
 <25329ddf-73d1-70e9-cd2f-372309e509ba@suse.de>
 <20220620085647.GA13464@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220620085647.GA13464@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> I wish we could have blktests for tearing down device-drivers; doing a
>> regression test here will be really hard.
> 
> The problem with a remove is that while we have a generic device remove
> attribute, it:
> 
>   a) isn't always in the same place relatively to the disk
>   b) once removed we have no generic way to add the device back for
>      further testing
> 
> nvme/032 has basic remove testing for nvme, and I think I can also
> wire up my scsi bind/unbind testing for blktests using scsi_debug without
> too much effort.  But that still isn't exactly a generic test.

It should be trivial to add a similar test for fabrics with toggling
nvmet $ns/enable config knob...
