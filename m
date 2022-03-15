Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67B8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 08:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiCOIjk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiCOIjj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 04:39:39 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B634CD58
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 01:38:27 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id r6so27350196wrr.2
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 01:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r0Ly8dROxZl7vyfQ0jxFpk6GeB2icBEHKDfa+x1z2Jg=;
        b=CeBUf6cbviaT1PylmjdQcM/8/zydlWJnQWpSlzUjC9H3Jn9ZBCjB2GmcBUdj7vj+1u
         IO6OrgR5lgdv99OSsOXZutLG12w6PkFLIZLXqImlYJU/rC68bm35MT1DF0F/UrvayWXB
         eplNTpQBFui57ON4P4SYkMYQIwr5cQYZGDvUGycF8+qCLOz/FdmI4JWqXUWdm3HiO8nk
         xXa3+XPOTtk15OFV5N8za5WB0vxNAEmruUL9zXby2DrWTWFecNAmiRAIjHXxbBW/pD32
         PojK1wQzDZXh1/AoY8ZImc95nm9ziPMZ7FTJMdG2wrys+zQEcRhUMGEWf5OhUXp2gsxp
         2Iiw==
X-Gm-Message-State: AOAM5310+76HJSdDN1yj0LLBUdc3nLfG5KQEm7HllWWta+4CJT2gGlqt
        DElr46fNg/d4pFdMxENVMqo=
X-Google-Smtp-Source: ABdhPJzZ29BzS6MbI4zup2n46sehZGwgnc82d4Af6bAtvXN0nJ4hyXge9S9wEZiRE5GLrJwEbYUWjA==
X-Received: by 2002:a05:6000:1a8b:b0:1f1:d8f4:4aa with SMTP id f11-20020a0560001a8b00b001f1d8f404aamr20074529wry.238.1647333506145;
        Tue, 15 Mar 2022 01:38:26 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x14-20020adfffce000000b001f1dfee4867sm22319073wrs.99.2022.03.15.01.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 01:38:25 -0700 (PDT)
Message-ID: <1cec32d1-511e-1a78-b157-9ecaebc72c66@grimberg.me>
Date:   Tue, 15 Mar 2022 10:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
 <87bkyyg4jc.fsf@collabora.com>
 <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
 <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
 <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
 <0b85385b-e8cf-2ab3-ce22-c63d4346cc16@acm.org>
 <c618c809-4ec0-69f9-0cab-87149ad6b45a@suse.de>
 <d2950977-9930-1e80-a46d-8311935e8da4@grimberg.me>
 <YjBKaoBYtofJXrgw@infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YjBKaoBYtofJXrgw@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> FYI, I have absolutely no interest in supporting any userspace hooks
> in nvmet.

Don't think we are discussing adding anything specific to nvmet, a
userspace backend will most likely sit behind a block device exported
via nvmet (at least from my perspective). Although I do see issues
with using the passthru interface...

> If you want a userspace nvme implementation please use SPDK.

The original use-case did not include nvmet, I may have stirred
the pot saying that we have nvmet loopback instead of a new kind
of device with a new set of tools.

I don't think that spdk meets even the original android use-case.

Not touching nvmet is fine, it just eliminates some of the possible
use-cases. Although personally I don't see a huge issue with adding
yet another backend to nvmet...
