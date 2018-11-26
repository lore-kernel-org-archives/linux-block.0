Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C15C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 14:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187CF20817
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 14:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187CF20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeK0A5A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:57:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38200 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeK0A47 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 19:56:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E5611DCB;
        Mon, 26 Nov 2018 06:02:46 -0800 (PST)
Received: from [10.1.196.73] (unknown [10.1.196.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F5613F5A0;
        Mon, 26 Nov 2018 06:02:42 -0800 (PST)
Subject: Re: [PATCH V2] mm: Replace all open encodings for NUMA_NO_NODE
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ocfs2-devel@oss.oracle.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-media@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org,
        akpm@linux-foundation.org, jiangqi903@gmail.com,
        hverkuil@xs4all.nl, vkoul@kernel.org
References: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
 <bcf609de-c60a-d6ad-7acb-6c59c412adbc@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <20049f8a-b68f-8af2-c4c7-9410781f37fa@arm.com>
Date:   Mon, 26 Nov 2018 19:32:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bcf609de-c60a-d6ad-7acb-6c59c412adbc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/26/2018 06:18 PM, David Hildenbrand wrote:
> On 26.11.18 13:26, Anshuman Khandual wrote:
>> At present there are multiple places where invalid node number is encoded
>> as -1. Even though implicitly understood it is always better to have macros
>> in there. Replace these open encodings for an invalid node number with the
>> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions like
>> 'invalid node' from various places redirecting them to a common definition.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V2:
>>
>> - Added inclusion of 'numa.h' header at various places per Andrew
>> - Updated 'dev_to_node' to use NUMA_NO_NODE instead per Vinod
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks David. My bad, forgot to add your review tag from the earlier version.
