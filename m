Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA3EC4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 02:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371346115C
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 02:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhHFCna (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 22:43:30 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:54839 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhHFCna (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 22:43:30 -0400
Received: by mail-pj1-f48.google.com with SMTP id a8so13730962pjk.4;
        Thu, 05 Aug 2021 19:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=w+3fDpFiOzl/w0HBn5g3m6GV7Q8q6gv5EmN0f1j9vjQ=;
        b=tv3/q6WOGL4dOrGo3os3qN7hPSDupQGOVPCRzbKoTYooWqpcGDRWagf/9DROnDDQjp
         XrPtOqboxOv3dYiUjJCpJX8mRbgCJtL1XuW1wW6DXaFcdkJlpia4OnE7k3Ef0KqzkBvN
         zg+xgl7QksPo2cvxyNBqWflqeqctgfaM4ISHyHsLNTLbB8SB/BVXv5BhuYPgUFW0/JP4
         GwVyoVRBlVOSxQV1jRJ9t1mSbS+7MQ2Vm7z00kn3+tUqGJ3meEoTC9YKe4/4txEVVMpG
         lRqIGhQTz2jxifD9pSnn5sXLao8blTs0XJmX52oHDFcs1JG+0qJS0jpHdJ98H3dTwl9m
         KLsw==
X-Gm-Message-State: AOAM5309Ppyh+xs/gWRVqeQuPFvgjCxSBSXdlvagf35/b/UmviqlsBZ6
        qPanU2EhyMrU5WI7HtkQ/Xk=
X-Google-Smtp-Source: ABdhPJyA5uWXSQSPwMbYqf1DXcRcFOPj3kbkGxMxdQI8drkkDVJ4KbJPtOUPQb36OyT7aHYZQaURgg==
X-Received: by 2002:a17:90a:ca0f:: with SMTP id x15mr17908632pjt.78.1628217793840;
        Thu, 05 Aug 2021 19:43:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:e704:5548:215f:29bb? ([2601:647:4000:d7:e704:5548:215f:29bb])
        by smtp.gmail.com with ESMTPSA id t8sm10717487pja.41.2021.08.05.19.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 19:43:12 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
To:     "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20210712031818.31918-1-yukuai3@huawei.com>
 <ade72519-5e16-1cc5-9a77-cb9ead42035e@acm.org>
 <5ab07cf8-a2a5-a60e-c86a-ab6ea53990bb@huawei.com>
 <e587c572-bcd7-87c4-5eea-30ccdc7455db@acm.org>
 <b124b91b-7474-fa27-b78c-01b7e7396a17@huawei.com>
 <07d2e6ba-d016-458a-a2ce-877fd7b72ed0@acm.org>
 <a63fbd36-5a43-e412-c0a2-a06730945a13@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b4603b71-4306-4542-e4fb-bf30133f89a8@acm.org>
Date:   Thu, 5 Aug 2021 19:43:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a63fbd36-5a43-e412-c0a2-a06730945a13@huawei.com>
Content-Type: multipart/mixed;
 boundary="------------1060257EAADDFC7E70C1AFA3"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------1060257EAADDFC7E70C1AFA3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 8/5/21 6:50 PM, yukuai (C) wrote:
> After applying this configuration, the number of null_blk in my
> machine is about 650k(330k before). Is this still too low?

That seems low to me. If I run the attached script on a six year old
desktop with an eight core i7-4790 CPU it reports a little more than 5
million IOPS. Has kernel debugging perhaps been enabled in the kernel on
the test setup? Or is the system perhaps slowed down by security
mitigations?

> By the way, there are no performance degradation.

Please wait with drawing a conclusion until you can run a workload on
your setup of several million IOPS.

Thanks,

Bart.

--------------1060257EAADDFC7E70C1AFA3
Content-Type: text/plain; charset=UTF-8;
 name="nullb-iops"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="nullb-iops"

IyEvYmluL2Jhc2gKCmlmIFsgLWUgL3N5cy9rZXJuZWwvY29uZmlnL251bGxiIF07IHRoZW4K
ICAgIGZvciBkIGluIC9zeXMva2VybmVsL2NvbmZpZy9udWxsYi8qOyBkbwogICAgICAgIFsg
LWQgIiRkIiBdICYmIHJtZGlyICIkZCIKICAgIGRvbmUKZmkKbnVtY3B1cz0kKGdyZXAgLWMg
XnByb2Nlc3NvciAvcHJvYy9jcHVpbmZvKQptb2Rwcm9iZSAtciBudWxsX2JsawpbIC1lIC9z
eXMvbW9kdWxlL251bGxfYmxrIF0gJiYgZXhpdCAkPwptb2Rwcm9iZSBudWxsX2JsayBucl9k
ZXZpY2VzPTAgJiYKICAgIHVkZXZhZG0gc2V0dGxlICYmCiAgICBjZCAvc3lzL2tlcm5lbC9j
b25maWcvbnVsbGIgJiYKICAgIG1rZGlyIG51bGxiMCAmJgogICAgY2QgbnVsbGIwICYmCiAg
ICBlY2hvIDAgPiBjb21wbGV0aW9uX25zZWMgJiYKICAgIGVjaG8gNTEyID4gYmxvY2tzaXpl
ICYmCiAgICBlY2hvIDAgPiBob21lX25vZGUgJiYKICAgIGVjaG8gMCA+IGlycW1vZGUgJiYK
ICAgIGVjaG8gMTAyNCA+IHNpemUgJiYKICAgIGVjaG8gMCA+IG1lbW9yeV9iYWNrZWQgJiYK
ICAgIGVjaG8gMiA+IHF1ZXVlX21vZGUgJiYKICAgIGVjaG8gMSA+IHBvd2VyIHx8CiAgICBl
eGl0ICQ/CgooCiAgICBjZCAvc3lzL2Jsb2NrL251bGxiMC9xdWV1ZSAmJgoJZWNobyAyID4g
cnFfYWZmaW5pdHkKKSB8fCBleGl0ICQ/Cgppb2RlcHRoPSR7MTotMX0KcnVudGltZT0zMAph
cmdzPSgpCmlmIFsgIiRpb2RlcHRoIiA9IDEgXTsgdGhlbgoJYXJncys9KC0taW9lbmdpbmU9
cHN5bmMpCmVsc2UKCWFyZ3MrPSgtLWlvZW5naW5lPWlvX3VyaW5nIC0taW9kZXB0aF9iYXRj
aD0kKChpb2RlcHRoLzIpKSkKZmkKYXJncys9KC0taW9kZXB0aD0kaW9kZXB0aCAtLW5hbWU9
bnVsbGIwIC0tZmlsZW5hbWU9L2Rldi9udWxsYjBcCiAgICAtLXJ3PXJlYWQgLS1icz00MDk2
IC0tbG9vcHM9JCgoMTw8MjApKSAtLWRpcmVjdD0xIC0tbnVtam9icz0kbnVtY3B1cyBcCiAg
ICAtLXRocmVhZCAtLXJ1bnRpbWU9JHJ1bnRpbWUgLS1pbnZhbGlkYXRlPTEgLS1ndG9kX3Jl
ZHVjZT0xIFwKICAgIC0tZ3JvdXBfcmVwb3J0aW5nPTEgLS1pb3NjaGVkdWxlcj1ub25lKQpp
ZiBudW1hY3RsIC1tIDAgLU4gMCBlY2hvID4mL2Rldi9udWxsOyB0aGVuCgludW1hY3RsIC1t
IDAgLU4gMCAtLSBmaW8gIiR7YXJnc1tAXX0iCmVsc2UKCWZpbyAiJHthcmdzW0BdfSIKZmkK

--------------1060257EAADDFC7E70C1AFA3--
