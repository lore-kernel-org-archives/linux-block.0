Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7163C432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 16:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A00C60FD9
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 16:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbhHZQcm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhHZQcl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 12:32:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F4EC061757
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 09:31:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u9so5996842wrg.8
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mskyHXQjMXJtt7a3IypmzlzyZVMi2psCG3mkvklLjWo=;
        b=fZMYjUiN/a9RznhX8FskmVdEiKijpvifY08UWJdikgmGur7iLbU/zawoh4lBuF3JmY
         wCYP9YBo6A+0akGBCrAlkaKk3RVFZG7SR6zVUu1/JpD0Kepg+R5eenNie3KwZ1kB/EqS
         F7orFKNeHanj4ec7EUHajS27acCUlFJMkk8o9afRiHpRXITqM+2N+9zH1VsMo4avWhwd
         89nhg42jPrAShPqli+3jn0W4zQrF9XRANorBYIPQb4SSczOH6gtA8L3aJhbbctn2fUuG
         iZM8UGZ5+ns5fp2CTPwKQ4zGH16sWlBezp8DhEVxVWf8C3OoVKyvtnnpfNooo88Ue4Mj
         1rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mskyHXQjMXJtt7a3IypmzlzyZVMi2psCG3mkvklLjWo=;
        b=qz9WSiYwV1gveXXeBoem9zPWUn5UZtfFAQch7QKx7+5/3lP0Hfw4fZUR8eAVkp/523
         vunXI35nr7q1MrMEJ5Yy5xXjSwHCysCrWs9whdGHulExEvsTPNPX4j6N112uB9mdZ1b3
         u3wPdXDppHPoyPwk1A1/SE7wn/bDsl7DzQNtnWiFZyBD1yzMqcxuq/Zruk0K0Iq2Eg2w
         AR2IeO/SjDnWFJVO/chW0MgKpgSmKhLNyI1qAXqjfXPpn3hsAJoQujKYjj0mNaSuK57D
         vt9Hkf5aM4EAMl5+PpcOIqjk1uOzodh+UTRJNfQsIYhYFXC5bqLNutfIl5NipSJ+8rZG
         5Dww==
X-Gm-Message-State: AOAM533dNkMUo/yWOxei1yIcJxtZY4f+YyefTDqBrDxIVKcFKXqdCAR1
        hl35lyi4uwYQt2VznC3EKR7FO4dWeLQ=
X-Google-Smtp-Source: ABdhPJxt2zDOF++zkNYvgIfi/5YbQa9l45/RVtFsHlR0gXOkp55ahDu1yzW1Nb2jHp2r8HQVn5QYsw==
X-Received: by 2002:a05:6000:184e:: with SMTP id c14mr5075780wri.186.1629995512765;
        Thu, 26 Aug 2021 09:31:52 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id f2sm3565193wru.31.2021.08.26.09.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 09:31:52 -0700 (PDT)
Subject: Re: [PATCH 5/8] loop: merge the cryptoloop module into the main loop
 module
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
References: <20210826133810.3700-1-hch@lst.de>
 <20210826133810.3700-6-hch@lst.de>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <977860f6-efc4-a55e-50e3-c5204fc762c5@gmail.com>
Date:   Thu, 26 Aug 2021 18:31:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826133810.3700-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26/08/2021 15:38, Christoph Hellwig wrote:
> No need to keep a separate loadable module infrastructure for a tiny
> amount of cryptoapi glue, especially as unloading of the cryptoloop
> module leads to nasty interactions with the loop device state machine
> through loop_unregister_transfer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hi Christoph,

the cryptoloop is insecure, most of the encryption modes are deprecated
(and known to be problematic); util-linux no longer support cryptoloop
options in losetup.

Isn't the better way to go just to remove cryptoloop completely?

(I tried this years ago, because dm-crypt can actually implement all,
even insecure, options, see https://lkml.org/lkml/2012/11/2/162 )

I know that loopAES still use this interface, but it implements
own modes anyway, replacing kernel code.

I really think that the best option here is just to kill this mess :-)
(Or implement sector-level crypto properly in loop.)

Just my 2 eorocents... :)

Milan
