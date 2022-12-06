Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE070C352A1
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 09:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiLFJZY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 04:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbiLFJY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 04:24:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D3321258
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 01:24:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DA7DB818D1
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 09:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C09DC433C1;
        Tue,  6 Dec 2022 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670318645;
        bh=mrhO9lVzNGoEQzqlqO7y05wP7Evj3elr2Lt/jWcD8JQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iS4zfwJIQRe8HrqPM8M3+gKso2RI5TuSIP3bufTXrlxvr44dovWch/gTwfne8siPo
         6umpnzPu4tmqqZs4e6q0KBjCPQMNc/elFzBEugkZMQ7RPLcQhiXIk7QLJt11O9sWYQ
         80lxa4C2u5qYWJ+DNN5zj46wWP7m1/IPlgzLmk67Ldb6b/rSuNFZafNJGtq/BdFDeE
         u/yjlj9tGKRde2h+58oqKOgWnm9HcsZbh5r9RSuxlelobFTGjEvisT/TOZdytuKn5+
         6FAiBKpd/FrR2NfWOtbZqjLU1xGrr0GkWnRPZO7kgTh9XEM0pFLYVsb8FwZ16abIp8
         KYC0piIZ+NStA==
Date:   Tue, 6 Dec 2022 10:23:59 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     luca.boccassi@gmail.com
Cc:     linux-block@vger.kernel.org, jonathan.derrick@linux.dev,
        gmazyland@gmail.com, axboe@kernel.dk, stepan.horacek@gmail.com,
        hch@infradead.org
Subject: Re: [PATCH v3] sed-opal: allow using IOC_OPAL_SAVE for locking too
Message-ID: <20221206092359.2coih5e4rr4hk3d4@wittgenstein>
References: <20221202003610.100024-1-luca.boccassi@gmail.com>
 <20221206000346.7465-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221206000346.7465-1-luca.boccassi@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 06, 2022 at 12:03:46AM +0000, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> Usually when closing a crypto device (eg: dm-crypt with LUKS) the
> volume key is not required, as it requires root privileges anyway, and
> root can deny access to a disk in many ways regardless. Requiring the
> volume key to lock the device is a peculiarity of the OPAL
> specification.
> 
> Given we might already have saved the key if the user requested it via
> the 'IOC_OPAL_SAVE' ioctl, we can use that key to lock the device if no
> key was provided here and the locking range matches, and the user sets
> the appropriate flag with 'IOC_OPAL_SAVE'. This allows integrating OPAL
> with tools and libraries that are used to the common behaviour and do
> not ask for the volume key when closing a device.
> 
> Callers can always pass a non-zero key and it will be used regardless,
> as before.
> 
> Suggested-by: Štěpán Horáček <stepan.horacek@gmail.com>
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
