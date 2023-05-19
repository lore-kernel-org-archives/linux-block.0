Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5592C77B7D
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 02:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjESCAg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 22:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjESCAf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 22:00:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB6310D8
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 19:00:30 -0700 (PDT)
Received: from letrec.thunk.org (c-73-212-78-46.hsd1.md.comcast.net [73.212.78.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34J20C9q022082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 22:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684461616; bh=zYaJWRadw9K9NYJhf54K31B4n7EW9dZE3PwzMUwdSyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lDLV1vJbhKah+968jiCuix/gw4QQd/4+P/KvmDMrl4x5UbZuuCf+rYwZk0KS8B7bt
         iD7EuivTlNnWuHfenUbpGIzGbodPHdbJ68411DqMBxGeocTDKJsbC+pcwXX0R9q+vg
         DNw+YbTNVyBTHqbWGBb83xg0TtIXFuzmPNNEphzvtuRnz356mQoJFPK8u+emCP+xRm
         /gWdJU9WQKFP/Hw4dWx/mYAkzQno9/D9On2nZIvzC6Z4zUM+uJLmHQBL/4aiCEEvhD
         qoA5kfl97EDAqocFf/te7k7NLhs4KMLmxEqsRSZDr95SkUk8inSFZHFp5XnN5OGBCz
         X9/JAIqaASN4Q==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 570DF8C02F5; Thu, 18 May 2023 22:00:12 -0400 (EDT)
Date:   Thu, 18 May 2023 22:00:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: introduce bdev holder ops and a file system shutdown method v2
Message-ID: <ZGbYLK0lOqYqPf9O@mit.edu>
References: <20230518042323.663189-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518042323.663189-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 18, 2023 at 06:23:09AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes the long standing problem that we never had a good way
> to communicate block device events to the user of the block device.
> 
> It fixes this by introducing a new set of holder ops registered at
> blkdev_get_by_* time for the exclusive holder, and then wire that up
> to a shutdown super operation to report the block device remove to the
> file systems.

Thanks for working on this!  Is there going to be an fstest which
simulates a device removal while we're running fsstress or some such,
so we can exercise full device removal path?

Thanks,

					- Ted
