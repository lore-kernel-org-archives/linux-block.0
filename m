Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5215CDB465
	for <linux-block@archiver.kernel.org>; Thu, 19 Oct 2023 06:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjJSGBS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Oct 2023 02:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjJSGAu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2023 02:00:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03F42129;
        Wed, 18 Oct 2023 22:57:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1ACB567373; Thu, 19 Oct 2023 07:57:41 +0200 (CEST)
Date:   Thu, 19 Oct 2023 07:57:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <20231019055740.GA14794@lst.de>
References: <20231017184823.1383356-1-hch@lst.de> <20231017184823.1383356-4-hch@lst.de> <20231018-retten-luftkammer-2bae34ff707f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-retten-luftkammer-2bae34ff707f@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I turns out that we'd need bdev_mark_dead generally exported for this.
I don't quite like that, but I don't really see a way around it.
Maybe fix that up in your tree?
