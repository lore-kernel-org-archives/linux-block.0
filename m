Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4CAC07545
	for <linux-block@archiver.kernel.org>; Tue, 24 Oct 2023 07:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjJXHGa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Oct 2023 03:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjJXHG3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Oct 2023 03:06:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A642C10C;
        Tue, 24 Oct 2023 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aSAEUUc9lFBEtVvww0Jt4hfvlUP/bfy8AtKAMM6xXWk=; b=1jFGFjjaZf1Hxd88eaA9/EV8S1
        sYjtvzDAlGEL86xdcNQ54uEvhFmZFE9XrgVsdncPjPykYAtNHbyj9x3AWoZf0B/8+o9Km99BFvC96
        sFQNsD2SLvhPLtfcTr34Cz8J4N2X6nrJHnxcmYDpsjedlRHb24AiVGMXETz/0RpYz3wQ44H/64xvs
        vjZRan1LkfQW88W7Wcdcqpss9OifF5oFk4ei7nyRvmyWWhsr1ruorIZFpgb8O28E/OL08nE/o290e
        XiOXG1pkkew2wL29hOvqXFcHuNU69QBaaQOwyCaBq3G/5GIm7gzNm66c6jQwz7YNJqYCEOm7NMn3y
        gu3gOeGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qvBUg-0092L6-0k;
        Tue, 24 Oct 2023 07:06:26 +0000
Date:   Tue, 24 Oct 2023 00:06:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: LOOP_CONFIGURE uevents
Message-ID: <ZTds8va6evIjnpJG@infradead.org>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <ZTExy7YTFtToAOOx@infradead.org>
 <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
 <20231020120436.jgxdlawibpfuprnz@quack3>
 <20231023-biberbau-spatzen-282ccea0825a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-biberbau-spatzen-282ccea0825a@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 23, 2023 at 04:08:21PM +0200, Christian Brauner wrote:
> No you get uevents if you trigger a partition rescan but only if there
> are actually partitions. What you never get however is a media change
> event even though we do increment the disk sequence number and attach an
> image to the loop device.
> 
> This seems problematic because we leave userspace unable to listen for
> attaching images to a loop device. Shouldn't we regenerate the media
> change event after we're done setting up the device and before the
> partition rescan for LOOP_CONFIGURE?

Maybe.  I think people mostly didn't care about the even anyway, but
about the changing sequence number to check that the content hasn't
changed.
