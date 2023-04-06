Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1681BC7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 07:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbjDFHc7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 03:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjDFHc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 03:32:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A2ECE
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 00:32:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D15ED1FF8C;
        Thu,  6 Apr 2023 07:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680766376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbBHR6DcbfG4L/fA0YlFdf3ObyJR3FjaiMe8e+n6Lp4=;
        b=xpq+mzIBGnBuGG9EXl9zyQkS0oNEg20BZy4PvTItyDOfHmuY7ELw6iQXo4NmFuRdhljwAF
        w0DWtfvV9+uTMLHS9vKHr4S1rxSeZa7j7stS8Oow1yl76CMDluGDZwVk8mcQ2eFYCWPA96
        83RnBfNHGHSj8AdXr8SzZ/W+5oMGcnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680766376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbBHR6DcbfG4L/fA0YlFdf3ObyJR3FjaiMe8e+n6Lp4=;
        b=ukujNXwSAcFbQMBb9y+2NkolcVtsvh69iCQ3N4NBYzBz/i3vnHiFcqoHfur6joJNXFhi+a
        /7aNzDdrGlqsKLCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C226D1351F;
        Thu,  6 Apr 2023 07:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S9ZZL6h1LmQ/RgAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 07:32:56 +0000
Date:   Thu, 6 Apr 2023 09:32:56 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 1/4] nvme/rc: Add setter for attr_qid_max
Message-ID: <spido7j7kjpylnnjxx6dzex4fizyhfu7mhjzzvxi5eaibzziln@6oram2xhcg3l>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-2-dwagner@suse.de>
 <9bde6907-20b8-1e19-8b5c-e26f62f2f9e4@nvidia.com>
 <2w3ki4ntl5m2farwokvepbgtcvd5piywv3cmdyzp4s6su6fngc@55wsvekrge3c>
 <f83b0c8a-3716-5154-9c5c-3989bcf2d320@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83b0c8a-3716-5154-9c5c-3989bcf2d320@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 07:05:45AM +0000, Chaitanya Kulkarni wrote:
 if there are functions in rc which are only testcase specific let's keep
> those there, we can always do cleanup later ..

Sure, works for me too.
