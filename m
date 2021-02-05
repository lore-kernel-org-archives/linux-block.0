Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A76C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 19:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D2664DA3
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 19:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhBESJA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:09:00 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:23078 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232591AbhBESHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Feb 2021 13:07:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612554545; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=NPsWXIeL1yu7Zu/3blrDQ6G8CVyagjT+skV5dFqeInA=;
 b=nOXPCdItt4JPUEMjDKClHWJyZuR/vugSYFsvl9NFvr2Zb+Xw/0PqXkLUQQkvvAPw1S4vkJXv
 y6FkfPYbIwIdwmEE/Nw7pu/+VV/QhiFKmgm1klOUvTxQJC/I1lozXBh60mj0UEBRq+7xtzxb
 vwJENEJVj/lYHp8PQvMsyxLU+e0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 601d647df112b7872c1bdd10 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 Feb 2021 15:30:05
 GMT
Sender: pragalla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42706C43465; Fri,  5 Feb 2021 15:30:05 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pragalla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EA69C433C6;
        Fri,  5 Feb 2021 15:30:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Feb 2021 21:00:04 +0530
From:   pragalla@codeaurora.org
To:     John Garry <john.garry@huawei.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        evgreen@google.com, jianchao.w.wang@oracle.com,
        linux-block@vger.kernel.org, stummala@codeaurora.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: use-after-free access in bt_iter()
In-Reply-To: <f1027dc3-d5a7-02c8-ef02-e34aeb12c0ac@huawei.com>
References: <f98dd950466b0408d8589de053b02e05@codeaurora.org>
 <056783fa-a510-2463-f353-c64dd8f37be9@acm.org>
 <f1027dc3-d5a7-02c8-ef02-e34aeb12c0ac@huawei.com>
Message-ID: <bbed52ea0c788b07ca68142bd86a07df@codeaurora.org>
X-Sender: pragalla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-02-04 21:47, John Garry wrote:
> On 04/02/2021 15:51, Bart Van Assche wrote:
>> On 2/4/21 3:46 AM,pragalla@codeaurora.org  wrote:
>>> Is this issue got fixed on any latest kernel ? if so, can you please
>>> help point the patch ?
>>> If not got fixed, can we have a final solution ? i can even help in
>>> testing the solution.
>> Hi John,
>> 
> 
> Hi Bart,
> 
>> Some time ago you replied the following to an email from me with a
>> suggestion for a fix: "Please let me consider it a bit more." Are you
>> still working on a fix?
> 
> Unfortunately I have not had a chance, sorry. But I can look again.
> 
> So I have only seen KASAN use-after-free's myself, but never an actual
> oops. IIRC, someone did report an oops.
> 
Hi John,

> @Pradeep, do you have a reliable re-creator? I noticed the timeout
> handler stackframe in your mail, so I guess not. However, as an
> experiment, could you test:
> https://lore.kernel.org/linux-block/1608203273-170555-2-git-send-email-john.garry@huawei.com/
> 
Yes, i don't have a reliable re-creator. The oops was noticed as a part 
of stability testing and
was not an intentional try. This was noticed couple of times.
Please share the steps (if any) to easy hit or to exercise this path 
more frequently.
Meanwhile, i will go with the usual stability procedure. i will update 
the results here later.

> This should fix the common issue. But no final solution to issues
> discussed from patch 2/2, which is more exotic.
> 
> BTW, is this the same Pradeep who reported:
> https://lore.kernel.org/linux-block/1606402925-24420-1-git-send-email-ppvk@codeaurora.org/
> 
> I did cc ppvk@codeaurora.org on earlier version of my series, but it 
> bounced.
> 
Yes, it's the same Pradeep. Unfortunately my old email 
"ppvk@codeaurora.org" got expired and
couldn't able to restore. Hence the bounced emails. Now this got 
resolved with a new email
"pragalla@codeaurora.org" which I'm now currently replying.

>> 
>> See also
>> https://lore.kernel.org/linux-block/1bcc1d9e-6a32-1e00-0d32-f5b7325b2f8c@huawei.com/
> 
> Thanks,
> John

Thanks and Regards,
Pradeep
