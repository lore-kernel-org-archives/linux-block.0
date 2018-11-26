Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3666EC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 18:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DF720817
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 18:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Lw9f4pae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DF720817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeK0E7V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:59:21 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40934 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeK0E7U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 23:59:20 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so29222777ita.5
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 10:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PqTq+H8+rhmPLG6tqGEachvR9RLFaxATqoCV/phnZGQ=;
        b=Lw9f4paennw2Q7ERYGYf13QL1FEe8xX+NxItWg7dT86uTIxE6CA6xqC2DagjtU3aqu
         JtoCrXTbTEym46o184VZvjfSsi0wU0CNg3iX3/UYitIcAo2af000amHmxeLr5hE0rxkT
         qnJ/CBQfVqFuzNNBlde+2rvGFo64GKbOGA9W0HyceNRKniIaXvsKe9u1X4ESusWJantf
         M4qMcRJ95em052Z4P8pghjv/XJgQ0afoEqPrfgwKzIIUXnoidlUf9mgZCKFEzoZPlgOc
         oJ2orvxxl6Qn33jVhfR4FlRRXQUW7fn3pvtRUOInThi1VSI3eBD+7/ublnTh3Ka3fOc2
         2S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PqTq+H8+rhmPLG6tqGEachvR9RLFaxATqoCV/phnZGQ=;
        b=miUUTPgM8kgd/VgMJpCXuuMfZDfTd5fj9tNR7yRle6krFkyJ9e7BLZW0c1qZmH/M0p
         gSUQ0J1yyWNIlKxarfN368wG8IFH19MeHjzuFsnc8DIc23FjM9MjyUmhHVztxyoHl6fv
         hvvbRVFHgQJoPphJmQ+AG3Hta74tAXSfhu3SxRRi4j+Z9F15dqFatxNkvUGfJZHTQWT5
         yMl6rxPaMPxpSPOAsW9Xw5rF113i9yY/ge7hY1PckpR9902vaF+5XLYOl+9SamE1LoUA
         ceoBrLBEEh+bTQahcUuFg3tQChC/YN1bkmae5UFvMOFcYOVA4nulI5ii+8gby81gM7pZ
         ZUkw==
X-Gm-Message-State: AA+aEWY5cpjsq4/PSrOjYTE85qPGDsWhPSHilncUe248gaF0iMQaW03/
        /4yXV+nm58tom92jSixna8ru+w==
X-Google-Smtp-Source: AFSGD/VMh/JR2/LSxaV6pJqJ8CN1srsI4trGfHLzd6kdp2ASaAmV/OX8sKXihw4FfTLaqvPSOOMEcg==
X-Received: by 2002:a02:8cce:: with SMTP id n14mr26118375jal.125.1543255467182;
        Mon, 26 Nov 2018 10:04:27 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r133-v6sm566263itb.17.2018.11.26.10.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 10:04:26 -0800 (PST)
Subject: Re: [Intel-wired-lan] [PATCH V2] mm: Replace all open encodings for
 NUMA_NO_NODE
To:     jeffrey.t.kirsher@intel.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     hverkuil@xs4all.nl, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, vkoul@kernel.org,
        dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
        sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org,
        intel-wired-lan@lists.osuosl.org, linux-alpha@vger.kernel.org,
        dmaengine@vger.kernel.org, jiangqi903@gmail.com,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        ocfs2-devel@oss.oracle.com, linux-media@vger.kernel.org
References: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
 <c1b8de1a8e9d4d215b56498e2d5b83a02083483a.camel@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d0840f2-bd96-e671-8120-56ef33a37816@kernel.dk>
Date:   Mon, 26 Nov 2018 11:04:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c1b8de1a8e9d4d215b56498e2d5b83a02083483a.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/18 10:56 AM, Jeff Kirsher wrote:
> On Mon, 2018-11-26 at 17:56 +0530, Anshuman Khandual wrote:
>> At present there are multiple places where invalid node number is
>> encoded
>> as -1. Even though implicitly understood it is always better to have
>> macros
>> in there. Replace these open encodings for an invalid node number
>> with the
>> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions
>> like
>> 'invalid node' from various places redirecting them to a common
>> definition.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> For the 'ixgbe' driver changes.
> 
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Lost the original, but for mtip32xx:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

