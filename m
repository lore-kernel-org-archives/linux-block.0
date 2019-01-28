Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ACBC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 08:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7FC20881
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 08:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="EU2vATTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfA1I1W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:27:22 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:44494 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1I1W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 03:27:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 49348A2348;
        Mon, 28 Jan 2019 09:27:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1548664038; i=@fjfi.cvut.cz;
        bh=Dn5qZfS5ktpFlozSnl1kn07sZK1+BZhHUiDw5tDPuZ4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=EU2vATTUpUUMq7w0Y7CdFtbIrEAEwgVP2aknvoS7Ri3hKE1yDvJgIDYLveY8ZK5qF
         pOvumEheqbetW4kdd/d1qKoF2LhWZOY+kP8Ti13WZf2tR+dZAcXc9NLf4o7F+ZviKJ
         lEAlvoTKQvXlGRRHlOi+UlViGVH4gfLHbZZZ93GI=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id eIsUu8Rv_3f8; Mon, 28 Jan 2019 09:27:07 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 1D09DA2481;
        Mon, 28 Jan 2019 09:27:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 1D09DA2481
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 9674D6004E; Mon, 28 Jan 2019 09:27:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 833C06004D;
        Mon, 28 Jan 2019 09:27:05 +0100 (CET)
Date:   Mon, 28 Jan 2019 09:27:05 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Scott Bauer <sbauer@plzdonthack.me>
cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v3 00/16] block: sed-opal: support shadow MBR done flag
 and write
In-Reply-To: <20190127211449.GP21149@hacktheplanet>
Message-ID: <alpine.LRH.2.21.1901280924090.12735@linux.fjfi.cvut.cz>
References: <1548196307-12987-1-git-send-email-zub@linux.fjfi.cvut.cz> <20190127211449.GP21149@hacktheplanet>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 27 Jan 2019, Scott Bauer wrote:

> On Tue, Jan 22, 2019 at 11:31:31PM +0100, David Kozub wrote:
>> David Kozub (8):
>>   block: sed-opal: fix typos and formatting
>>   block: sed-opal: close parameter list in cmd_finalize
>>   block: sed-opal: unify cmd start
>>   block: sed-opal: unify error handling of responses
>>   block: sed-opal: reuse response_get_token to decrease code duplication
>>   block: sed-opal: pass steps via argument rather than via opal_dev
>>   block: sed-opal: don't repeat opal_discovery0 in each steps array
>>   block: sed-opal: rename next to execute_steps
>>
>
> You forgot to send 16/16 again in v3. I pulled and tested off your github page.
> If you send a v4 or just resend that patch you can add my reviewed-by, as I reviewed it
> on my tree/from your github.

Hi Scott. Thank you for the review.

W.r.t. the 16th patch: I think I sent it, after all I also see it in 
lore.kernel.org:

https://lore.kernel.org/lkml/1548196307-12987-17-git-send-email-zub@linux.fjfi.cvut.cz/

Anyway, if the best way forward is to send v4, I'll do it.

Best regards,
David
