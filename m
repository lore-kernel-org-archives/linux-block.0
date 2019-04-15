Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C0C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 19:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1677220880
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 19:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfDOTay (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:30:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35321 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfDOTay (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 15:30:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so9068550plp.2
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2019 12:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RH2QVoE/burclUp6EfwT9JNEzt8KXbaEANPax6+F1VE=;
        b=JVGG82Wkr9TfCN/yXo4X+7843fE6E53ncW69IZfTsS2p+JFIFtHb4SVpGrAIDnahOY
         EBFyGG15tftmM3BCtfTxDRJC+hutf8N0/OBj6NHUXQ3UyKvPaLkDu0AoE7N3k9z6eQvF
         r5mQ68bBgUKUs5FeXwN20RGQL+jijBy78XI6Xs9+ZZDjTLQHTxAVpqDtTSQGEc0gfkex
         yqMXFSkHu3sYEhmwZdjn+hpcn7sVobZXFj5cNclZmQcOSchS0Cjilr55aJRlj7B13gy0
         5XCdbBga+LGtwYcrl5MH5F06HFR+7Fzu2awr4OEd9lkN6vDGIwQ1vPNRHvMDXD/nJAHU
         sqkw==
X-Gm-Message-State: APjAAAW2m8hmA5p4V7iBjX7odjtsLYi4txG8DvXZu6TjrMpDz3p5bPbQ
        9I+4YlKRbREnT57rtA2N5vU=
X-Google-Smtp-Source: APXvYqyNZxigdYnA8Vg77uuXNds/utjVztut8lU4yD/0jES2R1aXEpYNcxyW7O24uq5irk0xIgk4mQ==
X-Received: by 2002:a17:902:ea0d:: with SMTP id cu13mr76566057plb.92.1555356653456;
        Mon, 15 Apr 2019 12:30:53 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id v19sm90877365pfa.138.2019.04.15.12.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 12:30:52 -0700 (PDT)
Message-ID: <1555356651.161891.105.camel@acm.org>
Subject: Re: [PATCH v3] block: fix use-after-free on gendisk
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk, jack@suse.cz
Cc:     viro@zeniv.linux.org.uk, bart.vanassche@wdc.com,
        linux-block@vger.kernel.org
Date:   Mon, 15 Apr 2019 12:30:51 -0700
In-Reply-To: <20190402120634.51040-1-yuyufen@huawei.com>
References: <20190402120634.51040-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-02 at 20:06 +-0800, Yufen Yu wrote:
+AD4 commit 2da78092dda +ACI-block: Fix dev+AF8-t minor allocation lifetime+ACI
+AD4 specifically moved blk+AF8-free+AF8-devt(dev-+AD4-devt) call to part+AF8-release()
+AD4 to avoid reallocating device number before the device is fully
+AD4 shutdown.
+AD4 
+AD4 However, it can cause use-after-free on gendisk in get+AF8-gendisk().
+AD4 We use md device as example to show the race scenes:
+AD4 
+AD4 Process1		Worker			Process2
+AD4 md+AF8-free
+AD4 						blkdev+AF8-open
+AD4 del+AF8-gendisk
+AD4   add delete+AF8-partition+AF8-work+AF8-fn() to wq
+AD4   						+AF8AXw-blkdev+AF8-get
+AD4 						get+AF8-gendisk
+AD4 put+AF8-disk
+AD4   disk+AF8-release
+AD4     kfree(disk)
+AD4     						find part from ext+AF8-devt+AF8-idr
+AD4 						get+AF8-disk+AF8-and+AF8-module(disk)
+AD4     					  	cause use after free
+AD4 
+AD4     			delete+AF8-partition+AF8-work+AF8-fn
+AD4 			put+AF8-device(part)
+AD4     		  	part+AF8-release
+AD4 		    	remove part from ext+AF8-devt+AF8-idr
+AD4 
+AD4 Before +ADw-devt, hd+AF8-struct pointer+AD4 is removed from ext+AF8-devt+AF8-idr by
+AD4 delete+AF8-partition+AF8-work+AF8-fn(), we can find the devt and then access
+AD4 gendisk by hd+AF8-struct pointer. But, if we access the gendisk after
+AD4 it have been freed, it can cause in use-after-freeon gendisk in
+AD4 get+AF8-gendisk().
+AD4 
+AD4 We fix this by adding a new helper blk+AF8-invalidate+AF8-devt() in
+AD4 delete+AF8-partition() and del+AF8-gendisk(). It replaces hd+AF8-struct
+AD4 pointer in idr with value 'NULL', and deletes the entry from
+AD4 idr in part+AF8-release() as we do now.
+AD4 
+AD4 Thanks to Jan Kara for providing the solution and more clear comments
+AD4 for the code.

Nice work.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


