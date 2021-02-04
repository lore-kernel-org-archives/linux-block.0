Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ABAC433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB96664E4F
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 16:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhBDQUu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:20:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2495 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbhBDQUL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 11:20:11 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DWkDk2flJz67kpt;
        Fri,  5 Feb 2021 00:15:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 17:19:22 +0100
Received: from [10.210.168.183] (10.210.168.183) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 16:19:20 +0000
Subject: Re: use-after-free access in bt_iter()
To:     Bart Van Assche <bvanassche@acm.org>, <pragalla@codeaurora.org>,
        <axboe@kernel.dk>, <evgreen@google.com>,
        <jianchao.w.wang@oracle.com>
CC:     <linux-block@vger.kernel.org>, <stummala@codeaurora.org>,
        Ming Lei <ming.lei@redhat.com>
References: <f98dd950466b0408d8589de053b02e05@codeaurora.org>
 <056783fa-a510-2463-f353-c64dd8f37be9@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f1027dc3-d5a7-02c8-ef02-e34aeb12c0ac@huawei.com>
Date:   Thu, 4 Feb 2021 16:17:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <056783fa-a510-2463-f353-c64dd8f37be9@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.183]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/02/2021 15:51, Bart Van Assche wrote:
> On 2/4/21 3:46 AM,pragalla@codeaurora.org  wrote:
>> Is this issue got fixed on any latest kernel ? if so, can you please
>> help point the patch ?
>> If not got fixed, can we have a final solution ? i can even help in
>> testing the solution.
> Hi John,
> 

Hi Bart,

> Some time ago you replied the following to an email from me with a
> suggestion for a fix: "Please let me consider it a bit more." Are you
> still working on a fix?

Unfortunately I have not had a chance, sorry. But I can look again.

So I have only seen KASAN use-after-free's myself, but never an actual 
oops. IIRC, someone did report an oops.

@Pradeep, do you have a reliable re-creator? I noticed the timeout 
handler stackframe in your mail, so I guess not. However, as an 
experiment, could you test:
https://lore.kernel.org/linux-block/1608203273-170555-2-git-send-email-john.garry@huawei.com/

This should fix the common issue. But no final solution to issues 
discussed from patch 2/2, which is more exotic.

BTW, is this the same Pradeep who reported:
https://lore.kernel.org/linux-block/1606402925-24420-1-git-send-email-ppvk@codeaurora.org/

I did cc ppvk@codeaurora.org on earlier version of my series, but it 
bounced.

> 
> See also
> https://lore.kernel.org/linux-block/1bcc1d9e-6a32-1e00-0d32-f5b7325b2f8c@huawei.com/

Thanks,
John
