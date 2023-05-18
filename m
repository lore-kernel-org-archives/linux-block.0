Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB960C77B7D
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 07:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjERHwQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 03:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjERHwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 03:52:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9512699;
        Thu, 18 May 2023 00:52:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 199CF22618;
        Thu, 18 May 2023 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684396332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=35wFhivmcYCWnVrRWAiYgC66ZHYrppThfjDiaL7jSDs=;
        b=gNaF4FEF4sCEAoxMytxwRr24GdjT8ysJtK4mZVMdB6U7mOAaNy9+e/8ROl4bTWmVE5p2kl
        ooY4Tybp8d+N0Zie0mPzgBkdlsvfONKgCMPjMyzpz1gUj3RknDCfNKrjI3JTVeS6zUHnpB
        4yVehVoifvGbZDr8er2poJBS5RZ3/HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684396332;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=35wFhivmcYCWnVrRWAiYgC66ZHYrppThfjDiaL7jSDs=;
        b=mMuwCITDzTnnCtb0M9rvVEUBnsoij5qy+Bez40xgUbr1ldcfQWzVPwim0FVUDQ2efW9cQO
        V0qP84RymdNjyrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08CAE1390B;
        Thu, 18 May 2023 07:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iU/FASzZZWRpKQAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 18 May 2023 07:52:12 +0000
Date:   Thu, 18 May 2023 09:52:11 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 05/11] nvme{032,040}: Use runtime fio
 background jobs
Message-ID: <eykbvi7lzhnbd6ft6cva6qu4lp5ryn3ha2fgigmao2553qm4bu@227ey5mv5ls5>
References: <20230511140953.17609-1-dwagner@suse.de>
 <20230511140953.17609-6-dwagner@suse.de>
 <50c50cda-23f5-b55d-a902-ce34de8498e1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c50cda-23f5-b55d-a902-ce34de8498e1@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 17, 2023 at 04:40:52AM +0000, Chaitanya Kulkarni wrote:
> On 5/11/23 07:09, Daniel Wagner wrote:
> > The fio jobs are supposed to run long in background during the test.
> > Instead relying on a job size use explicit runtime for this.
> >
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> Is there any issue with the exiting approach for this change ?

The expectation of the test here is that there is a background job running.
Depending on the job size is an indirect way to express run at least for x
seconds. This gives a variable runtime as it depends the how fast fio jobs gets
executed. Explicitly telling the runtime is my opinion more robust and documents
the indention better.
