Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE71DECAAD3
	for <linux-block@archiver.kernel.org>; Fri,  9 Sep 2022 15:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiIIPS3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Sep 2022 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiIIPS2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 11:18:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D05146710
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 08:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D0D5B82554
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 15:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024B7C433B5;
        Fri,  9 Sep 2022 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662736704;
        bh=VXWcmgxtEKtxgo0MwLo94NsZ5ofPiusi/7G0X0ut9kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKylg8SN6eVEDeJHKPeuWa+d+L30aJCZt9v6lM6Go5r0sHAFAAVlMNkx7K812Lb/k
         VC1Sh7xIKrlxkKXhR4606AD1as/BGeUjaCcwvK0pwHNXlyZTJWKBiljopYzMPAmbv+
         7t+ppmeADemYFfdVhWQSp9oKp+R3npxaZ31OIPYsOa0fAikDF+o6TmXfI/0UbuWMQ/
         9A8EWCgyhUiRhEJzkfI5/wfEv6Xbz4m/A76inVIPQN8cwWon47zXZbG+XCoD+E/+Lw
         IKVYPLvVpuogHO0lMLvmKQWj1LRKnNO5Le45rpMA/VEGQdpRGv7cT31Er+lYdVOih1
         5rTqch/t/LUkw==
Date:   Fri, 9 Sep 2022 09:18:21 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCHv4] sbitmap: fix batched wait_cnt accounting
Message-ID: <YxtZPUk2NepSneeE@kbusch-mbp.dhcp.thefacebook.com>
References: <20220908215132.3243008-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908215132.3243008-1-kbusch@fb.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 08, 2022 at 02:51:32PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Batched completions can clear multiple bits, but we're only decrementing
> the wait_cnt by one each time. This can cause waiters to never be woken,
> stalling IO. Use the batched count instead.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215679

A longer running test finally failed in a similar manner as before. It use to
fail much quicker, but something is still off, so please don't apply or test
this patch yet.
