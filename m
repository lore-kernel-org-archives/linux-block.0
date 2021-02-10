Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B41C433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 20:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E45F64EE5
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 20:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhBJUWa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:22:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233530AbhBJUVp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 15:21:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3504064F00;
        Wed, 10 Feb 2021 20:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612988382;
        bh=TvmjjBQMashqYeR34N26U0gn1dIqetjqzDH8k6T1CEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CbhpmMz7Jt7VTYtX6pogHQfXCZURWdX4XSBQb/7jryW82Er+JQQMEcZjVHuHt+qMo
         YJ5xH6JVY6VfcrpRV3+DzBivr4Hr1LJkq3mbhsiYkQMuRVHsXq7WOy3No0+bblYsXz
         QdpYyu4hssn2veqh2Gf23upcZq+MEvfm/efo7XrTU7ARBjNeUuJ06n9y0jPe6ISj51
         rF38GvtsJ68cKM3h54Cl9+kqJ8Clb6YiZPsbBLSRn06IUUcsBB+BfJHt5UkB2OrGCD
         LbXDdWXB5uYW9fV5dW1aNEJfQO9a8SRSNsS0Ip14jM64glIl4I4ySDPmq8gaPEtH6A
         Ffs68JU2jNniQ==
Date:   Wed, 10 Feb 2021 12:19:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v4 4/5] dm: support key eviction from keyslot managers of
 underlying devices
Message-ID: <YCQ/3EJuufLXMiG4@gmail.com>
References: <20210201051019.1174983-1-satyat@google.com>
 <20210201051019.1174983-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201051019.1174983-5-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 01, 2021 at 05:10:18AM +0000, Satya Tangirala wrote:
> Now that device mapper supports inline encryption, add the ability to
> evict keys from all underlying devices. When an upper layer requests
> a key eviction, we simply iterate through all underlying devices
> and evict that key from each device.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

This latest version looks good to me.  If it's needed despite my
Co-developed-by, feel free to add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
