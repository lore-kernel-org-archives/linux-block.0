Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25EC4332F
	for <linux-block@archiver.kernel.org>; Mon,  6 Nov 2023 20:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjKFUUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Nov 2023 15:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjKFUUi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Nov 2023 15:20:38 -0500
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ADB10D4
        for <linux-block@vger.kernel.org>; Mon,  6 Nov 2023 12:20:33 -0800 (PST)
Message-ID: <b6f134e7-cc2f-49f2-8c52-8ff0bacc3941@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699302032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Czz03c7B8Ipf+ig640Okg2kezVH+J+rO2vcFaPEA8SI=;
        b=DUfW9aQoAa6yKtr/cSFLVHgtZXmLbklWuRO7WXE/j1JrkjsJsNMrdL9JM/X5hyc4CvQVgc
        VKZrg1bf4JGwU5MYJfFY67bBfbpXqWaEufPekT2By+ItH2VeISDVk4PeVAUU4p0qQYS3j1
        s7fWM2zNpy7lyxKrwsA0maqUNITNcR8=
Date:   Mon, 6 Nov 2023 23:20:30 +0300
MIME-Version: 1.0
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: question about ZRAM_HUGE flag
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ZRAM_HUGE flag doubles most significant bit in zram size.
I had an idea to redefine it, but do not fully understand how to do it correctly.
I'm sure that MSB = PAGE_SHIFT on BIG_ENDIAN but do not understand what's happen on LITTLE_ENDIAN?
Is MSB = 0 in this case? Could it have some other unpredictable value?
In any case I think we can always replace ZRAM_HUGE bit check by BIT(PAGE_SHIFT) test.

Thank you,
	Vasily Averin
