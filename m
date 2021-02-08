Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078C8C4332D
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 17:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40E364E54
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 17:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhBHR4O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 12:56:14 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:35379 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbhBHRyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Feb 2021 12:54:53 -0500
Received: by mail-wr1-f49.google.com with SMTP id l12so18318236wry.2
        for <linux-block@vger.kernel.org>; Mon, 08 Feb 2021 09:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a66xHvPpp6i9dDSA9qGRCMjzbDlKR3Qlu6Ofb9DVV5E=;
        b=Ts5dcSWWItkvbNq47KF4QZxBH9AknujtV5AEBIi1ZkGpfxr2nNTS1adYjZJsti8sO5
         sy46z2TUY/kLeJVNIB66D0QtVbAPkWbrPadn9G9q1hQv3gPqbBwSeohp0FVIW/NEFFFb
         sbZbZa2y4bmg8ph/h91DVMxwjEz8P/pU9ImN3ieTXfXenKJvKnK0Ps8/Vgvh/LOwdTH1
         6bXSgV++cAe8oXuuRQQxhct6/Np8ayqbDm4W0owMs1kwx2C+S1UHW2E2z3P2QRrH6koV
         WTDQen/3LZeZavzNbQ70SrXLRDgavvPHsjzk6Id7qX3OhKtBvrKIhQH8K109kao6RvBr
         o64w==
X-Gm-Message-State: AOAM530kKf5pjkIU2WnehfD/0X0Z8W8KidMF1kb5P5q9gmrY7wHvVWjN
        P7NpddCME8xtQTWh0d9NB64=
X-Google-Smtp-Source: ABdhPJwIIPgo5PKX+i0q2vi/2CObaqK+7TZC0mTmqpVzYgMhSpi6YclHvMWBzpjahZguuxz5zto/xQ==
X-Received: by 2002:a5d:58fb:: with SMTP id f27mr9164214wrd.119.1612806849850;
        Mon, 08 Feb 2021 09:54:09 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5? ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
        by smtp.gmail.com with ESMTPSA id z4sm29766665wrw.38.2021.02.08.09.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 09:54:09 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>
Cc:     axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Chaitanya.Kulkarni@wdc.com
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
Date:   Mon, 8 Feb 2021 09:54:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi Sagi
> 
> On 2/8/21 5:46 PM, Sagi Grimberg wrote:
>>
>>> Hello
>>>
>>> We found this kernel NULL pointer issue with latest 
>>> linux-block/for-next and it's 100% reproduced, let me know if you 
>>> need more info/testing, thanks
>>>
>>> Kernel repo: 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>> Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next
>>>
>>> Reproducer: blktests nvme-tcp/012
>>
>> Thanks for reporting Ming, I've tried to reproduce this on my VM
>> but did not succeed. Given that you have it 100% reproducible,
>> can you try to revert commit:
>>
>> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
>>
> 
> Revert this commit fixed the issue and I've attached the config. :)

Good to know,

I see some differences that I should probably change to hit this:
--
@@ -254,14 +256,15 @@ CONFIG_PERF_EVENTS=y
  # end of Kernel Performance Events And Counters

  CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLUB_DEBUG=y
  # CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
-# CONFIG_SLOB is not set
-CONFIG_SLAB_MERGE_DEFAULT=y
-# CONFIG_SLAB_FREELIST_RANDOM is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLAB_MERGE_DEFAULT is not set
+CONFIG_SLAB_FREELIST_RANDOM=y
  # CONFIG_SLAB_FREELIST_HARDENED is not set
-# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
+CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
+CONFIG_SLUB_CPU_PARTIAL=y
  CONFIG_SYSTEM_DATA_VERIFICATION=y
  CONFIG_PROFILING=y
  CONFIG_TRACEPOINTS=y
@@ -299,7 +302,8 @@ CONFIG_HAVE_INTEL_TXT=y
  CONFIG_X86_64_SMP=y
  CONFIG_ARCH_SUPPORTS_UPROBES=y
  CONFIG_FIX_EARLYCON_MEM=y
-CONFIG_PGTABLE_LEVELS=4
+CONFIG_DYNAMIC_PHYSICAL_MASK=y
+CONFIG_PGTABLE_LEVELS=5
  CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
--

Probably CONFIG_SLUB and CONFIG_SLUB_DEBUG should be used.
