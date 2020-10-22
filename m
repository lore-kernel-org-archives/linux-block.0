Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F893C4363A
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 18:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FC224640
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 18:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="lq05AoxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368945AbgJVSpj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Oct 2020 14:45:39 -0400
Received: from ale.deltatee.com ([204.191.154.188]:48334 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368848AbgJVSpi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Oct 2020 14:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uf6C3j/ocrBTm97iqgRtQoheYZQH4nzs9ZR+u0LyQS0=; b=lq05AoxRq5ysREPtYrPSKtt+zZ
        IiorJvq1mo/HpX8T89V7Nb7wfbLJ9rBkb/cKdr0iPL3Jn+727NrDZeVoUxsYiiz0dVZjydHb4q+/w
        ZtVALKjISZkAdX0RdP4UNqc0tVK/iPwPzNSDv7LwCrL6ANRr05UISlOl3WWm+w+Tlzxx0Gj1j2Sty
        T+/3ZsL7GHq4Bm6o/XdDcgXK+SpoGXvPiKkAEjfI7cvh3u4LyuNDrYfCF5CrYSm7HtMbtjLbvPhGe
        CCZ/nsQ4kzykeOcvlWPsPUj0JAslOxvgXdTVNPJHkpeotI5iLuu2xXy+XuCG5r6BblFAsV1FdrEXv
        6KitHdtQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kVfaa-0002PY-K8; Thu, 22 Oct 2020 12:45:29 -0600
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20201008164024.12546-1-logang@deltatee.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <29f3dc94-50c3-1548-034e-09c5394ef781@deltatee.com>
Date:   Thu, 22 Oct 2020 12:45:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, sagi@grimberg.me, osandov@osandov.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v3 00/11] NVMe Target Passthru Block Tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2020-10-08 10:40 a.m., Logan Gunthorpe wrote:
> Hi,
> 
> This series adds blktests for the nvmet passthru feature that was merged
> for 5.9. It's been reconciled with Sagi's blktest series that Omar
> recently merged.

Bump. This has been around for a while now. Omar, can you please
consider picking this up?

Thanks,

Logan
