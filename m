Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05957C43461
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 22:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF39206F4
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 22:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="KIuJSg9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgINWFI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 18:05:08 -0400
Received: from ale.deltatee.com ([204.191.154.188]:52634 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgINWFH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 18:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nG4K6Yxte9vWheiAlxDvydlqMsGpoYQ7ibzsTTQ7UrE=; b=KIuJSg9jyNmlMer9aghx7fzWe5
        X7sAt+smjQgvwh6biLcuhaLTLL0Hp5jl7RqaBUYGF8GRz6BzHjuaV0sNAfLQoFObqNsZRiAuTZ3IQ
        939vlFejI1Km1v2i1Mhigao0YVTxaxocKfBp2iQuvavP6nN0c0x6MXwCA7gE9Fz/j0VTGLKl2pORv
        OCgatXrXv12trs1zM61o9PPpKhGgXcFxTfMJY235wk9osu+9rnzNJHQdqyJne69hheHAeVRkG1555
        SEU9eLps8X09TM3kuNEuu8zl8x7LjDBzp2Ce5SXoeGnzNnDKBQmxCdr3szTjrRZIBZPVR1n/ADXur
        zXgFlc+Q==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kHwar-0005rI-I3; Mon, 14 Sep 2020 16:05:02 -0600
To:     Omar Sandoval <osandov@osandov.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-2-sagi@grimberg.me>
 <20200914215145.GA148663@relinquished.localdomain>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1c502865-5ac1-9952-1b79-fef0f61749c6@deltatee.com>
Date:   Mon, 14 Sep 2020 16:04:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914215145.GA148663@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me, osandov@osandov.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-09-14 3:51 p.m., Omar Sandoval wrote:
>> diff --git a/tests/nvme/002 b/tests/nvme/002
>> index 07b7fdae2d39..aaa5ec4d729a 100755
>> --- a/tests/nvme/002
>> +++ b/tests/nvme/002
>> @@ -10,7 +10,8 @@
>>  DESCRIPTION="create many subsystems and test discovery"
>>  
>>  requires() {
>> -	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
>> +	_nvme_requires
>> +	_have_modules loop
> 
> Bash functions return the status of the last executed command, and the
> requires function needs to return 0 on success and 1 on failure. So,
> this is losing the return value of _nvme_requires. Just chain multiple
> checks with && to fix this (here and the other places _nvme_requires was
> added with other checks):
> 
> requires() {
> 	_nvme_requires && _have_modules loop
> }

I noticed this too during my review, but based on my read of the current
blktest code, the return value of the requires() function is not
actually used. It seems to only check if SKIP_REASON is set.

If we want to ensure the return value of requires() is correct, perhaps
we should check it after we call it and then consult SKIP_REASON? And
WARN or fail if SKIP_REASON is set when requires() didn't return 1.

Also, we need to do more than adding &&s... _nvme_requires() will need
to be fixed up as it calls other _have_x() functions and ignores their
return value.

Logan
