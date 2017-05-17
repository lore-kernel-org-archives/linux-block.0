Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16456 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbdEQApb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2017 20:45:31 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20170517004529epoutp02c38fecbfc9119a0e87fd15779e925c11~-PiTx5ONr1866218662epoutp027
        for <linux-block@vger.kernel.org>; Wed, 17 May 2017 00:45:29 +0000 (GMT)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] ext4: hand over jobs handling discard commands on
 commit complete phase to kworkers
Reply-To: daeho.jeong@samsung.com
From: Daeho Jeong <daeho.jeong@samsung.com>
To: Christoph Hellwig <hch@infradead.org>,
        Daeho Jeong <daeho.jeong@samsung.com>
CC: "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
In-Reply-To: <20170516115306.GA15058@infradead.org>
Message-ID: <20170517004529epcms1p297077c5039bda981024d5a10db5f676e@epcms1p2>
Date: Wed, 17 May 2017 00:45:29 +0000
Content-Type: text/plain; charset="utf-8"
References: <20170516115306.GA15058@infradead.org>
        <1494920262-10128-1-git-send-email-daeho.jeong@samsung.com>
        <CGME20170516073738epcas1p42daa31d04ae9d07eae07d9fcee6708a2@epcms1p2>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>> Now, when we mount ext4 filesystem with '-o discard' option, we have to
>> issue all the discard commands for the blocks to be deallocated and
>> wait for the completion of the commands on the commit complete phase.
 
> No, you don't.  You can execute them asynchronously, similar to what
> XFS already does.

Thank you, I will check XFS codes issuing discard commands asynchronously.
But, even if the discard commands can be handled in parallel by doing this,
we still need to wait for all the discard requests completion on the journaling
commit phase. I want to modify this part, too.
 

 
