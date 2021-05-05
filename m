Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783B6C433ED
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 20:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5551B613C9
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 20:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhEEU2r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 May 2021 16:28:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59200 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbhEEU2m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 May 2021 16:28:42 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id CA4824FDDC141;
        Wed,  5 May 2021 13:27:43 -0700 (PDT)
Date:   Wed, 05 May 2021 13:27:39 -0700 (PDT)
Message-Id: <20210505.132739.2022645880622422332.davem@davemloft.net>
To:     u.kleine-koenig@pengutronix.de
Cc:     axboe@kernel.dk, kuba@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, sparclinux@vger.kernel.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] sparc/vio: make remove callback return void
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210505201449.195627-1-u.kleine-koenig@pengutronix.de>
References: <20210505201449.195627-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 05 May 2021 13:27:44 -0700 (PDT)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Wed,  5 May 2021 22:14:49 +0200

> The driver core ignores the return value of struct bus_type::remove()
> because there is only little that can be done. To simplify the quest to
> make this function return void, let struct vio_driver::remove() return
> void, too. All users already unconditionally return 0, this commit makes
> it obvious that returning an error code is a bad idea and should prevent
> that future driver authors consider returning an error code.
> 
> Note there are two nominally different implementations for a vio bus:
> one in arch/sparc/kernel/vio.c and the other in
> arch/powerpc/platforms/pseries/vio.c. This patch only addresses the
> former.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
