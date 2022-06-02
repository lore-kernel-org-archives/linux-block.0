Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9DDC433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 19:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbiFBTNF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238437AbiFBTM6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 15:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15CD6101C9
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654197177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ura6WzJRfDCe639hKtMahR5YURQ9sPrCG1JQZM8gR34=;
        b=QIRXaLXQPNcR+T3pSWTavt/mCfYgHvX7fff5mvqqvQ4bABMdka3p5jTg2EqdU0GaTuWeKk
        XrZEfkqOux2emF3Mb+OwJIXMEhOC87eX+ltokKx/QZnowjQtJ7Vwm7BLjWzk+YGg8keYhj
        h6DRji3QsYXGW/daXxm9UII/iImSq10=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-l6nvbvmKOSeZhTBelqCCeQ-1; Thu, 02 Jun 2022 15:12:54 -0400
X-MC-Unique: l6nvbvmKOSeZhTBelqCCeQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 993753C10142;
        Thu,  2 Jun 2022 19:12:53 +0000 (UTC)
Received: from [10.22.32.147] (unknown [10.22.32.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CD8F403371;
        Thu,  2 Jun 2022 19:12:53 +0000 (UTC)
Message-ID: <3ba0799f-c008-bbdf-bbc1-626d8bb4b821@redhat.com>
Date:   Thu, 2 Jun 2022 15:12:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 4/4] blk-cgroup: Document the design of new lockless
 iostat_cpu list
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20220602133543.128088-2-longman@redhat.com>
 <20220602185401.162937-1-longman@redhat.com>
 <YpkJ6rDTR24ScuEq@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YpkJ6rDTR24ScuEq@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/2/22 15:05, Tejun Heo wrote:
> On Thu, Jun 02, 2022 at 02:54:01PM -0400, Waiman Long wrote:
>> A set of percpu lockless lists per block cgroup (blkcg) is added to
>> track the set of recently updated iostat_cpu structures. Add comment
>> in the code to document the design of this new set of lockless lists.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.

I have just realized that I forgot to free the percpu blkcg->lhead in 
blkcg_css_free(). I will send out v6 with this change as well as 
integrating this documentation patch back. Sorry for the omission.

Thanks,
Longman

