Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D365DC433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 16:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbiKPQux (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiKPQub (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 11:50:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DD959FDD
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 08:48:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B092961596
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 16:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96F3C433C1;
        Wed, 16 Nov 2022 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668617331;
        bh=3Hkx6PB49o80L9Fc+XPqxoxI0uNzYE40vPwvJ4LDC70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugDVPZykbdicb1vwb1J+XKZoXXmlJEKIipSr+wuWz7ENIr23qa0rD7AUM1AMc28mP
         fIYePxmQYM5QYCbO+I29ETvR8QlP5wwtfGBnL7j6vzzvK3aMPG2MQlpmL9dl1z+xl0
         I9Es6VkKm30kqrWLYugRdOSokrXuz1NJb8LQkZxFtC3rQ57RSloG3mQl8yg5z2+aMm
         fLyIzzKh1STQ1FbpW+87mslHXxbLsMtBBOpEVgphxf1TIUVhDcwFy+zCsC+o4IQxpT
         ymRpYIEGdWsdVWP08VYb+CIc8fsrhk/PBq6f+2sfR538E5GmUUoTZ5BKpfYXkzclMY
         UzDr4ZaG3GOdA==
Date:   Wed, 16 Nov 2022 09:48:47 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] tests/nvme: Remove test output for passthrough error
 logging
Message-ID: <Y3UUb9RvkmS2OuYp@kbusch-mbp.dhcp.thefacebook.com>
References: <20221116001234.581003-1-alan.adamson@oracle.com>
 <20221116041701.mu4osauvwqsbvjau@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116041701.mu4osauvwqsbvjau@shindev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 16, 2022 at 04:17:03AM +0000, Shinichiro Kawasaki wrote:
> On Nov 15, 2022 / 16:12, Alan Adamson wrote:
> > Commit d7ac8dca938c ("nvme: quiet user passthrough command errors")
> > disabled error logging for passthrough commands so the associated
> > error output in nvme/039.out should be removed.
> > 
> > When an error logging opt-in mechanism for passthrough commands is
> > provided, the error output can be added back.
> 
> Thanks for this quick action. This two-steps approach looks good for me.
> 
> I confirmed the fix avoids the failure with v6.1-rc5 kernel. Also, I observe
> this fix makes the test case fail with v6.0 kernel. I suggest to skip the test
> case with kernel v6.0 or older, applying the hunk below. Could you repost v2
> with this change? Or if you want, I can apply it together with v1. Please let
> me know your preference.

It sounds like some future case might allow these errors to log in some
circumstances, so I'm not sure the test case should be so dependent on
seeing or not seeing these messages. Is there a mechanism to say these
are optional messages that may or may not show up?
