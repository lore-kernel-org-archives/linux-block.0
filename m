Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CEEC76196
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 18:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjDCS35 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Apr 2023 14:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjDCS34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2023 14:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B893
        for <linux-block@vger.kernel.org>; Mon,  3 Apr 2023 11:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0F38618F8
        for <linux-block@vger.kernel.org>; Mon,  3 Apr 2023 18:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B2DC433D2;
        Mon,  3 Apr 2023 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680546594;
        bh=aj7tqA5SlmHTRd4Ym5d9407t2OBYC+t6CFFC9FTCFWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GY8a8C/b9jrGZrLdf4XSdk49RgRSesgQ7hvM5mGec4mYFYvmv/K/OnA7QiNVK9vOb
         AYwCVcxt+4dENqEQE3S4q9DmoWjYioYDgkr9O3wx90nJUIwT0YpFMwoqjQxL0LrLMX
         o6hw1vJvrgGuLUYwImo5A6oO+/CXOLCPjw9S6BS1q+QFlLsO2s1obHN3uVjMayt65g
         9ntaJzglJ+tEAPqDyjbtuzrnyEpZq3jiPbCj09ksbGFx5Gq2sbH9KIYisMMHiAhfyJ
         4iOgmqo40Lb/7dWhATVSAV3XCij4XFeCg7C7G4T8uy1Xn25m0WoQOVq1MYIIbq9mHM
         eBnixnjnZMd1w==
Date:   Mon, 3 Apr 2023 12:29:51 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Laurence Oberman <loberman@redhat.com>
Cc:     minlei@redhat.com, jmeneghi@redhat.com,
        "Hellwig, Christoph" <hch@infradead.org>, axboe@fb.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Issue with discard with NVME and Infinibox Storage
Message-ID: <ZCsbH+kipS2fbV2h@kbusch-mbp.dhcp.thefacebook.com>
References: <d1dbb7c5eca51993e9988849ab2e43e800ecb067.camel@redhat.com>
 <ZCsUMR3uLx+vPoOp@kbusch-mbp.dhcp.thefacebook.com>
 <89d2cd0379c848f145eed7daf1931d7b4c81b230.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d2cd0379c848f145eed7daf1931d7b4c81b230.camel@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 03, 2023 at 02:18:21PM -0400, Laurence Oberman wrote:
> On Mon, 2023-04-03 at 12:00 -0600, Keith Busch wrote:
> > > 
> > > 
> > > Let me know your thoughts please. for both issues
> > 
> > The commit you found unconditionally sets the discard queue limit to
> > the
> > reported DMRSL, so it sounds like your target is reporting DMRSL as
> > '0'. Prior
> > to that commit, we'd use that value only if it was non-zero. I hope
> > that helps.
> > 
> 
> 
> 
> Hello Keith,
> Many Thanks as always
> I will inform Infinidat and have them figure this out.

If you have access to such a target and want to quickly verify, you could run:

  # nvme nvm-id-ctrl /dev/nvme0

and see what it reports for DMRSL.
