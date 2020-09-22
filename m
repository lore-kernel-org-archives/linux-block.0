Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C379C4727F
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 00:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69DBB23AA2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 00:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600734453;
	bh=WJ9vUtalwvX0VoxlCJ9TGwxylNWpZKu4FE8jhq+HMCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sZK5PK1Y2AHu41KOjBY+ROyXqXcs8UAPrXFPF0Q4oqsdPmAWAVkmIpyA3XETm06Y1
	 LokBZ3kAsnyH4g3Es9mtWc5JyT/XQ0RuSBgr36DtPUJGzRBm/knmJAOrz0r/X/C2LA
	 7PoArtdzXi6XZShOyxvOguneDuUiUPvCIcOJKsVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgIVA13 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 20:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729312AbgIVA11 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 20:27:27 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3464A23A79;
        Tue, 22 Sep 2020 00:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600734447;
        bh=WJ9vUtalwvX0VoxlCJ9TGwxylNWpZKu4FE8jhq+HMCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pf/d7qFw3WZA2gru9HH3l5bhO3AXSs/qy9hyRCF00/odkdcTnbJm9WyK7R+4/GCP3
         bAAzMWhh1YsXr85NLmsyN5dc0Y8ljcSl/0vX1N2kUJC1hnafqXrge2t5xx5uUj1mHa
         rLS2GuHCOgL3g88Sy2pk5wjV2vfgA5evLQZtxLdw=
Date:   Mon, 21 Sep 2020 17:27:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 1/3] block: keyslot-manager: Introduce passthrough
 keyslot manager
Message-ID: <20200922002725.GB32959@sol.localdomain>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909234422.76194-2-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 09, 2020 at 11:44:20PM +0000, Satya Tangirala wrote:
> The device mapper may map over devices that have inline encryption
> capabilities, and to make use of those capabilities, the DM device must
> itself advertise those inline encryption capabilities. One way to do this
> would be to have the DM device set up a keyslot manager with a
> "sufficiently large" number of keyslots, but that would use a lot of
> memory. Also, the DM device itself has no "keyslots", and it doesn't make
> much sense to talk about "programming a key into a DM device's keyslot
> manager", so all that extra memory used to represent those keyslots is just
> wasted. All a DM device really needs to be able to do is advertise the
> crypto capabilities of the underlying devices in a coherent manner and
> expose a way to evict keys from the underlying devices.
> 
> There are also devices with inline encryption hardware that do not
> have a limited number of keyslots. One can send a raw encryption key along
> with a bio to these devices (as opposed to typical inline encryption
> hardware that require users to first program a raw encryption key into a
> keyslot, and send the index of that keyslot along with the bio). These
> devices also only need the same things from the keyslot manager that DM
> devices need - a way to advertise crypto capabilities and potentially a way
> to expose a function to evict keys from hardware.

To be a bit more concrete, FMP (Flash Memory Protector) on Exynos SoCs is an
example of hardware that supports inline encryption without having the concept
of keyslots.  On that hardware, each request takes an actual key, rather than a
keyslot number.  Likewise, some Mediatek SoCs are like this too.

So support for inline encryption without keyslots is something that is useful
for real hardware, in addition to the device-mapper support which is the initial
use case included in this patchset.

> So we introduce a "passthrough" keyslot manager that provides a way to
> represent a keyslot manager that doesn't have just a limited number of
> keyslots, and for which do not require keys to be programmed into keyslots.
> DM devices can set up a passthrough keyslot manager in their request
> queues, and advertise appropriate crypto capabilities based on those of the
> underlying devices. Blk-crypto does not attempt to program keys into any
> keyslots in the passthrough keyslot manager. Instead, if/when the bio is
> resubmitted to the underlying device, blk-crypto will try to program the
> key into the underlying device's keyslot manager.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

Generally looks good, feel free to add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

However, maybe it's worth reconsidering the suggestion I've made previously
(https://lkml.kernel.org/linux-block/20200326062213.GF858@sol.localdomain) of
separating the crypto capabilities from the keyslot manager.  If we did that,
then this case could be handled by a NULL keyslot manager, rather than a special
kind of keyslot manager that doesn't actually do the keyslot management.

I realize that it's a bit tricky because the key eviction callback would still
be needed.  So maybe it's not really better.  Also, previously other people have
seemed to prefer just the keyslot manager, e.g.
https://lkml.kernel.org/linux-block/20200327170047.GA24682@infradead.org.

Does anyone have any new thoughts on this?

Also, a couple minor comments below.

> @@ -353,6 +372,9 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm)
>  {
>  	unsigned int slot;
>  
> +	if (WARN_ON(blk_ksm_is_passthrough(ksm)))
> +		return;
> +

I think the above WARN_ON() should just be removed:

	if (blk_ksm_is_passthrough(ksm))
		return;

Otherwise callers might need to conditionally call blk_ksm_reprogram_all_keys()
depending on whether there are keyslots or not.

> +/**
> + * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
> + * @ksm: The keyslot manager to init
> + *
> + * Initialize a passthrough keyslot manager.
> + * Called by e.g. storage drivers to set up a keyslot manager in their
> + * request_queue, when the storage driver wants to manage its keys by itself.
> + * This is useful for inline encryption hardware that don't have a small fixed
> + * number of keyslots, and for layered devices.
> + *

Maybe:

"inline encryption hardware that don't have a small fixed number of keyslots"

=>

"inline encryption hardware that doesn't have the concept of keyslots"
