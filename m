Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDD7EB64DD
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 06:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGKGWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 02:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjGKGWi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 02:22:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C409BE4B
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 23:22:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E6D66732D; Tue, 11 Jul 2023 08:22:33 +0200 (CEST)
Date:   Tue, 11 Jul 2023 08:22:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
        chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] f2fs: don't reopen the main block device in
 f2fs_scan_devices
Message-ID: <20230711062233.GB20392@lst.de>
References: <20230707094028.107898-1-hch@lst.de> <ZKx2jVONy35B0/S1@google.com> <20230711050101.GA19128@lst.de> <63766a54-54db-20a7-ba2f-d31fd230623d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63766a54-54db-20a7-ba2f-d31fd230623d@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 11, 2023 at 08:19:50AM +0200, Hannes Reinecke wrote:
>>     	for (i = 0; i < sbi->s_ndevs; i++) {
>> -		blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
>> +		if (i > 0)
>> +			blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
> You could have started the loop at '1', and avoid the curious 'if' clause 

That's what the previous version did, which caused a NULL pointer
dereference discussed in this thread, as well as a compile error for
non-zoned builds..

