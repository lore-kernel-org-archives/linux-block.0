Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46949C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 15:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BB7218FD
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 15:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfCUPmD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:42:03 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:37636 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfCUPmD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 11:42:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 23E9B60D4822;
        Thu, 21 Mar 2019 16:42:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1yo2eUvrtXPh; Thu, 21 Mar 2019 16:42:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C7C2760D4821;
        Thu, 21 Mar 2019 16:42:00 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rGDP5xh5P4wx; Thu, 21 Mar 2019 16:42:00 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 12FA4603B562;
        Thu, 21 Mar 2019 16:42:00 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Nicolas Pitre <nico@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Convert mount_single-using filesystems to fs_context
Date:   Thu, 21 Mar 2019 16:41:59 +0100
Message-ID: <20992998.5BCRIlqCZf@blindfold>
In-Reply-To: <6007.1553181386@warthog.procyon.org.uk>
References: <3463221.D14WHduXq3@blindfold> <155316902426.29884.2476392753144421312.stgit@warthog.procyon.org.uk> <6007.1553181386@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am Donnerstag, 21. März 2019, 16:16:26 CET schrieb David Howells:
> Bah.  The problem is that vfs_get_super() doesn't set fc->root before calling
> reconfigure_super().

Do you still need the disassembly?

Thanks,
//richard



