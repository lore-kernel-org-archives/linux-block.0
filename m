Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F475C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 06:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjDFGMV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDFGMU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 02:12:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64427AA6
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 23:12:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F7EC22591;
        Thu,  6 Apr 2023 06:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680761535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HEuH/YkOBOinF1cO2uWYOkFM8PNnCrP0rdn4xwT5/74=;
        b=CkW+mlZZ57yZ9Qn4hRM+IE6aTUShGtpL1Der3Bv5pM0cdh1+nuj9OHJbeMGQgBkzMLFEhd
        RemidBnMjk9xrepeLsoaNUa0Ko4I26DH3SsjUpqYbY5OWv9OziQEFEdIwd0YOf9+45EPD0
        6z/UitWKp7FbVUPeQBQ3PsWCy0EKmWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680761535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HEuH/YkOBOinF1cO2uWYOkFM8PNnCrP0rdn4xwT5/74=;
        b=WUenku246MDvCLBqqQ0P5JzbF1T+196qFpqZhf2VW6OuCU9Zzc8ARLJRZe1sCDrxhWRvWM
        b7Mg0Buus+gN+ABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7053F133E5;
        Thu,  6 Apr 2023 06:12:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P3BkG79iLmS+IAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 06:12:15 +0000
Date:   Thu, 6 Apr 2023 08:12:14 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 1/4] nvme/rc: Add setter for attr_qid_max
Message-ID: <2w3ki4ntl5m2farwokvepbgtcvd5piywv3cmdyzp4s6su6fngc@55wsvekrge3c>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-2-dwagner@suse.de>
 <9bde6907-20b8-1e19-8b5c-e26f62f2f9e4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bde6907-20b8-1e19-8b5c-e26f62f2f9e4@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 05, 2023 at 06:39:43PM +0000, Chaitanya Kulkarni wrote:
> this is only used in the testcase patch #4, until we get a second
> user move it to patch #4 ?
> 
> in case this was already discussed and decision made to keep it
> in rc, please ignore this comment.

There wasn't any decision on this topic. I was not sure if I should put it in rc
but I saw there are already _set_nvmet_*() functions. Thus I came to the
conclusion it makes maintaining these helper function simpler in future because
they are all in one file. If someone touches all _set_nvmet_*() function this
one is not forgotten.

The same goes for the other rc helpers (patch 1-3).

That said, I really do not insit in putiting in rc.
