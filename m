Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD89EB64DD
	for <linux-block@archiver.kernel.org>; Thu,  6 Jul 2023 07:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjGFHXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 03:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjGFHXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 03:23:49 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A51DA;
        Thu,  6 Jul 2023 00:23:48 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 88C1D7315BC;
        Thu,  6 Jul 2023 09:23:42 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, stable@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check patch
Date:   Thu, 06 Jul 2023 09:23:38 +0200
Message-ID: <5702311.DvuYhMxLoT@lichtvoll.de>
In-Reply-To: <e15fb0c5-d9d2-454d-9741-32dd9bae58b8@gmail.com>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <c9bcd3ca-8260-3f29-26d1-0c00e2b098a3@kernel.dk>
 <e15fb0c5-d9d2-454d-9741-32dd9bae58b8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Michael Schmitz - 06.07.23, 01:54:49 CEST:
> Let's hope this is it for Amiga partition handling!
> 
> I should certainly hope so!

Yeah, really. For good.

Thank you, Michael and Jens!

-- 
Martin


