Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA3CECAAD3
	for <linux-block@archiver.kernel.org>; Fri,  9 Sep 2022 17:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIIRD7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Sep 2022 13:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIIRD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 13:03:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1551D11FCA2
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 10:03:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4969F1F38D;
        Fri,  9 Sep 2022 17:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662743029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5DBKvQV64HNidx1WefRoLtiMAhLrcp7RPWg7TnTb5U=;
        b=a7ZMAXRzClqH+/L9Ruxp30+uLQ/ozSJ66z+hd0yPjucxr9SubLW0YjdyJuxQ+nEmKPwbgI
        2I8pCd5Vsi5eL76oTohVEe0lOZCfzhVbx88KJ4f/smmMzp+BFe6YLE0fXhVwL29IR06R3k
        CApK28vxP7o1utpPa8stV3kc29XAEu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662743029;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5DBKvQV64HNidx1WefRoLtiMAhLrcp7RPWg7TnTb5U=;
        b=rQj5ql/O7NvPESEI8Fe78TjyRZGtbNl+VLhX7wFRud71DdNtVxsm5OsF3sMnfU7BGZSRZd
        DzhcHAm6DGsDwyBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3649213A93;
        Fri,  9 Sep 2022 17:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZIamDPVxG2O4EAAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 09 Sep 2022 17:03:49 +0000
Date:   Fri, 9 Sep 2022 19:03:48 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2] nvme/045: test queue count changes on
 reconnect
Message-ID: <20220909170348.ges2dlty7zomoe7f@carbon.lan>
References: <20220831153506.28234-1-dwagner@suse.de>
 <20220908000222.elkaqaz4l3a2x66k@shindev>
 <20220908073322.oh2cdzwyqwjiyomm@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908073322.oh2cdzwyqwjiyomm@carbon.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 08, 2022 at 09:33:23AM +0200, Daniel Wagner wrote:
> > [  175.612999]  ? nvmet_subsys_attr_qid_max_store+0x13d/0x160 [nvmet]
> 
> Hmm, as qid_max is more or less a copy of existing attributes it might
> not the only attribute store operation which has this problem.

D'oh, the port online check is obviously wrong... working on a fix.
