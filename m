Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D0BC433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 11:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FA920DD4
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592394596;
	bh=SGktHL8v4bUaxnE11zkIKRC5NP2G8l0cI+uxomn/MU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=T36xVQXZsVsQ1/txg52oWIDSDkhVPP45tslUXh9QQ4N1+iy1zGei+vYABzcwTZmcP
	 DqgPlDwr5T+QbUR5cv86HDw4RbI9MTN/L+cvXrHbsShWL9AfOgWYawBLSajs0SXVtJ
	 5icASSOVMjcUmKnco/4N1WmVLEae9rXMRaDOFw2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgFQLtz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQLtz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 07:49:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 682F42098B;
        Wed, 17 Jun 2020 11:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592394594;
        bh=SGktHL8v4bUaxnE11zkIKRC5NP2G8l0cI+uxomn/MU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1+haDgzUZBvOMdpdBhZ9W5amJUuetI3EiyNrNw7K/AsopZqolAfCjt6ECuMn06iIB
         omCnTHLmqDswENeS05R08MwhSN9WHJpVIkNIaM0ny2d9lBQ2SpvboScc0aowX4FxB7
         Te9pJc8qPCMK7u0PNkTo7Fji+FhSYYis1lr+lRag=
Date:   Wed, 17 Jun 2020 13:49:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc:     Steffen Maier <maier@linux.ibm.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wade Mealing <wmealing@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] Revert "zram: convert remaining CLASS_ATTR() to
 CLASS_ATTR_RO()"
Message-ID: <20200617114946.GA2131650@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617103412.GA2027053@kroah.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Wade Mealing <wmealing@redhat.com>

Turns out that the permissions for 0400 really are what we want here,
otherwise any user can read from this file.

[fixed formatting, added changelog, and made attribute static - gregkh]

Reported-by: Wade Mealing <wmealing@redhat.com>
Cc: stable <stable@vger.kernel.org>
Fixes: f40609d1591f ("zram: convert remaining CLASS_ATTR() to CLASS_ATTR_RO()")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1847832
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: fix read/write confusion in the changelog, thanks to Steffen for the
    review.
    was more specific as to the changes I made to the original patch.

 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6e2ad90b17a3..270dd810be54 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2021,7 +2021,8 @@ static ssize_t hot_add_show(struct class *class,
 		return ret;
 	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
 }
-static CLASS_ATTR_RO(hot_add);
+static struct class_attribute class_attr_hot_add =
+	__ATTR(hot_add, 0400, hot_add_show, NULL);
 
 static ssize_t hot_remove_store(struct class *class,
 			struct class_attribute *attr,
-- 
2.27.0


