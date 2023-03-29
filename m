Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39382C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 15:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjC2P2a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjC2P23 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 11:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F243A3C15
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 08:28:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9777D61D34
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 15:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BCDC4339B;
        Wed, 29 Mar 2023 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680103708;
        bh=NC50MtKcNYzQV4XDQO5aiRi3IJS/ePkGeuIcCzXSFpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5WJ0UYS5gd2IJZl9F0UvYphTiWAQQWQYuHIKn1UCTBHhg3UZ412GPrQjy1Q41SeC
         +muoRL7C42MxvREX4/99QREeaKTrr+MyqcgLvPNAHdpPUhCI1cKB7EeIR+61NbpGTE
         jTpMXQO8FKeNKw7V7Jt2kcL0nxwp6Ie42Qqk8sDwDY88AcLvY4v7umB9pt1hqLd0GZ
         dtnEir2zOkmEbOq7Nk6G4ZM7DLZ6m1552QnobSvO5q56GLqmOJPGjzWYd8xYRklqKw
         iiZoyljFDnVv/Qv1cDvZ2sNUmjZ3p4b3MfvkiOgEtSDBCA8qRFDDhIMlS1ZCim9uyX
         D1ct+xuYExtfg==
Date:   Wed, 29 Mar 2023 17:28:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, rafael.antognolli@intel.com
Subject: Re: [PATCH 2/5] sed-opal: add helper for adding user authorities in
 ACE.
Message-ID: <20230329-cesspool-dreamlike-a111baee8776@brauner>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-3-okozina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322151604.401680-3-okozina@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 04:16:01PM +0100, Ondrej Kozina wrote:
> Moves ACE construction away from add_user_to_lr routine
> to be used later in added code.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> Tested-by: Milan Broz <gmazyland@gmail.com>
> ---

Seems fine,
Acked-by: Christian Brauner <brauner@kernel.org>
