Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399BAC001DB
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 12:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjHJMjR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 08:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjHJMjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 08:39:16 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ED410C7;
        Thu, 10 Aug 2023 05:39:16 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id C4A8D80254;
        Thu, 10 Aug 2023 08:39:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691671156; bh=n7aR0zqyygkmVHTZcDKNlHWMZC0NCU/kngYcQqc4qVM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gk44zgKbZL5ak+RhsrmUJkYw4LWVmgNZveSNacU7llWaNcSS7eCYSA6a6PhoH9XyZ
         HqsUQj13KbMKnFg2l2HKBMtIpZO3WpbAm7F/D66FTtAmX2GpkbJbqijSuN2yf32hK8
         YR+2/H4dXmBYtnvBC11VoV2okvIeub6MtxLdy6OBWGVRN/dPnZg2URVbUg2Ab3xmEw
         87agLMjveeVZtxf9dywcYhigcFzEeRLQQRlewMBJo7o0DxPVh0MaEa61a0lR19Xojc
         wporJHTraPIC5aTn2mio2CtJ1GdQIbo2ZFSAGExfbNknc0HZ7lcAIJA3/AoBDGPAN4
         GYHJ7w6yYu1cQ==
Message-ID: <f3ab3d6b-23f9-dbe0-446d-597defb46296@dorminy.me>
Date:   Thu, 10 Aug 2023 08:39:15 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2] blk-crypto: dynamically allocate fallback profile
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        stable@vger.kernel.org
References: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
 <20230810045907.GB923@sol.localdomain>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20230810045907.GB923@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/10/23 00:59, Eric Biggers wrote:
> On Wed, Aug 09, 2023 at 08:56:22AM -0400, Sweet Tea Dorminy wrote:
>>   
>> +	blk_crypto_fallback_profile =
>> +		kzalloc(sizeof(*blk_crypto_fallback_profile), GFP_KERNEL);
>> +
> 
> I think you missed part of my feedback on v1.
> 
> - Eric

You're absolutely right, I completely missed that there were code 
changes. I'll fixup and resend.
