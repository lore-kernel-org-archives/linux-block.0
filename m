Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5592C433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Jul 2022 14:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiGQOlB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Jul 2022 10:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQOlB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Jul 2022 10:41:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A28FE2;
        Sun, 17 Jul 2022 07:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C3B6611C1;
        Sun, 17 Jul 2022 14:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596DDC3411E;
        Sun, 17 Jul 2022 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658068858;
        bh=dqhyP+8gKpip9W8T3rXRIi1I/ss8fh95OtlNLlnaZOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mN6oaNqhJWZfiZHBqD5gPoE3RISEwnyksTaYtzQvKEGC9o1D4c0fTEGQSP/CbJTt9
         7CvXq2Y39OdCVUrsFN5bhbwJHFj74kQbeyv7aLv2z6/elFyezFX+xGyxrr2OeQx6nD
         prM0jzrtrcYPM68TjQ3W5EfPd2aCRsPAA0JweMuMS1zUwaw7VD0CMAzUDO3ctpfG8X
         ZZSFh9WBIEcnT267y+VocMWIl4tXRMEE1PX3ulIgG5igqqo8xyPuc2okxWTEDyG7xP
         NtQ177S5/xF9YEVxTmt4OJIVVrFvAdnEXnnKk930+ROLeilLustkCR/AHa2uyitk8b
         zqWw0rgITsQVA==
Date:   Sun, 17 Jul 2022 08:40:56 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: WARNING in loop_add
Message-ID: <YtQfePz3+zeRDfMg@kbusch-mbp>
References: <CAO4mrfc=oS37CJtvPt+dWm-24mkV-5XRTGNZDr5ZopAE7pY3WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO4mrfc=oS37CJtvPt+dWm-24mkV-5XRTGNZDr5ZopAE7pY3WQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 17, 2022 at 10:06:16PM +0800, Wei Chen wrote:
> Recently when using our tool to fuzz kernel, the following crash was triggered:
> 
> HEAD commit: 64570fbc14f8 Linux 5.15-rc5

That's an unusual commit to be testing today. Why are you using such an old
release candidate?
