Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75789C4332F
	for <linux-block@archiver.kernel.org>; Mon,  6 Nov 2023 20:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjKFUDy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Nov 2023 15:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjKFUDv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Nov 2023 15:03:51 -0500
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C61D6F
        for <linux-block@vger.kernel.org>; Mon,  6 Nov 2023 12:03:48 -0800 (PST)
Message-ID: <f30438ab-01e4-4847-a72d-5a4107d7ba46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hKWfuOa3Q0szrCKnsOau3qz4CjBKZPrK1uXh9qY6QbE=;
        b=ggrMO68Hc3yQhQ3zVNjiJqUqKRXuOGWP3Q2Tqlpk8/bJrZwMlYl6hCK2QhmMsQ8+Z9SLwx
        HlUdzCtuJildD3g4yc+AY/9PZVZdr1KudBaxlhgtPl3Lc58pwUvOmmMM6ypFTNG/p8EQ6i
        WkWEfOgIbWGdpiRUaCuH8kCD4caSA/8=
Date:   Mon, 6 Nov 2023 23:03:44 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] zram: extra zram_get_element call in
 zram_read_from_zspool()
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
In-Reply-To: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/23 22:55, Vasily Averin wrote:
> 'element' and 'handle' are union in struct zram_table_entry.

struct zram_table_entry {
        union {
                unsigned long handle;
                unsigned long element;
        };

I do not understand the sense of this union.
From my POV it just makes it harder to check the code because an reviewer doesn't
expect that the zram element can't be used together.
Can I remove this union at all and replace zram_get/set_element calls by zram_get/set_handle instead?

Thank you,
	Vasily Averin
