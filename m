Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34033C47423
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 00:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17E920756
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 00:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HKVw5IB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgI3ANl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 20:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgI3ANl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 20:13:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BE7C061755;
        Tue, 29 Sep 2020 17:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=TahisG6kUDutXipbSb0V03+wLD+q13trx54ypaJdagw=; b=HKVw5IB0hKYct1Uuw5lklIVCpV
        xIZbt6VpLzXCuKp7AVdtX3indQiObrAjXZK2OA8P24B1NiVEZW/A/CW8G4xmiCSFCIEycEXrpEouN
        GS+AB1Cvtoj7VsWfmOjT+KRdFl+s3HxVZIg3Ny93a9/ZezVvUVePIQz6ShtlqxRWhw9HdQHTCxaHC
        WnUrWMAuzc91jJ+MwsUgE48yut+uFo9chQM+Kt4w8H4qaQaPyWn1RHEoamyd/j3qtSaqgvukDYnr1
        vZDU2UeFKGWnuXF3hFi3G7/P6Bxhpyj558Ww/GKzSFZ1GQUuoh+irzDyWYnFTf5XArKfOGcgvQ0nF
        KKG3rqIw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNPkS-0000MO-Un; Wed, 30 Sep 2020 00:13:33 +0000
Subject: Re: [PATCH 17/22] mpool: add mpool lifecycle management ioctls
To:     nmeeramohide@micron.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org
Cc:     smoyer@micron.com, gbecker@micron.com, plabat@micron.com,
        jgroves@micron.com
References: <20200928164534.48203-1-nmeeramohide@micron.com>
 <20200928164534.48203-18-nmeeramohide@micron.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <43f24e68-2625-36ce-1727-fcf981955b17@infradead.org>
Date:   Tue, 29 Sep 2020 17:13:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928164534.48203-18-nmeeramohide@micron.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/20 9:45 AM, nmeeramohide@micron.com wrote:
> +	if (_IOC_TYPE(cmd) != MPIOC_MAGIC)
Hi,

MPIOC_MAGIC is defined in patch 01/22.
It should also be added to Documentation/userspace-api/ioctl/ioctl-number.rst.


thanks.
-- 
~Randy

