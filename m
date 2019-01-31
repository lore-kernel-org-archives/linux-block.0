Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D30C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 23:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF63E2086C
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 23:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfAaXbX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:31:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37477 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfAaXbW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 18:31:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so2213980pfb.4;
        Thu, 31 Jan 2019 15:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izOyogts5LGS7lLic+INp0zWqVDLGgYin8DIryE5Tws=;
        b=r90PJ8Jhd6ZY/dyw0NAEsmZmJwlviE+2wq6wpEjEVPtyEizT9PemCd1BDlFUOOi/hM
         hChwWUFrhyZ2XKm1IIli4kcij/H522956Amz5OoS8BdlBCYT7JzVEFf/FCfPVH4o5Gut
         hmNK+hhwGY4j6OL68Rrq+TQ0GWhVEPlZSm7ObE2cKWs0B45Tlm8ni8lG44/TkKaUfbII
         SxYImnL2wXtaH0oalm9/Uj4D0y3HrzWqilIVJMojixtv4ObRT+AJdiQRJbKUj1Po/Kgd
         FSjIWdYgcqLYk6IX9j80puXLyYbLChyvCDW+Z1tByizVVGpwc4g+TLpligRIH+FFA1Nz
         uAAA==
X-Gm-Message-State: AJcUukek2cObtYIHyG0IzCjfzj3/Wv6rddMNv3369rP8R1svwKWCQlYD
        zdqtmjnr6vRE6uE93iMRXlZcfCtn
X-Google-Smtp-Source: ALg8bN4kGCAfS6Mo7Qq5WJKt4eSbDMPjwuDSKpR9h9Kn9d9UOEZhtmkjmk/0cDK8ngJtLsAohPzcdQ==
X-Received: by 2002:a62:a510:: with SMTP id v16mr36583605pfm.18.1548977481866;
        Thu, 31 Jan 2019 15:31:21 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id g26sm6990268pfh.61.2019.01.31.15.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 15:31:20 -0800 (PST)
Message-ID: <1548977479.213038.20.camel@acm.org>
Subject: Re: [RESEND PATCH 1/2] loop: Report EOPNOTSUPP properly
From:   Bart Van Assche <bvanassche@acm.org>
To:     Evan Green <evgreen@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Martin K Peterson <martin.peterson@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 31 Jan 2019 15:31:19 -0800
In-Reply-To: <20190131221328.85343-2-evgreen@chromium.org>
References: <20190131221328.85343-1-evgreen@chromium.org>
         <20190131221328.85343-2-evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-01-31 at 14:13 -0800, Evan Green wrote:
+AD4 diff --git a/drivers/block/loop.c b/drivers/block/loop.c
+AD4 index cf5538942834..a1ba555e3b92 100644
+AD4 --- a/drivers/block/loop.c
+AD4 +-+-+- b/drivers/block/loop.c
+AD4 +AEAAQA -458,8 +-458,13 +AEAAQA static void lo+AF8-complete+AF8-rq(struct request +ACo-rq)
+AD4  
+AD4  	if (+ACE-cmd-+AD4-use+AF8-aio +AHwAfA cmd-+AD4-ret +ADw 0 +AHwAfA cmd-+AD4-ret +AD0APQ blk+AF8-rq+AF8-bytes(rq) +AHwAfA
+AD4  	    req+AF8-op(rq) +ACEAPQ REQ+AF8-OP+AF8-READ) +AHs
+AD4 -		if (cmd-+AD4-ret +ADw 0)
+AD4 -			ret +AD0 BLK+AF8-STS+AF8-IOERR+ADs
+AD4 +-		if (cmd-+AD4-ret +ADw 0) +AHs
+AD4 +-			if (cmd-+AD4-ret +AD0APQ -EOPNOTSUPP)
+AD4 +-				ret +AD0 BLK+AF8-STS+AF8-NOTSUPP+ADs
+AD4 +-			else
+AD4 +-				ret +AD0 BLK+AF8-STS+AF8-IOERR+ADs
+AD4 +-		+AH0

Please do not nest if-conditions if that is not necessary. I think the
above code can be written more clearly as follows:

if (cmd-+AD4-ret +AD0APQ -ENOTSUPP)
	ret +AD0 BLK+AF8-STS+AF8-NOTSUPP+ADs
else if (cmd-+AD4-ret +ADw 0)
	ret +AD0 BLK+AF8-STS+AF8-IOERR+ADs

Thanks,

Bart.
