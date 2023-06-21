Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DFDEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 11:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjFULUJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 07:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjFULTs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 07:19:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BB9E69;
        Wed, 21 Jun 2023 04:19:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDBF31FDD5;
        Wed, 21 Jun 2023 11:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687346371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HHkbLk/cLJhPHRHX27FHhhWp3DrX/nCJGGt+VLR1SzI=;
        b=gGyxtk4CRVWFBztpC1rGErZc/Yx9a1BC/H90dzZ7W77getnyDY45MVlreaQOjjctagP6q+
        u63OAFg3WhKhJdsBe0yueYNraFUBO74si03Y2gRIuobb2g+rXj3sg+745UIb/IGq3SlfDF
        eSRWB5UJqo1OlzXzTD/JquDJguSgW0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687346371;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HHkbLk/cLJhPHRHX27FHhhWp3DrX/nCJGGt+VLR1SzI=;
        b=QYsModYHdx6Ew+QFqgUL2c5xStel7OjLiIEsT8JEjjqZiMC2Vpv+HL6H+peDN8c2+QpLwN
        4tLO/CKpYV5251AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCD4F134B1;
        Wed, 21 Jun 2023 11:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QwPcNcPckmQeJwAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 21 Jun 2023 11:19:31 +0000
Date:   Wed, 21 Jun 2023 13:19:31 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Message-ID: <h7m22wkkpxo524a73rhl6y55lh5jkjcdteasc7voc6m6e7vfvx@hbr7hfhfkf2k>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-2-dwagner@suse.de>
 <380cde65-8794-cfbc-237f-30a8d7e9330c@grimberg.me>
 <f6rvvhgim4nk34onfgbwyfctgvgdbdigwbsugjvizgtli46p57@s7c4gkqrpjqy>
 <083e29ff-4ad0-d05f-0521-56ace13629e6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <083e29ff-4ad0-d05f-0521-56ace13629e6@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 21, 2023 at 12:50:29PM +0300, Sagi Grimberg wrote:
> > > Why not simply wait for live? The connecting is obviously racy...
> > 
> > That is what the new version is doing. It's waiting for the live state and then
> > checks the queue count.
> 
> Maybe don't fold waiting for live into waiting for queue_count.

Alright, will do!
