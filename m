Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C9DC433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CE064E15
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhBIK2p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:28:45 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:40676 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhBIK0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 05:26:43 -0500
Received: by mail-wm1-f49.google.com with SMTP id o24so2922082wmh.5
        for <linux-block@vger.kernel.org>; Tue, 09 Feb 2021 02:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ibV/jLkBrn87E5CW6kJR0CKTV/LoaHX30Sh+5d0LRZA=;
        b=e4rXgh8lqeaInnOB88B1ibhT9saKZwlEb5uB27lATBds6bO0sGOSu/w2uY0QtcN+V2
         bhKcfvMO6BSZBAzg01Qt/b4yl2lFj7vfZXrUeDlQTjgg3QVPaXvVaJtBy7skLbj1XjMD
         iVd8KmS0xZE8yDlcXqZHi0RdK1LF/QyYo8FDYzwOGs4PYUSA5eBsHdLhZkcXBQ3dr3q9
         zL3fZTfXBDE0y07ax4Qh4vsIh6Qy3AmTNT+xfNB63QMa0BzNYd1M1suEL0/65BF1LLDq
         23lXYRKs5fp3f4LeNFxHm0Vhe6HFSdH+519IVObR54E+FIeTZJxy7KUsYlkvyC8hNyKz
         csLA==
X-Gm-Message-State: AOAM533bQevIkO8N7ohT9SNH5gyS8CIZE2tRE/3Qd4AmL0ZrSbn6/ZS4
        52FxYsABpg9AuhgVgX7SNwM=
X-Google-Smtp-Source: ABdhPJwQ+cVQLW3Ht0As419gQ0XUQrXNHud+lSTx41ToJ41y0uyo86ZxMiOcq3S+N2Lb/gMkU5C1Rw==
X-Received: by 2002:a1c:4483:: with SMTP id r125mr2679863wma.80.1612866360943;
        Tue, 09 Feb 2021 02:26:00 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5? ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
        by smtp.gmail.com with ESMTPSA id m131sm4012557wmf.41.2021.02.09.02.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 02:26:00 -0800 (PST)
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
Message-ID: <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
Date:   Tue, 9 Feb 2021 02:25:56 -0800
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

Hey Ming,

Instead of revert, does this patch makes the issue go away?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 619b0d8f6e38..69f59d2c5799 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2271,7 +2271,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct 
nvme_ns *ns,
         req->data_len = blk_rq_nr_phys_segments(rq) ?
                                 blk_rq_payload_bytes(rq) : 0;
         req->curr_bio = rq->bio;
-       if (req->curr_bio)
+       if (req->curr_bio && req->data_len)
                 nvme_tcp_init_iter(req, rq_data_dir(rq));

         if (rq_data_dir(rq) == WRITE &&
--
