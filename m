Return-Path: <SRS0=k455=3T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5142C2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 30 Jan 2020 20:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B92B20CC7
	for <linux-block@archiver.kernel.org>; Thu, 30 Jan 2020 20:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgA3Utn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:49:43 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:51842 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgA3Utm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jan 2020 15:49:42 -0500
Received: by mail-pj1-f47.google.com with SMTP id fa20so1859179pjb.1;
        Thu, 30 Jan 2020 12:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=PCGTGKEuUdmweRSlZyMdUUWhW62vjeeBm7dC57oJuWc=;
        b=B4YDDbURdt3mHwBpG8QxmVrZtcpW48k+dqys35/LveOPuffzzEBst5hUIOYbAEzquQ
         H77+lPgsBlxZD0AblyBr8M4YvxkbqdRUuZURsRVaolHF37w8q+7pFFgYCGhmUPAzypEa
         C5JPmWhXGX/+nN0LBV8ELYdeqmWOu3P5bVziVaD9/+o7U44VvqcypTXU5LxrNkAlLRP/
         qA/OYXdVUBmTqQZKlom9SEuIvL0lzYnJrMi9c+W7IWqBrt1cME99doC/j2Qb78lgxmLG
         zM4YJHx32OcY8hSVrOUAQGRZCIyDMzbHDsYmJavphoNydx4dx7gxLMFCpQ9ZkxzPWyLM
         MwSw==
X-Gm-Message-State: APjAAAX55pHvVMEABBLe7VTfTfIBtnqVoHqobzLmcqy9wOItEEASv2zu
        HYBicWOj1OEIh36Dpq6oieU=
X-Google-Smtp-Source: APXvYqyS2NCsg2j9/CPExAQLGFnTysnK2GaETCsfrzeBYiSpG80kBPKXwLvmqGWhMB3mRMnHUyEm6w==
X-Received: by 2002:a17:902:760e:: with SMTP id k14mr6199385pll.119.1580417381730;
        Thu, 30 Jan 2020 12:49:41 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c19sm7886971pfc.144.2020.01.30.12.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 12:49:39 -0800 (PST)
Subject: Re: Hung tasks with multiple partitions
To:     Salman Qazi <sqazi@google.com>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>
References: <CAKUOC8WM3XU5y9QKHrO8VBdC4Dghexqy+o9OGM1qUs4kGQxZdQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <55c0fe61-a091-b351-11b4-fa7f668e49d7@acm.org>
Date:   Thu, 30 Jan 2020 12:49:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAKUOC8WM3XU5y9QKHrO8VBdC4Dghexqy+o9OGM1qUs4kGQxZdQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------F114B3B5D8577E657D9AB906"
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------F114B3B5D8577E657D9AB906
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/20 11:34 AM, Salman Qazi wrote:
> I am writing on behalf of the Chromium OS team at Google.  We found
> the root cause for some hung tasks we were experiencing and we would
> like to get your opinion on potential solutions.  The bugs were
> encountered on 4.19 kernel.
> However my reading of the code suggests that the relevant portions of the
> code have not changed since then.
> 
> We have an eMMC flash drive that has been carved into partitions on an
> 8 CPU system.  The repro case that we came up with, is to use 8
> threaded fio write-mostly workload against one partition, let the
> system use the other partition as the read-write filesystem (i.e. just
> background activity) and then run the following loop:
> 
> while true; do sync; sleep 1 ; done
> 
> The hung task stack traces look like the following:
> 
> [  128.994891] jbd2/dm-1-8     D    0   367      2 0x00000028
> last_sleep: 96340206998.  last_runnable: 96340140151
> [  128.994898] Call trace:
> [  128.994903]  __switch_to+0x120/0x13c
> [  128.994909]  __schedule+0x60c/0x7dc
> [  128.994914]  schedule+0x74/0x94
> [  128.994919]  io_schedule+0x1c/0x40
> [  128.994925]  bit_wait_io+0x18/0x58
> [  128.994930]  __wait_on_bit+0x78/0xdc
> [  128.994935]  out_of_line_wait_on_bit+0xa0/0xcc
> [  128.994943]  __wait_on_buffer+0x48/0x54
> [  128.994948]  jbd2_journal_commit_transaction+0x1198/0x1a4c
> [  128.994956]  kjournald2+0x19c/0x268
> [  128.994961]  kthread+0x120/0x130
> [  128.994967]  ret_from_fork+0x10/0x18
> 
> I added some more information to trace points to understand what was
> going on.  It turns out that blk_mq_sched_dispatch_requests had
> checked hctx->dispatch, found it empty, and then began consuming
> requests from the io scheduler (in blk_mq_do_dispatch_sched).
> Unfortunately, the deluge from the I/O scheduler (BFQ in our case)
> doesn't stop for 30 seconds and there is no mechanism present in
> blk_mq_do_dispatch_sched to terminate early or reconsider
> hctx->dispatch contents.  In the meantime, a flush command arrives in
> hctx->dispatch (via insertion in  blk_mq_sched_bypass_insert) and
> languishes there.  Eventually the thread waiting on the flush triggers
> the hung task watchdog.
> 
> The solution that comes to mind is to periodically check
> hctx->dispatch in blk_mq_do_dispatch_sched and exit early if it is
> non-empty.  However, not being an expert in this subsystem, I am not
> sure if there would be other consequences.

