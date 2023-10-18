Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA334CDB47E
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 09:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjJRJYl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Oct 2023 05:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjJRJYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2023 05:24:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0664A106
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2023 02:24:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FE7C433C9;
        Wed, 18 Oct 2023 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697621075;
        bh=NhuPB8WoDr3nFTdxtomSvCNDDuxNLeX3GORUDiRLFN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=trMNMDJ18oYau9v2zE3uj+bdy2I0anLGR83+A8p3TephJeDKXpgkATXkfTy+JOQ8O
         nr+xoPnHzofMtKbGgeK1w9RiMfsbVnaNFNgBjKiA8mft3r+Bo/f5uCFfpv3Gxm4y8m
         LgPynOP2VVUh/aoK7UfZhPNqeTWSkVi/0h8Xe3Ggtwe57z9h/QtxpY2KMyxL+K7VIT
         xm9WCDRyOqXG6ygQPhUYnBkkO0JRyjk0I6pOBbZ9fZaCfz7XgfjV2vfVWnqUvCoMV9
         ZF51not7uKFei5Y3ZAIYOg+D/eqiDYIC9IOcG9uSvHA5czPWyU1HTOZhfs975pHCvj
         AfX66DEwBJX8Q==
Date:   Wed, 18 Oct 2023 11:24:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <20231018-retten-luftkammer-2bae34ff707f@brauner>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 17, 2023 at 08:48:21PM +0200, Christoph Hellwig wrote:
> disk_check_media_change is mostly called from ->open where it makes
> little sense to mark the file system on the device as dead, as we
> are just opening it.  So instead of calling bdev_mark_dead from
> disk_check_media_change move it into the few callers that are not
> in an open instance.  This avoid calling into bdev_mark_dead and
> thus taking s_umount with open_mutex held.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
