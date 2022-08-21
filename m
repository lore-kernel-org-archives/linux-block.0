Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51614C32789
	for <linux-block@archiver.kernel.org>; Sun, 21 Aug 2022 20:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiHUU7k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Aug 2022 16:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiHUU7j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Aug 2022 16:59:39 -0400
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D39E20BF5;
        Sun, 21 Aug 2022 13:59:38 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 7B2214C45AF;
        Sun, 21 Aug 2022 22:59:34 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition support
Date:   Sun, 21 Aug 2022 22:59:32 +0200
Message-ID: <2669426.mvXUDI8C0e@lichtvoll.de>
In-Reply-To: <0bf2e4f9-a1c1-3847-a2b5-d9b9eaaa783a@gmail.com>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com> <71d9f2fe-42d1-2a09-a860-702b42a3a733@kernel.dk> <0bf2e4f9-a1c1-3847-a2b5-d9b9eaaa783a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Michael Schmitz - 26.07.22, 05:58:40 CEST:
> Am 26.07.2022 um 15:40 schrieb Jens Axboe:
> > On 7/25/22 7:53 PM, Michael Schmitz wrote:
> >> Hi Jens,
> >> 
> >> there's been quite a bit of review on this patch series back in the
> >> day (most of that would have been on linux-m68k IIRC; see Geert's
> >> Reviewed-By tag), and I addressed the issues raised but as you say,
> >> it did never get merged.
> >> 
> >> I've found a copy of the linux-block repo that has these patches,
> >> will see if I can get them updated to apply to current
> >> linux-block.> 
> > Thanks, please do resend them and we can get them applied.
> 
> Will do - running final compile tests.

Just reminding. Did this go in meanwhile?

Thanks,
-- 
Martin


