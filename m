Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f46.google.com ([209.85.160.46]:33930 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbeCEWE1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Mar 2018 17:04:27 -0500
Received: by mail-pl0-f46.google.com with SMTP id u13-v6so10558672plq.1
        for <linux-block@vger.kernel.org>; Mon, 05 Mar 2018 14:04:27 -0800 (PST)
Subject: Re: Some bcache patches need reveiw
To: tang.junhui@zte.com.cn
Cc: colyli@suse.de, linux-block@vger.kernel.org,
        linux-bcache@vger.kernel.org
References: <1520246366-8273-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <904db67c-0090-8ddb-f2fc-07cbccc00969@lyle.org>
Date: Mon, 5 Mar 2018 14:04:25 -0800
MIME-Version: 1.0
In-Reply-To: <1520246366-8273-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey Tang Junhui--

You're right.  I'm sorry, these had slipped through the cracks / I had
lost track of them.  I also have the rest of Coly's patchset to work
through.  I was able to apply the first two, and will continue to work
on my for-next branch.

Mike


On 03/05/2018 02:39 AM, tang.junhui@zte.com.cn wrote:
> Hello Mike
> 
> I send some patches some times before, with no response,
> 
> Bellow patches are very simple, can you or anybody else have a review?
> [PATCH] bcache: fix incorrect sysfs output value of strip size
> [PATCH] bcache: fix error return value in memory shrink
> [PATCH] bcache: fix error count in memory shrink
> 
> Bellow patches are simple too, and important for me and also important for bcache,
> can you or anybody else have a review?
> [PATCH] bcache: finish incremental GC
> [PATCH] bcache: calculate the number of incremental GC nodes according to the total of btree nodes
> 
> Thanks,
> Tang Junhui
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
