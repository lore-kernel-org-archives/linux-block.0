Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777E2C433DF
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5291521744
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 16:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgHGQhW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:37:22 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38775 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHGQhU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 12:37:20 -0400
Received: by mail-pj1-f65.google.com with SMTP id ep8so1162484pjb.3
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 09:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IGOBihw2RaRydNVMv9yxROPAHrRNnsrTubbIJZmiX8U=;
        b=NqkpApTwS6yDDd/jAwJrcxnp5k4cJ1Wj9igc+280i/USeCEUYg9baP3PXjBPkO+qLz
         ltXtL61krTv58fA3SDVIBfP6scYxy7nS4wmWIhJzYrhkIlLsemHoMIWP7MKSmL4jqgjl
         z9446jLoCIToTxBD4BqYNMWj7Zfzf5y3P2XK5F+usgLq0Ul0aMmZM1Gx9nvpEs5c78LR
         eECexINYvMyJRrl1YClgw5Gn/XeDiuUy/V396oTHVXTNuYYEzn1QWwRFr4bFMhCVgHZV
         +1a6LTGKoTf2F/TD4JjAv3POLXue5JvE/mOadiTuSMvygWGf9t3v3rOUxq9KGRXseYly
         ftQQ==
X-Gm-Message-State: AOAM532ZY2uN+VudsfvYmriqevovhL1VNU7BEH7zBGsARnjS2do4R8dM
        F9uLXdLD1nSec0qbovN4wtw=
X-Google-Smtp-Source: ABdhPJwolUnv+/WanlbsWum2u1Pemy3dezf66gK6kzbV1uxvZ/qoLd3mAya3yz/zSaGouUV280Ue5g==
X-Received: by 2002:a17:90a:f2d7:: with SMTP id gt23mr14578990pjb.0.1596818239526;
        Fri, 07 Aug 2020 09:37:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a? ([2601:647:4802:9070:d88d:857c:b14c:519a])
        by smtp.gmail.com with ESMTPSA id l63sm11093432pgl.24.2020.08.07.09.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 09:37:18 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
To:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de
References: <20200807090559.29582-1-lengchao@huawei.com>
 <20200807134932.GA2122627@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d3bedf2b-58d5-667c-7f87-6334772a5772@grimberg.me>
Date:   Fri, 7 Aug 2020 09:37:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807134932.GA2122627@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> nvme_stop_queues quiesce queues for all name spaces, now quiesce one by
>> one, if there is lots of name spaces, sync wait long time(more than 10s).
>> Multipath can not fail over to retry quickly, cause io pause long time.
>> This is not expected.
>> To reduce quiesce time, we introduce async mechanism for sync SRCUs
>> and quiesce queue.
>>
> 
> Frankly speaking, I prefer to replace SRCU with percpu_refcount:
> 
> - percpu_refcount has much less memory footprint than SRCU, so we can simply
> move percpu_refcount into request_queue, instead of adding more bytes
> into each hctx by this patch
> 
> - percpu_ref_get()/percpu_ref_put() isn't slower than srcu_read_lock()/srcu_read_unlock().
> 
> - with percpu_refcount, we can remove 'srcu_idx' from hctx_lock/hctx_unlock()

Ming, I don't have an issue with your preference, but I don't want to
tie it to what Chao is attempting to fix.

So we should either move forward with an srcu approach, or you please
provide evidence to your claims if you are replacing the fast-path
synchronization mechanism, as this warrants a very good justification.
