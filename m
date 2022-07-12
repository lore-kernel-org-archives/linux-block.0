Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1674C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 19:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbiGLTUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiGLTTh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 15:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91542EB012
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 11:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1566561582
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 18:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C407C3411E;
        Tue, 12 Jul 2022 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657652201;
        bh=jBjVzYtHZsBaG5CBnzyZ4hZhZcpnBdY4THIatRpO6M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pd8uckI2TiqppywK978gp/BN1nY65B/GK3oM6xaZ6VPr8r1S40CrbIExnnzCqY+C5
         QgquCk04gfnvNMnZpsflguLKW+elW9XWxO/vqMIwNXmhKCHVbSd2JDH2Y+tKsB2iY7
         vKyWgOoeWI4JZhxhBqbot6R8zki6Q1xk6KTmOvORMAMokRMzKmhAxiHzMwdKhlLvH9
         nAikF71Uo1XSOAG6/VqVh0gotiXkY4/+5rqWC9iMdWfMXe5xrKU/DTPr9PqeRW1cJC
         GuEtbbPaibD8XBBRi4yTIyIlkMsYJ/iuq7k2iePl0cNA6pGfmWBNsRLBshDIIaK6iI
         9ig9nVes7Z4VQ==
Date:   Tue, 12 Jul 2022 12:56:38 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [bug report] block: fix leaking page ref on truncated direct io
Message-ID: <Ys3D5jQuR2/u8zNC@kbusch-mbp>
References: <Ys02ZQ+ekH1b0Dtl@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys02ZQ+ekH1b0Dtl@kili>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 12, 2022 at 11:52:53AM +0300, Dan Carpenter wrote:
> Hello Keith Busch,
> 
> The patch 7b1ccdf617ca: "block: fix leaking page ref on truncated
> direct io" from Jul 5, 2022, leads to the following Smatch static
> checker warning:
> 
> 	block/bio.c:1254 __bio_iov_iter_get_pages()
> 	error: uninitialized symbol 'i'.

Yeah, this one was not ready to be merged into any staging trees. One of the
build-bots even flagged this patch hours after it was initially posted.

I've a v2 posted with the appropriate correction, and I'll sort it out with the
maintainers on next steps.
