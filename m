Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686C7C88CB2
	for <linux-block@archiver.kernel.org>; Fri, 25 Aug 2023 12:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244418AbjHYML1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Aug 2023 08:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244595AbjHYMLU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2023 08:11:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA1FE6B;
        Fri, 25 Aug 2023 05:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF3D6396A;
        Fri, 25 Aug 2023 12:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB353C433C7;
        Fri, 25 Aug 2023 12:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692965477;
        bh=w9irN07rzpmcVFq+/nXz+ItXfH5K5JHFoVhhyoLEr4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgwsQk83JEE356qZ5CIds68Z0EkxlmZZ7w/oW3RFs/1XfQUQ+cTThp2PA+jNR14p8
         D2Ky8aafAffwGCP0SDYiTJIGfK+CEolD7oM8MUdwGyRLsbPT2LFDHXD4vqNEvf3thT
         K8lRSq3fcE1UnMWgmxFCX9PKX4aUvxVJpothuvekxhPNI4P7wWhtzcchzl7HLrYV+v
         +aN3gW8+CFoR6RQ9xYTh0WEGnw7krHbnGf9dmVF22u2u2i6QbD0QoeQ093raBKQwLy
         oCPgHN9WOH5QI504GG9NVeK127lhQmshRebUjM+txQf8JiAQZarxxcy1K6OIbryq34
         5bXJKcz4OoDoQ==
Date:   Fri, 25 Aug 2023 14:11:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Joern Engel <joern@lazybastard.org>,
        linux-mtd@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/29] mtd: block2mtd: Convert to bdev_open_by_dev/path()
Message-ID: <20230825-danken-erklommen-042e5f8678b1@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-12-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-12-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:23PM +0200, Jan Kara wrote:
> Convert block2mtd to use bdev_open_by_dev() and bdev_open_by_path() and
> pass the handle around.
> 
> CC: Joern Engel <joern@lazybastard.org>
> CC: linux-mtd@lists.infradead.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
