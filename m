Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90664C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 14:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiBVOrH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiBVOrH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 09:47:07 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AC56540A
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 06:46:30 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id k1so33756322wrd.8
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 06:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x4C6Xvbuw7YQde7780tGgqiKVkX/jmW8VHi4cjbzNvQ=;
        b=BKvHP30if5WL7K5PZ/Xq0qu5NFd+vQYTQeqtB2pdPT6bSciaNhLFL0Y8vn5RMolUhe
         nMogLj6eTjWKsH7lW1l3K/sy2kjWbRg2un39lDH4Wa43RFQY/t5fat5L+SxX9ZFkQYlU
         uw4I8/XYn6TXuu+oyfeVeHs7u/mYk/gIivGqTjO+JMkSwJdMEogrBTYQj6ziloW2F7xd
         KlB6uSHcXqXzOptWqo943tr+3e1Kou3YiKmaybs97e8N+FvBuT/Omg7tAaZoshqxkxD/
         d4N5s4/IdoDOX//knjRzqmxRrZ1RWzJxPOUwOLgdJ+K44oO8roGm9oxycPHT2ei4/ZBW
         DsNw==
X-Gm-Message-State: AOAM533LFzD6jOn37S8wdCjFmUm9/3Jr4yYsq4R3h1Fg9Fp9V49Y/Zlb
        /f3e1TGHaOyy8NrvcTbAbrk3J9inEG0=
X-Google-Smtp-Source: ABdhPJxbhe1H6fbtykGOBn9bYJCqZ5kVMrMfD1PyPHnqK/OXKuWeptVSaS79MqC1t31Lwlm3Cb56nQ==
X-Received: by 2002:adf:ce82:0:b0:1e3:2bdd:8243 with SMTP id r2-20020adfce82000000b001e32bdd8243mr19599867wrn.259.1645541188878;
        Tue, 22 Feb 2022 06:46:28 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il. [46.117.116.119])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b00354d399ef32sm2702924wmq.39.2022.02.22.06.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 06:46:28 -0800 (PST)
Message-ID: <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
Date:   Tue, 22 Feb 2022 16:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <986caf55-65d1-0755-383b-73834ec04967@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Actually, I'd rather have something like an 'inverse io_uring', where an 
> application creates a memory region separated into several 'ring' for 
> submission and completion.
> Then the kernel could write/map the incoming data onto the rings, and 
> application can read from there.
> Maybe it'll be worthwhile to look at virtio here.

There is lio loopback backed by tcmu... I'm assuming that nvmet can
hook into the same/similar interface. nvmet is pretty lean, and we
can probably help tcmu/equivalent scale better if that is a concern...
