Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D89FC001DB
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 12:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjHJMe3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 08:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjHJMe3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 08:34:29 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12102127;
        Thu, 10 Aug 2023 05:34:27 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 64441835E6;
        Thu, 10 Aug 2023 08:34:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691670866; bh=ML5SfmwASQtjse17hbDn1da7PJSyvKnyAEKSbGudQo8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VarItYdfyHrAg0AulNW3EJhm+Hahz+QX22Dm5In5TYAqRJast60YH86Qh0HnB9Sj6
         QRt5mcE0FbTVdlSUx2oMHhoYvkhlExTUafJ+XQkoYWPMnvx4sHw3DJyoklx1IPPy80
         xVLAwIGCnG08QGusAYHefrNYVVA3VdbIIGctH4GC59a6wYvqibegG9JSEsgbVdJC6x
         xkFf6Ips0wHGzPjQPHCGiss929LAV+Zd1/Uu9iXdQ8/znPYgZzqMLMweLGZhzuYPKi
         EGrJjPQMGk9tSXFXIVo86qSDAh6OyP6LpgU3FnrzjIu45yYDSG/R4vBuFzA4PWZwfK
         gFKxcjACDUbuw==
Message-ID: <1455689d-8266-66e0-2ba4-354c3a4225b5@dorminy.me>
Date:   Thu, 10 Aug 2023 08:34:23 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2] blk-crypto: dynamically allocate fallback profile
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        ebiggers@kernel.org
Cc:     stable@vger.kernel.org
References: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
 <bdc3956a-9ba9-3268-b822-7ea337c0e9b9@acm.org>
Content-Language: en-US
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <bdc3956a-9ba9-3268-b822-7ea337c0e9b9@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/9/23 17:57, Bart Van Assche wrote:
> On 8/9/23 05:56, Sweet Tea Dorminy wrote:
>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> Signed-off-by should be followed by a real name. Sweet Tea doesn't look
> like a real name to me.

I do go by Sweet Tea in real life as well as online.

And the DCO changed to say 'known identity' instead of 'real name' in 
6.3: 
https://github.com/torvalds/linux/commit/d4563201f33a022fc0353033d9dfeb1606a88330. 


