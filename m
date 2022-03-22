Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D4C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 13:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiCVNKP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 09:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiCVNJu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 09:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE2D0E0EF
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647954498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orishQn+wclGjtFFgDbZmXfA/JKSYgw35GI/WKD7gX4=;
        b=UzOpo/pNtgK3kpAXCokeKQI4FREGgT/HEkhi/3372k9+C3fzRhJfezzTahM4ZBi6DBJ1zv
        zVkThattw+CKTX7QPxMJ+x7Q2NIcVAVbGwZqyGpqUhM9Gg0f9EORRUNHspBjpLcH/90IKf
        AcdDL/4hgkmkI0MSWzZy70cqbw0ii0I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-VVmPYBYCP0aa21F1uB4sHQ-1; Tue, 22 Mar 2022 09:08:16 -0400
X-MC-Unique: VVmPYBYCP0aa21F1uB4sHQ-1
Received: by mail-wm1-f72.google.com with SMTP id 9-20020a05600c240900b0038c99b98f6fso896773wmp.0
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 06:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=orishQn+wclGjtFFgDbZmXfA/JKSYgw35GI/WKD7gX4=;
        b=HSaGilrWv0IWGddLcjaSQeUUR0M8lsjXl7yLjLBI/G0ewszLnTjCo3f2PuwyJ0wCGp
         rEeOZMVVbOTDJswu025HZNU/2yRJmcedjKwGWF1RMbBqbfbPEawKj/wQm8Za4KQmwpP0
         0/reZKETCbhleD6yv8Hw0kei5ka79z343I7cDYAKKIVtPAuYFGFCWtVv3p2peYMG9vR2
         6rIQK0VSgR4mHm9koRfHv84hIPGBD8L0bFswjUUDkgL75fRVVuF33GC4X6es3DoZGrH9
         ye7BuLKwJhynfRdTQQeOEAx4DAJthlLaRpW2WCVNAqvgarUWdj42ZWtUGo9Nfeyal+5K
         EM4Q==
X-Gm-Message-State: AOAM530InZAxoetegJPn5cx3wqtVvpzeaM7wq8Zt0P0GhFhffVaV0Xje
        x3mYEqGN84BFNriiKkMGZ8qlNb2O6nuMxV7lowADT1R96hUMAYeaNLnEJ4TD04oj+up67uYFX/b
        rFDJzaIoy1QoTNKt70Kg7NaU=
X-Received: by 2002:a7b:c40f:0:b0:389:f3ad:5166 with SMTP id k15-20020a7bc40f000000b00389f3ad5166mr3672758wmi.63.1647954495394;
        Tue, 22 Mar 2022 06:08:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycVf3WpHFnTxKZZR/Qx73w8NH+ILgxlEa4QnfmD7Tq1gtTbItNDzuVWuN5GFtXq/sjR1/www==
X-Received: by 2002:a7b:c40f:0:b0:389:f3ad:5166 with SMTP id k15-20020a7bc40f000000b00389f3ad5166mr3672723wmi.63.1647954495014;
        Tue, 22 Mar 2022 06:08:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:de00:549e:e4e4:98df:ff72? (p200300cbc708de00549ee4e498dfff72.dip0.t-ipconnect.de. [2003:cb:c708:de00:549e:e4e4:98df:ff72])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b0038caf684679sm2800030wmq.0.2022.03.22.06.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 06:08:14 -0700 (PDT)
Message-ID: <019a2159-57d6-c330-53c5-38458b6b5ec9@redhat.com>
Date:   Tue, 22 Mar 2022 14:08:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC 2/3] mm: export zap_page_range()
Content-Language: en-US
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-mm@kvack.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-block@vger.kernel.org, xuyu@linux.alibaba.com,
        bostroesser@gmail.com
References: <20220318095531.15479-1-xiaoguang.wang@linux.alibaba.com>
 <20220318095531.15479-3-xiaoguang.wang@linux.alibaba.com>
 <a37e9ba2-354b-0b75-cb05-bc730cb30151@redhat.com>
 <37d6b269-dd9d-dbd1-74b1-4191cc3d4bf9@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <37d6b269-dd9d-dbd1-74b1-4191cc3d4bf9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22.03.22 14:02, Xiaoguang Wang wrote:
> hi,
> 
>> On 18.03.22 10:55, Xiaoguang Wang wrote:
>>> Module target_core_user will use it to implement zero copy feature.
>>>
>>> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
>>> ---
>>>   mm/memory.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 1f745e4d11c2..9974d0406dad 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -1664,6 +1664,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
>>>   	mmu_notifier_invalidate_range_end(&range);
>>>   	tlb_finish_mmu(&tlb);
>>>   }
>>> +EXPORT_SYMBOL_GPL(zap_page_range);
>>>   
>>>   /**
>>>    * zap_page_range_single - remove user pages in a given range
>> To which VMAs will you be applying zap_page_range? I assume only to some
>> special ones where you previously vm_insert_page(s)_mkspecial'ed pages,
>> not to some otherwise random VMAs, correct?
> Yes, you're right :)

I'd suggest exposing a dedicated function that performs sanity checks on
the vma (VM_PFNMAP ?) and only zaps within a single VMA.

Essentially zap_page_range_single(), excluding "struct zap_details
*details" and including sanity checks.

Reason is that we don't want anybody to blindly zap_page_range() within
random VMAs from a kernel module.

-- 
Thanks,

David / dhildenb

