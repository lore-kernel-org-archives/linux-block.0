Return-Path: <SRS0=jKGj=DT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C43C433DF
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 16:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E69B2080A
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 16:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r0J6Sx/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390541AbgJLQse (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Oct 2020 12:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbgJLQse (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Oct 2020 12:48:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA88C0613D0;
        Mon, 12 Oct 2020 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=c0qiq02WC8RL85uMcCI6g0IMZwRK/aQydvv8iai/B5g=; b=r0J6Sx/ynRaXiPD0rYgQZ/hVCO
        GsnX4CJ0amAf2sl19r1hkWbhzOC3Z7pF30zh/Wd23g92NllTpznPd51aqxABPJkK/V38O2aiW2/xK
        SpYuWOGWWMBoDtSSETNdRBCxov5raZFBJ6C9bg80JwlMQHFTmPGImdhxSet8v11X2Q3LFvccMih91
        jUY+UIDyZ3qM2au5/XCe3X4PvtopButc40ce9Ipfuv821LDZ3D+Y4azfFie0TyCXDIdk9tSFbg1rL
        zoLUkkWHgRvcW377XhlrGhYnxiXMxvTpuMe6aONVwutJ0KeRYQmStI0EigcAQ9KJ15qzBDT/xPSKm
        iTxlqv7w==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kS0zt-0005Ce-38; Mon, 12 Oct 2020 16:48:30 +0000
Subject: Re: [PATCH v2 01/22] mpool: add utility routines and ioctl
 definitions
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Nabeel M Mohamed <nmeeramohide@micron.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Cc:     smoyer@micron.com, gbecker@micron.com, plabat@micron.com,
        jgroves@micron.com
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201012162736.65241-2-nmeeramohide@micron.com>
 <954153c4-ee2f-2a2f-8643-8ff67d8cd649@infradead.org>
Message-ID: <bcc66e64-a19a-cb40-34cd-e71fa983b861@infradead.org>
Date:   Mon, 12 Oct 2020 09:48:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <954153c4-ee2f-2a2f-8643-8ff67d8cd649@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/20 9:45 AM, Randy Dunlap wrote:
> On 10/12/20 9:27 AM, Nabeel M Mohamed wrote:
>> +#define MPIOC_MAGIC             ('2')
> 
> Hi,
> 
> That value should be documented in
> Documentation/userspace-api/ioctl/ioctl-number.rst.


Sorry, I see it now.

thanks.

-- 
~Randy