The call stack shown in your e-mail usually means that an I/O request 
got stuck. How about determining first whether this is caused by the BFQ 
scheduler or by the eMMC driver? I think the developers of these 
software components need that information anyway before they can step in.

The attached script may help to identify which requests got stuck.

Bart.

--------------F114B3B5D8577E657D9AB906
Content-Type: text/plain; charset=UTF-8;
 name="list-pending-block-requests"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="list-pending-block-requests"

IyEvYmluL2Jhc2gKCnNob3dfc3RhdGUoKSB7CiAgICBsb2NhbCBhIGRldj0kMQoKICAgIGZv
ciBhIGluIGRldmljZS9zdGF0ZSBxdWV1ZS9zY2hlZHVsZXI7IGRvCglbIC1lICIkZGV2LyRh
IiBdICYmIGdyZXAgLWFIIC4gIiRkZXYvJGEiCiAgICBkb25lCn0KCmlmIFsgLWUgL3N5cy9r
ZXJuZWwvZGVidWcvYmxvY2sgXTsgdGhlbgogICAgZGV2cz0oJChjZCAvc3lzL2tlcm5lbC9k
ZWJ1Zy9ibG9jayAmJiBlY2hvIC4vKikpCmVsc2UKICAgIGRldnM9KCQoY2QgL3N5cy9jbGFz
cy9ibG9jayAmJiBlY2hvIC4vKikpCmZpCgpjZCAvc3lzL2NsYXNzL2Jsb2NrIHx8IGV4aXQg
JD8KZm9yIGRldiBpbiAiJHtkZXZzW0BdfSI7IGRvCiAgICBkZXY9IiR7ZGV2Iy4vfSIKICAg
IGVjaG8gIiRkZXYiCiAgICBwZW5kaW5nPTAKICAgIGlmIFsgLWUgIiRkZXYvbXEiIF07IHRo
ZW4KCWZvciBmIGluICIkZGV2Ii9tcS8qL3twZW5kaW5nLCovcnFfbGlzdH07IGRvCgkgICAg
WyAtZSAiJGYiIF0gfHwgY29udGludWUKCSAgICBpZiB7IHJlYWQgLXIgbGluZTEgJiYgcmVh
ZCAtciBsaW5lMjsgfSA8IiRmIjsgdGhlbgoJCWVjaG8gIiRmIgoJCWVjaG8gIiRsaW5lMSAk
bGluZTIiID4vZGV2L251bGwKCQloZWFkIC1uIDkgIiRmIgoJCSgocGVuZGluZysrKSkKCSAg
ICBmaQoJZG9uZQogICAgZmkKICAgICgKCWJ1c3k9MAoJY2QgL3N5cy9rZXJuZWwvZGVidWcv
YmxvY2sgPiYvZGV2L251bGwgJiYKCSAgICB7IGdyZXAgLWFIIC4gJGRldi9yZXF1ZXVlX2xp
c3Q7IHRydWU7IH0gJiYKCSAgICBmb3IgZCBpbiAiJGRldiIvbXEvaGN0eCogIiRkZXYiL2hj
dHgqOyBkbwoJCVsgISAtZCAiJGQiIF0gJiYgY29udGludWUKCQl7IFsgISAtZSAiJGQvdGFn
cyIgXSB8fAoJCSAgICAgIGdyZXAgLXEgJ15idXN5PTAkJyAiJGQvdGFncyI7IH0gJiYKCQkg
ICAgeyBbICEgLWUgIiRkL3NjaGVkX3RhZ3MiIF0gfHwKCQkJICBbICIkKDwiJGQvc2NoZWRf
dGFncyIpIiA9ICIiIF0gfHwKCQkJICBncmVwIC1xICdeYnVzeT0wJCcgIiRkL3NjaGVkX3Rh
Z3MiOyB9ICYmIGNvbnRpbnVlCgkJKChidXN5KyspKQoJICAgICAgICBmb3IgZiBpbiAiJGQi
L3thY3RpdmUsYnVzeSxkaXNwYXRjaCxmbGFncyxyZXF1ZXVlX2xpc3Qsc2NoZWRfdGFncyxz
dGF0ZSx0YWdzKixjcHUqL3JxX2xpc3Qsc2NoZWQvKnJxc307IGRvCgkJICAgIFsgLWUgIiRm
IiBdICYmIGdyZXAgLWFIIC4gIiRmIgoJCWRvbmUKCSAgICBkb25lCglleGl0ICRidXN5CiAg
ICApCiAgICBwZW5kaW5nPSQoKHBlbmRpbmcrJD8pKQogICAgaWYgWyAiJHBlbmRpbmciIC1n
dCAwIF07IHRoZW4KCSgKCSAgICBjZCAvc3lzL2tlcm5lbC9kZWJ1Zy9ibG9jayA+Ji9kZXYv
bnVsbCAmJgoJCWlmIFsgLWUgIiRkZXYvbXEvc3RhdGUiIF07IHRoZW4KCQkgICAgZ3JlcCAt
YUggLiAiJGRldi9tcS9zdGF0ZSIKCQllbHNlCgkJICAgIGdyZXAgLWFIIC4gIiRkZXYvc3Rh
dGUiCgkJZmkKCSkKCXNob3dfc3RhdGUgIiRkZXYiCiAgICBmaQpkb25lCg==
--------------F114B3B5D8577E657D9AB906--
