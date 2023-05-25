Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F89C77B7A
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 03:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjEYDMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 23:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYDMM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 23:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD4CA9
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 20:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684984283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmezpQCSAWPX0f5uWe+bwcHVCf1gmeaUk9ZMvZ64NSA=;
        b=PAgJIYv+aATy9pW/OXhUx2bQygkDvT7WDc5J7u2iUobacCtSmQimiY4CAe5dwDWyV/bd3q
        Z8EhhlmSe50rkoHiGHnbOcKsrgMCvRKdhGTxJBi5icsryPTdDnO74JzWIA8uqvCq9YKgsX
        ENYantci/nbxAm5Ge9qTch0sPJQeQGQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-zi2SxJ4zPj2vLluz-7E4Gw-1; Wed, 24 May 2023 23:11:20 -0400
X-MC-Unique: zi2SxJ4zPj2vLluz-7E4Gw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B42543C0BE44;
        Thu, 25 May 2023 03:11:19 +0000 (UTC)
Received: from [10.22.17.224] (unknown [10.22.17.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 655532166B27;
        Thu, 25 May 2023 03:11:19 +0000 (UTC)
Message-ID: <25b603a5-8da6-af8c-93f0-5c0e81a2eb0b@redhat.com>
Date:   Wed, 24 May 2023 23:11:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2] blk-cgroup: Flush stats before releasing blkcg_gq
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        mkoutny@suse.com
References: <20230524035150.727407-1-ming.lei@redhat.com>
 <f2c10b18-8d83-91a5-bf22-03894bf3c910@redhat.com>
 <ZG2R+jYuAZMpx49d@ovpn-8-17.pek2.redhat.com>
 <76a863b4-112e-82ae-59e4-6326fff48ffc@redhat.com>
 <bde4174a-ace4-6e2a-6536-855fb18d0890@redhat.com>
 <ZG7CJtN7ATaYZ5Ao@ovpn-8-21.pek2.redhat.com>
 <7ffbb748-46e3-44b2-388d-9199f47dc9a7@redhat.com>
 <CAJD7tkYfwVSNrTibnv5BpyAfbyY0dnK0Cp-HQK_-2nxHmveAxw@mail.gmail.com>
 <9b06dceb-f26d-7faf-460c-ba554a0757ef@redhat.com>
In-Reply-To: <9b06dceb-f26d-7faf-460c-ba554a0757ef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/24/23 23:04, Waiman Long wrote:
>> Hi Waiman,
>>
>> I don't have context about blkcg, but isn't this exactly what
>> cgroup_rstat_lock does? Is it too expensive to just call
>> cgroup_rstat_flush () here?
>
> I have thought about that too. However, in my test, just calling 
> cgroup_rstat_flush() in blkcg_destroy_blkgs() did not prevent dying 
> blkcgs from increasing meaning that there are still some extra 
> references blocking its removal. I haven't figured out exactly why 
> that is the case. There may still be some races that we have not fully 
> understood yet. On the other hand, Ming's patch is verified to not do 
> that since it does not take extra blkg references. So I am leaning on 
> his patch now. I just have to make sure that there is no concurrent 
> rstat update.

It is also true that calling cgroup_rstat_flush() is much more 
expensive, especially at the blkg level where there can be many blkgs to 
be destroyed when a blkcg is destroyed.

Cheers,
Longman

