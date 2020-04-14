Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B4AC352BE
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F1A20787
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 21:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GwNkoQjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633755AbgDNVSs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:18:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39766 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633733AbgDNVSr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 17:18:47 -0400
Received: from [10.137.106.115] (unknown [131.107.174.243])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3E91D20B4737;
        Tue, 14 Apr 2020 14:18:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E91D20B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586899126;
        bh=8vd2NllO885QphfJq499exMBBONhyoMLoUuWkoB9kMM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GwNkoQjLBGfCuuREHe/03lAwC66jZGflscriy+ucC2VLYeU1H2gwGfnbtARtIw/Bv
         4DplFt0PBFLVA7BsFj6OcZIZHvCpm7RJoNrRJgrPikIOOWGzRv+KAeHNeUITy1lxxp
         3F7GXI1j8U26y2fFZxmIuTVq/Npy+xZPthhmAfPo=
Subject: Re: [RFC PATCH v2 11/12] documentation: Add IPE Documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com, linux-kernel@vger.kernel.org
References: <20200406221439.1469862-1-deven.desai@linux.microsoft.com>
 <20200406221439.1469862-12-deven.desai@linux.microsoft.com>
 <20200414093809.2c6ef93b@lwn.net>
From:   Deven Bowers <deven.desai@linux.microsoft.com>
Message-ID: <9c55bbe9-2c6e-7a0d-cf90-5b2aee724f19@linux.microsoft.com>
Date:   Tue, 14 Apr 2020 14:18:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414093809.2c6ef93b@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/14/2020 8:38 AM, Jonathan Corbet wrote:
> On Mon,  6 Apr 2020 15:14:38 -0700
> deven.desai@linux.microsoft.com wrote:
>
>> From: Deven Bowers <deven.desai@linux.microsoft.com>
>>
>> Add IPE's documentation to the kernel tree.
>>
>> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Thanks for including this nice documentation from the outset!  I have a
> couple of tiny nits to pick, but nothing really substantive to complain
> about, so:
>
>    Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks!

> [...]
>
>> +IPE is a Linux Security Module, which allows for a configurable policy
> I'd drop the comma (I told you these were nits!)

Got it, thanks!

>
> [...]
>
>> +IPE Policy
>> +~~~~~~~~~~
>> +
>> +IPE policy is designed to be both forward compatible and backwards
>> +compatible. There is one required line, at the top of the policy,
>> +indicating the policy name, and the policy version, for instance:
>> +
>> +::
>> +
>> +   policy_name="Ex Policy" policy_version=0.0.0
> This pattern can be compressed a bit by just putting the "::" at the end of
> the last line of text:
>
> 	indicating the policy name, and the policy version, for instance::
>
> 	   policy_name="Ex Policy" policy_version=0.0.0
>
> The result is a bit more readable in the plain-text format, IMO, and
> renders exactly the same in Sphinx.

Awesome. I'll address this feedback in v3.
