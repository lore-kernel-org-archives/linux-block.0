Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC869C4332F
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 20:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiK2ULE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 15:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbiK2ULE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 15:11:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2EA5917E
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 12:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669752605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZQ4wLln4WoY1SeYotmNRnOISY1+44kDYICwKWwdJ1w=;
        b=hARJwQaPTLfDjnFT9gAm7r7Li/ozKrIrBtavH1Pke1cfxwUm0li7wPK5R7i9Br/NGVyysb
        8c/xfAvkP6eq9Y9Gxz0fI2h4fb/zZny6uf0kUm0DmComlWyGtC65vFn06wxx5CGY8w52dS
        Wr5I8gxHryH7Yboq6Ssjr8FPoiXcPCw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-DN8pwP3HN7CqUV50uFZyCA-1; Tue, 29 Nov 2022 15:10:04 -0500
X-MC-Unique: DN8pwP3HN7CqUV50uFZyCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24F67185A7AD;
        Tue, 29 Nov 2022 20:10:04 +0000 (UTC)
Received: from [10.22.17.30] (unknown [10.22.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F31AC2166B2D;
        Tue, 29 Nov 2022 20:10:03 +0000 (UTC)
Message-ID: <89084392-7d67-0271-507b-9fb85cc17d82@redhat.com>
Date:   Tue, 29 Nov 2022 15:10:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: blktests: block/027 failing consistently
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f9490310-11e2-fdc9-db3f-2b4a51170c85@nvidia.com>
 <b1efe64c-7b8d-b10f-a041-bae26aa3e637@acm.org>
 <270267dc-0313-c047-97e7-9ecca036be10@nvidia.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <270267dc-0313-c047-97e7-9ecca036be10@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/29/22 14:21, Chaitanya Kulkarni wrote:
> On 11/29/22 11:13, Bart Van Assche wrote:
>> On 11/29/22 10:49, Chaitanya Kulkarni wrote:
>>> blktest:block/027 failing consistently on latest linux-block/for-next
>> Hi Chaitanya,
>>
>> Is this report perhaps a duplicate of
>> https://lore.kernel.org/linux-block/69af7ccb-6901-c84c-0e95-5682ccfb750c@acm.org/
>> ?
>>
>> Thanks,
>>
>> Bart.
> Indeed as Jens pointed out.
>
> Waiman please run the blktests block/027 when you fix it so we all
> know...
>
> -ck

Sure. I will the run the test after applying my fix.

Cheers,
Longman

