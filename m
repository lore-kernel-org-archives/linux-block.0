Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7377C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 15:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjC2Pd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjC2Pd0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 11:33:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79139558B
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 08:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E4E0B8235A
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 15:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCE3C433D2;
        Wed, 29 Mar 2023 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680103986;
        bh=+CPV9ToTj+oV3taRjNh36GT7TO/ctFTXP0vDqukQIio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FK4BpiLmSx+ORq2mKXFR+QT7P7iGMjQkcQhP1wSyEqovK3kOr81lRmNqslCUNvUit
         WFaWSNY4O1paN4xklVdIxj4dfndXWYN0/VCEeAIWI/nJo/4+MqDmjyLju6jipMhq+P
         cOInU1RNsjlDq/ErJR/nCwphl5cDqjOiZxfs01nxIN3c9aqB/rdQjzLPkJQVXkZn0E
         6/N+zmAMigTssRo/+v8EabMoOxj0TWBRRoXd8qLHWdH8KlZ+HiL9ImVicuXl0oCQHl
         JzRZUaGNpa6KDxqycyzAFUuP/Wm7EObjlid7UIe9HT0qlenhV/OqV4/+dyjmXKkn/O
         nvvjCZ//Af+2Q==
Date:   Wed, 29 Mar 2023 17:32:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, rafael.antognolli@intel.com
Subject: Re: [PATCH 4/5] sed-opal: add helper to get multiple columns at once.
Message-ID: <20230329-jailer-preplan-4c9cb9043ec5@brauner>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-5-okozina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322151604.401680-5-okozina@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 04:16:03PM +0100, Ondrej Kozina wrote:
> Refactors current code querying single column to use the
> new helper. Real multi column usage will be added later.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> Tested-by: Milan Broz <gmazyland@gmail.com>
> ---

Seems fine,
Acked-by: Christian Brauner <brauner@kernel.org>
