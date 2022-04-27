Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800ABC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 05:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350493AbiD0FqD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 01:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351046AbiD0FqB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 01:46:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403BD15780E
        for <linux-block@vger.kernel.org>; Tue, 26 Apr 2022 22:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j/x1n4tHKrMYifu+UyV8Of7pI/CGXcYjvKfhLoBcP5s=; b=zWNmTqFTwOmRpf7HXXWlrelCS+
        QfhQmh8sezmmZ7Xr8l9rCgcBJ6z+Qzz4+ZFc3IxydnM6HK2DIKlBnh77OU87Gv78XVIw6KRy+ZHeV
        xX6iFqLTz9jAm65ttS0IdQMZ6Z8YBlp2Xkz5LcugEHMQa/+BQnQbW1zJ4tApsM9itt0GHArXqeJPc
        kkER1gTvUVkLZigvcWuU9Ol2zzRnFu5frO5WtUREfg028Q0EFrdGItPWDgI291d54dcfqVQ/YrZSp
        X/bv/q5KMIvl60elWRVwmM5zsrjdKA7wrxgORvWPKNXDBqYCKu3JGQ0nkHjOUPZXtTEqoFjPqjUSe
        h3aRFlTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njaRq-00HVF5-LI; Wed, 27 Apr 2022 05:42:46 +0000
Date:   Tue, 26 Apr 2022 22:42:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Klaus Jensen <its@irrelevant.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Message-ID: <YmjX1h2wnTWDHEN2@bombadil.infradead.org>
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
 <20220420055429.t5ni7yah4p4yxgsq@shindev>
 <YmGbo5Pvv9bOMqmt@bombadil.infradead.org>
 <20220427050825.rkn633nevijh3ux5@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427050825.rkn633nevijh3ux5@shindev>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 27, 2022 at 05:08:25AM +0000, Shinichiro Kawasaki wrote:
> The conditions to recreate the I/O timeout error are as follows:
> 
> - Larger size of QEMU ZNS drive (10GB)
>     - I use QEMU ZNS drives with 1GB size for my test runs. With this smaller
>       size, the I/O timeout is not observed.
> 
> - Issue zone reset command for all zones (with 'blkzone reset' command) just
>   after zbd/005 completion to the drive.
>     - The test case zbd/006 calls the zone reset command. It's enough to repeat
>       zbd/005 and zone reset command to recreate the I/O timeout.
>     - When 10 seconds sleep is added between zbd/005 run and zone reset command,
>       the I/O timeout was not observed.
>     - The data write pattern of zbd/005 looks important. Simple dd command to
>       fill the device before 'blkzone reset' did not recreate the I/O timeout.
> 
> I dug into QEMU code and found that it takes long time to complete zone reset
> command with all zones flag. It takes more than 30 seconds and looks triggering
> the I/O timeout in the block layer. The QEMU calls fallocate punch hole to the
> backend file for each zone, so that data of each zone is zero cleared. Each
> fallocate call is quick but between the calls, 0.7 second delay was observed
> often. I guess some fsync or fdatasync operation would be running and causing
> the delay.
> 
> In other words, QEMU ZNS zone reset for all zones is so slow depending on the
> ZNS drive's size and status. Performance improvement of zone reset is desired in
> QEMU. I will seek for the chance to work on it.

Awesome find Shinichiro!

  Luis
