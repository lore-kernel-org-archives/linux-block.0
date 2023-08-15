Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA21C41513
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 12:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbjHOMlw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Aug 2023 08:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbjHOMlq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 08:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8582DEE
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 05:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2187F61355
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 12:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3D5C433C7;
        Tue, 15 Aug 2023 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692103304;
        bh=cN1NrmlLfhNXoiItjJFkdiIm61IFr8pMIbIeul1KnTw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=KoPwo1tOMjPngPfIkZGiN/nJj7JrCftIbnDxbfKRnJ/KoMq9tsvwiNumpbW7xp2pA
         cZZwx++3MtfZdlDtG8OSArcyemqjK+3wVU7QtGCRP70gor/dErm9luRblw937XhDiw
         1tVZQxZK/fGysBd8/WskYRD6BPo9/6znD14vDKGEY2+D5ngRCQzzWUCAA+6V8RMMBx
         L2ZkxTYv1ao6evcaOgCCX/aODP6LJiPiMiIpNn5CthZuMgTURnHRJ+JiX0RXuGlxtp
         TqR5gM6CcfdvQD2uJxyZ+gvBXmhtO2svwDca4ZKIgiuzB4n2+UP325enEpsrVSRq6z
         njbSuHZVBJF1A==
Message-ID: <2d1bc374-cb98-8986-75b3-230d1ac580f9@kernel.org>
Date:   Tue, 15 Aug 2023 21:41:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/5] block: switch ldm partition code to use pr_xxx()
 functions
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-6-dlemoal@kernel.org>
 <790b86db-da57-4997-86f4-98796bcca8b1@wdc.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <790b86db-da57-4997-86f4-98796bcca8b1@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/15/23 19:06, Johannes Thumshirn wrote:
> On 08.08.23 19:56, Damien Le Moal wrote:
>> +#define ldm_debug(f, a...) pr_debug("%s(): " f, __func__, ##a) +#define 
>> ldm_crit(f, a...) pr_crit("%s(): " f, __func__, ##a) +#define 
>> ldm_error(f, a...) pr_err("%s(): " f, __func__, ##a) +#define 
>> ldm_info(f, a...) pr_info("%s(): " f, __func__, ##a)
> 
> Is there any value in keeping these ldm_XXX() macros around, other than 
> printing the function name?

You named it: I didn't want to change the messages.
I do not mind simplifying these by removing the function name, but if we do not,
then the macros actually simplify the print calls.

> 
> I'd just get rid of them as well and replace with the according pr_XXX() 
> calls.

-- 
Damien Le Moal
Western Digital Research

