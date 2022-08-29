Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F91AECAAA2
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 01:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiH2BZW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Aug 2022 21:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiH2BZV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Aug 2022 21:25:21 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DC6248FA;
        Sun, 28 Aug 2022 18:25:19 -0700 (PDT)
Subject: Re: WARNING in md_alloc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661736317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1xzT3UoMLLybwcCIK6qdwfJjzYJVmGxruZr5ZqdtTM=;
        b=MWdfd/e4VSJgjM2zcfeRNT5fvPiNIaPaOT00PLiyDxWeFI2Uv/G3uGHRZ7zwoY/3/haLxO
        mJfUlvGuHfy9OWBWj40qLSsYkPdM4WE90npo9fkqXskQqyXSPwQZLIzwdCfvAuWMLzMwH/
        OI46ucKraIM6aRQoopvSB0DRD8NwnGM=
To:     Jiacheng Xu <578001344xu@gmail.com>, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, martin.petersen@oracle.com, mcgrof@kernel.org
Cc:     linux-block@vger.kernel.org
References: <CAO4S-meHv6Z-Wr1ZLz6j=i7fWkhPijv0CxE5JOFDWJOFH=C_3w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <6b49d53c-15ba-51e4-56fc-446276f6a82f@linux.dev>
Date:   Mon, 29 Aug 2022 09:25:07 +0800
MIME-Version: 1.0
In-Reply-To: <CAO4S-meHv6Z-Wr1ZLz6j=i7fWkhPijv0CxE5JOFDWJOFH=C_3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 8/28/22 10:34 PM, Jiacheng Xu wrote:
> Hello,
>
> When using modified Syzkaller to fuzz the Linux kernel-5.15.58, the
> following crash was triggered.
>
> HEAD commit: 568035b01cfb Linux-5.15.58

Pls try with a recently kernel such as 5.19 or 6.0-rc3.

Thanks,
Guoqing
