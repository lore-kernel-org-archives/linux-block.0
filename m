Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBD1C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Feb 2021 06:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AFE64EC0
	for <linux-block@archiver.kernel.org>; Fri, 19 Feb 2021 06:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhBSGXW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Feb 2021 01:23:22 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:45749 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhBSGXU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Feb 2021 01:23:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613715780; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=R8F5SrJMAIGBbO6RxWiqQbg011N71/HoCZ+ew9nIx4Y=;
 b=DqLDj5OeJ/kl7CmfrSX0AHWIZ0fM12Pm7PtQWeH7OCcuXLkPLl6OlALcv7MmWY8oDbMrboQN
 IgHsFX+TdSKsA7Pw2JHUza0yEOLk1jYWHnLh4gICM9SoTHJz3ZxQE3yPAeZpolgTSaJhZ0TJ
 XU7rEmrmP1exSBPmkUiU0lyang8=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 602f59237237f827dc0b4fa6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Feb 2021 06:22:27
 GMT
Sender: pragalla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BF5FDC43461; Fri, 19 Feb 2021 06:22:26 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pragalla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8AECC433C6;
        Fri, 19 Feb 2021 06:22:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Feb 2021 11:52:25 +0530
From:   pragalla@codeaurora.org
To:     John Garry <john.garry@huawei.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        evgreen@google.com, linux-block@vger.kernel.org,
        stummala@codeaurora.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: use-after-free access in bt_iter()
In-Reply-To: <9ace4c26c47e84c3c6a1c68ef1a193f8@codeaurora.org>
References: <f98dd950466b0408d8589de053b02e05@codeaurora.org>
 <056783fa-a510-2463-f353-c64dd8f37be9@acm.org>
 <f1027dc3-d5a7-02c8-ef02-e34aeb12c0ac@huawei.com>
 <bbed52ea0c788b07ca68142bd86a07df@codeaurora.org>
 <5ab6e628-6c93-618a-a10b-fe0df1ab4a40@huawei.com>
 <9ace4c26c47e84c3c6a1c68ef1a193f8@codeaurora.org>
Message-ID: <b859618aeac58bd9bb620d7ebdb24b90@codeaurora.org>
X-Sender: pragalla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-02-05 21:51, pragalla@codeaurora.org wrote:
> On 2021-02-05 21:37, John Garry wrote:
>> - bouncing jianchao.w.wang@oracle.com
>> 
>>>> 
>>>>> Some time ago you replied the following to an email from me with a
>>>>> suggestion for a fix: "Please let me consider it a bit more." Are 
>>>>> you
>>>>> still working on a fix?
>>>> 
>>>> Unfortunately I have not had a chance, sorry. But I can look again.
>>>> 
>>>> So I have only seen KASAN use-after-free's myself, but never an 
>>>> actual
>>>> oops. IIRC, someone did report an oops.
>>>> 
>>> Hi John,
>>> 
>>>> @Pradeep, do you have a reliable re-creator? I noticed the timeout
>>>> handler stackframe in your mail, so I guess not. However, as an
>>>> experiment, could you test:
>>>> https://lore.kernel.org/linux-block/1608203273-170555-2-git-send-email-john.garry@huawei.com/
>>> Yes, i don't have a reliable re-creator. The oops was noticed as a 
>>> part of stability testing and
>>> was not an intentional try. This was noticed couple of times.
>>> Please share the steps (if any) to easy hit or to exercise this path 
>>> more frequently.
>>> Meanwhile, i will go with the usual stability procedure. i will 
>>> update the results here later.
>>> 
>> 
Hi John,

we ran the stability with the above patch
(https://lore.kernel.org/linux-block/1608203273-170555-2-git-send-email-john.garry@huawei.com/)
with switching the io-schedulers in b/w for ~88hrs on 2 devices, we 
didn't notice any crash/issue.

>> Do you have a full kernel log for your crash?
> Yes. Attaching the full kernel dmesg log.
>> 
>> So there are different flavors of this issue, and you reported a crash
>> from blk_mq_queue_tag_busy_iter().
>> 
>> If you check:
>> https://lore.kernel.org/linux-block/76190c94-c5c1-9553-5509-9969fc323544@huawei.com/
>> 
>> You can see how I artificially trigger an issue in 
>> blk_mq_queue_tag_busy_iter().
> Sure, i will go through the steps on the recreation part. Thanks.
>> 
>>>> This should fix the common issue. But no final solution to issues
>>>> discussed from patch 2/2, which is more exotic.
>>>> 
>>>> BTW, is this the same Pradeep who reported:
>>>> https://lore.kernel.org/linux-block/1606402925-24420-1-git-send-email-ppvk@codeaurora.org/
>> 
>> Thanks,
>> John
> 
> Thanks and Regards,
> Pradeep
