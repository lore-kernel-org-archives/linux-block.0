Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4FBC43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 11:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D20320861
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 11:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D20320861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394333AbeKWV74 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:59:56 -0500
Received: from foss.arm.com ([217.140.101.70]:42194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394331AbeKWV74 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 16:59:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F7153620;
        Fri, 23 Nov 2018 03:16:05 -0800 (PST)
Received: from [10.1.29.128] (p8cg001049571a15.cambridge.arm.com [10.1.29.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DB893F5A0;
        Fri, 23 Nov 2018 03:16:00 -0800 (PST)
Subject: Re: [PATCH] mm: Replace all open encodings for NUMA_NO_NODE
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ocfs2-devel@oss.oracle.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-media@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org,
        akpm@linux-foundation.org, jiangqi903@gmail.com, hverkuil@xs4all.nl
References: <1542966856-12619-1-git-send-email-anshuman.khandual@arm.com>
 <d7cb905f-76f7-3053-2a46-e1a514bd309b@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2c0e9cef-663b-553c-e25e-63f7da59ab63@arm.com>
Date:   Fri, 23 Nov 2018 16:46:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d7cb905f-76f7-3053-2a46-e1a514bd309b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

min

On 11/23/2018 04:06 PM, David Hildenbrand wrote:
> On 23.11.18 10:54, Anshuman Khandual wrote:
>> At present there are multiple places where invalid node number is encoded
>> as -1. Even though implicitly understood it is always better to have macros
>> in there. Replace these open encodings for an invalid node number with the
>> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions like
>> 'invalid node' from various places redirecting them to a common definition.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>
>> Changes in V1:
>>
>> - Dropped OCFS2 changes per Joseph
>> - Dropped media/video drivers changes per Hans
>>
>> RFC - https://patchwork.kernel.org/patch/10678035/
>>
>> Build tested this with multiple cross compiler options like alpha, sparc,
>> arm64, x86, powerpc, powerpc64le etc with their default config which might
>> not have compiled tested all driver related changes. I will appreciate
>> folks giving this a test in their respective build environment.
>>
>> All these places for replacement were found by running the following grep
>> patterns on the entire kernel code. Please let me know if this might have
>> missed some instances. This might also have replaced some false positives.
>> I will appreciate suggestions, inputs and review.
>>
>> 1. git grep "nid == -1"
>> 2. git grep "node == -1"
>> 3. git grep "nid = -1"
>> 4. git grep "node = -1"
> 
> Hopefully you found most users :)

I hope so :)

> 
> Did you check if some are encoded into function calls? f(-1, ...)

Not really. Just wondering how do we even search for it. There might be
higher level functions passing down -1 to core MM. If you have some
instances in mind which need replacement I will accommodate them.

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for the review.
